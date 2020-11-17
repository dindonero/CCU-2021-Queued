package pt.ist.ccu2021.queued.Server.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import lombok.*;
import org.springframework.data.geo.Point;
import pt.ist.ccu2021.queued.Server.domain.Schedule;
import pt.ist.ccu2021.queued.Server.domain.Store;

import javax.persistence.Column;
import java.util.List;
import java.util.stream.Collectors;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
@ToString
@JsonPropertyOrder({"id", "name", "img", "mapCoords", "categoryId", "counters", "companyId"})
public class StoreDto {

    @JsonProperty("id")
    private int id;

    @JsonProperty("name")
    private String name;

    @JsonProperty("img")
    private byte[] img;

    @JsonProperty("mapCoords")
    private Point mapCoords;

    @JsonProperty("categoryId")
    private int categoryId;

    @JsonProperty("counters")
    private int counters;

    @JsonProperty("schedules")
    private List<ScheduleDto> schedules;

    public StoreDto(Store store, List<Schedule> scheduleList){
        id = store.getId();
        name = store.getName();
        img = store.getImg();
        mapCoords = store.getMapCoords();
        categoryId = store.getCategoryId();
        counters = store.getCounters();
        schedules = scheduleList.stream().map(ScheduleDto::new).collect(Collectors.toList());
    }

    public Store toDomain(int companyId){
        return Store.builder().id(id).name(name).img(img).mapCoords(mapCoords).categoryId(categoryId).counters(counters)
                .companyId(companyId).build();
    }
}
