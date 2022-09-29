package com.gratex.helloworld.config;

import io.micrometer.core.instrument.binder.commonspool2.CommonsObjectPool2Metrics;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppConfig {

    @Bean
    protected CommonsObjectPool2Metrics commonsPool2Metrics(){
        return new CommonsObjectPool2Metrics();
    }
}
