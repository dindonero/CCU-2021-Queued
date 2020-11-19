package pt.ist.ccu2021.queued.Server.service.implementation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pt.ist.ccu2021.queued.Server.Exception.ClosedCounterException;
import pt.ist.ccu2021.queued.Server.Exception.NoOneCurrentlyWaitingInLineException;
import pt.ist.ccu2021.queued.Server.Exception.NoOneWaitingInLineException;
import pt.ist.ccu2021.queued.Server.domain.Counter;
import pt.ist.ccu2021.queued.Server.domain.Store;
import pt.ist.ccu2021.queued.Server.domain.Ticket;
import pt.ist.ccu2021.queued.Server.dto.CounterDto;
import pt.ist.ccu2021.queued.Server.dto.UserTicketDto;
import pt.ist.ccu2021.queued.Server.repository.contract.ICounterRepository;
import pt.ist.ccu2021.queued.Server.repository.contract.IStoreRepository;
import pt.ist.ccu2021.queued.Server.repository.contract.ITicketRepository;
import pt.ist.ccu2021.queued.Server.service.contract.ITicketService;

import java.sql.Date;
import java.sql.Time;
import java.time.Duration;
import java.time.temporal.TemporalAmount;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class TicketService implements ITicketService {

    @Autowired
    private ITicketRepository _ticketRepository;

    @Autowired
    private IStoreRepository _storeRepository;

    @Autowired
    private ICounterRepository _counterRepository;

    @Override
    public List<UserTicketDto> getAllUserTickets(int userId) {
        List<Ticket> tickets = _ticketRepository.findByUserId(userId);

        return tickets.stream().map(ticket -> getUserTicket(ticket.getId())).collect(Collectors.toList());
    }


    @Override
    public UserTicketDto getUserTicket(int ticketId) {
        Ticket ticket = _ticketRepository.findById((long) ticketId).orElseThrow();
        Store store = _storeRepository.findById((long) ticket.getStoreId()).orElseThrow();

        int peopleAheadInLine = calculatePeopleAheadInLineForUser(ticket);

        Time avgWaitingTime = calculateAvgWaitingTime(ticket.getCounterId());

        return new UserTicketDto(ticket, peopleAheadInLine, avgWaitingTime, store.getName(), store.getAddress());
    }


    @Override
    public UserTicketDto getNewTicket(int userId, int counterId) throws ClosedCounterException {
        Counter counter = _counterRepository.findById( (long) counterId).orElseThrow();
        if (!counter.isHasStaff()) throw new ClosedCounterException(counterId, counter.getName());
        Ticket ticket = Ticket.builder().storeId(counter.getStoreid()).counterId(counterId)
                .userId(userId).canceled(false).enteringTime(new Date(System.currentTimeMillis())).build();
        int id = _ticketRepository.save(ticket).getId();

        return getUserTicket(id);
    }


    @Override
    public UserTicketDto cancelUserTicket(int ticketId) {
        Ticket ticket = _ticketRepository.findById((long) ticketId).orElseThrow();
        ticket.setCanceled(true);

        return getUserTicket(_ticketRepository.save(ticket).getId());
    }


    @Override
    public UserTicketDto cancelUserTicket(int userId, int counterId) {
        Ticket ticket = findUserTicketByUserAndCounterId(userId, counterId);
        ticket.setCanceled(true);

        return getUserTicket(_ticketRepository.save(ticket).getId());
    }


    @Override
    public Time calculateAvgWaitingTime(int counterId){
        List<Ticket> ticketsFromCounter = _ticketRepository.findByCounterId(counterId);
        if (ticketsFromCounter.size() == 0) return new Time(0);
        long secondsWaiting = ticketsFromCounter.stream().filter(ticket -> ticket.getLeavingTime() != null)
                .mapToLong(ticket -> ticket.getLeavingTime().getTime() - ticket.getEnteringTime().getTime()).sum();
        double avgWaitingTime = secondsWaiting / ticketsFromCounter.size();

        return new Time((long) avgWaitingTime);
    }


    @Override
    public int calculatePeopleAheadInLine(int counterId){
        return (int) _ticketRepository.findByCounterId(counterId).stream()
                .filter(ticket -> !ticket.isCanceled() && ticket.getLeavingTime() == null).count() - 1;
    }


    @Override
    public CounterDto staffNextTicket(int counterId) throws NoOneWaitingInLineException, NoOneCurrentlyWaitingInLineException {
        Ticket currentTicket = getCurrentTicket(counterId);
        if (currentTicket == null) throw new NoOneCurrentlyWaitingInLineException(counterId, _counterRepository.findById((long) counterId).orElseThrow().getName());
        currentTicket.setLeavingTime(new Date(System.currentTimeMillis()));
        _ticketRepository.save(currentTicket);

        if (getCurrentTicket(counterId) == null) throw new NoOneWaitingInLineException(counterId, _counterRepository.findById((long) counterId).orElseThrow().getName());
        Counter counter = _counterRepository.findById((long) counterId).orElseThrow();

        return new CounterDto(counter, calculatePeopleAheadInLine(counterId), calculateAvgWaitingTime(counterId), getCurrentTicket(counterId).getId());
    }


    @Override
    public Ticket getCurrentTicket(int counterId) {

        return _ticketRepository.findByCounterId(counterId).stream().filter(ticket -> ticket.getLeavingTime() == null).findFirst().orElse(null);
    }


    private Ticket findUserTicketByUserAndCounterId(int userId, int counterId){

        return _ticketRepository.findByUserId(userId).stream().filter(ticket -> ticket.getCounterId() == counterId).findFirst().orElseThrow();
    }


    private int calculatePeopleAheadInLineForUser(Ticket userTicket){

        return (int) _ticketRepository.findByCounterId(userTicket.getCounterId()).stream()
                .filter(ticket -> !ticket.isCanceled() && ticket.getLeavingTime() == null && ticket.getId() < userTicket.getId()).count() - 1;
    }
}
