package pt.ist.ccu2021.queued.Server.domain;

import lombok.*;

import javax.persistence.*;
import java.sql.Timestamp;

@Builder
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "ticket")
public class Ticket {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "storeid")
    private int storeId;

    @Column(name = "counterid")
    private int counterId;

    @Column(name = "userid")
    private int userId;

    @Column(name = "canceled")
    private boolean canceled;

    @Column(name = "enteringtime")
    private Timestamp enteringTime;

    @Column(name = "leavingtime")
    private Timestamp leavingTime;

    @Column(name = "staffcounter")
    private String staffCounter;

}
