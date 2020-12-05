package pt.ist.ccu2021.queued.Server.repository.contract;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pt.ist.ccu2021.queued.Server.domain.Category;

@Repository
public interface ICategoryRepository extends JpaRepository<Category, Long> {
}
