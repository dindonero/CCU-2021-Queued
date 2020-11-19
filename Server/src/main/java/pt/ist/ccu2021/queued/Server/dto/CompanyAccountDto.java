package pt.ist.ccu2021.queued.Server.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import lombok.*;
import pt.ist.ccu2021.queued.Server.domain.CompanyAccount;
import pt.ist.ccu2021.queued.Server.domain.UserAccount;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
@ToString
@JsonPropertyOrder({"id", "name", "email", "password", "secondaryEmail"})
public class CompanyAccountDto {

    @JsonProperty("id")
    private int id;

    @JsonProperty("name")
    private String name;

    @JsonProperty("email")
    private String email;

    @JsonProperty("password")
    private String password;

    @JsonProperty("secondaryEmail")
    private String secondaryEmail;

    public CompanyAccountDto(CompanyAccount company){
        id = company.getId();
        name = company.getName();
        email = company.getEmail();
        password = company.getPassword();
        secondaryEmail = company.getSecondaryEmail();

    }
    public CompanyAccount toDomain(){
        return CompanyAccount.builder().name(name).email(email)
                .password(password).secondaryEmail(secondaryEmail).build();
    }
}
