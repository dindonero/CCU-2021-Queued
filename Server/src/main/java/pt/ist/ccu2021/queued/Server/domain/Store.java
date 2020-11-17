package pt.ist.ccu2021.queued.Server.domain;

import lombok.*;
import org.springframework.data.geo.Point;

import javax.persistence.*;

@Builder
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "store")
public class Store {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "name")
    private String name;

    @Column(name = "img")
    private byte[] img;

    @Column(name = "mapcoords")
    private Point mapCoords;

    @Column(name = "categoryid")
    private int categoryId;

    @Column(name = "counters")
    private int counters;

    @Column(name = "companyid")
    private int companyId;
}
