package pt.ist.ccu2021.queued.Server.service.implementation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pt.ist.ccu2021.queued.Server.Exception.DuplicateEmailException;
import pt.ist.ccu2021.queued.Server.Exception.EmailNotFoundException;
import pt.ist.ccu2021.queued.Server.Exception.WrongPasswordException;
import pt.ist.ccu2021.queued.Server.domain.CompanyAccount;
import pt.ist.ccu2021.queued.Server.dto.CompanyAccountDto;
import pt.ist.ccu2021.queued.Server.dto.LoginCompanyAccountDto;
import pt.ist.ccu2021.queued.Server.repository.contract.ICompanyAccountRepository;
import pt.ist.ccu2021.queued.Server.service.contract.ICompanyAccountService;

@Service
public class CompanyAccountService implements ICompanyAccountService {

    @Autowired
    private ICompanyAccountRepository _companyAccountRespository;

    @Override
    public int createNewCompanyAccount(CompanyAccountDto newCompany) throws DuplicateEmailException {
        if (_companyAccountRespository.findByEmail(newCompany.getEmail()) != null) throw new DuplicateEmailException(newCompany.getEmail());
        return _companyAccountRespository.save(newCompany.toDomain()).getId();
    }

    @Override
    public CompanyAccountDto loginCompany(LoginCompanyAccountDto companyLogin) throws EmailNotFoundException, WrongPasswordException {
        CompanyAccount company = _companyAccountRespository.findByEmail(companyLogin.getEmail());
        if (company == null) throw new EmailNotFoundException(companyLogin.getEmail());
        if (!company.getPassword().equals(companyLogin.getPassword())) throw new WrongPasswordException(companyLogin.getEmail(), companyLogin.getPassword());
        return new CompanyAccountDto(company);
    }

    @Override
    public CompanyAccountDto loginStaff(LoginCompanyAccountDto staffLogin) throws EmailNotFoundException, WrongPasswordException {
        CompanyAccount company = _companyAccountRespository.findByStaffEmail(staffLogin.getEmail());
        if (company == null) throw new EmailNotFoundException(staffLogin.getEmail());
        if (!company.getStaffPassword().equals(staffLogin.getPassword())) throw new WrongPasswordException(staffLogin.getEmail(), staffLogin.getPassword());
        return new CompanyAccountDto(company);
    }
}
