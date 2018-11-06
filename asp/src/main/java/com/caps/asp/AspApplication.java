package com.caps.asp;

import com.caps.asp.util.GoogleAPI;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@SpringBootApplication
public class AspApplication {

	public static void main(String[] args) {
		SpringApplication.run(AspApplication.class, args);
		GoogleAPI googleAPI = new GoogleAPI();
		System.out.println(googleAPI.getLocationName(10.7723159, 106.6917893).addressComponents.length);
		System.out.println(googleAPI.getLocationName(10.989514,106.5694446).formattedAddress);
		System.out.println(googleAPI.getLocationName(10.989514,106.5694446).formattedAddress.split(",")[2]);
		System.out.println(googleAPI.getLocationName(10.7723159, 106.6917893).addressComponents[0]);
		System.out.println(googleAPI.getLocationName(10.7723159, 106.6917893).addressComponents[1]);
		System.out.println(googleAPI.getLocationName(10.7723159, 106.6917893).addressComponents[2]);
		System.out.println(googleAPI.getLocationName(10.7723159, 106.6917893).addressComponents[3]);




	}
	@Bean
	public BCryptPasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
}
