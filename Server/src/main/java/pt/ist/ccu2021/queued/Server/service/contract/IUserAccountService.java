package pt.ist.ccu2021.queued.Server.service.contract;

import org.springframework.stereotype.Service;
import pt.ist.ccu2021.queued.Server.Exception.DuplicateEmailException;
import pt.ist.ccu2021.queued.Server.Exception.UserEmailNotFoundException;
import pt.ist.ccu2021.queued.Server.Exception.WrongPasswordException;
import pt.ist.ccu2021.queued.Server.domain.UserAccount;

public interface IUserAccountService {

    int createNewUserAccount(UserAccount newUser) throws DuplicateEmailException;

    UserAccount loginUser(UserAccount user) throws UserEmailNotFoundException, WrongPasswordException;

}
