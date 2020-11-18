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
import pt.ist.ccu2021.queued.Server.domain.CompanyAccount;
import pt.ist.ccu2021.queued.Server.dto.CompanyAccountDto;
import pt.ist.ccu2021.queued.Server.dto.LoginCompanyAccountDto;
import pt.ist.ccu2021.queued.Server.service.contract.ICompanyAccountService;

@RestController
@RequestMapping(value = "/company")
public class CompanyController {

    private static final Logger _logger = LoggerFactory.getLogger(CategoryController.class);

    @Autowired
    private ICompanyAccountService _companyAccountService;

    @PostMapping(value = "/register")
    public ResponseEntity<Integer> createNewCompanyAccount(@RequestBody CompanyAccountDto newCompanyAccountDto){
        _logger.info(String.format("CreateNewCompanyAccount - Name:%s, Email:%s, Password:%s, SecondaryEmail:%s",
                newCompanyAccountDto.getName(), newCompanyAccountDto.getEmail(),
                newCompanyAccountDto.getPassword(), newCompanyAccountDto.getSecondaryEmail()));
        try {
            int id = _companyAccountService.createNewCompanyAccount(newCompanyAccountDto.toDomain());
            return new ResponseEntity<>(id, HttpStatus.CREATED);
        }
        catch (DuplicateEmailException e){
            _logger.error(e.getMessage());
            return new ResponseEntity<>(-1, HttpStatus.CONFLICT);
        }
    }

    @PostMapping(value = "/login")
    public ResponseEntity<CompanyAccountDto> loginCompany(@RequestBody LoginCompanyAccountDto companyAccountDto) {
        _logger.info(String.format("LoginCompanyAccount - Email:%s, Password:%s",
                companyAccountDto.getEmail(), companyAccountDto.getPassword()));

        try {
            CompanyAccount company = _companyAccountService.loginCompany(companyAccountDto.toDomain());
            return new ResponseEntity<>(new CompanyAccountDto(company), HttpStatus.ACCEPTED);
        } catch (WrongPasswordException e) {
            _logger.error(e.getMessage());
            return new ResponseEntity<>(null, HttpStatus.FORBIDDEN);
        } catch (EmailNotFoundException e) {
            _logger.error(e.getMessage());
            return new ResponseEntity<>(null, HttpStatus.NOT_FOUND);
        }
    }
}
