package pt.ist.ccu2021.queued.Server.service.contract;

import pt.ist.ccu2021.queued.Server.Exception.DuplicateEmailException;
import pt.ist.ccu2021.queued.Server.Exception.EmailNotFoundException;
import pt.ist.ccu2021.queued.Server.Exception.WrongPasswordException;
import pt.ist.ccu2021.queued.Server.domain.UserAccount;

public interface IUserAccountService {

    int createNewUserAccount(UserAccount newUser) throws DuplicateEmailException;

    UserAccount loginUser(UserAccount userLogin) throws EmailNotFoundException, WrongPasswordException;

}
