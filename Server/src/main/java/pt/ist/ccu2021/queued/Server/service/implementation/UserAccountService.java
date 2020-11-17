package pt.ist.ccu2021.queued.Server.service.implementation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pt.ist.ccu2021.queued.Server.Exception.DuplicateEmailException;
import pt.ist.ccu2021.queued.Server.domain.UserAccount;
import pt.ist.ccu2021.queued.Server.repository.contract.IUserAccountRepository;
import pt.ist.ccu2021.queued.Server.service.contract.IUserAccountService;

@Service
public class UserAccountService implements IUserAccountService {

    @Autowired
    private IUserAccountRepository userAccountRepository;

    @Override
    public int createNewUserAccount(UserAccount newUser) throws DuplicateEmailException {
        if (userAccountRepository.findByEmail(newUser.getEmail()) != null) throw new DuplicateEmailException(newUser.getEmail());
        return userAccountRepository.save(newUser).getId();
    }
}
