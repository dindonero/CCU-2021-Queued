package pt.ist.ccu2021.queued.Server.repository.contract;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import pt.ist.ccu2021.queued.Server.domain.Ticket;

import java.util.List;

@Repository
public interface ITicketRepository extends JpaRepository<Ticket, Long> {

    List<Ticket> findByStoreId(int storeid);

    List<Ticket> findByUserId(int userid);

    @Query(value = "SELECT * FROM Ticket t WHERE t.counterId = ?1", nativeQuery = true)
    List<Ticket> findByCounterId(int counterid);

}
