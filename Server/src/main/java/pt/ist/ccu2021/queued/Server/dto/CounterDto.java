package pt.ist.ccu2021.queued.Server.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import lombok.*;
import pt.ist.ccu2021.queued.Server.domain.Category;
import pt.ist.ccu2021.queued.Server.domain.Counter;


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

    public CounterDto(Counter counter){
        id = counter.getId();
        name = counter.getName();
        storeId = counter.getStoreid();
        hasStaff = counter.isHasStaff();
    }

    public Counter toDomain(){
        return Counter.builder().name(name).storeid(storeId).hasStaff(hasStaff).build();
    }
}
