package controller;

import domain.UserVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@Slf4j
public class HelloController {
    @GetMapping("/index")
    public void index() {
        log.info("HelloController - index()");
    }


    @ResponseBody
    @GetMapping(value = "/rest",
            produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
    public UserVO rest() {
        log.info("HelloController - rest()");
        UserVO user = new UserVO();
        user.setUsername("deneb1593");
        user.setPassword("1593");
        log.info("user info: {}", user);
        return user;
    }

    @GetMapping("/redirect")
    public String redirect(RedirectAttributes attr) {
        log.info("HelloController - redirect()");
        attr.addFlashAttribute("result", "spring");
        return "redirect:/index";
    }
}