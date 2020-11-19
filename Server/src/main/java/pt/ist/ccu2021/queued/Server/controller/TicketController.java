package pt.ist.ccu2021.queued.Server.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pt.ist.ccu2021.queued.Server.Exception.ClosedCounterException;
import pt.ist.ccu2021.queued.Server.Exception.NoOneCurrentlyWaitingInLineException;
import pt.ist.ccu2021.queued.Server.Exception.NoOneWaitingInLineException;
import pt.ist.ccu2021.queued.Server.dto.CounterDto;
import pt.ist.ccu2021.queued.Server.dto.StoreDto;
import pt.ist.ccu2021.queued.Server.dto.UserTicketDto;
import pt.ist.ccu2021.queued.Server.service.contract.IStoreService;
import pt.ist.ccu2021.queued.Server.service.contract.ITicketService;

import java.util.List;

@RestController
@RequestMapping(value = "/ticket")
public class TicketController {

    private static final Logger _logger = LoggerFactory.getLogger(TicketController.class);

    @Autowired
    private ITicketService _ticketService;

    @GetMapping(value = "/user/{userid}")
    public ResponseEntity<List<UserTicketDto>> getAllUserTickets(@PathVariable("userid") int userId){

        return new ResponseEntity<>(_ticketService.getAllUserTickets(userId), HttpStatus.OK);
    }

    @GetMapping(value = "/user/{userid}/counter/{counterid}/new")
    public ResponseEntity<UserTicketDto> getNewTicket(@PathVariable("userid") int userId, @PathVariable("counterid") int counterId){

        try {
            return new ResponseEntity<>(_ticketService.getNewTicket(userId, counterId), HttpStatus.CREATED);
        } catch (ClosedCounterException e) {
            return new ResponseEntity<>(null, HttpStatus.I_AM_A_TEAPOT);
        }
    }

    @GetMapping(value = "/user/{userid}/counter/{counterid}/cancel")
    public ResponseEntity<UserTicketDto> cancelUserTicket(@PathVariable("userid") int userId, @PathVariable("counterid") int counterId){

        return new ResponseEntity<>(_ticketService.cancelUserTicket(userId, counterId), HttpStatus.ACCEPTED);
    }

    @GetMapping(value = "/{ticketid}")
    public ResponseEntity<UserTicketDto> getUserTicket(@PathVariable("ticketid") int ticketId){

        return new ResponseEntity<>(_ticketService.getUserTicket(ticketId), HttpStatus.OK);
    }

    @GetMapping(value = "/{ticketid}/cancel")
    public ResponseEntity<UserTicketDto> cancelUserTicketById(@PathVariable("ticketid") int ticketId){

        return new ResponseEntity<>(_ticketService.cancelUserTicket(ticketId), HttpStatus.ACCEPTED);
    }

    @GetMapping(value = "/counter/{counterid}/next")
    public ResponseEntity<CounterDto> staffNextTicket(@PathVariable("counterid") int counterId){

        try {
            return new ResponseEntity<>(_ticketService.staffNextTicket(counterId), HttpStatus.ACCEPTED);
        } catch (NoOneWaitingInLineException e) {
            return new ResponseEntity<>(null, HttpStatus.SERVICE_UNAVAILABLE);
        } catch (NoOneCurrentlyWaitingInLineException e) {
            return new ResponseEntity<>(null, HttpStatus.FORBIDDEN);
        }
    }
}
