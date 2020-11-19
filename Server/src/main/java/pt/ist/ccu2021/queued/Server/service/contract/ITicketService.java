package pt.ist.ccu2021.queued.Server.service.contract;

import pt.ist.ccu2021.queued.Server.dto.UserTicketDto;

import java.util.List;

public interface ITicketService {

    List<UserTicketDto> getAllUserTickets(int userId);

    UserTicketDto getUserTicket(int ticketId);

    UserTicketDto getNewTicket();
}


//TODO