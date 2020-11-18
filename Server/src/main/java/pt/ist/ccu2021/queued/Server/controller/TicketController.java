package pt.ist.ccu2021.queued.Server.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pt.ist.ccu2021.queued.Server.dto.StoreDto;
import pt.ist.ccu2021.queued.Server.service.contract.IStoreService;

import java.util.List;

@RestController
@RequestMapping(value = "")
public class TicketController {

    private static final Logger _logger = LoggerFactory.getLogger(TicketController.class);

    //TODO
}
