package com.tech.backend.communication.model.enumeration;

/**
 * @author chuanlh on 2021-03-23
 */
public enum BrandNameAccountMode {

  BUKIZI,
  EXTERNAL;

  public static BrandNameAccountMode getAccountMode(String mode) {
    for (BrandNameAccountMode accountMode : BrandNameAccountMode.values()) {
      if (accountMode.toString().equalsIgnoreCase(mode)) {
        return accountMode;
      }
    }
    return null;
  }
}
