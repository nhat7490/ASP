package com.caps.asp;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.database.*;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@SpringBootApplication
public class AspApplication {

    public static void main(String[] args) {

        SpringApplication.run(AspApplication.class, args);
        FileInputStream serviceAccount = null;
        try {
            serviceAccount = new FileInputStream("D:\\Capstone\\ASP\\asp\\src\\main\\resources\\accommodation-ad340-firebase-adminsdk-dg6g4-2c59734e89.json");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        FirebaseOptions options = null;
        try {
            options = new FirebaseOptions.Builder()
                    .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                    .setDatabaseUrl("https://accommodation-ad340.firebaseio.com/")
                    .build();
        } catch (IOException e) {
            e.printStackTrace();
        }

        FirebaseApp.initializeApp(options);

        final FirebaseDatabase database = FirebaseDatabase.getInstance();
        DatabaseReference ref = database.getReference("notifications/user");
        DatabaseReference usersRef = ref.child("user");

        Map<String,String> noti = new HashMap<>();

        noti.put("aa","bbb");
        noti.put("aaaaa","aaaaaabbb");
        usersRef.setValueAsync(noti);

    }

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
