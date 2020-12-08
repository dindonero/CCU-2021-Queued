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
@JsonPropertyOrder({"id", "firstName", "lastName", "email", "password"})
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

    public UserAccountDto(UserAccount user){
        id = user.getId();
        firstName = user.getFirstName();
        lastName = user.getLastName();
        email = user.getEmail();
        password = user.getPassword();
        //dateOfBirth = user.getDateOfBirth().toInstant().toEpochMilli();

    }

    public UserAccount toDomain(){
        return UserAccount.builder().firstName(firstName).lastName(lastName).email(email)
                .password(password)/*.dateOfBirth(new Date(dateOfBirth))*/.build();
    }
}