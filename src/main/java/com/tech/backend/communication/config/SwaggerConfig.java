package com.tech.backend.communication.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import springfox.documentation.builders.ParameterBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.schema.ModelRef;
import springfox.documentation.service.ApiKey;
import springfox.documentation.service.AuthorizationScope;
import springfox.documentation.service.Parameter;
import springfox.documentation.service.SecurityReference;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spi.service.contexts.SecurityContext;
import springfox.documentation.spring.web.paths.RelativePathProvider;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

import javax.servlet.ServletContext;
import java.util.Collections;
import java.util.List;

/**
 * @author nguyen.tam.thi at 08:29 2019-08-11
 */
@Configuration
@EnableSwagger2
public class SwaggerConfig {
    public static final String AUTHORIZATION_HEADER = "Authorization";
    public static final String TENANT_ID_HEADER = "Tenant-Id";
    public static final String TENANT_ID_HEADER_DESCRIPTION = "Tenant Id: (isalon/tenant-bukizi)";
    public static final String DEFAULT_TENANT_ID = "isalon";

    @Autowired
    private ServletContext servletContext;

    @Autowired
    private Environment environment;

    @Bean
    public Docket api() {
        Boolean isLocal = Boolean.parseBoolean(environment.getProperty("api.local", "false"));
        return new Docket(DocumentationType.SWAGGER_2)
            .globalOperationParameters(defaultParameters())
            .securityContexts(Collections.singletonList(securityContext()))
            .securitySchemes(Collections.singletonList(apiKey()))
            .host(!isLocal ? environment.getProperty("api.host") : null)
            .pathProvider(new RelativePathProvider(servletContext) {
                @Override
                public String getApplicationBasePath() {
                    return isLocal ? super.getApplicationBasePath() : "/communication";
                }
            })
            .protocols(Collections.singleton(isLocal ? "http" : "https"))
            .select()
            .apis(RequestHandlerSelectors.any())
            .paths(PathSelectors.any())
            .build();
    }

    private ApiKey apiKey() {
        return new ApiKey("JWT", AUTHORIZATION_HEADER, "header");
    }

    private SecurityContext securityContext() {
        return SecurityContext.builder()
                .securityReferences(defaultAuth())
                .forPaths(PathSelectors.any())
                .build();
    }

    List<SecurityReference> defaultAuth() {
        AuthorizationScope authorizationScope = new AuthorizationScope("global", "accessEverything");
        AuthorizationScope[] authorizationScopes = new AuthorizationScope[1];
        authorizationScopes[0] = authorizationScope;
        return Collections.singletonList(new SecurityReference("JWT", authorizationScopes));
    }

    List<Parameter> defaultParameters() {
        return Collections.singletonList(
                new ParameterBuilder()
                        .name(TENANT_ID_HEADER)
                        .description(TENANT_ID_HEADER_DESCRIPTION)
                        .modelRef(new ModelRef("string"))
                        .parameterType("header")
                        .defaultValue(DEFAULT_TENANT_ID)
                        .required(true)
                        .build());
    }
}
