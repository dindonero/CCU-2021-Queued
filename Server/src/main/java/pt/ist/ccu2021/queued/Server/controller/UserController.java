package pt.ist.ccu2021.queued.Server.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pt.ist.ccu2021.queued.Server.Exception.DuplicateEmailException;
import pt.ist.ccu2021.queued.Server.dto.UserAccountDto;
import pt.ist.ccu2021.queued.Server.service.contract.IUserAccountService;

@RestController
@RequestMapping(value = "/user")
public class UserController {

    private static final Logger _logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private IUserAccountService userAccountService;

    @PostMapping(value = {"", "/", "me"})
    public ResponseEntity<Integer> createNewUserAccount(@RequestBody UserAccountDto newUserAccount){
        _logger.info(String.format("CreateNewUserAccount - FirstName:%s, LastName:%s, Email:%s, Password:%s, DateOfBirth:%s",
                newUserAccount.getFirstName(), newUserAccount.getLastName(), newUserAccount.getEmail(),
                newUserAccount.getPassword(), newUserAccount.getDateOfBirth().toString()));
        try {
            int id = userAccountService.createNewUserAccount(newUserAccount.toDomain());
            return new ResponseEntity<>(1, HttpStatus.CREATED);
        }
        catch (DuplicateEmailException e){
            return new ResponseEntity<>(-1, HttpStatus.ACCEPTED);
        }
    }
}
