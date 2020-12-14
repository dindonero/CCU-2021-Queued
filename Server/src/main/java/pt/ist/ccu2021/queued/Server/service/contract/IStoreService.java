package pt.ist.ccu2021.queued.Server.service.contract;

import pt.ist.ccu2021.queued.Server.dto.CounterDto;
import pt.ist.ccu2021.queued.Server.dto.StoreDto;

import java.util.List;

public interface IStoreService {

    List<StoreDto> getAllStoresFromCategory(int categoryId);

    List<StoreDto> getAllStoresFromName(String name);

    int insertNewStore(StoreDto store, int companyId);

    List<StoreDto> getAllStoresFromCompany(int companyId);

    List<StoreDto> getAllStoresFromStaffEmail(String email);

    CounterDto getCounterFromId(int counterId);

    CounterDto staffHasEnteredCounter(int counterId);

    CounterDto staffHasLeftCounter(int counterId);

    StoreDto updateStoreInfo(int companyId, StoreDto storeDto);

}
