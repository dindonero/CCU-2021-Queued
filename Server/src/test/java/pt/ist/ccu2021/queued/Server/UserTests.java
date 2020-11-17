package pt.ist.ccu2021.queued.Server;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.util.Assert;
import org.springframework.web.client.RestTemplate;
import pt.ist.ccu2021.queued.Server.domain.UserAccount;
import pt.ist.ccu2021.queued.Server.dto.UserAccountDto;

import java.util.Date;

@SpringBootTest
public class UserTests {

    private UserAccountDto user = UserAccountDto.builder().firstName("Francisco").lastName("Morgado").email("franciscomanhas@gmail.com").password("asdasdasd").dateOfBirth(new Date()).build();
    private String url = "http://localhost:8080/user/";

    @Test
    void createNewUser(){
        RestTemplate rest = new RestTemplate();
        int response = rest.postForObject(url, user, Integer.class);
        Assertions.assertNotEquals(-1, response);
    }
}
