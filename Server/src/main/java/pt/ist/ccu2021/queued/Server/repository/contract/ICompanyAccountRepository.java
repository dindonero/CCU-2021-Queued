package pt.ist.ccu2021.queued.Server.repository.contract;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;
import pt.ist.ccu2021.queued.Server.domain.CompanyAccount;

@Repository
public interface ICompanyAccountRepository extends JpaRepository<CompanyAccount, Long> {

    public CompanyAccount findByEmail(String email);

    @Query(value = "SELECT * FROM CompanyAccount WHERE staffemail LIKE ?1", nativeQuery = true)
    public CompanyAccount findByStaffEmail(String staffEmail);

}
