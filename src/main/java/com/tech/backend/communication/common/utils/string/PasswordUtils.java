package com.tech.backend.communication.common.utils.string;

import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

/**
 * Created by chautn on 7/25/2017.
 */
public class PasswordUtils {

  public static String md5(String text) {
    MessageDigest md;
    try {
      md = MessageDigest.getInstance("MD5");
      md.update(text.getBytes());
      byte byteData[] = md.digest();
      StringBuilder sb = new StringBuilder();
      for (byte aByteData : byteData) {
        sb.append(Integer.toString((aByteData & 0xff) + 0x100, 16).substring(1));
      }
      return sb.toString();
    } catch (NoSuchAlgorithmException e) {
      return null;
    }
  }

  public static String base64Encode(String str) {
    Base64.Encoder encoder = Base64.getEncoder();
    byte[] encoded = encoder.encode(str.getBytes());
    return new String(encoded, StandardCharsets.UTF_8);
  }

  public static String base64Decode(String str) {
    Base64.Decoder decoder = Base64.getDecoder();
    byte[] decoded = decoder.decode(str.getBytes());
    return new String(decoded, StandardCharsets.UTF_8);
  }

  public static void main(String[] args) throws UnsupportedEncodingException {
    System.out.println(base64Encode("controller:key-5970e6c1a229297763e9c5bd894e17d6"));
  }
}
