package com.tech.backend.communication.model.enumeration;

/**
 * Author: chautn on 7/4/2018 4:55 PM
 */
public enum PushServer {

  FCM,
  EXPO;

  public static PushServer pushServer(String pushServer) {
    for (PushServer server: values()) {
      if (server.name().equals(pushServer)) {
        return server;
      }
    }
    return null;
  }
}
