package com.matrix.form.admin.business.controller;


import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.matrix.api.MFExecutionService;
import com.matrix.client.ClientConstants;
import com.matrix.client.foundation.group.tool.SecurityGroupTool;
import com.matrix.commonservice.data.DataService;
import com.matrix.extention.SessionContextHolder;
import com.matrix.form.admin.business.model.BusinessType;
import com.matrix.form.admin.common.utils.CommonUtil;
import com.matrix.form.admin.custom.helper.FormUtils;
import com.matrix.form.api.MFormContext;
import commonj.sdo.DataObject;
import net.sf.json.JSONArray;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import com.matrix.form.admin.business.model.BusinessType;
import com.matrix.form.admin.business.service.BusinessTypeService;
import com.matrix.form.admin.common.utils.CommonUtil;
import com.matrix.form.admin.querylist.service.QueryListSetService;

import java.util.*;

@RestController
@RequestMapping(value = "/businessType", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE})
public class BusinessTypeController {
	
	@Resource
	BusinessTypeService businessTypeService;

	
	/**
	 * 根据业务编码获取所有子业务信息
	 * @param businessId
	 * @return
	 */
	@PostMapping("/getSubBusinessById")
	public String getSubBusinessById(@RequestParam String businessId){
		String str = businessTypeService.getSubBusinessById(businessId);
		return str.toString();
	}
	
	/**
	 * 根据业务编码集合获取对应的业务信息
	 * @param businessId
	 * @return
	 */
	@PostMapping("/getBusinessInfoByIds")
	public String getBusinessInfoByIds(@RequestParam String businessIds) {
		String str = businessTypeService.getBusinessInfoByIds(businessIds);
		return str.toString();
	}

	/**
	 * 获得所有业务
	 * @return
	 */
	@PostMapping("/getAllBusiness")
	public String getAllBusiness(){
		String str = businessTypeService.getAllBusiness();
		return str.toString();
	}
}
