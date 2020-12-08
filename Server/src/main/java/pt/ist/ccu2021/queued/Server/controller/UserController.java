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
import pt.ist.ccu2021.queued.Server.Exception.EmailNotFoundException;
import pt.ist.ccu2021.queued.Server.Exception.WrongPasswordException;
import pt.ist.ccu2021.queued.Server.domain.UserAccount;
import pt.ist.ccu2021.queued.Server.dto.LoginUserAccountDto;
import pt.ist.ccu2021.queued.Server.dto.UserAccountDto;
import pt.ist.ccu2021.queued.Server.service.contract.IUserAccountService;

@RestController
@RequestMapping(value = "/user")
public class UserController {

    private static final Logger _logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private IUserAccountService _userAccountService;

    @PostMapping(value = "/register")
    public ResponseEntity<Integer> createNewUserAccount(@RequestBody UserAccountDto newUserAccountDto){
        _logger.info(String.format("CreateNewUserAccount - FirstName:%s, LastName:%s, Email:%s, Password:%s",
                newUserAccountDto.getFirstName(), newUserAccountDto.getLastName(), newUserAccountDto.getEmail(),
                newUserAccountDto.getPassword()));
        try {
            int id = _userAccountService.createNewUserAccount(newUserAccountDto);
            return new ResponseEntity<>(id, HttpStatus.CREATED);
        }
        catch (DuplicateEmailException e){
            _logger.error(e.getMessage());
            return new ResponseEntity<>(-1, HttpStatus.CONFLICT);
        }
    }

    @PostMapping(value = "/login")
    public ResponseEntity<UserAccountDto> loginUser(@RequestBody LoginUserAccountDto userAccountDto) {
        _logger.info(String.format("LoginUserAccount - Email:%s, Password:%s",
                userAccountDto.getEmail(), userAccountDto.getPassword()));

        try {
            return new ResponseEntity<>(_userAccountService.loginUser(userAccountDto), HttpStatus.ACCEPTED);
        } catch (WrongPasswordException e) {
            _logger.error(e.getMessage());
            return new ResponseEntity<>(null, HttpStatus.UNAUTHORIZED);
        } catch (EmailNotFoundException e) {
            _logger.error(e.getMessage());
            return new ResponseEntity<>(null, HttpStatus.NOT_FOUND);
        }
    }

}
