package com.exp.backboot.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class MvcConfiguration implements WebMvcConfigurer {

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("index");
        registry.addViewController("/new").setViewName("new");
        registry.addViewController("/engineTable").setViewName("engineTable");
        registry.addViewController("/tableSetting").setViewName("tableSetting");
        registry.addViewController("/menu").setViewName("menu");
    }
}
