package pt.ist.ccu2021.queued.Server.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pt.ist.ccu2021.queued.Server.dto.CategoryDto;
import pt.ist.ccu2021.queued.Server.service.contract.ICategoryService;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping(value = "/category")
public class CategoryController {

    private static final Logger _logger = LoggerFactory.getLogger(CategoryController.class);

    @Autowired
    private ICategoryService _categoryService;

    @GetMapping(value = {"", "/", "/getAll"})
    public ResponseEntity<List<CategoryDto>> getAllCategories(){
        _logger.info("GetAllCategories");

        return new ResponseEntity<>(
                _categoryService.getAllCategories(),
                HttpStatus.OK);
    }
}
