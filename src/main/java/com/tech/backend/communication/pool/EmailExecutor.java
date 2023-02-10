package com.tech.backend.communication.pool;

import com.tech.backend.communication.service.EmailService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by chautn on 8/11/2017.
 */
public class EmailExecutor implements Runnable {

  public final Logger logger = LoggerFactory.getLogger(EmailExecutor.class);

  private EmailService emailService;
    private Long emailId;

    public EmailExecutor(EmailService emailService, Long emailId) {
      this.emailService = emailService;
      this.emailId = emailId;
    }

    @Override
    public void run() {
      int count = 0;
      while (count < 5) {
        try {
          logger.info("Start sending email: " + emailId);
          emailService.send(emailId);
          logger.info("Send email success: " + emailId);
          break;
        } catch (Exception e) {
          count++;
          logger.info("Send email fail: " + emailId + ". Retrying... " + count);
          try {
            Thread.sleep(1000);
          } catch (InterruptedException e1) {
            logger.error("Internal error: ", e1);
          }
        }
      }

      if (count == 3) {
        logger.error("Can not send email: " + emailId + ". Please check bugs...");
      }
    }

}
