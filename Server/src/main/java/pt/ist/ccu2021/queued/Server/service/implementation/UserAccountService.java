package pt.ist.ccu2021.queued.Server.service.implementation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pt.ist.ccu2021.queued.Server.Exception.DuplicateEmailException;
import pt.ist.ccu2021.queued.Server.Exception.EmailNotFoundException;
import pt.ist.ccu2021.queued.Server.Exception.WrongPasswordException;
import pt.ist.ccu2021.queued.Server.domain.UserAccount;
import pt.ist.ccu2021.queued.Server.dto.LoginUserAccountDto;
import pt.ist.ccu2021.queued.Server.dto.UserAccountDto;
import pt.ist.ccu2021.queued.Server.repository.contract.IUserAccountRepository;
import pt.ist.ccu2021.queued.Server.service.contract.IUserAccountService;

@Service
public class UserAccountService implements IUserAccountService {

    @Autowired
    private IUserAccountRepository _userAccountRepository;

    @Override
    public UserAccountDto createNewUserAccount(UserAccountDto newUser) throws DuplicateEmailException {
        if (_userAccountRepository.findByEmail(newUser.getEmail()) != null) throw new DuplicateEmailException(newUser.getEmail());
        return new UserAccountDto(_userAccountRepository.save(newUser.toDomain()));
    }

    @Override
    public UserAccountDto loginUser(LoginUserAccountDto userLogin) throws EmailNotFoundException, WrongPasswordException {
        UserAccount user = _userAccountRepository.findByEmail(userLogin.getEmail());
        if (user == null) throw new EmailNotFoundException(userLogin.getEmail());
        if (!user.getPassword().equals(userLogin.getPassword())) throw new WrongPasswordException(userLogin.getEmail(), userLogin.getPassword());
        return new UserAccountDto(user);
    }
}
