package com.tech.backend.communication.client;

import com.tech.backend.communication.client.request.SMSBrandNameHtcRequest;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author chuanlh on 2021-03-24
 */
@FeignClient(name = "smsBrandNameHtc", url = "${sms_brand_name.supplier.htc.host}")
public interface SmsBrandNameHtcClient {

  @RequestMapping(method = RequestMethod.POST, value = "/sms_api", consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
  String sendSmsWithBrand(@RequestBody SMSBrandNameHtcRequest request);
}
