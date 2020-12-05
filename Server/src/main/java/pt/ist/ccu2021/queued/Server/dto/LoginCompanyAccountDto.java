package pt.ist.ccu2021.queued.Server.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import lombok.*;
import pt.ist.ccu2021.queued.Server.domain.CompanyAccount;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
@ToString
@JsonPropertyOrder({"email", "password"})
public class LoginCompanyAccountDto {
    @JsonProperty("email")
    private String email;

    @JsonProperty("password")
    private String password;

    public CompanyAccount toDomain(){
        return CompanyAccount.builder().email(email).password(password).build();
    }

}
