package pt.ist.ccu2021.queued.Server.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pt.ist.ccu2021.queued.Server.domain.Store;
import pt.ist.ccu2021.queued.Server.dto.CategoryDto;
import pt.ist.ccu2021.queued.Server.dto.StoreDto;
import pt.ist.ccu2021.queued.Server.service.contract.ICategoryService;
import pt.ist.ccu2021.queued.Server.service.contract.IStoreService;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping(value = "")
public class StoreController {

    private static final Logger _logger = LoggerFactory.getLogger(StoreController.class);

    @Autowired
    private IStoreService _storeService;

    @GetMapping(value = "/category/{categoryid}/store")
    public ResponseEntity<List<StoreDto>> getAllStoresFromCategory(@PathVariable("categoryid") int categoryId){
        _logger.info("GetAllStoresFromCategory - CategoryId:" + categoryId);

        return new ResponseEntity<>(_storeService.getAllStoresFromCategory(categoryId), HttpStatus.OK);
    }

    @GetMapping(value = "/searchStores/{name}")
    public ResponseEntity<List<StoreDto>> searchStoresByName(@PathVariable("name") String name){
        _logger.info("SearchStoresByName - Name:" + name);

        return new ResponseEntity<>(_storeService.getAllStoresFromName(name), HttpStatus.OK);
    }

    @PostMapping(value = "company/{companyid}/store/register")
    public ResponseEntity<Integer> addNewStore(@PathVariable("companyid") int companyId, @RequestBody StoreDto storeDto){
        _logger.info(String.format("AddNewStore - CompanyId:%s, Name:%s, CategoryId:%s, Counters:%s, MapCoords:%s",
                companyId, storeDto.getName(), storeDto.getCategoryId(), storeDto.getCounters(), storeDto.getMapCoords()));

        return new ResponseEntity<>(_storeService.insertNewStore(storeDto, companyId), HttpStatus.CREATED);
    }
}
