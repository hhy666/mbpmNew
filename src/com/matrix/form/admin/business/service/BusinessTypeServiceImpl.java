package com.matrix.form.admin.business.service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.matrix.form.admin.business.model.BusinessType;
import com.matrix.form.admin.common.utils.CommonUtil;


@Service
@Transactional
public class BusinessTypeServiceImpl implements BusinessTypeService{

	
	/**
	 * 根据业务编码获取所有子业务信息
	 * @param businessId
	 * @return
	 */
	public String getSubBusinessById(String businessId) {
		StringBuffer str = new StringBuffer();
		str.append("[");
		if(businessId != null && businessId.trim().length() > 0){
			if("01".equals(businessId)){
				str.append("{");
				str.append("\"businessId\":\"0101\"");
				str.append(",\"businessName\":\"A类\"");
				str.append(",\"parentId\":\"01\"");
				str.append("}");
				str.append(",{");
				str.append("\"businessId\":\"0102\"");
				str.append(",\"businessName\":\"B类\"");
				str.append(",\"parentId\":\"01\"");
				str.append("}");
				str.append(",{");
				str.append("\"businessId\":\"0103\"");
				str.append(",\"businessName\":\"C类\"");
				str.append(",\"parentId\":\"01\"");
				str.append("}");
			}else if("02".equals(businessId)){
				str.append("{");
				str.append("\"businessId\":\"0201\"");
				str.append(",\"businessName\":\"D类\"");
				str.append(",\"parentId\":\"02\"");
				str.append("}");
				str.append(",{");
				str.append("\"businessId\":\"0202\"");
				str.append(",\"businessName\":\"E类\"");
				str.append(",\"parentId\":\"02\"");
				str.append("}");
				str.append(",{");
				str.append("\"businessId\":\"0203\"");
				str.append(",\"businessName\":\"F类\"");
				str.append(",\"parentId\":\"02\"");
				str.append("}");
			}else if("03".equals(businessId)){
				str.append("{");
				str.append("\"businessId\":\"0301\"");
				str.append(",\"businessName\":\"G类\"");
				str.append(",\"parentId\":\"03\"");
				str.append("}");
				str.append(",{");
				str.append("\"businessId\":\"0302\"");
				str.append(",\"businessName\":\"H类\"");
				str.append(",\"parentId\":\"03\"");
				str.append("}");
				str.append(",{");
				str.append("\"businessId\":\"0303\"");
				str.append(",\"businessName\":\"I类\"");
				str.append(",\"parentId\":\"03\"");
				str.append("}");
			}else if("0101".equals(businessId)){
				str.append("{");
				str.append("\"businessId\":\"010101\"");
				str.append(",\"businessName\":\"A小类\"");
				str.append(",\"parentId\":\"0101\"");
				str.append("}");
				str.append(",{");
				str.append("\"businessId\":\"010102\"");
				str.append(",\"businessName\":\"A中类\"");
				str.append(",\"parentId\":\"0101\"");
				str.append("}");
				str.append(",{");
				str.append("\"businessId\":\"010103\"");
				str.append(",\"businessName\":\"A大类\"");
				str.append(",\"parentId\":\"0101\"");
				str.append("}");
			}else if("0102".equals(businessId)){
				str.append("{");
				str.append("\"businessId\":\"010201\"");
				str.append(",\"businessName\":\"B小类\"");
				str.append(",\"parentId\":\"0102\"");
				str.append("}");
				str.append(",{");
				str.append("\"businessId\":\"010202\"");
				str.append(",\"businessName\":\"B大类\"");
				str.append(",\"parentId\":\"0102\"");
				str.append("}");
			}else if("0103".equals(businessId)){
				str.append("{");
				str.append("\"businessId\":\"010301\"");
				str.append(",\"businessName\":\"C小类\"");
				str.append(",\"parentId\":\"0103\"");
				str.append("}");
				str.append(",{");
				str.append("\"businessId\":\"010302\"");
				str.append(",\"businessName\":\"C大类\"");
				str.append(",\"parentId\":\"0103\"");
				str.append("}");
			}
		}else{   //为空表示根    第一层业务
			str.append("{");
			str.append("\"businessId\":\"01\"");
			str.append(",\"businessName\":\"采购合同\"");
			str.append("}");
			str.append(",{");
			str.append("\"businessId\":\"02\"");
			str.append(",\"businessName\":\"销售合同\"");
			str.append("}");
			str.append(",{");
			str.append("\"businessId\":\"03\"");
			str.append(",\"businessName\":\"建设合同\"");
			str.append("}");
		}
		str.append("]");
		return str.toString();
	}
	
