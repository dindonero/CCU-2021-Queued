package pt.ist.ccu2021.queued.Server.service.implementation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pt.ist.ccu2021.queued.Server.domain.Store;
import pt.ist.ccu2021.queued.Server.domain.Ticket;
import pt.ist.ccu2021.queued.Server.dto.UserTicketDto;
import pt.ist.ccu2021.queued.Server.repository.contract.IStoreRepository;
import pt.ist.ccu2021.queued.Server.repository.contract.ITicketRepository;
import pt.ist.ccu2021.queued.Server.service.contract.ITicketService;

import java.sql.Time;
import java.time.Duration;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class TicketService implements ITicketService {

    @Autowired
    private ITicketRepository _ticketRepository;

    @Autowired
    private IStoreRepository _storeRepository;

    @Override
    public List<UserTicketDto> getAllUserTickets(int userId) {
        List<Ticket> tickets = _ticketRepository.findByUserId(userId);
        return tickets.stream().map(ticket -> getUserTicket(ticket.getId())).collect(Collectors.toList());
    }

    @Override
    public UserTicketDto getUserTicket(int ticketId) {
        Ticket ticket = _ticketRepository.findById((long) ticketId).get();
        Store store = _storeRepository.findById((long) ticket.getStoreId()).get();

        List<Ticket> ticketsAhead = _ticketRepository.findByCounterId(ticket.getCounterId()).stream()
                .filter(ticket1 -> !ticket1.isCanceled() && ticket1.getLeavingTime() == null).collect(Collectors.toList());

        int peopleAheadInLine = ticketsAhead.size();

        List<Ticket> ticketsFromCounter = _ticketRepository.findByCounterId(ticket.getCounterId());

        long secondsWaiting = ticketsFromCounter.stream().mapToLong(ticket1 -> Duration.between(ticket1.getEnteringTime().toLocalTime(), ticket1.getLeavingTime().toLocalTime()).getSeconds()).sum();
        double avgWaitingTime = secondsWaiting / ticketsFromCounter.size();

        return new UserTicketDto(ticket, peopleAheadInLine, new Time((long) avgWaitingTime * 1000), store.getName(), store.getAddress());
    }
}
