package com.tech.backend.communication.pool;

import com.tech.backend.communication.model.entity.Sms;
import com.tech.backend.communication.model.request.ProviderSmsBrandNameConfig;
import com.tech.backend.communication.service.SmsService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author nguyen.tam.thi at 16:08 2020-10-12
 */
@Slf4j
public class SmsExecutor implements Runnable {

  public final Logger logger = LoggerFactory.getLogger(SmsExecutor.class);

  private SmsService smsService;
  private Long smsId;
  private ProviderSmsBrandNameConfig providerSmsBrandNameConfig;

  public SmsExecutor(SmsService smsService, Long smsId, ProviderSmsBrandNameConfig providerSmsBrandNameConfig) {
    this.smsService = smsService;
    this.smsId = smsId;
    this.providerSmsBrandNameConfig = providerSmsBrandNameConfig;
  }

  @Override
  public void run() {
    int count = 0;
    while (count < 5) {
      try {
        logger.info("Start sending sms: " + smsId);
        Sms sms = smsService.send(smsId, providerSmsBrandNameConfig);
        logger.info(sms.getResult());
        break;
      } catch (Exception e) {
        count++;
        logger.info("Send sms fail: " + smsId + ". Retrying... " + count);
        try {
          Thread.sleep(1000);
        } catch (InterruptedException e1) {
          logger.error("Internal error: ", e1);
        }
      }
    }

    if (count == 3) {
      logger.error("Can not send sms: " + smsId + ". Please check bugs...");
    }
  }
}

