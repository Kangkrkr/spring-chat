package com.teamk.chat.front.util;

public class CmFuntion {
	
	public static boolean isEmpty(String str) {
		if(null == str || "".equals(str)) {
			return true;
		} else {
			return false;
		}
	}
	
	public static boolean isNotEmpty(String str) {
		if(null != str && !"".equals(str)) {
			return true;
		} else {
			return false;
		}
	}
	
}
