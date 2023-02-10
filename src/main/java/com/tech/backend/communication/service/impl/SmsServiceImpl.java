package com.tech.backend.communication.service.impl;

import com.google.gson.Gson;
import com.tech.backend.communication.client.SmsBrandNameFptClient;
import com.tech.backend.communication.client.SmsBrandNameHtcClient;
import com.tech.backend.communication.client.request.SMSBrandNameHtcRequest;
import com.tech.backend.communication.client.request.SmsBrandNameFptPushRequest;
import com.tech.backend.communication.client.response.SMSBrandNameHtc;
import com.tech.backend.communication.client.response.SmsBrandNameFptAccessToken;
import com.tech.backend.communication.client.response.SmsBrandNameFptMessage;
import com.tech.backend.communication.common.BadRequestException;
import com.tech.backend.communication.common.NotFoundException;
import com.tech.backend.communication.common.ResourceBundle;
import com.tech.backend.communication.common.utils.string.PasswordUtils;
import com.tech.backend.communication.common.utils.string.TemplateUtils;
import com.tech.backend.communication.model.entity.Sms;
import com.tech.backend.communication.model.entity.Template;
import com.tech.backend.communication.model.enumeration.BrandNameAccountMode;
import com.tech.backend.communication.model.enumeration.Channel;
import com.tech.backend.communication.model.enumeration.CommunicationStatus;
import com.tech.backend.communication.model.mapper.SmsMapper;
import com.tech.backend.communication.model.request.ProviderSmsBrandNameConfig;
import com.tech.backend.communication.model.request.SmsRequest;
import com.tech.backend.communication.model.request.TemplateFilterRequest;
import com.tech.backend.communication.pool.SmsExecutor;
import com.tech.backend.communication.repository.SmsRepository;
import com.tech.backend.communication.repository.TemplateRepository;
import com.tech.backend.communication.service.SmsService;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.ExecutorService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.security.oauth2.common.exceptions.UnauthorizedClientException;
import org.springframework.stereotype.Service;

/**
 * @author nguyen.tam.thi at 11:01 2020-10-12
 */
@Slf4j
@Service
public class SmsServiceImpl implements SmsService {

  @Autowired
  private SmsRepository smsRepository;

  @Autowired
  private TemplateRepository templateRepository;

  @Autowired
  private ResourceBundle resourceBundle;

  @Autowired
  private SmsBrandNameFptClient smsBrandNameFptClient;

  @Autowired
  private SmsBrandNameFptAccessToken smsBrandNameFptAccessToken;

  @Autowired
  private SmsBrandNameHtcClient smsBrandNameHtcClient;

  @Autowired
  private ExecutorService executorService;

  @Autowired
  private Gson gson;

  @Autowired
  private Environment env;

  @Override
  public void executeSendSms(Long smsId) {
    if (smsId != null) {
      executorService.execute(new SmsExecutor(this, smsId, null));
    }
  }

  @Override
  public void executeSendSms(Long smsId, ProviderSmsBrandNameConfig providerSmsBrandNameConfig) {
    if (smsId != null) {
      executorService.execute(new SmsExecutor(this, smsId, providerSmsBrandNameConfig));
    }
  }

  @Override
  public void send(SmsRequest request) {
    if (StringUtils.isEmpty(request.getPhone())) {
      throw new BadRequestException(resourceBundle.getMessage("err.require.param", "phone"));
    }
    Long templateId = null;
    if (StringUtils.isNotEmpty(request.getTemplateCode())) {
      TemplateFilterRequest templateFilterRequest = TemplateFilterRequest
          .builder()
          .templateCode(request.getTemplateCode())
          .language(request.getLanguage())
          .tenantId(request.getTenantId())
          .type(Channel.SMS.name())
          .build();
      List<Template> templates = templateRepository.filter(templateFilterRequest);
      if (templates.isEmpty()) {
        throw new NotFoundException(resourceBundle.getMessage("err.template.notFound"));
      }
      Template template = templates.get(0);
      templateId = template.getTemplateId();
    }

    String[] phones = request.getPhone().split("\\s*,\\s*");
    List<Sms> smsList = new ArrayList<>();
    for (int i = 0; i < phones.length; i++) {
      Sms sms = new Sms();
      if (templateId != null) {
        sms.setTemplateId(templateId);
      } else if (StringUtils.isNotEmpty(request.getCustomContent())) {
        sms.setCustomContent(request.getCustomContent());
      } else {
        throw new BadRequestException(resourceBundle.getMessage("err.invalid.param"));
      }
      sms.setProfileId(request.getProfileId());
      sms.setTenantId(request.getTenantId());
      sms.setCustomContent(request.getCustomContent());
      sms.setContentParams(SmsMapper.INSTANCE.covertParamsToString(request.getParams()));
      sms.setProviderId(request.getProviderId());
      sms.setBrandName(request.getBrandName());
      if (request.getProviderSmsBrandNameConfig() != null) {
        sms.setBrandNameAccountMode(
            (request.getProviderSmsBrandNameConfig().getBrandNameAccountMode() != null && request.getProviderSmsBrandNameConfig().getBrandNameAccountMode()
                .equals(BrandNameAccountMode.EXTERNAL) ? BrandNameAccountMode.EXTERNAL : BrandNameAccountMode.BUKIZI));
      } else {
        sms.setBrandNameAccountMode(BrandNameAccountMode.BUKIZI);
      }
      String phone = phones[i];
      sms.setPhoneNumber(phone);

      smsList.add(sms);
    }
    List<Sms> savedList = smsRepository.saveAll(smsList);
    savedList.forEach(s -> executeSendSms(s.getId(), request.getProviderSmsBrandNameConfig()));
  }

