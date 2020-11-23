package pt.ist.ccu2021.queued.Server.service.contract;

import pt.ist.ccu2021.queued.Server.Exception.DuplicateEmailException;
import pt.ist.ccu2021.queued.Server.Exception.EmailNotFoundException;
import pt.ist.ccu2021.queued.Server.Exception.WrongPasswordException;
import pt.ist.ccu2021.queued.Server.dto.CompanyAccountDto;
import pt.ist.ccu2021.queued.Server.dto.LoginCompanyAccountDto;

public interface ICompanyAccountService {

    int createNewCompanyAccount(CompanyAccountDto newCompany) throws DuplicateEmailException;

    CompanyAccountDto loginCompany(LoginCompanyAccountDto companyLogin) throws EmailNotFoundException, WrongPasswordException;

    CompanyAccountDto loginStaff(LoginCompanyAccountDto companyLogin) throws EmailNotFoundException, WrongPasswordException;

}
