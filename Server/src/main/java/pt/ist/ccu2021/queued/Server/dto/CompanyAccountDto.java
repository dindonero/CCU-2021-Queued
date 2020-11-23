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
@JsonPropertyOrder({"id", "name", "email", "password", "staffEmail", "staffPassword"})
public class CompanyAccountDto {

    @JsonProperty("id")
    private int id;

    @JsonProperty("name")
    private String name;

    @JsonProperty("email")
    private String email;

    @JsonProperty("password")
    private String password;

    @JsonProperty("staffEmail")
    private String staffEmail;

    @JsonProperty("staffPassword")
    private String staffPassword;

    public CompanyAccountDto(CompanyAccount company){
        id = company.getId();
        name = company.getName();
        email = company.getEmail();
        password = company.getPassword();
        staffEmail = company.getStaffEmail();
        staffPassword = company.getStaffPassword();
    }
    public CompanyAccount toDomain(){
        return CompanyAccount.builder().name(name).email(email)
                .password(password).staffEmail(staffEmail).staffPassword(staffPassword).build();
    }
}
