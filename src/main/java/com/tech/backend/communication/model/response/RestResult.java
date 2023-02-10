package com.tech.backend.communication.model.response;

import java.util.List;

/**
 * Author: chautn on 6/14/2018 10:27 AM
 */
public class RestResult<T> {
  public static final String STATUS_SUCCESS = "success";
  public static final String STATUS_ERROR = "error";

  private String status;

  private List<String> messages;

  private String message;

  private T data;

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public List<String> getMessages() {
    return messages;
  }

  public void setMessages(List<String> messages) {
    this.messages = messages;
  }

  public String getMessage() {
    return message;
  }

  public void setMessage(String message) {
    this.message = message;
  }

  public T getData() {
    return data;
  }

  public void setData(T data) {
    this.data = data;
  }
}
