package com.tech.backend.communication.common.utils.collection;

import java.util.Arrays;
import java.util.List;
import org.apache.commons.collections4.CollectionUtils;

/**
 * Created by chautn on 8/11/2017.
 */
public class ListUtils {

  public static String listToString(List<String> list) {
    String result = "";
    if (CollectionUtils.isNotEmpty(list)) {
      for (int i = 0; i < list.size() - 1; i++) {
        result += list.get(i) + ",";
      }
      result += list.get(list.size() - 1);
    }
    return result;
  }

  public static List<String> stringToList(String strs) {
    return Arrays.asList(strs.split(","));
  }
}
