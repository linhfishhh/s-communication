package com.tech.backend.communication.controller;

import com.tech.backend.communication.common.ServicePath;
import com.tech.backend.communication.model.enumeration.SupportedLanguage;
import com.tech.backend.communication.model.request.TemplateRequest;
import com.tech.backend.communication.model.response.TemplateDTO;
import com.tech.backend.communication.model.response.RestResult;
import com.tech.backend.communication.service.TemplateService;
import io.swagger.annotations.ApiOperation;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author chuanlh on 2020-12-17
 */

@RestController
@RequestMapping(ServicePath.COMMUNICATION)
public class CommunicationController extends BaseController {

  public static final Logger logger = LoggerFactory.getLogger(CommunicationController.class);

  @Autowired
  private TemplateService templateService;

  @ApiOperation("Get template by code")
  @PostMapping("/code/template")
  public ResponseEntity<RestResult<List<TemplateDTO>>> getTemplateByCode(@RequestBody TemplateRequest request) {
    RestResult result = new RestResult<>();
    result.setData(templateService
        .getPreviewTemplateByTenantIdAndCodeAndTypeAndLanguage(request.getTenantId(), request.getTemplateCode(), request.getType(),
            SupportedLanguage.getSupportedLanguage(request.getLanguage()), request.getParams()));
    result.setStatus(RestResult.STATUS_SUCCESS);
    result.setMessage("Get template by codes successfully");
    return new ResponseEntity<>(result, HttpStatus.OK);
  }

}
