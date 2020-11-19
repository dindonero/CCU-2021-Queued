package pt.ist.ccu2021.queued.Server;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.web.client.RestTemplate;
import pt.ist.ccu2021.queued.Server.dto.CompanyAccountDto;
import pt.ist.ccu2021.queued.Server.dto.ScheduleDto;
import pt.ist.ccu2021.queued.Server.dto.StoreDto;

import java.awt.*;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@SpringBootTest
public class StoreTests {

    private List<ScheduleDto> scheduleDtos = new ArrayList<>();
    private StoreDto storeDto = StoreDto.builder().categoryId(1).counters(new ArrayList<>()).img("aaa".getBytes()).schedules(scheduleDtos)
            .address("Rua Manuel Vaccines 31").name(ServerApplicationTests.generateRandomString()).build();
    private RestTemplate rest = new RestTemplate();
    private String url = "http://localhost:8080/company/1/store/register";
    private String url2 = "http://localhost:8080/category/1/store";
    private CompanyAccountDto company = CompanyAccountDto.builder().email(ServerApplicationTests.generateRandomString()).name(ServerApplicationTests.generateRandomString()).password("asdasdasd").build();


    @BeforeAll
    public static void createCompany(){
        new CompanyTests().createNewCompany_ReturnsCompanyId();
    }

    @Test
    public void whenInsertingStore_ReturnsStoreId(){
        int id = rest.postForEntity(url, storeDto, Integer.class).getBody();
        Assertions.assertNotEquals(-1, id);
    }

    @Test
    public void whenReadingStore_ReturnsSameAsInserted(){
        int id = rest.postForObject(url, storeDto, Integer.class);
        storeDto.setId(id);
        // Asserts if local store is equal to the server store with the same id
        Assertions.assertEquals(storeDto, rest.exchange(url2,
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<List<StoreDto>>(){}).getBody()
                .stream().filter(x -> x.getId() == id).collect(Collectors.toList()).get(0));
    }
}
