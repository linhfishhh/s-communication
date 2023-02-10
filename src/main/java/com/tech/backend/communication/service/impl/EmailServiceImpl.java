package com.tech.backend.communication.service.impl;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.tech.backend.communication.common.BadRequestException;
import com.tech.backend.communication.common.ResourceBundle;
import com.tech.backend.communication.common.utils.collection.ListUtils;
import com.tech.backend.communication.common.utils.string.TemplateUtils;
import com.tech.backend.communication.model.entity.Device;
import com.tech.backend.communication.model.entity.Email;
import com.tech.backend.communication.model.entity.Template;
import com.tech.backend.communication.model.enumeration.CommunicationStatus;
import com.tech.backend.communication.model.enumeration.EmailTemplate;
import com.tech.backend.communication.model.enumeration.SupportedLanguage;
import com.tech.backend.communication.model.enumeration.TemplateEncode;
import com.tech.backend.communication.model.request.EmailRequest;
import com.tech.backend.communication.pool.EmailExecutor;
import com.tech.backend.communication.repository.EmailRepository;
import com.tech.backend.communication.service.DeviceService;
import com.tech.backend.communication.service.EmailService;
import com.tech.backend.communication.service.TemplateService;
import com.tech.backend.communication.support.mailgun.MailGunBuilder;
import com.tech.backend.communication.support.mailgun.MailGunParameter;
import freemarker.cache.StringTemplateLoader;
import freemarker.template.Configuration;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringWriter;
import java.lang.reflect.Type;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ExecutorService;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpStatus;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

/**
 * Created by doductrung
 */
@Service
public class EmailServiceImpl implements EmailService {

  public final Logger logger = LoggerFactory.getLogger(EmailServiceImpl.class);

  private static Gson gson = new Gson();

  @Autowired
  private Environment environment;

  @Autowired
  private EmailRepository emailRepository;

  @Autowired
  private TemplateService templateService;

  @Autowired
  private ExecutorService executorService;

  @Autowired
  private PoolingHttpClientConnectionManager httpClientConnectionManager;

  @Autowired
  private DeviceService deviceService;

  @Autowired
  private ResourceBundle resourceBundle;


  @Override
  public void putEmail(Long emailId) {
    if (emailId != null) {
      executorService.execute(new EmailExecutor(this, emailId));
    }
  }

  @Override
  public void send(
      String tenantId,
      Long profileId,
      String profileType,
      String email,
      EmailTemplate template,
      Map<String, Object> params,
      String cc,
      String bcc,
      String fromName,
      String replyTo) {

    Email emailEntity = buildEmail(tenantId, profileId, profileType, email, getLanguageFromDevice(profileId), template, params, cc, bcc, fromName, replyTo);
    if (emailEntity != null) {
      putEmail(emailEntity.getEmailId());
    } else {
      logger.error("Can not build email");
    }
  }

  @Override
  public void send(EmailRequest request) {
    if (request == null) {
      return;
    }
    if (StringUtils.isEmpty(request.getEmail())) {
      throw new BadRequestException(resourceBundle.getMessage("err.invalid.param", "email"));
    }
    if (StringUtils.isEmpty(request.getTemplateCode())) {
      throw new BadRequestException(resourceBundle.getMessage("err.invalid.param", "templateCode"));
    }

    send(
        request.getTenantId(),
        request.getProfileId(),
        request.getProfileType(),
        request.getEmail(),
        EmailTemplate.fromString(request.getTemplateCode()),
        request.getParams(),
        request.getCc(),
        request.getBcc(),
        request.getFromName(),
        request.getReplyTo()
    );
  }

  @Override
  public Email send(Long emailId) {
    return send(emailRepository.getOne(emailId));
  }

