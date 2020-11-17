package pt.ist.ccu2021.queued.Server.domain;

import lombok.*;

import javax.persistence.*;
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
    private int storeid;

    @Column(name = "userid")
    private int userId;

    @Column(name = "inline")
    private boolean inline;

    @Column(name = "enteringtime")
    private Time enteringTime;

    @Column(name = "leavingtime")
    private Time leavingTime;
}
