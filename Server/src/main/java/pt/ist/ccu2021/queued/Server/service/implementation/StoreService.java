package pt.ist.ccu2021.queued.Server.service.implementation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pt.ist.ccu2021.queued.Server.domain.Store;
import pt.ist.ccu2021.queued.Server.dto.StoreDto;
import pt.ist.ccu2021.queued.Server.repository.contract.IScheduleRepository;
import pt.ist.ccu2021.queued.Server.repository.contract.IStoreRepository;
import pt.ist.ccu2021.queued.Server.service.contract.IStoreService;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class StoreService implements IStoreService {

    @Autowired
    private IStoreRepository _storeRepository;

    @Autowired
    private IScheduleRepository _scheduleRepository;

    @Override
    public List<StoreDto> getAllStoresFromCategory(int categoryId) {
        List<Store> stores = _storeRepository.findByCategoryId(categoryId);
        return stores.stream()
                .map(store -> new StoreDto(store, _scheduleRepository.findByStoreId(store.getId())))
                .collect(Collectors.toList());
    }

    @Override
    public List<StoreDto> getAllStoresFromName(String name) {
        List<Store> stores = _storeRepository.findByName(name);
        return stores.stream()
                .map(store -> new StoreDto(store, _scheduleRepository.findByStoreId(store.getId())))
                .collect(Collectors.toList());
    }

    @Override
    public int insertNewStore(StoreDto store, int companyId) {
        int id = _storeRepository.save(store.toDomain(companyId)).getId();
        store.getSchedules().forEach(scheduleDto -> _scheduleRepository.save(scheduleDto.toDomain(id)));
        return id;
    }
}
