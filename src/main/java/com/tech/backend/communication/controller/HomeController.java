package com.tech.backend.communication.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author vuld
 */
@RestController
public class HomeController {

  public static final Logger logger = LoggerFactory.getLogger(HomeController.class);

  @GetMapping("/")
  public String index() {
    return "Welcome to Stg Microservices - Communication Service";
  }


}
