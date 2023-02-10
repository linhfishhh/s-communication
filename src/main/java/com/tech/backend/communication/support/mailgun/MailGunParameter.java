package com.tech.backend.communication.support.mailgun;

import java.util.List;
import lombok.Data;

/**
 * Created by chautn on 8/11/2017.
 */
@Data
public class MailGunParameter {

  private String subject;
  private String text;
  private String html;
  private String fromName;
  private String fromAddress;
  private List<String> to;
  private String bcc;
  private String cc;
  private String replyTo;
}
