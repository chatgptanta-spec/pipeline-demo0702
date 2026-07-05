package com.example.pipelinedemo0702.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    // 访问地址：http://localhost:8080/hello
    @GetMapping("/hello")
    public String hello() {
        return "hello 3333333333333333333333!!!!/n";
    }
}