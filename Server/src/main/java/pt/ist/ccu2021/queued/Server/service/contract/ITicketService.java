package pt.ist.ccu2021.queued.Server.service.contract;

import pt.ist.ccu2021.queued.Server.Exception.ClosedCounterException;
import pt.ist.ccu2021.queued.Server.Exception.NoOneCurrentlyWaitingInLineException;
import pt.ist.ccu2021.queued.Server.Exception.NoOneWaitingInLineException;
import pt.ist.ccu2021.queued.Server.domain.Ticket;
import pt.ist.ccu2021.queued.Server.dto.CounterDto;
import pt.ist.ccu2021.queued.Server.dto.UserTicketDto;

import java.sql.Time;
import java.util.List;

public interface ITicketService {

    List<UserTicketDto> getAllUserTickets(int userId);

    UserTicketDto getUserTicket(int ticketId);

    UserTicketDto getNewTicket(int userId, int counterId) throws ClosedCounterException;

    UserTicketDto cancelUserTicket(int ticketId);

    UserTicketDto cancelUserTicket(int userId, int counterId);

    Time calculateAvgWaitingTime(int counterId);

    Ticket getCurrentTicket(int counterId, String staffCounter);

    int calculatePeopleAheadInLine(int counterId);

    CounterDto staffNextTicket(int counterId, String staffCounter) throws NoOneWaitingInLineException;

}


//TODO