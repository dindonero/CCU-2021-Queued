package pt.ist.ccu2021.queued.Server.domain;

import lombok.*;

import javax.persistence.*;
import java.util.Date;

@Builder
@Setter @Getter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "useraccount")
public class UserAccount {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "firstname")
    private String firstName;

    @Column(name = "lastname")
    private String lastName;

    @Column(name = "email")
    private String email;

    @Column(name = "password")
    private String password;

    @Column(name = "dateofbirth")
    private Date dateOfBirth;
}
