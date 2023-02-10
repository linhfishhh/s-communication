package com.tech.backend.communication.support.mailgun;

import com.tech.backend.communication.common.utils.collection.ListUtils;
import com.tech.backend.communication.common.utils.string.PasswordUtils;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpHeaders;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.message.BasicNameValuePair;

/**
 * Created by chautn on 8/11/2017.
 */
public class MailGunBuilder {

  public static HttpPost requestSend(String domain, String api, String username, String password, MailGunParameter params) throws UnsupportedEncodingException {
    List<NameValuePair> urlParameters = new ArrayList<>();
    urlParameters.add(new BasicNameValuePair("subject", params.getSubject()));
    if (StringUtils.isNotBlank(params.getText())) {
      urlParameters.add(new BasicNameValuePair("text", params.getText()));
    }
    if (StringUtils.isNotBlank(params.getHtml())) {
      urlParameters.add(new BasicNameValuePair("html", params.getHtml()));
    }
    urlParameters.add(new BasicNameValuePair("to", ListUtils.listToString(params.getTo())));
    urlParameters.add(new BasicNameValuePair("from", params.getFromName() + "<" + params.getFromAddress() + ">"));

    if (params.getTo().size() > 1) {
      List<String> recipientsJson = new ArrayList<>();
      for (String recipient : params.getTo()) {
        recipientsJson.add("\"" + recipient + "\"" + ":{}");
      }
      urlParameters.add(new BasicNameValuePair("recipient-variables", "{" + ListUtils.listToString(recipientsJson) + "}"));
    }
    if (StringUtils.isNotEmpty(params.getCc())) {
      urlParameters.add(new BasicNameValuePair("cc", params.getCc()));
    }
    if (StringUtils.isNotEmpty(params.getBcc())) {
      urlParameters.add(new BasicNameValuePair("bcc", params.getBcc()));
    }
    if (StringUtils.isNotEmpty(params.getReplyTo())) {
      urlParameters.add(new BasicNameValuePair("h:Reply-To", params.getReplyTo()));
    }

    HttpPost post = new HttpPost(String.format(api, domain));
    post.addHeader(HttpHeaders.AUTHORIZATION, "Basic " + PasswordUtils.base64Encode(username + ":" + password));
    post.setEntity(new UrlEncodedFormEntity(urlParameters, Charset.defaultCharset()));

    return post;
  }
}
