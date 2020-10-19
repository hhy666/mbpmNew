package com.matrix.form.admin.common.utils;

public class RestRequestUrl {
	
	
    //根据业务编码获取所有子业务信息
	public static String GETSUBBUSINESSBYID = "http://localhost:8080/mbpm/businessType/getSubBusinessById";
		
	//根据业务编码集合获取对应的业务信息
	public static String GETBUSINESSINFOBYIDS = "http://localhost:8080/mbpm/businessType/getBusinessInfoByIds";
	
	//获得所有业务信息
	public static String GETALLBUSINESS = "http://localhost:8080/mbpm/businessType/getAllBusiness";
}
