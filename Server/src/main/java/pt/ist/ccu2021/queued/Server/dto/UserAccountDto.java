package pt.ist.ccu2021.queued.Server.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import lombok.*;
import pt.ist.ccu2021.queued.Server.domain.UserAccount;

import java.io.Serializable;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter @Setter
@ToString
@JsonPropertyOrder({"id", "firstName", "lastName", "email", "password", "dateOfBirth"})
public class UserAccountDto implements Serializable {

    @JsonProperty("id")
    private int id;

    @JsonProperty("firstName")
    private String firstName;

    @JsonProperty("lastName")
    private String lastName;

    @JsonProperty("email")
    private String email;

    @JsonProperty("password")
    private String password;

    @JsonProperty("dateOfBirth")
    private Date dateOfBirth;

    public UserAccount toDomain(){
        return UserAccount.builder().id(id).firstName(firstName).lastName(lastName).email(email)
                .password(password).dateOfBirth(dateOfBirth).build();
    }
}