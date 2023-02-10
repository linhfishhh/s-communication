package com.tech.backend.communication.service.impl;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.tech.backend.communication.common.SmsLengthCalculator;
import com.tech.backend.communication.common.utils.string.TemplateUtils;
import com.tech.backend.communication.model.entity.Template;
import com.tech.backend.communication.model.enumeration.SupportedLanguage;
import com.tech.backend.communication.model.enumeration.TemplateEncode;
import com.tech.backend.communication.model.mapper.TemplateMapper;
import com.tech.backend.communication.model.response.TemplateDTO;
import com.tech.backend.communication.repository.TemplateRepository;
import com.tech.backend.communication.service.TemplateService;
import freemarker.cache.StringTemplateLoader;
import freemarker.template.Configuration;
import java.io.StringWriter;
import java.lang.reflect.Type;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by chautn on 7/22/2017.
 */
@Service
public class TemplateServiceImpl implements TemplateService {

  private static final Logger logger = LoggerFactory.getLogger(TemplateServiceImpl.class);

  private static Gson gson = new Gson();
  @Autowired
  private TemplateRepository templateRepository;

  @Override
  public List<Template> getTemplateByCodeAndType(String code, String type) {
    return templateRepository.findByCodeAndType(code, type);
  }

  @Override
  public Template getTemplateByCodeAndTypeAndLanguage(String code, String type, SupportedLanguage language) {
    return templateRepository.findByCodeAndTypeAndLanguage(code, type, language == null ? SupportedLanguage.VIETNAMESE.language() : language.language());
  }

  @Override
  public Template getTemplateByTenantIdAndCodeAndTypeAndLanguage(String tenantId, String code, String type, SupportedLanguage language) {
    return templateRepository
        .findByTenantIdAndCodeAndTypeAndLanguage(tenantId, code, type, language == null ? SupportedLanguage.VIETNAMESE.language() : language.language());
  }

  @Override
  public TemplateDTO getPreviewTemplateByTenantIdAndCodeAndTypeAndLanguage(String tenantId, String code, String type, SupportedLanguage language,
      Map<String, Object> paramRequest) {
    Template template = templateRepository
        .findByTenantIdAndCodeAndTypeAndLanguage(tenantId, code, type, language == null ? SupportedLanguage.VIETNAMESE.language() : language.language());
    // convert to html
    try {
      StringTemplateLoader stringLoader = new StringTemplateLoader();
      Type mapType = new TypeToken<Map<String, Object>>() {
      }.getType();
      Map<String, Object> defaultParam =
          StringUtils.isNotBlank(template.getDefaultParamValue()) ? gson.fromJson(template.getDefaultParamValue(), mapType) : new HashMap<>();
      defaultParam.putAll(paramRequest);
      if (template.getEncode().equalsIgnoreCase(TemplateEncode.FREEMARKER.name())) {
        stringLoader.putTemplate("template", template.getMessage());
        Configuration cfg = new Configuration(Configuration.VERSION_2_3_28);
        cfg.setTemplateLoader(stringLoader);
        cfg.setDefaultEncoding("UTF-8");
        freemarker.template.Template templateFreeMarker = cfg.getTemplate("template");
        StringWriter writer = new StringWriter();
        templateFreeMarker.process(defaultParam, writer);
        template.setMessage("");
        template.setPreview(writer.toString());
      } else if (template.getEncode().equalsIgnoreCase(TemplateEncode.TEXT.name())) {
        String preview = TemplateUtils.replaceParams(template.getMessage(), defaultParam);
        template.setPreview(preview);
        int SmsLength = SmsLengthCalculator.getPartCount(preview);
        template.setSmsTotal(SmsLength);
      }
    } catch (Exception ex) {
      logger.info("Get error at: " + ex);
    }
    return TemplateMapper.INSTANCE.toEmailTemplateDto(template);
  }
}
