package pt.ist.ccu2021.queued.Server.domain;

import lombok.*;

import javax.persistence.*;
import java.sql.Date;
import java.sql.Time;

@Builder
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "companyaccount")
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
    private Date enteringTime;

    @Column(name = "leavingtime")
    private Date leavingTime;

    @Column(name = "staffcounter")
    private String staffCounter;

}
