package pt.ist.ccu2021.queued.Server.service.implementation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pt.ist.ccu2021.queued.Server.domain.CompanyAccount;
import pt.ist.ccu2021.queued.Server.domain.Counter;
import pt.ist.ccu2021.queued.Server.domain.Schedule;
import pt.ist.ccu2021.queued.Server.domain.Store;
import pt.ist.ccu2021.queued.Server.dto.CounterDto;
import pt.ist.ccu2021.queued.Server.dto.StoreDto;
import pt.ist.ccu2021.queued.Server.repository.contract.ICompanyAccountRepository;
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

    @Autowired
    private ICompanyAccountRepository _companyAccountRespository;

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
        if (store.getCounters().isEmpty())
            _counterRepository.save(Counter.builder().name("General").storeid(id).hasStaff(false).build());
        store.getCounters().forEach(counterDto -> _counterRepository.save(counterDto.toDomain(id)));
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
    public List<StoreDto> getAllStoresFromStaffEmail(String email) {
        CompanyAccount companyAccount = _companyAccountRespository.findByStaffEmail((String) email);
        if (companyAccount != null) {
            return getAllStoresFromCompany(companyAccount.getId());
        } else {
            return null;
        }
    }

    @Override
    public CounterDto getCounterFromId(int counterId) {
        Counter counter = _counterRepository.findById(counterId);
        return new CounterDto(counter, _ticketService.calculatePeopleAheadInLine(counterId), _ticketService.calculateAvgWaitingTime(counterId));
    }

    @Override
    public CounterDto staffHasEnteredCounter(int counterId) {
        Counter counter = _counterRepository.findById((int) counterId);
        counter.setHasStaff(true);
        int peopleAhead = _ticketService.calculatePeopleAheadInLine(counterId);
        return new CounterDto(_counterRepository.save(counter),
                peopleAhead,
                _ticketService.calculateAvgWaitingTime(counterId));
    }

    @Override
    public CounterDto staffHasLeftCounter(int counterId) {
        Counter counter = _counterRepository.findById((int) counterId);
        counter.setHasStaff(false);
        return new CounterDto(_counterRepository.save(counter),
                _ticketService.calculatePeopleAheadInLine(counterId),
                _ticketService.calculateAvgWaitingTime(counterId));
    }

    // todo unique (storeid, countername) on db
    @Override
    public StoreDto updateStoreInfo(int companyId, StoreDto storeDto) {
        Store store = _storeRepository.findById(storeDto.getId());

        if (companyId != store.getCompanyId()) ; // throw new StoreNotOwnedByCompany
        store.setName(storeDto.getName());
        store.setAddress(storeDto.getAddress());
        store.setCategoryId(storeDto.getCategoryId());
        store.setImg(storeDto.getImg());

        // Delete Counters
        _counterRepository.findByStoreid(store.getId()).forEach(counter -> _counterRepository.delete(counter));
        if (storeDto.getCounters().isEmpty()) _counterRepository.save(Counter.builder().name("General").storeid(storeDto.getId()).hasStaff(false).build());
        else storeDto.getCounters().forEach(counterDto -> _counterRepository.save(counterDto.toDomain(storeDto.getId())));
        List<CounterDto> counterDtos = _counterRepository.findByStoreid(store.getId()).stream().map(counter -> new CounterDto(counter, _ticketService.calculatePeopleAheadInLine(counter.getId()), _ticketService.calculateAvgWaitingTime(counter.getId()))).collect(Collectors.toList());

        // Delete Schedules
        _scheduleRepository.findByStoreId(storeDto.getId()).forEach(schedule -> _scheduleRepository.delete(schedule));
        List<Schedule> scheduleDtos = storeDto.getSchedules().stream().map(scheduleDto -> _scheduleRepository.save(scheduleDto.toDomain(storeDto.getId()))).collect(Collectors.toList());

        return new StoreDto(_storeRepository.save(store), counterDtos, scheduleDtos);
    }
}
