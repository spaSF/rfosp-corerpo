package com.gratex.helloworld.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class OpenApiConfig implements WebMvcConfigurer {

    @Bean
    protected OpenAPI openAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("API")
                        .description("rest api")
                        .version("v0.0.1"));
    }
}

