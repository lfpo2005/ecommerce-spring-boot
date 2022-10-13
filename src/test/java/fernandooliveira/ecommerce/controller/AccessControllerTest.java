package fernandooliveira.ecommerce.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import fernandooliveira.ecommerce.EcommerceSpringbootApplication;
import fernandooliveira.ecommerce.model.Acesso;
import fernandooliveira.ecommerce.repository.AcessoRepository;
import fernandooliveira.ecommerce.util.ExceptionMentoriaJava;
import junit.framework.TestCase;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Profile;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.DefaultMockMvcBuilder;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

import static java.time.LocalTime.now;

@Profile("dev")
@SpringBootTest(classes = EcommerceSpringbootApplication.class)
class AccessControllerTest  extends TestCase {


    @Autowired
    private AcessoController acessoController;
    @Autowired
    private AcessoRepository acessoRepository;

    @Autowired
    private WebApplicationContext wac;

    @Test
    public void testRestApiPostController() throws JsonProcessingException, Exception {

        DefaultMockMvcBuilder builder = MockMvcBuilders.webAppContextSetup(this.wac);
        MockMvc mockMvc = builder.build();

        Acesso access = new Acesso();
        access.setDescricao("ROLE_BUYER" + now());

        ObjectMapper objectMapper = new ObjectMapper();

        ResultActions returnApi = mockMvc
                .perform(MockMvcRequestBuilders.post("/access")
                        .content(objectMapper.writeValueAsString(access))
                        .accept(MediaType.APPLICATION_JSON)
                        .contentType(MediaType.APPLICATION_JSON));

        System.out.println("Return the Api: -------> " + returnApi.andReturn().getResponse().getContentAsString());

        Acesso objectReturn = objectMapper
                .readValue(returnApi
                                .andReturn()
                                .getResponse()
                                .getContentAsString(),
                        Acesso.class);

        assertEquals(access.getDescricao(), objectReturn.getDescricao());


    }

    @Test
    public void testRestApiDeleteController() throws JsonProcessingException, Exception {

        DefaultMockMvcBuilder builder = MockMvcBuilders.webAppContextSetup(this.wac);
        MockMvc mockMvc = builder.build();

        Acesso access = new Acesso();
        access.setDescricao("ROLE_TEST_DELETE");

        access = acessoRepository.save(access);

        ObjectMapper objectMapper = new ObjectMapper();

        ResultActions returnApi = mockMvc
                .perform(MockMvcRequestBuilders.delete("/access/" + access.getId())
                        .content(objectMapper.writeValueAsString(access.getId()))
                        .accept(MediaType.APPLICATION_JSON)
                        .contentType(MediaType.APPLICATION_JSON));

        System.out.println("Return the Api: -------> " + returnApi.andReturn().getResponse().getContentAsString());
        System.out.println("Return the Status: -------> " + returnApi.andReturn().getResponse().getStatus());

        assertEquals("Access deleted success!!!", returnApi.andReturn().getResponse().getContentAsString());
        assertEquals(200, returnApi.andReturn().getResponse().getStatus());


    }

    @Test
    public void testRestApiGetByIdController() throws JsonProcessingException, Exception {

        DefaultMockMvcBuilder builder = MockMvcBuilders.webAppContextSetup(this.wac);
        MockMvc mockMvc = builder.build();

        Acesso access = new Acesso();
        access.setDescricao("ROLE_TEST_BY_ID");

        access = acessoRepository.save(access);

        ObjectMapper objectMapper = new ObjectMapper();

        ResultActions returnApi = mockMvc
                .perform(MockMvcRequestBuilders.get("/access/" + access.getId())
                        .content(objectMapper.writeValueAsString(access.getId()))
                        .accept(MediaType.APPLICATION_JSON)
                        .contentType(MediaType.APPLICATION_JSON));

        assertEquals(200, returnApi.andReturn().getResponse().getStatus());

        Acesso accessReturn = objectMapper.readValue(returnApi.andReturn().getResponse().getContentAsString(), Acesso.class);
        assertEquals(access.getDescricao(), accessReturn.getDescricao());

        acessoRepository.deleteById(access.getId());
    }

    @Test
    public void testRestApiGetByDescController() throws JsonProcessingException, Exception {

        DefaultMockMvcBuilder builder = MockMvcBuilders.webAppContextSetup(this.wac);
        MockMvc mockMvc = builder.build();

        Acesso access = new Acesso();
        access.setDescricao("ROLE_TEST_BY_DESCRIPTION");

        access = acessoRepository.save(access);

        ObjectMapper objectMapper = new ObjectMapper();

        ResultActions returnApi = mockMvc
                .perform(MockMvcRequestBuilders.get("/access/search/BY_DESCRIPTION")
                        .content(objectMapper.writeValueAsString(access.getId()))
                        .accept(MediaType.APPLICATION_JSON)
                        .contentType(MediaType.APPLICATION_JSON));

        assertEquals(200, returnApi.andReturn().getResponse().getStatus());

        List<Acesso> returnApiList = objectMapper
                .readValue(returnApi.andReturn()
                                .getResponse().getContentAsString(),
                        new TypeReference<List<Acesso>>() {});

        assertEquals(1, returnApiList.size());
        assertEquals(access.getDescricao(), returnApiList.get(0).getDescricao());

        acessoRepository.deleteById(access.getId());
    }


    @Test
    public void testAccessController(){

        Acesso access = new Acesso();

        access.setDescricao("ROLE_USER");
        assertEquals(true, access.getId() == null);
        try {
            access = (Acesso) acessoController.save(access).getBody();
        } catch (ExceptionMentoriaJava e) {
            throw new RuntimeException(e);
        }

        assertEquals(true, access.getId() > 0);
        assertEquals("ROLE_USER", access.getDescricao());

        Acesso access2 = acessoRepository.findById(access.getId()).get();
        assertEquals(access.getId(), access2.getId());

        acessoRepository.deleteById(access2.getId());
        acessoRepository.flush();

        Acesso access3 = acessoRepository.findById(access2.getId()).orElse(null);
        assertEquals(true, access3 == null);
    }


}