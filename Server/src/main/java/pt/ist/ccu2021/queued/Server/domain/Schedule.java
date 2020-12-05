package pt.ist.ccu2021.queued.Server.domain;

import lombok.*;

import javax.persistence.*;

@Builder
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "schedule")
public class Schedule {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "storeid")
    private int storeId;

    @Column(name = "day")
    private String day;

    @Column(name = "openingtime")
    private String openingTime;

    @Column(name = "closingtime")
    private String closingTime;
}
