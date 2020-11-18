package pt.ist.ccu2021.queued.Server.service.contract;

import pt.ist.ccu2021.queued.Server.Exception.DuplicateEmailException;
import pt.ist.ccu2021.queued.Server.Exception.EmailNotFoundException;
import pt.ist.ccu2021.queued.Server.Exception.WrongPasswordException;
import pt.ist.ccu2021.queued.Server.domain.CompanyAccount;

public interface ICompanyAccountService {

    int createNewCompanyAccount(CompanyAccount newCompany) throws DuplicateEmailException;

    CompanyAccount loginCompany(CompanyAccount companyLogin) throws EmailNotFoundException, WrongPasswordException;

}
