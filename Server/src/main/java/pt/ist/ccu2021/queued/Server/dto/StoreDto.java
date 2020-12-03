package pt.ist.ccu2021.queued.Server.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import lombok.*;
import pt.ist.ccu2021.queued.Server.domain.Counter;
import pt.ist.ccu2021.queued.Server.domain.Schedule;
import pt.ist.ccu2021.queued.Server.domain.Store;

import java.util.List;
import java.util.stream.Collectors;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
@ToString
@JsonPropertyOrder({"id", "name", "img", "address", "categoryId", "counters", "companyId"})
public class StoreDto {

    @JsonProperty("id")
    private int id;

    @JsonProperty("name")
    private String name;

    @JsonProperty("img")
    private Byte[] img;

    @JsonProperty("address")
    private String address;

    @JsonProperty("categoryId")
    private int categoryId;

    @JsonProperty("counters")
    private List<CounterDto> counters;

    @JsonProperty("schedules")
    private List<ScheduleDto> schedules;

    public StoreDto(Store store, List<CounterDto> counterList, List<Schedule> scheduleList){
        id = store.getId();
        name = store.getName();
        img = store.getImg();
        address = store.getAddress();
        categoryId = store.getCategoryId();
        counters = counterList;
        schedules = scheduleList.stream().map(ScheduleDto::new).collect(Collectors.toList());
    }

    public Store toDomain(int companyId){
        return Store.builder().name(name).img(img).address(address).categoryId(categoryId)
                .companyId(companyId).build();
    }
}
