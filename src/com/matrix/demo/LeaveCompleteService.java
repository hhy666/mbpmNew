package com.matrix.demo;

import com.matrix.api.MFException;
import com.matrix.api.data.ProcessData;
import com.matrix.api.instance.activity.ActivityInstance;
import com.matrix.api.instance.process.ProcessInstance;
import com.matrix.api.integration.ComponentContext;
import com.matrix.api.integration.ComponentProvider;
import com.matrix.commonservice.data.DataService;
import com.matrix.form.api.MFormContext;

import commonj.sdo.DataObject;

public class LeaveCompleteService  implements ComponentProvider{
	@Override
	public void execute(ComponentContext context){
		//获取流程实例对象
		ProcessInstance procIns = context.getProcessIns();
		//获取当前活动实例
		ActivityInstance actIns = context.getActivityIns();
		//获取流程实例变量
		ProcessData processData = context.getProcessInsData();
		
		DataService dataService = MFormContext.getService("DataService");
		DataObject leaveAppInfo = (DataObject) MFormContext.getRequestAttribute("leaveAppInfo");
		//修改业务信息的状态为已完成
		leaveAppInfo.set("mStatus", 3);
		dataService.saveOrUpdate(leaveAppInfo);
		
		
	}
	
}
