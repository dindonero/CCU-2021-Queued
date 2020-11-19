package pt.ist.ccu2021.queued.Server;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import pt.ist.ccu2021.queued.Server.dto.CompanyAccountDto;
import pt.ist.ccu2021.queued.Server.dto.LoginCompanyAccountDto;

import java.text.SimpleDateFormat;

@SpringBootTest
public class CompanyTests {

    private SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
    private CompanyAccountDto company = CompanyAccountDto.builder().email(ServerApplicationTests.generateRandomString()).name(ServerApplicationTests.generateRandomString()).password("asdasdasd").build();
    private String registerUrl = "http://localhost:8080/company/register";
    private String loginUrl = "http://localhost:8080/company/login";
    private RestTemplate rest = new RestTemplate();

    @Test
    void createNewCompany_ReturnsCompanyId(){
        int response = rest.postForObject(registerUrl, company, Integer.class);
        Assertions.assertNotEquals(-1, response);
    }

    @Test
    void createDuplicateCompanyWithDuplicateEmailException_ThrowsConflictException(){
        rest.postForObject(registerUrl, company, Integer.class);
        Assertions.assertThrows(HttpClientErrorException.Conflict.class, () -> rest.postForObject(registerUrl, company, Integer.class));
    }

    @Test
    void registerAndThenLoginCompany_ReturnsCompany(){
        company.setId(rest.postForObject(registerUrl, company, Integer.class));
        LoginCompanyAccountDto loginCompany = LoginCompanyAccountDto.builder().email(company.getEmail()).password(company.getPassword()).build();
        Assertions.assertEquals(company, rest.postForObject(loginUrl, loginCompany, CompanyAccountDto.class));
    }

    @Test
    void registerAndThenLoginWithWrongPassword_ThrowsConflictException(){
        company.setId(rest.postForObject(registerUrl, company, Integer.class));
        LoginCompanyAccountDto loginCompany = LoginCompanyAccountDto.builder().email(company.getEmail()).password("WrongPassword").build();
        Assertions.assertThrows(HttpClientErrorException.Unauthorized.class, () -> rest.postForObject(loginUrl, loginCompany, Integer.class));
    }

    @Test
    void loginWithNonExistingEmail_ThrowsNotFoundException(){
        company.setId(rest.postForObject(registerUrl, company, Integer.class));
        LoginCompanyAccountDto loginCompany = LoginCompanyAccountDto.builder().email("NonExistingEmail").password("MayBeRightPassword").build();
        Assertions.assertThrows(HttpClientErrorException.NotFound.class, () -> rest.postForObject(loginUrl, loginCompany, Integer.class));
    }
}
