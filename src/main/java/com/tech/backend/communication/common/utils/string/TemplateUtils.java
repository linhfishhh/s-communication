package com.tech.backend.communication.common.utils.string;

import java.util.Map;
import java.util.Map.Entry;

/**
 * Created by chautn on 7/25/2017.
 */
public class TemplateUtils {

  public static String replaceParams(String text, Map<String, Object> params) {
    String result = text;
    if (params != null && params.size() > 0) {
      for (Entry<String, Object> kv : params.entrySet()) {
        if (kv.getValue() instanceof String) {
          String value = (String) kv.getValue();
          result = result.replaceAll("\\$_" + kv.getKey() + "_", value);
        }
      }
    }
    return result;
  }
}
