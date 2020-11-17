package pt.ist.ccu2021.queued.Server.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import lombok.*;
import pt.ist.ccu2021.queued.Server.domain.Schedule;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
@ToString
@JsonPropertyOrder({"storeId", "dayId", "openingTime", "closingTime"})
public class ScheduleDto {

    @JsonProperty("storeId")
    private int storeId;

    @JsonProperty("day")
    private String day;

    @JsonProperty("openingTime")
    private String openingTime;

    @JsonProperty("closingTime")
    private String closingTime;

    public ScheduleDto(Schedule schedule){
        storeId = schedule.getStoreId();
        day = schedule.getDay();
        openingTime = schedule.getOpeningTime();
        closingTime = schedule.getClosingTime();
    }
}
