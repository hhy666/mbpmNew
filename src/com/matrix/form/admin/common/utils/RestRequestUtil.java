package com.matrix.form.admin.common.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class RestRequestUtil {
	
	/**
	 * 根据业务编码获取所有子业务信息
	 * @param businessId
	 * @return
	 */
	public static String getSubBusinessById(String businessId){
		String str = "";
		if(businessId != null && businessId.trim().length() > 0){
			MultiValueMap<String, String> paramMap = new LinkedMultiValueMap<>();
			paramMap.add("businessId", businessId);
			try{
				RestTemplate restTemplate = new RestTemplate();
		        ResponseEntity<JSONArray> jsonObjectRemote = restTemplate.postForEntity(RestRequestUrl.GETSUBBUSINESSBYID, paramMap, JSONArray.class);        
		        JSONArray jsonArray = jsonObjectRemote.getBody();
		        
		        if(jsonArray != null){
		        	str = jsonArray.toString();;
		        }
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return str;
	}
	
	/**
	 * 根据业务编码集合获取对应的业务信息
	 * @param businessIds
	 * @return
	 */
	public static String getBusinessInfoByIds(List<String> businessIdList){
		String str = "";
		if(businessIdList != null && businessIdList.size() > 0){
			StringBuffer businessIds = new StringBuffer();
			boolean isFirst = true;
			for (String businessId : businessIdList) {
				if(!isFirst){
					businessIds.append(",");
				}			
				businessIds.append(businessId);
				
				isFirst = false;
			}
			
			MultiValueMap<String, String> paramMap = new LinkedMultiValueMap<>();
			paramMap.add("businessIds", businessIds.toString());
			
			try{
				RestTemplate restTemplate = new RestTemplate();
		        ResponseEntity<JSONArray> jsonObjectRemote = restTemplate.postForEntity(RestRequestUrl.GETBUSINESSINFOBYIDS, paramMap, JSONArray.class);        
		        JSONArray jsonArray = jsonObjectRemote.getBody();
		        
		        if(jsonArray != null){
		        	str = jsonArray.toString();;
		        }
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		return str;
	}
	
	
	/**
	 * 根据业务编码集合获取对应的业务编码和名称的键值对
	 * @param businessIds
	 * @return
	 */
	public static Map<String, String> getBusinessIdAndNameMap(List<String> businessIdList){
		HashMap<String, String> businessIdAndNameMap = new HashMap<String, String>();
		
		if(businessIdList != null && businessIdList.size() > 0){
			StringBuffer businessIds = new StringBuffer();
			
			boolean isFirst = true;
			for (String businessId : businessIdList) {
				if(!isFirst){
					businessIds.append(",");
				}			
				businessIds.append(businessId);
				
				isFirst = false;
			}
			
			
			MultiValueMap<String, String> paramMap = new LinkedMultiValueMap<>();
			paramMap.add("businessIds", businessIds.toString());
			
			try{
				RestTemplate restTemplate = new RestTemplate();
		        ResponseEntity<JSONArray> jsonObjectRemote = restTemplate.postForEntity(RestRequestUrl.GETBUSINESSINFOBYIDS, paramMap, JSONArray.class);        
		        JSONArray jsonArray = jsonObjectRemote.getBody();
		        if(jsonArray != null && jsonArray.size() > 0){
		        	for ( int i = 0; i < jsonArray .size(); i ++) {
		        		JSONObject jsonObject = (JSONObject) jsonArray.get(i);
		        		
		        		String businessId = jsonObject.getString("businessId");
		        		String businessName = jsonObject.getString("businessName");
		        		if(businessId!=null && businessId.trim().length()>0 
		        				&& businessName!=null && businessName.trim().length()>0){
		        			businessIdAndNameMap.put(businessId, businessName);
		        		}       		
		        	}
		        }
			}catch(Exception e){
				e.printStackTrace();
			}
		}		
        return businessIdAndNameMap;
	}
	
	/**
	 * 根据单个业务编码返回业务名称
	 * @param businessId
	 * @return
	 */
	public static String getBusinessNameById(String businessId){
		List<String> businessIdList = new ArrayList<String>();
		if (businessId != null && businessId.trim().length() > 0) {
			businessIdList.add(businessId);
		}
		//获取业务编码和名称的键值对
		Map<String, String> businessIdAndNameMap = RestRequestUtil.getBusinessIdAndNameMap(businessIdList);
		
		String businessName = businessIdAndNameMap.get(businessId);
		if(businessName == null || businessName.trim().length() == 0){
			businessName = "";
		}
		return businessName;
	}
	
	/**
	 * 获得所有业务
	 * @return
	 */
	public static String getAllBusiness(){
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<JSONArray> jsonObjectRemote = restTemplate.postForEntity(RestRequestUrl.GETALLBUSINESS, null, JSONArray.class);        
		JSONArray jsonArray = jsonObjectRemote.getBody();
		 
		String str = "";
        if(jsonArray != null){
        	str = jsonArray.toString();;
        }
		return  str;
	}
}
