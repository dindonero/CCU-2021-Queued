package pt.ist.ccu2021.queued.Server.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import lombok.*;
import pt.ist.ccu2021.queued.Server.domain.UserAccount;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
@ToString
@JsonPropertyOrder({"email", "password"})
public class LoginUserAccountDto {

    @JsonProperty("email")
    private String email;

    @JsonProperty("password")
    private String password;

    public UserAccount toDomain(){
        return UserAccount.builder().email(email).password(password).build();
    }
}
