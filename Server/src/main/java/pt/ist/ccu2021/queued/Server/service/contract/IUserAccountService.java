package pt.ist.ccu2021.queued.Server.service.contract;

import org.springframework.stereotype.Service;
import pt.ist.ccu2021.queued.Server.Exception.DuplicateEmailException;
import pt.ist.ccu2021.queued.Server.domain.UserAccount;

public interface IUserAccountService {

    int createNewUserAccount(UserAccount newUser) throws DuplicateEmailException;

}
