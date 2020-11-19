package pt.ist.ccu2021.queued.Server.service.contract;

import pt.ist.ccu2021.queued.Server.dto.CategoryDto;

import java.util.List;

public interface ICategoryService {

    List<CategoryDto> getAllCategories();

}
