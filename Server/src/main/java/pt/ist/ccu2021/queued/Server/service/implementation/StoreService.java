package pt.ist.ccu2021.queued.Server.service.implementation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pt.ist.ccu2021.queued.Server.domain.Counter;
import pt.ist.ccu2021.queued.Server.domain.Store;
import pt.ist.ccu2021.queued.Server.dto.CounterDto;
import pt.ist.ccu2021.queued.Server.dto.StoreDto;
import pt.ist.ccu2021.queued.Server.repository.contract.ICounterRepository;
import pt.ist.ccu2021.queued.Server.repository.contract.IScheduleRepository;
import pt.ist.ccu2021.queued.Server.repository.contract.IStoreRepository;
import pt.ist.ccu2021.queued.Server.service.contract.IStoreService;
import pt.ist.ccu2021.queued.Server.service.contract.ITicketService;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class StoreService implements IStoreService {

    @Autowired
    private IStoreRepository _storeRepository;

    @Autowired
    private IScheduleRepository _scheduleRepository;

    @Autowired
    private ICounterRepository _counterRepository;

    @Autowired
    private ITicketService _ticketService;

    @Override
    public List<StoreDto> getAllStoresFromCategory(int categoryId) {
        List<Store> stores = _storeRepository.findByCategoryId(categoryId);
        return stores.stream()
                .map(store -> new StoreDto(store,
                        _counterRepository.findByStoreid(store.getId()).stream()
                                .map(counter -> new CounterDto(counter,
                                        _ticketService.calculatePeopleAheadInLine(counter.getId()),
                                        _ticketService.calculateAvgWaitingTime(counter.getId()))).collect(Collectors.toList()),
                        _scheduleRepository.findByStoreId(store.getId())))
                .collect(Collectors.toList());
    }

    @Override
    public List<StoreDto> getAllStoresFromName(String name) {
        List<Store> stores = _storeRepository.findAll().stream().filter(store -> store.getName().toLowerCase().contains(name.toLowerCase())).collect(Collectors.toList());
        return stores.stream()
                .map(store -> new StoreDto(store,
                        _counterRepository.findByStoreid(store.getId()).stream()
                                .map(counter -> new CounterDto(counter,
                                        _ticketService.calculatePeopleAheadInLine(counter.getId()),
                                        _ticketService.calculateAvgWaitingTime(counter.getId()))).collect(Collectors.toList()),
                        _scheduleRepository.findByStoreId(store.getId())))
                .collect(Collectors.toList());
    }

    @Override
    public int insertNewStore(StoreDto store, int companyId) {
        int id = _storeRepository.save(store.toDomain(companyId)).getId();
        store.getSchedules().forEach(scheduleDto -> _scheduleRepository.save(scheduleDto.toDomain(id)));
        store.getCounters().forEach(counterDto -> _counterRepository.save(counterDto.toDomain(false)));
        return id;
    }

    @Override
    public List<StoreDto> getAllStoresFromCompany(int companyId) {
        return _storeRepository.findByCompanyId(companyId).stream()
                .map(store -> new StoreDto(store,
                        _counterRepository.findByStoreid(store.getId()).stream()
                                .map(counter -> new CounterDto(counter,
                                        _ticketService.calculatePeopleAheadInLine(counter.getId()),
                                        _ticketService.calculateAvgWaitingTime(counter.getId()))).collect(Collectors.toList()),
                        _scheduleRepository.findByStoreId(store.getId()))
                ).collect(Collectors.toList());
    }

    @Override
    public CounterDto staffHasEnteredCounter(int counterId) {
        Counter counter = _counterRepository.findById((long) counterId).orElseThrow();
        counter.setHasStaff(true);
        int peopleAhead = _ticketService.calculatePeopleAheadInLine(counterId);
        return new CounterDto(_counterRepository.save(counter),
                peopleAhead,
                _ticketService.calculateAvgWaitingTime(counterId));
    }

    @Override
    public CounterDto staffHasLeftCounter(int counterId) {
        Counter counter = _counterRepository.findById((long) counterId).orElseThrow();
        counter.setHasStaff(false);
        return new CounterDto(_counterRepository.save(counter),
                _ticketService.calculatePeopleAheadInLine(counterId),
                _ticketService.calculateAvgWaitingTime(counterId));
    }
}
