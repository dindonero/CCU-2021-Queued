package pt.ist.ccu2021.queued.Server;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import pt.ist.ccu2021.queued.Server.dto.LoginUserAccountDto;
import pt.ist.ccu2021.queued.Server.dto.UserAccountDto;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@SpringBootTest
public class UserTests {

    private SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
    private UserAccountDto user = UserAccountDto.builder().firstName("Francisco").lastName("Morgado").password("asdasdasd").build();
    private String registerUrl = "http://localhost:8080/user/register";
    private String loginUrl = "http://localhost:8080/user/login";
    private RestTemplate rest = new RestTemplate();

    @BeforeEach
    public void beforeEach(){
        user.setEmail(ServerApplicationTests.generateRandomString());
        try {
            user.setDateOfBirth(formatter.parse(formatter.format(new Date())));
        } catch (ParseException e) {
            // do nothing
        }
    }

    @Test
    void createNewUser_ReturnsUserId(){
        int response = rest.postForObject(registerUrl, user, Integer.class);
        Assertions.assertNotEquals(-1, response);
    }

    @Test
    void createDuplicateUserWithDuplicateEmailException_ThrowsConflictException(){
        rest.postForObject(registerUrl, user, Integer.class);
        Assertions.assertThrows(HttpClientErrorException.Conflict.class, () -> rest.postForObject(registerUrl, user, Integer.class));
    }

    @Test
    void registerAndThenLoginUser_ReturnsUser(){
        user.setId(rest.postForObject(registerUrl, user, Integer.class));
        LoginUserAccountDto loginUser = LoginUserAccountDto.builder().email(user.getEmail()).password(user.getPassword()).build();
        Assertions.assertEquals(user, rest.postForObject(loginUrl, loginUser, UserAccountDto.class));
    }

    @Test
    void registerAndThenLoginWithWrongPassword_ThrowsConflictException(){
        user.setId(rest.postForObject(registerUrl, user, Integer.class));
        LoginUserAccountDto loginUser = LoginUserAccountDto.builder().email(user.getEmail()).password("WrongPassword").build();
        Assertions.assertThrows(HttpClientErrorException.Forbidden.class, () -> rest.postForObject(loginUrl, loginUser, Integer.class));
    }

    @Test
    void loginWithNonExistingEmail_ThrowsNotFoundException(){
        user.setId(rest.postForObject(registerUrl, user, Integer.class));
        LoginUserAccountDto loginUser = LoginUserAccountDto.builder().email("NonExistingEmail").password("MayBeRightPassword").build();
        Assertions.assertThrows(HttpClientErrorException.NotFound.class, () -> rest.postForObject(loginUrl, loginUser, Integer.class));
    }
}
