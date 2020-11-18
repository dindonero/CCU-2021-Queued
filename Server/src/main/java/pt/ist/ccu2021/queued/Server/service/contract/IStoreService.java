package pt.ist.ccu2021.queued.Server.service.contract;

import pt.ist.ccu2021.queued.Server.dto.StoreDto;

import java.util.List;

public interface IStoreService {

    List<StoreDto> getAllStoresFromCategory(int categoryId);

    List<StoreDto> getAllStoresFromName(String name);

    int insertNewStore(StoreDto store, int companyId);

}
