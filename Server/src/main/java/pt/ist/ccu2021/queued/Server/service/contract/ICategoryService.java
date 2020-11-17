package pt.ist.ccu2021.queued.Server.service.contract;

import pt.ist.ccu2021.queued.Server.domain.Category;

import java.util.List;

public interface ICategoryService {

    List<Category> getAllCategories();

}
