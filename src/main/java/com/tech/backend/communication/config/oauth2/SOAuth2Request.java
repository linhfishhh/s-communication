package com.tech.backend.communication.config.oauth2;

import java.util.HashMap;
import java.util.Map;
import lombok.Getter;
import lombok.Setter;

/**
 * Author: chautn on 6/6/2018 5:21 PM
 */
@Getter
@Setter
public class SOAuth2Request {

  private String tenantId;
  private String grantType;
  private String username;
  private String password;
  private String email;
  private String phone;
  private String otp;
  private String token;

  public Map<String, String> toParamsMap() {
    Map<String, String> params = new HashMap<>();
    if (tenantId != null) {
      params.put("client_id", tenantId);
    }
    if (grantType != null) {
      params.put("grant_type", grantType);
    }
    if (username != null) {
      params.put("username", username);
    }
    if (password != null) {
      params.put("password", password);
    }
    if (email != null) {
      params.put("email", email);
    }
    if (phone != null) {
      params.put("phone", phone);
    }
    if (otp != null) {
      params.put("otp", otp);
    }
    if (token != null) {
      params.put("token", token);
    }
    return params;
  }

  public static SOAuth2Request fromParams(Map<String, String> params) {
    if (params != null && params.size() > 0) {
      SOAuth2Request request = new SOAuth2Request();
      request.setTenantId(params.get("client_id"));
      request.setGrantType(params.get("grant_type"));
      request.setUsername(params.get("username"));
      request.setPassword(params.get("password"));
      request.setEmail(params.get("email"));
      request.setPhone(params.get("phone"));
      request.setOtp(params.get("otp"));
      request.setToken(params.get("token"));
      return request;
    } else {
      return null;
    }
  }
}
