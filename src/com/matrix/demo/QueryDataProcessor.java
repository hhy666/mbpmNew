package com.matrix.demo;

import java.util.List;

import com.matrix.commonservice.data.DataService;
import com.matrix.form.api.MFormContext;
import com.matrix.form.model.component.composite.QueryForm;
import com.matrix.form.model.component.data.DataProcessor;
import com.matrix.form.render.runtime.html5.composite.Html5DefaultDataProcessor;

import commonj.sdo.DataObject;

public class QueryDataProcessor implements DataProcessor{
	
	//覆盖父类方法
	public void loadData(Object dataProvider){
		
		String condition = null;
		//可以自定以追加查询条件
		
		this.loadData(dataProvider,condition);
	}
	
	//覆盖父类方法
	public void loadData(Object dataProvider,String condition){
		if(dataProvider!=null){
			if(dataProvider instanceof QueryForm){
				DataService dataService = MFormContext.getService("DataService");
				QueryForm qf = (QueryForm)dataProvider;
				
				//获取查询列表的查询条件
				String queryCondition = qf.getQueryString();
				//获取查询列表的排序信息
				String orderStr = qf.getOrderString();
				
				//采用默认的DataProcessor进行数据查询
				Html5DefaultDataProcessor processor = new Html5DefaultDataProcessor();
				processor.loadData(qf, condition);

				List<DataObject> list = (List) qf.getData();
				for(DataObject dataObject : list){
				}
				
				//如果自己组织的数据，回写结果
				//qf.setData(list);   //回写结果DataObject对象列表
				//qf.setCount(count); //回写总记录数
				
			}
		}
	}
}