package pt.ist.ccu2021.queued.Server;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.web.client.RestTemplate;
import pt.ist.ccu2021.queued.Server.dto.CategoryDto;

import java.util.List;

@SpringBootTest
public class CategoryTests {

    private String url = "http://localhost:8080/category/getAll";
    private RestTemplate rest = new RestTemplate();

    @Test
    public void getAllCategories_Returns8Categories(){
        List<CategoryDto> categoryDtoList = rest.exchange(url,
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<List<CategoryDto>>() {}).getBody();
        Assertions.assertEquals(8, categoryDtoList.size());
    }
}
