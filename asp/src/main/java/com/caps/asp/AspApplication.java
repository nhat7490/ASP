package com.caps.asp;

import com.caps.asp.service.FireBaseService;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@SpringBootApplication
public class AspApplication {
    public static void main(String[] args) {
        SpringApplication.run(AspApplication.class, args);
        FireBaseService fireBaseService = new FireBaseService();
        fireBaseService.initialize();
    }

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
