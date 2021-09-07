package controller;

import config.RootConfig;
import config.ServletConfig;
import domain.UserVO;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.ui.ModelMap;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(classes = {RootConfig.class, ServletConfig.class})
@Slf4j
public class BoardControllerTests {
    @Setter(onMethod_ = {@Autowired})
    private WebApplicationContext context;

    private MockMvc mockMvc;

    @Before
    public void setup() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    @Ignore
    public void testRest() throws Exception {
        ModelMap map = mockMvc.perform(MockMvcRequestBuilders.get("/rest"))
                .andReturn()
                .getModelAndView()
                .getModelMap();

            UserVO user = (UserVO) map.get("user");
            log.info(user.toString());
            assertEquals(user.getUsername(), "deneb1593");
    }

    @Test
    @Ignore
    public void testRedirect() throws Exception {
        String viewName = mockMvc.perform(MockMvcRequestBuilders.get("/redirect"))
                .andReturn()
                .getModelAndView()
                .getViewName();

        log.info("viewName: {}", viewName);
    }

    @Test
    @Ignore
    public void testRegister() throws Exception {
        ModelAndView model = mockMvc.perform(MockMvcRequestBuilders.post("/board/register")
                .param("title", "BoardController register Test Title")
                .param("content", "BoardController register Test Content")
                .param("writer", "BoardController Test")
        ).andReturn().getModelAndView();

        //redirect:/board/list
        log.info("Return ViewName" + model.getViewName());
        log.info("Return Values: " + model.getModel());
    }

    @Test
    public void testListWithPaging() throws Exception {
        ModelMap modelMap = mockMvc.perform(
                MockMvcRequestBuilders.get("/board/list")
                        .param("pageNum", "1")
                        .param("amount", "5"))
                .andReturn().getModelAndView().getModelMap();

        log.info("{}", modelMap);
    }
}
