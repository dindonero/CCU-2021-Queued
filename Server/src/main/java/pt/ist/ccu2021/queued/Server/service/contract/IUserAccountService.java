package pt.ist.ccu2021.queued.Server.service.contract;

import pt.ist.ccu2021.queued.Server.Exception.DuplicateEmailException;
import pt.ist.ccu2021.queued.Server.Exception.EmailNotFoundException;
import pt.ist.ccu2021.queued.Server.Exception.WrongPasswordException;
import pt.ist.ccu2021.queued.Server.domain.UserAccount;
import pt.ist.ccu2021.queued.Server.dto.LoginUserAccountDto;
import pt.ist.ccu2021.queued.Server.dto.UserAccountDto;

public interface IUserAccountService {

    UserAccountDto createNewUserAccount(UserAccountDto newUser) throws DuplicateEmailException;

    UserAccountDto loginUser(LoginUserAccountDto userLogin) throws EmailNotFoundException, WrongPasswordException;

}
