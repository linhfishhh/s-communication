package com.tech.backend.communication.config;

import com.zaxxer.hikari.HikariDataSource;
import java.util.Properties;
import javax.persistence.EntityManagerFactory;
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.env.Environment;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;

/**
 * Author: chautn on 6/6/2018 10:52 PM
 */
@Configuration
public class DatabaseConfig {

  @Autowired
  private Environment env;

  @Bean
  @Primary
  @ConfigurationProperties(prefix = "spring.datasource")
  public DataSourceProperties dataSourceProperties() {
    return new DataSourceProperties();
  }

  @Bean
  public DataSource dataSource() {
    DataSourceProperties properties = dataSourceProperties();
    return DataSourceBuilder
        .create()
        .driverClassName(properties.getDriverClassName())
        .url(properties.getUrl())
        .username(properties.getUsername())
        .password(properties.getPassword())
        .type(HikariDataSource.class)
        .build();
  }

  @Bean
  public EntityManagerFactory entityManagerFactory() {
    LocalContainerEntityManagerFactoryBean factoryBean = new LocalContainerEntityManagerFactoryBean();
    factoryBean.setDataSource(dataSource());
    factoryBean.setPackagesToScan("com.tech.backend.communication.model.entity");
    factoryBean.setJpaVendorAdapter(new HibernateJpaVendorAdapter());
    factoryBean.setJpaProperties(jpaProperties());
    factoryBean.afterPropertiesSet();
    return factoryBean.getObject();
  }

  @Bean
  public JpaTransactionManager transactionManager() {
    return new JpaTransactionManager(entityManagerFactory());
  }

  private Properties jpaProperties() {
    Properties properties = new Properties();
    properties.put("hibernate.dialect", env.getRequiredProperty("spring.jpa.hibernate.dialert"));
    properties.put("hibernate.show_sql", env.getRequiredProperty("spring.jpa.hibernate.showSql"));
    properties.put("hibernate.temp.use_jdbc_metadata_defaults", env.getRequiredProperty("spring.jpa.hibernate.use_jdbc_metadata_defaults"));
    properties.put("hibernate.enable_lazy_load_no_trans", env.getRequiredProperty("spring.jpa.hibernate.enable_lazy_load_no_trans"));

    return properties;
  }

}