	/**
	 * 根据业务编码集合获取对应的业务名称
	 * a,b,c 以逗号分隔
	 * @param businessIds
	 * @return
	 */
	public String getBusinessInfoByIds(String businessIds){
		StringBuffer str = new StringBuffer();
		str.append("[");	
		if(businessIds != null && businessIds.trim().length() > 0){
			String[] businessIdsArr = businessIds.split(",");
			if(businessIdsArr != null && businessIdsArr.length > 0){
				boolean isFirst = true;
				for(int i=0;i<businessIdsArr.length;i++) {
					String businessId = businessIdsArr[i];
					if(businessId != null && businessId.trim().length() > 0){
						String businessName = "";
						String parentId = "";
						if("01".equals(businessId)){
							businessName = "采购合同";
						}else if("02".equals(businessId)){
							businessName = "销售合同";
						}else if("03".equals(businessId)){
							businessName = "建设合同";
						}else if("0101".equals(businessId)){
							businessName = "A类";
							parentId = "01";
						}else if("0102".equals(businessId)){
							businessName = "B类";
							parentId = "01";
						}else if("0103".equals(businessId)){
							businessName = "C类";
							parentId = "01";
						}else if("010101".equals(businessId)){
							businessName = "A小类";
							parentId = "0101";
						}else if("010202".equals(businessId)){
							businessName = "A中类";
							parentId = "0101";
						}else if("010303".equals(businessId)){
							businessName = "A大类";
							parentId = "0101";
						}else if("010201".equals(businessId)){
							businessName = "B小类";
							parentId = "0102";
						}else if("010202".equals(businessId)){
							businessName = "B大类";
							parentId = "0102";
						}else if("010301".equals(businessId)){
							businessName = "C小类";
							parentId = "0103";
						}else if("010302".equals(businessId)){
							businessName = "C大类";
							parentId = "0103";
						}else if("0201".equals(businessId)){
							businessName = "D类";
							parentId = "02";
						}else if("0202".equals(businessId)){
							businessName = "E类";
							parentId = "02";
						}else if("0203".equals(businessId)){
							businessName = "F类";
							parentId = "02";
						}
						if(!isFirst){
							str.append(",");
						}
						str.append("{");
						str.append("\"businessId\":\""+businessId+"\"");
						str.append(",\"businessName\":\""+businessName+"\"");
						str.append(",\"parentId\":\""+parentId+"\"");
						str.append("}");
						
						isFirst = false;
					}
				}
			}
		}
		str.append("]");
		return str.toString();
	}

	/**
	 * 获得所有业务
	 */
	public String getAllBusiness() {
		StringBuffer str = new StringBuffer();
		str.append("[");
		
		str.append("{");
		str.append("\"businessId\":\"01\"");
		str.append(",\"businessName\":\"采购合同\"");
		str.append(",\"parentId\":\"\"");
		str.append("}");
		str.append(",{");
		str.append("\"businessId\":\"02\"");
		str.append(",\"businessName\":\"销售合同\"");
		str.append(",\"parentId\":\"\"");
		str.append("}");
		str.append(",{");
		str.append("\"businessId\":\"03\"");
		str.append(",\"businessName\":\"建设合同\"");
		str.append(",\"parentId\":\"\"");
		str.append("}");
		
		str.append(",{");
		str.append("\"businessId\":\"0101\"");
		str.append(",\"businessName\":\"A类\"");
		str.append(",\"parentId\":\"01\"");
		str.append("}");
		str.append(",{");
		str.append("\"businessId\":\"0102\"");
		str.append(",\"businessName\":\"B类\"");
		str.append(",\"parentId\":\"01\"");
		str.append("}");
		str.append(",{");
		str.append("\"businessId\":\"0103\"");
		str.append(",\"businessName\":\"C类\"");
		str.append(",\"parentId\":\"01\"");
		str.append("}");
		
		str.append(",{");
		str.append("\"businessId\":\"0201\"");
		str.append(",\"businessName\":\"D类\"");
		str.append(",\"parentId\":\"02\"");
		str.append("}");
		str.append(",{");
		str.append("\"businessId\":\"0202\"");
		str.append(",\"businessName\":\"E类\"");
		str.append(",\"parentId\":\"02\"");
		str.append("}");
		str.append(",{");
		str.append("\"businessId\":\"0203\"");
		str.append(",\"businessName\":\"F类\"");
		str.append(",\"parentId\":\"02\"");
		str.append("}");

		str.append(",{");
		str.append("\"businessId\":\"0301\"");
		str.append(",\"businessName\":\"G类\"");
		str.append(",\"parentId\":\"03\"");
		str.append("}");
		str.append(",{");
		str.append("\"businessId\":\"0302\"");
		str.append(",\"businessName\":\"H类\"");
		str.append(",\"parentId\":\"03\"");
		str.append("}");
		str.append(",{");
		str.append("\"businessId\":\"0303\"");
		str.append(",\"businessName\":\"I类\"");
		str.append(",\"parentId\":\"03\"");
		str.append("}");

		str.append(",{");
		str.append("\"businessId\":\"010101\"");
		str.append(",\"businessName\":\"A小类\"");
		str.append(",\"parentId\":\"0101\"");
		str.append("}");
		str.append(",{");
		str.append("\"businessId\":\"010102\"");
		str.append(",\"businessName\":\"A中类\"");
		str.append(",\"parentId\":\"0101\"");
		str.append("}");
		str.append(",{");
		str.append("\"businessId\":\"010103\"");
		str.append(",\"businessName\":\"A大类\"");
		str.append(",\"parentId\":\"0101\"");
		str.append("}");
		
		str.append(",{");
		str.append("\"businessId\":\"010201\"");
		str.append(",\"businessName\":\"B小类\"");
		str.append(",\"parentId\":\"0102\"");
		str.append("}");
		str.append(",{");
		str.append("\"businessId\":\"010202\"");
		str.append(",\"businessName\":\"B大类\"");
		str.append(",\"parentId\":\"0102\"");
		str.append("}");
		
		str.append(",{");
		str.append("\"businessId\":\"010301\"");
		str.append(",\"businessName\":\"C小类\"");
		str.append(",\"parentId\":\"0103\"");
		str.append("}");
		str.append(",{");
		str.append("\"businessId\":\"010302\"");
		str.append(",\"businessName\":\"C大类\"");
		str.append(",\"parentId\":\"0103\"");
		str.append("}");

		str.append("]");
		return str.toString();
	}
	
}
