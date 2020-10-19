package com.matrix.demo;


import java.util.Map;

import javax.matrix.faces.context.MFacesContext;

import com.matrix.api.MFExecutionService;
import com.matrix.api.data.ReadWriteContainer;
import com.matrix.client.ClientConstants;
import com.matrix.commonservice.data.DataService;
import com.matrix.form.api.MFormContext;

import commonj.sdo.DataObject;

public class LeaveService {
	
	//发起流程
	public void startProcess(){
		DataService dataService = MFormContext.getService("DataService");
		DataObject leaveAppInfo = (DataObject) MFormContext.getRequestAttribute("leaveAppInfo");
		
		dataService.saveOrUpdate(leaveAppInfo);
		String appId = leaveAppInfo.getString("appId");
//		leaveAppInfo.set("appId", appId);
		
		MFExecutionService service = (MFExecutionService) MFormContext.getSessionAttribute(ClientConstants.EXECUTION_SERVICE);
		
		
		
		
		//得到流程实例输入参数对象
		ReadWriteContainer input = service.getProcessInContainer("leaveAppFlow");
		//对初始参数进行赋值
		input.setString("mBizId", appId);
		//创建并启动流程实例
		String piid = service.createAndStartProcessInstance("leaveAppFlow",input);
		
		//保存业务对象
		leaveAppInfo.set("piid", piid);
		//修改业务对象的状态为流转中
		leaveAppInfo.set("mStatus", 2);
		dataService.saveOrUpdate(leaveAppInfo);

	}
	
	//执行任务
	public void sendProcess(){
		
		MFExecutionService service = (MFExecutionService) MFormContext.getSessionAttribute(ClientConstants.EXECUTION_SERVICE);
		//提交任务
		String taskId = MFormContext.getParameter("taskId");
		service.claimTask(taskId);
		service.completeTask(taskId);
	}
	
	
}
