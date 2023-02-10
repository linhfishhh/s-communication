package com.tech.backend.communication.service;
import com.tech.backend.communication.model.entity.Email;
import com.tech.backend.communication.model.enumeration.EmailTemplate;
import com.tech.backend.communication.model.enumeration.SupportedLanguage;
import com.tech.backend.communication.model.request.EmailRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by chautn on 8/11/2017.
 */
public interface EmailService {

  /**
   * @author chautn
   * @param emailId
   */
  void putEmail(Long emailId);

  /**
   * send email to an user
   *
   * @param tenantId
   * @param profileId
   * @param profileType
   * @param email
   * @param template
   * @param params
   * @param cc
   * @param bcc
   */
  void send(
      String tenantId,
      Long profileId,
      String profileType,
      String email,
      EmailTemplate template,
      Map<String, Object> params,
      String cc,
      String bcc,
      String fromName,
      String replyTo
  );

  /**
   * wrap up above function
   *
   * @param request
   */
  void send(EmailRequest request);

  /**
   * Do not use this method to send directly sms
   * @author chautn
   * @param emailId
   * @return
   */
  Email send(Long emailId);

  /**
   * Do not use this method to send directly sms
   * @author chautn
   * @param email
   * @return
   */
  Email send(Email email);

}
