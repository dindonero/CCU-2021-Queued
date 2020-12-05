package pt.ist.ccu2021.queued.Server.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import lombok.*;
import pt.ist.ccu2021.queued.Server.domain.Day;
import pt.ist.ccu2021.queued.Server.domain.Schedule;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
@ToString
@JsonPropertyOrder({"dayId", "openingTime", "closingTime"})
public class ScheduleDto {

    @JsonProperty("day")
    private Day day;

    @JsonProperty("openingTime")
    private String openingTime;

    @JsonProperty("closingTime")
    private String closingTime;

    public ScheduleDto(Schedule schedule){
        day = Day.valueOf(schedule.getDay());
        openingTime = schedule.getOpeningTime();
        closingTime = schedule.getClosingTime();
    }

    public Schedule toDomain(int storeId){
        return Schedule.builder().day(day.toString()).storeId(storeId).openingTime(openingTime).closingTime(closingTime).build();
    }
}
