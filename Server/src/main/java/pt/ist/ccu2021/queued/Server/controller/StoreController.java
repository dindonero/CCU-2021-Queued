package pt.ist.ccu2021.queued.Server.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pt.ist.ccu2021.queued.Server.dto.CounterDto;
import pt.ist.ccu2021.queued.Server.dto.StoreDto;
import pt.ist.ccu2021.queued.Server.service.contract.IStoreService;

import java.util.List;

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

    @PostMapping(value = "/company/{companyid}/store/register")
    public ResponseEntity<Integer> addNewStore(@PathVariable("companyid") int companyId, @RequestBody StoreDto storeDto){
        _logger.info(String.format("AddNewStore - CompanyId:%s, Name:%s, CategoryId:%s, Counters:%s, address:%s",
                companyId, storeDto.getName(), storeDto.getCategoryId(), storeDto.getCounters(), storeDto.getAddress()));

        return new ResponseEntity<>(_storeService.insertNewStore(storeDto, companyId), HttpStatus.CREATED);
    }

    @GetMapping(value = "/company/{companyid}")
    public ResponseEntity<List<StoreDto>> getAllStoresFromCompany(@PathVariable("companyid") int companyId){
        _logger.info("getAllStoresFromCompany - CompanyId:" + companyId);

        return new ResponseEntity<>(_storeService.getAllStoresFromCompany(companyId), HttpStatus.OK);
    }

    @PostMapping(value = "/staff/getStores")
    public ResponseEntity<List<StoreDto>> getAllStoresFromStaffEmail(@RequestBody String staffEmail){
        _logger.info("getAllStoresFromStaffEmail - StaffEmail:" + staffEmail);

        return new ResponseEntity<>(_storeService.getAllStoresFromStaffEmail(staffEmail), HttpStatus.OK);
    }

    @GetMapping(value = "/counter/{counterid}")
    public ResponseEntity<CounterDto> getCounterFromId(@PathVariable("counterid") int counterId){
        _logger.info("getCounterFromId - CounterId:" + counterId);

        return new ResponseEntity<>(_storeService.getCounterFromId(counterId), HttpStatus.ACCEPTED);
    }

    @GetMapping(value = "/counter/{counterid}/staff/enter")
    public ResponseEntity<CounterDto> staffHasEnteredCounter(@PathVariable("counterid") int counterId){
        _logger.info("staffHasEnteredCounter - CounterId:" + counterId);

        return new ResponseEntity<>(_storeService.staffHasLeftCounter(counterId), HttpStatus.ACCEPTED);
    }

    @GetMapping(value = "/counter/{counterid}/staff/leave")
    public ResponseEntity<CounterDto> staffHasLeftCounter(@PathVariable("counterid") int counterId){
        _logger.info("staffHasLeftCounter - CounterId:" + counterId);

        return new ResponseEntity<>(_storeService.staffHasLeftCounter(counterId), HttpStatus.ACCEPTED);
    }
}
