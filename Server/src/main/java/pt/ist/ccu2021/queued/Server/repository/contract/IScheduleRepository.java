package pt.ist.ccu2021.queued.Server.repository.contract;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pt.ist.ccu2021.queued.Server.domain.Schedule;

import java.util.List;

@Repository
public interface IScheduleRepository extends JpaRepository<Schedule, Long> {

    public List<Schedule> findByStoreId(int storeid);
}
