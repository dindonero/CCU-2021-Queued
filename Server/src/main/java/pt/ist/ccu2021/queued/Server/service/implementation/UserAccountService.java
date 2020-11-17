package pt.ist.ccu2021.queued.Server.service.implementation;

import org.apache.catalina.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pt.ist.ccu2021.queued.Server.Exception.DuplicateEmailException;
import pt.ist.ccu2021.queued.Server.Exception.UserEmailNotFoundException;
import pt.ist.ccu2021.queued.Server.Exception.WrongPasswordException;
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

    @Override
    public UserAccount loginUser(UserAccount userLogin) throws UserEmailNotFoundException, WrongPasswordException {
        UserAccount user = userAccountRepository.findByEmail(userLogin.getEmail());
        if (user == null) throw new UserEmailNotFoundException(userLogin.getEmail());
        if (!user.getPassword().equals(userLogin.getPassword())) throw new WrongPasswordException(userLogin.getEmail(), userLogin.getPassword());
        return user;
    }
}
