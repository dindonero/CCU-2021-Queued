package pt.ist.ccu2021.queued.Server.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import lombok.*;
import org.springframework.data.geo.Point;
import pt.ist.ccu2021.queued.Server.domain.Store;

import javax.persistence.Column;

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

    @JsonProperty("categoryName")
    private String categoryName;

    @JsonProperty("counters")
    private int counters;

    public StoreDto(Store store){
        id = store.getId();
        name = store.getName();
        img = store.getImg();
        mapCoords = store.getMapCoords();
        // missing categoryName for companies
        counters = store.getCounters();
    }
}
