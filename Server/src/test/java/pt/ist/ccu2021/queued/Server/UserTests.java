package pt.ist.ccu2021.queued.Server;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.web.client.RestTemplate;
import pt.ist.ccu2021.queued.Server.dto.UserAccountDto;

import java.util.Date;

@SpringBootTest
public class UserTests {

    private UserAccountDto user = UserAccountDto.builder().firstName("Francisco").lastName("Morgado").email("franciscomanhas@gmail.com").password("asdasdasd").dateOfBirth(new Date()).build();
    private String url = "http://localhost:8080/user/";
    private RestTemplate rest = new RestTemplate();

    @BeforeEach
    public void beforeEach(){
        user.setEmail(ServerApplicationTests.generateRandomString());
    }

    @Test
    void createNewUser(){
        int response = rest.postForObject(url, user, Integer.class);
        Assertions.assertNotEquals(-1, response);
    }

    @Test
    void createDuplicateUserWithDuplicateEmailException_ReturnsNegativeOne(){
        rest.postForObject(url, user, Integer.class);
        Assertions.assertEquals(-1, rest.postForObject(url, user, Integer.class));
    }
}
