package pt.ist.ccu2021.queued.Server.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import lombok.*;
import pt.ist.ccu2021.queued.Server.domain.Category;
import pt.ist.ccu2021.queued.Server.domain.Counter;

import java.sql.Time;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
@ToString
@JsonPropertyOrder({"id", "name", "img"})
public class CounterDto {

    @JsonProperty("id")
    private int id;

    @JsonProperty("name")
    private String name;

    @JsonProperty("storeid")
    private int storeId;

    @JsonProperty("hasStaff")
    private boolean hasStaff;

    @JsonProperty("peopleWaitingInLine")
    private int peopleWaitingInLine;

    @JsonProperty("avgWaitingTime")
    private Time avgWaitingTime;

    @JsonProperty("currentTicketId")
    private int currentTicketId;

    public CounterDto(Counter counter, int peopleAhead, Time avgTime){
        id = counter.getId();
        name = counter.getName();
        storeId = counter.getStoreid();
        hasStaff = counter.isHasStaff();
        peopleWaitingInLine = peopleAhead;
        avgWaitingTime = avgTime;
    }

    public CounterDto(Counter counter, int peopleAhead, Time avgTime, int currentTicket){
        id = counter.getId();
        name = counter.getName();
        storeId = counter.getStoreid();
        hasStaff = counter.isHasStaff();
        peopleWaitingInLine = peopleAhead;
        avgWaitingTime = avgTime;
        currentTicketId = currentTicket;
    }

    public Counter toDomain(boolean staff){
        return Counter.builder().name(name).storeid(storeId).hasStaff(staff).build();
    }
}