  @Override
  public Sms send(Sms sms, ProviderSmsBrandNameConfig providerSmsBrandNameConfig) {
    if (sms == null) {
      log.error("Can not send null sms");
      return null;
    }
    send(sms, providerSmsBrandNameConfig, 0);
    return sms;
  }

  private Sms send(Sms sms, ProviderSmsBrandNameConfig providerSmsBrandNameConfig, int retryTime) {
    try {
      switch (env.getRequiredProperty("sms_brand_name.default_supplier")) {
        case "fpt":
          SmsBrandNameFptPushRequest request = new SmsBrandNameFptPushRequest();
          request.setAccessToken(smsBrandNameFptAccessToken.getAccessToken());
          request.setBrandName(sms.getBrandName());
          if (sms.getCustomContent() == null) {
            request.setMessage(PasswordUtils
                .base64Encode(TemplateUtils.replaceParams(sms.getTemplate().getMessage(), SmsMapper.INSTANCE.convertParamsToMap(sms.getContentParams()))));
          } else {
            request.setMessage(PasswordUtils.base64Encode(sms.getCustomContent()));
          }
          request.setPhone(sms.getPhoneNumber());
          request.setSessionId(UUID.randomUUID().toString());
          SmsBrandNameFptMessage result = smsBrandNameFptClient.push(request).getBody();
          sms.setResult("Send SMS successfully: " + gson.toJson(result));
          sms.setStatus(CommunicationStatus.DELIVERED.name());
          sms.setDeliveryTime(new Timestamp(new Date().getTime()));
          return smsRepository.save(sms);
        case "htc":
          SMSBrandNameHtcRequest htcRequest;
          if (sms.getBrandNameAccountMode().equals(BrandNameAccountMode.BUKIZI)) {
            htcRequest = SMSBrandNameHtcRequest.builder()
                .brandName(sms.getBrandName())
                .user(env.getRequiredProperty("sms_brand_name.supplier.htc.user"))
                .pass(env.getRequiredProperty("sms_brand_name.supplier.htc.password"))
                .dataEncode(1)
                .mess(sms.getCustomContent())
                .sendTime("")
                .telcoCode("")
                .phone(sms.getPhoneNumber())
                .tranId("")
                .build();
            SMSBrandNameHtc htcResult = gson.fromJson(smsBrandNameHtcClient.sendSmsWithBrand(htcRequest), SMSBrandNameHtc.class);
            if (htcResult.getCode().equals("1")) {
              sms.setResult("Send SMS successfully: " + htcResult);
              sms.setStatus(CommunicationStatus.DELIVERED.name());
              sms.setDeliveryTime(new Timestamp(new Date().getTime()));
            } else {
              sms.setResult("Send SMS fail from internal: " + "Error code: " + htcResult.getCode() + "; Error message: " + htcResult.getMessage());
              sms.setStatus(CommunicationStatus.FAIL_INTERNAL.name());
              log.error("Send SMS fail from internal " + "Error code: " + htcResult.getCode() + "; Error message: " + htcResult.getMessage());
              smsRepository.save(sms);
            }
            return smsRepository.save(sms);
          } else if (providerSmsBrandNameConfig != null && sms.getBrandNameAccountMode().equals(BrandNameAccountMode.EXTERNAL)) {
            htcRequest = SMSBrandNameHtcRequest.builder()
                .brandName(sms.getBrandName())
                .user(providerSmsBrandNameConfig.getUser())
                .pass(providerSmsBrandNameConfig.getPass())
                .dataEncode(1)
                .mess(sms.getCustomContent())
                .sendTime("")
                .telcoCode("")
                .phone(sms.getPhoneNumber())
                .tranId("")
                .build();
            SMSBrandNameHtc htcResult = gson.fromJson(smsBrandNameHtcClient.sendSmsWithBrand(htcRequest), SMSBrandNameHtc.class);
            sms.setResult("Send SMS successfully: " + htcResult);
            sms.setStatus(CommunicationStatus.DELIVERED.name());
            sms.setDeliveryTime(new Timestamp(new Date().getTime()));
          }
        default:
          return null;
      }

    } catch (UnauthorizedClientException e) {
      if (retryTime > 0) {
        sms.setResult("Send SMS fail from internal: " + e.getMessage());
        sms.setStatus(CommunicationStatus.FAIL_INTERNAL.name());
        log.error("Send SMS fail from internal", e);
        return smsRepository.save(sms);
      } else {
        return send(sms, providerSmsBrandNameConfig, retryTime + 1);
      }
    } catch (Exception e) {
      sms.setResult("Send SMS fail from internal: " + e.getMessage());
      sms.setStatus(CommunicationStatus.FAIL_INTERNAL.name());
      log.error("Send SMS fail from internal", e);
      return smsRepository.save(sms);
    }
  }

  @Override
  public Sms send(Long smsId, ProviderSmsBrandNameConfig providerSmsBrandNameConfig) {
    Sms sms = smsRepository.findFirstById(smsId);
    return send(sms, providerSmsBrandNameConfig);
  }
}
