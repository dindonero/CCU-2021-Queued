package pt.ist.ccu2021.queued.Server.domain;

import lombok.*;

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
    private Byte[] img;

    @Column(name = "address")
    private String address;

    @Column(name = "categoryid")
    private int categoryId;

    @Column(name = "companyid")
    private int companyId;

}
