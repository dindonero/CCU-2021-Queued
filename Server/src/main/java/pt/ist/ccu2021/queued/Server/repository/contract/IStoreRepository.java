package pt.ist.ccu2021.queued.Server.repository.contract;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pt.ist.ccu2021.queued.Server.domain.Store;

import java.util.List;

@Repository
public interface IStoreRepository extends JpaRepository<Store, Long> {

    public List<Store> findByName(String name);

    public List<Store> findByCategoryId(int categoryid);

}
