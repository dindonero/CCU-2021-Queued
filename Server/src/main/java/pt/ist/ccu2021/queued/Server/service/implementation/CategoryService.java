package pt.ist.ccu2021.queued.Server.service.implementation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pt.ist.ccu2021.queued.Server.domain.Category;
import pt.ist.ccu2021.queued.Server.repository.contract.ICategoryRepository;
import pt.ist.ccu2021.queued.Server.service.contract.ICategoryService;

import java.util.List;

@Service
public class CategoryService implements ICategoryService {

    @Autowired
    private ICategoryRepository _categoryRepository;

    @Override
    public List<Category> getAllCategories() {
        return _categoryRepository.findAll();
    }
}
