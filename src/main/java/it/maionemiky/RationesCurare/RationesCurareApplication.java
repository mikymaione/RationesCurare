package it.maionemiky.RationesCurare;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@SpringBootApplication
public class RationesCurareApplication {

    @RequestMapping("/")
    @ResponseBody
    String home() {
        return "Welcome to RationesCurare";
    }

    public static void main(String[] args) {
        SpringApplication.run(RationesCurareApplication.class, args);
    }

}
