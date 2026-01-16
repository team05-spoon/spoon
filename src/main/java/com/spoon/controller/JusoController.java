package com.spoon.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class JusoController {

    @RequestMapping("/jusoPopup")
    public String jusoPopup() {
        return "jusoPopup"; // src/main/webapp/WEB-INF/jsp/jusoPopup.jsp
    }
}