  @Override
  public Email send(Email email) {
    if (email == null) {
      logger.error("Can not send null email");
      return null;
    }
    @SuppressWarnings("unchecked") Set<String> whiteList = environment.getProperty("mail.white-list", Set.class);
    if (!CollectionUtils.isEmpty(whiteList) && !whiteList.contains(StringUtils.lowerCase(email.getEmail()))) {
      logger.info("Not belong to email white list: " + email.getEmail());
      return null;
    }

    CloseableHttpResponse response = null;
    try {
      Type type = new TypeToken<Map<String, Object>>() {
      }.getType();
      Map<String, Object> contentParams = StringUtils.isNotBlank(email.getContentParams()) ? gson.fromJson(email.getContentParams(), type) : new HashMap<>();
      MailGunParameter params = new MailGunParameter();
      params.setSubject(TemplateUtils.replaceParams(email.getTemplate().getTitle(), contentParams));
      if (TemplateEncode.HTML.name().equalsIgnoreCase(email.getTemplate().getEncode())) {
        params.setHtml(TemplateUtils.replaceParams(email.getTemplate().getMessage(), contentParams));
      } else if (TemplateEncode.TEXT.name().equalsIgnoreCase(email.getTemplate().getEncode())) {
        params.setText(TemplateUtils.replaceParams(email.getTemplate().getMessage(), contentParams));
      } else {
        StringTemplateLoader stringLoader = new StringTemplateLoader();
        stringLoader.putTemplate("template", email.getTemplate().getMessage());
        Configuration cfg = new Configuration(Configuration.VERSION_2_3_28);
        cfg.setTemplateLoader(stringLoader);
        cfg.setDefaultEncoding("UTF-8");
        freemarker.template.Template template = cfg.getTemplate("template");
        StringWriter writer = new StringWriter();
        template.process(contentParams, writer);
        params.setHtml(writer.toString());
      }
      params.setFromName(StringUtils.isNotEmpty(email.getFromName()) ? email.getFromName() : email.getTemplate().getFromName());
      params.setFromAddress(email.getTemplate().getFromAddress());
      params.setTo(ListUtils.stringToList(email.getEmail()));
      params.setBcc(email.getBcc());
      params.setCc(email.getCc());
      params.setReplyTo(email.getReplyTo());

      String domain = null;
      if (StringUtils.isNotEmpty(email.getTenantId())) {
        domain = environment.getProperty(String.format("mail.mailgun.domains.%s", email.getTenantId()));
      }
      if (StringUtils.isEmpty(domain)) {
        domain = environment.getRequiredProperty("mail.mailgun.default_domain");
      }
      response = HttpClients.custom().setConnectionManager(httpClientConnectionManager).build().execute(
          MailGunBuilder.requestSend(
              domain,
              environment.getProperty("mail.mailgun.api"),
              environment.getProperty("mail.mailgun.user"),
              environment.getProperty("mail.mailgun.api_key"),
              params)
      );
      BufferedReader br = new BufferedReader(new InputStreamReader((response.getEntity().getContent())));
      StringBuilder result = new StringBuilder();
      String line;
      while ((line = br.readLine()) != null) {
        result.append(line);
      }
      br.close();

      if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
        email.setDeliveryTime(new Timestamp(Calendar.getInstance().getTimeInMillis()));
        email.setResult(result.toString());
        email.setStatus(CommunicationStatus.DELIVERED.name());
      } else {
        email.setResult("Send email fail to MailGun [HttpStatus=" + response.getStatusLine().getStatusCode() + "]: " + result.toString());
        email.setStatus(CommunicationStatus.FAIL_EXTERNAL.name());
        logger.error("Send email fail to MailGun [HttpStatus=" + response.getStatusLine().getStatusCode() + "]: " + result.toString());
      }
    } catch (Exception e) {
      email.setResult("Send email fail from internal");
      email.setStatus(CommunicationStatus.FAIL_INTERNAL.name());
      logger.error("Send email fail from internal", e);
    } finally {
      if (response != null) {
        try {
          response.close();
        } catch (IOException e) {
          email.setStatus(CommunicationStatus.FAIL_INTERNAL.name());
          email.setResult("Can not close response stream");
          logger.error("Can not close response stream", e);
        }
      }
      emailRepository.save(email);
    }
    return email;
  }

  //==== PRIVATE METHODS ========

  private Email buildEmail(
      String tenantId,
      Long profileId,
      String profileType,
      String email, SupportedLanguage language,
      EmailTemplate emailTemplate,
      Map<String, Object> params,
      String cc,
      String bcc,
      String fromName,
      String replyTo) {
    Template template;
    if (StringUtils.isNotEmpty(tenantId)) {
      template = templateService.getTemplateByTenantIdAndCodeAndTypeAndLanguage(
          tenantId,
          emailTemplate.getName(),
          EmailTemplate.TYPE,
          language);
    } else {
      template = templateService.getTemplateByCodeAndTypeAndLanguage(
          emailTemplate.getName(),
          EmailTemplate.TYPE,
          language);
    }
    if (template == null) {
      logger.error("Template is not found: " + emailTemplate.getName());
      return null;
    }
    Email emailEntity = new Email();
    emailEntity.setTemplate(template);
    emailEntity.setContentParams(gson.toJson(params));
    emailEntity.setEmail(StringUtils.lowerCase(email));
    emailEntity.setProfileId(profileId);
    emailEntity.setProfileType(profileType);
    emailEntity.setStatus(CommunicationStatus.INIT.name());
    emailEntity.setCc(cc);
    emailEntity.setBcc(bcc);
    emailEntity.setTenantId(tenantId);
    emailEntity.setFromName(fromName);
    emailEntity.setReplyTo(replyTo);
    emailRepository.saveAndFlush(emailEntity);
    return emailEntity;
  }

  private SupportedLanguage getLanguageFromDevice(Long profileId) {
    if (profileId == null) {
      return SupportedLanguage.VIETNAMESE;
    }
    List<Device> devices = deviceService.getDevice(profileId);
    if (CollectionUtils.isEmpty(devices)) {
      return SupportedLanguage.VIETNAMESE;
    }
    return SupportedLanguage.getSupportedLanguage(devices.get(0).getLanguage());
  }

}
