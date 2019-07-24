package com.fasylgroup.attendance_rest;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@SpringBootApplication
@EnableJpaAuditing
public class FasylAttendanceApplication {

	public static void main(String[] args) {
		SpringApplication.run(FasylAttendanceApplication.class, args);
	}

}
