package com.tech.backend.communication.client.config.sms;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.tech.backend.communication.client.response.SmsBrandNameFptAccessToken;
import feign.RequestInterceptor;
import feign.RequestTemplate;
import java.lang.reflect.Type;
import java.nio.charset.Charset;
import java.util.Map;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;

/**
 * @author nguyen.tam.thi at 16:21 2020-10-12
 */
public class SmsBrandNameInterceptor implements RequestInterceptor {

  @Autowired
  private Environment env;

  @Autowired
  private SmsBrandNameFptAccessToken smsBrandNameFptAccessToken;

  @Autowired
  private SmsBrandNameService smsBrandNameService;

  @Autowired
  private Gson gson;

  @Override
  public void apply(RequestTemplate requestTemplate) {
    if (env.getRequiredProperty("sms_brand_name.supplier.fpt.path.oauth2").equals(requestTemplate.url())) {
      return;
    }
    if (StringUtils.isBlank(smsBrandNameFptAccessToken.getAccessToken()) ||
        smsBrandNameFptAccessToken.getAccessToken().equals(SmsBrandNameFptAccessToken.DEFAULT_ACCESS_TOKEN)) {
      smsBrandNameService.smsBrandNameFptAuthenticate();
    }

    Type type = new TypeToken<Map<String, Object>>(){}.getType();
    Map<String, Object> body = gson.fromJson(new String(requestTemplate.body(), Charset.forName("UTF-8")), type);
    body.put("access_token", smsBrandNameFptAccessToken.getAccessToken());
    String bodyData = gson.toJson(body);
    requestTemplate.body(bodyData);
  }
}
