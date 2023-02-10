package com.tech.backend.communication.service;

import com.tech.backend.communication.model.entity.Sms;
import com.tech.backend.communication.model.enumeration.SupportedLanguage;
import com.tech.backend.communication.model.request.ProviderSmsBrandNameConfig;
import com.tech.backend.communication.model.request.SmsRequest;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.springframework.data.domain.Page;

/**
 * @author nguyen.tam.thi at 10:51 2020-10-12
 */
public interface SmsService {

  /**
   * Put sms to sending queue
   * @param request
   */
  void send(SmsRequest request);

  /**
   * Send sms immediately
   * @param sms
   * @return
   */
  public Sms send(Sms sms, ProviderSmsBrandNameConfig providerSmsBrandNameConfig);

  /**
   * Send sms immediately
   * @param smsId
   * @return
   */
  public Sms send(Long smsId, ProviderSmsBrandNameConfig providerSmsBrandNameConfig);

  /**
   * Executor method
   * @param smsId
   */
  void executeSendSms(Long smsId);

  void executeSendSms(Long smsId, ProviderSmsBrandNameConfig providerSmsBrandNameConfig);
}
