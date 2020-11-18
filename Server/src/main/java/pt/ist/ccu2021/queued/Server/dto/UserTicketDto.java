package pt.ist.ccu2021.queued.Server.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import lombok.*;
import pt.ist.ccu2021.queued.Server.domain.Schedule;
import pt.ist.ccu2021.queued.Server.domain.Store;
import pt.ist.ccu2021.queued.Server.domain.Ticket;

import javax.persistence.Column;
import java.sql.Time;
import java.util.List;
import java.util.stream.Collectors;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
@ToString
@JsonPropertyOrder({"id", "storeid", "counterid", "userId", "canceled", "enteringTime", "peopleAheadInLine", "estimatedWaitingTime", "storeName", "storeAddress"})
public class UserTicketDto {

    @JsonProperty("id")
    private int id;

    @JsonProperty("storeId")
    private int storeId;

    @JsonProperty("counterId")
    private int counterId;

    @JsonProperty("userId")
    private int userId;

    @JsonProperty("canceled")
    private boolean canceled;

    @JsonProperty("enteringTime")
    private Time enteringTime;

    @JsonProperty("peopleAheadInLine")
    private int peopleAheadInLine;

    @JsonProperty("estimatedWaitingTime")
    private Time estimatedWaitingTime;

    @JsonProperty("storeName")
    private String storeName;

    @JsonProperty("storeAddress")
    private String storeAddress;

    public UserTicketDto(Ticket ticket, int peopleAhead, Time waitingTime, String sName, String sAddress){
        id = ticket.getId();
        storeId = ticket.getStoreId();
        counterId = ticket.getCounterId();
        userId = ticket.getUserId();
        canceled = ticket.isCanceled();
        enteringTime = ticket.getEnteringTime();
        peopleAheadInLine = peopleAhead;
        estimatedWaitingTime = waitingTime;
        storeName = sName;
        storeAddress = sAddress;
    }
}
