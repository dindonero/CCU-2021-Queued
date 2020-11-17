package pt.ist.ccu2021.queued.Server.repository.contract;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import pt.ist.ccu2021.queued.Server.domain.UserAccount;


@Repository
public interface IUserAccountRepository extends JpaRepository<UserAccount, Long> {

    UserAccount findByEmail(String email);

}
