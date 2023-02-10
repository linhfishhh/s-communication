package com.tech.backend.communication.config;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import org.apache.http.config.SocketConfig;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Author: chautn on 7/4/2018 7:18 PM
 */
@Configuration
public class PoolConfig {

  @Bean
  PoolingHttpClientConnectionManager httpClientConnectionManager() {
    PoolingHttpClientConnectionManager httpClientPool = new PoolingHttpClientConnectionManager();
    httpClientPool.setDefaultMaxPerRoute(10);
    httpClientPool.setMaxTotal(100);
    httpClientPool.setDefaultSocketConfig(SocketConfig.custom().setSoTimeout(5000).build());
    httpClientPool.closeIdleConnections(5, TimeUnit.SECONDS);
    return httpClientPool;
  }

  @Bean
  ExecutorService executorService() {
    return new ThreadPoolExecutor(10, 100, 5, TimeUnit.SECONDS, new LinkedBlockingQueue<>(1000));
  }

}
