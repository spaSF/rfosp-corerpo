package com.gratex.helloworld;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/hello")
public class HelloController {
    @Value("${hello.message:world}")
    private String message;

    @GetMapping
    public String hello() {
        return "Hello "+ message;
    }
}
