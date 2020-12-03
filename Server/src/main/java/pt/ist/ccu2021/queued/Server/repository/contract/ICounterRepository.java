package pt.ist.ccu2021.queued.Server.repository.contract;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pt.ist.ccu2021.queued.Server.domain.Category;
import pt.ist.ccu2021.queued.Server.domain.Counter;

import java.util.List;

@Repository
public interface ICounterRepository extends JpaRepository<Counter, Long> {

    List<Counter> findByStoreid(int storeid);

    Counter findById(int id);

}
