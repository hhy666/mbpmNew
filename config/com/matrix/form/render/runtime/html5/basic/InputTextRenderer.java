package com.matrix.form.render.runtime.html5.basic;

import com.matrix.form.core.util.FacesUtils;
import com.matrix.form.core.web.AjaxUtils;
import com.matrix.form.faces.util.MessageFactory2;
import com.matrix.form.faces.util.MessageUtils2;
import com.matrix.form.model.component.basic.InputText;
import com.matrix.form.model.component.hidden.DataSource;
import com.matrix.form.model.validator.*;
import com.matrix.form.render.abstracts.AbstractInputTextRenderer;
import com.matrix.form.render.message.Messages;
import com.matrix.form.render.util.RenderKitUtils;
import com.opensymphony.xwork2.validator.Validator;

import javax.matrix.faces.component.MUIComponent;
import javax.matrix.faces.component.MUIInput;
import javax.matrix.faces.context.MFacesContext;
import javax.matrix.faces.context.MResponseWriter;
import javax.matrix.faces.convert.MConverterException;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Iterator;
import java.util.List;

public class InputTextRenderer extends AbstractInputTextRenderer {

	@Override
	public void encodeBegin(MFacesContext context, MUIComponent component)
			throws IOException {
		
		Boolean rendered = RenderKitUtils.isRenderCurrentComponent(context,
				component);
		InputText inputText = (InputText) component;
		if(inputText.getIsFilterInput()){
			renderFilterInputText(context, component);
		}else{
			renderNormalInputText(context, component, rendered);
		}

	}
	
	
	 protected String getCurrentValue(MFacesContext context,
             MUIComponent component) {

		if (component instanceof MUIInput) {
			Object submittedValue = ((MUIInput) component).getSubmittedValue();
			if (submittedValue != null && (submittedValue+"").trim().length()>0) {
				return (String) submittedValue;
			}
		}
		
		String currentValue = null;
		Object currentObj = getValue(component);
		//if (currentObj != null && (currentObj+"").trim().length()>0) {
		if (currentObj != null) {
			currentValue = getFormattedValue(context, component, currentObj);
		}
		return currentValue;
		
	}
			 
	private void renderNormalInputText(MFacesContext context, MUIComponent component, Boolean rendered) throws IOException{
		
		InputText inputText = (InputText) component;
		String onchange = inputText.getOnchange();
		String onblur = inputText.getOnblur();
		
		// 输出html
		MResponseWriter writer = context.getResponseWriter();
		// 输出js
		MResponseWriter jsWriter = context.getJsWriter();
		String currentValue = this.getCurrentValue(context, component);
		// String clientId = component.getId();
		String itemID = component.getClientId(context);
		String type = inputText.getType();
		String icon = inputText.getIcon();
		String position = inputText.getPosition();//定位
		String addon=inputText.getAddon();//插件
		String placeholder=inputText.getHint();//占位符
		Boolean isSecret=inputText.getIsSecret();
		String autocomplete=(String) component.getAttributes().get("autocomplete");
		String autofocus=(String) component.getAttributes().get("autofocus");
		Integer col=(Integer) component.getAttributes().get("col");
		String style = (String) component.getAttributes().get("style");//获得组件样式
		String min =inputText.getMin();
		String max =inputText.getMax();
		String step =inputText.getStep();
		String pattern =inputText.getPattern();
		String help =inputText.getHelp();
		String iconclick =inputText.getIconclick();
		String btnText=inputText.getBtnText();
		String btnclick=inputText.getBtnclick();
		String formProxyId = RenderKitUtils.getFormProxyId(component, context);
		Boolean toText = RenderKitUtils.isToTextCurrentComponent(context,
				component);
		String styleClass = (String) component.getAttributes()
				.get("styleClass");
		// disabled
		boolean disabled = !RenderKitUtils.isEditableCurrentComponent(context,
				component);
		
		if (AjaxUtils.isAjaxRequest(context)) {
			// 异步刷新
			// 判断是否设置了强制刷新信息
			if (!RenderKitUtils.isRefreshCurrentComponent(context, component))
				return;
			RenderKitUtils.writeAjaxStart(jsWriter);
			if (currentValue == null)
				currentValue = "";
			if (toText != null && toText) {
				jsWriter.write(RenderKitUtils.writeISCToTextContentAjax(
						currentValue, currentValue, itemID, style, styleClass));
			} else {

				// change style javascript
				RenderKitUtils.writeISCStyleForAjax(context, component,
						jsWriter);

			/*	// change class javascript
				if (!FacesUtils.isEmpty(styleClass)) {
					jsWriter.write(itemID + ".setProperty('textBoxStyle','"
							+ styleClass + "');");
				}*/

				// change other style
				//RenderKitUtils.renderISCPassThruAttributesForAjax(context,
					//	jsWriter, component);

				

				// change value
//				currentValue = RenderKitUtils
//						.convertSpecialCharacter(currentValue);
				jsWriter.write("document.getElementById(\""+itemID + "\").value=\""+currentValue+"\";" );

				if (!disabled) {
					jsWriter.write("document.getElementById(\""+itemID + "\").disabled=false;");
					boolean canEdit = RenderKitUtils
							.canEditableCurrentComponent(context, component);
					if (!canEdit) {
						jsWriter.write("document.getElementById(\""+itemID + "\").readOnly=true;");
					}
				} else {
					jsWriter.write("document.getElementById(\""+itemID + "\").disabled=true;");
				}
			}
			RenderKitUtils.writeAjaxEnd(jsWriter);
			return;
		} else {
			//同步
			// String defaultValue = (String)
			// component.getAttributes().get("defaultValue");
			String defaultValue = RenderKitUtils.getDefaultValue(context,
					component);
			if (toText != null && toText) {
				String textValue = currentValue;
				if (textValue == null)
					textValue = defaultValue;
				RenderKitUtils.writeISCToTextContent(context, textValue,
						textValue, component, itemID);
				return;
			}
			// render componentDiv div for inputText
			StringBuffer inputHtml = new StringBuffer();
			inputHtml.append("<div id='"+itemID+"_div' class='input-group default-width ");
			if (col != null ){
				inputHtml.append("col-md-"+col+" ");
			}else{
				
				inputHtml.append("col-md-12 ");
			}

			boolean isRequired = RenderKitUtils.isRequiredCurrentComponent(
					context, component);
			if (!FacesUtils.isEmpty(styleClass)) {//加载样式类
				inputHtml.append(styleClass+" ");

			} 
			if (icon != null && icon.trim().length() > 0) //判断是否加载图标，并控制格式
				inputHtml.append("has-feedback ");
			inputHtml.append("' ");
			inputHtml.append("style='display: inline-table; vertical-align: middle; ");
			if (!rendered) {
				inputHtml.append(" display: none; ");
			}
			if (style != null && style.trim().length() > 0&& (!"null".equals(style.trim()))) {//加载样式
				inputHtml.append(style);//文本框宽度由div控制
			}
			inputHtml.append(" '> ");
			
			/**
			inputHtml.append("<div class=\"");
			if (addon != null && addon.trim().length() > 0) 
				inputHtml.append("input-group");
			inputHtml.append("\" >");
			**/
			if (addon != null && addon.trim().length() > 0) {
				if (position==null||(!position.equals("right"))) {
					inputHtml.append("<span class='input-group-addon' style='background-color: #fff;border-radius: 1px;'>");
					inputHtml.append(addon);
					inputHtml.append("</span>");
				}
			}
			if (btnText != null && btnText.trim().length() > 0) {
				if (position==null||(!position.equals("right"))) {
					inputHtml.append("<span class=\"input-group-btn\"> <button type=\"button\" class=\"x-btn ok-btn\"");
					if (btnclick != null && btnclick.trim().length() > 0) {
						inputHtml.append("onclick=\""+btnclick+"\" ");
					}
					inputHtml.append(">");
					inputHtml.append(btnText);
					inputHtml.append("</button> </span>");
				}
			}
			inputHtml.append("<input id=\"");
			inputHtml.append(itemID);//组件编码
			inputHtml.append("\" name=\"");
			inputHtml.append(itemID);//组件编码
			//------asd 文本框限制长度
			if(inputText.getLength()!= null){
				inputHtml.append("\" maxlength=\"");
				inputHtml.append(inputText.getLength());//最大长度
			}
			//-------
			inputHtml.append("\" ");
			inputHtml.append("type=\"");
			if(isSecret){
				inputHtml.append("password");
			}else{
			if (type != null && type.trim().length() > 0) {//判断是否填写类型，默认为text
				inputHtml.append(type);
			} else {
				inputHtml.append("text");
			}
			}
			inputHtml.append("\" ");
			if (isRequired) {
				inputHtml.append("required ");
			}
			
			String exAttribute = inputText.getExtentionAttribute();
			if(exAttribute != null && exAttribute.trim().length()>0){
				inputHtml.append(exAttribute);
			}
			
			inputHtml.append("class='");
			
			inputHtml.append("form-control ");
			
				if(isRequired){ //中认必填的时候设置背景色
					inputHtml.append(" required ");
				}

			if (icon != null && icon.trim().length() > 0) {//判断是否加载图标，并控制格式
				inputHtml.append("has-feedback-");
				if (position != null && position.trim().length() > 0) {
					inputHtml.append(position+" ");
				} else {
					inputHtml.append("left ");
				}
				
			}
			inputHtml.append("' ");
		
			//if (style != null && style.trim().length() > 0&& (!"null".equals(style.trim()))) {//加载样式
				inputHtml.append("style=\" ");
				//String width=style.toLowerCase().substring(style.toLowerCase().indexOf("width"),style.toLowerCase().indexOf(";")+1);
				inputHtml.append("width:100%;height:100%;");//文本框不控制宽度  高度
//				inputHtml.append("width:100%;height:100%;padding-left: 5px;");//文本框不控制宽度  高度
				inputHtml.append("\" ");
				
			//}
			
			String mask=inputText.getMask(); 
			if (mask != null && mask.trim().length() > 0) {//判断是否加载图标，并控制格式
				inputHtml.append("data-inputmask=\"'mask':'");
				inputHtml.append(mask);
				inputHtml.append("'\" ");
				
			}
			if (currentValue != null && currentValue.trim().length()>0) {
				//如果授权设置默认值有效了,将当前值强制设置为默认值
//				if(RenderKitUtils.isAuthedDefaultValue(context, component)){
//					String dValue = (String) component.getAttributes().get("defaultValue");
//					if(defaultValue == null || "null".equals(defaultValue.trim())){
//						dValue = "";
//					}else if(defaultValue instanceof String){
//						dValue = (String)defaultValue;
//					}else{
//						dValue = defaultValue+"";
//					}
//					currentValue = dValue;
//				}
//				currentValue = RenderKitUtils.convertSpecialCharacter(currentValue);
				inputHtml.append("value=\""+currentValue+"\"");
			}else if(defaultValue!=null && defaultValue.trim().length()>0){
				if(!FacesUtils.isPostBack(context)){//判断是否为第一次加载
					inputHtml.append("value=\""+defaultValue+"\"");
//					inputHtml.append("value=\""+RenderKitUtils.convertSpecialCharacter(defaultValue)+"\"");
				}
			}
//			ComponentValidatorHelper.getComponentValidatorsHtml(inputText);

			outValidations(inputText, inputHtml,itemID);

			if (step!=null&&step.trim().length()>0) {//步数
				inputHtml.append("step=\"");
				inputHtml.append(step);
				inputHtml.append("\" ");
				
			}
			
			if (pattern !=null&&pattern .trim().length()>0) {//校验格式
				pattern = pattern.trim();
				if(pattern.startsWith("/") && pattern.endsWith("/"))
					pattern = pattern.substring(1, pattern.length()-1);
				inputHtml.append("pattern =\"");
				inputHtml.append(pattern );
				inputHtml.append("\" ");
				
			}
//			if (disabled) {//disabled
//				inputHtml.append("disabled=\"disabled");
//				inputHtml.append("\" ");
//				
//			}
			boolean canEdit = RenderKitUtils
			.canEditableCurrentComponent(context, component);//readonly
			if (!canEdit) {
				inputHtml.append("readOnly=\"true");
				inputHtml.append("\" ");
				
			}
			
			if (onchange!=null&&!onchange.equals("")) {//onchange
				inputHtml.append(" onchange=\""+onchange+"\"");
			}
			
			if (onblur!=null&&!onblur.equals("")) {//onblur
				inputHtml.append(" onblur=\""+onblur+"\"");
			}
			
			String onclick = inputText.getOnclick();
			String ondbclick = inputText.getOndbclick();
			String onfocus = inputText.getOnfocus();
			
			if (onclick!=null&&!onclick.equals("")) {//onclick
				inputHtml.append(" onclick=\""+onclick+"\"");
			}
			if (ondbclick!=null&&!ondbclick.equals("")) {//ondbclick
				inputHtml.append(" ondbclick=\""+ondbclick+"\"");
			}
			if (onfocus!=null&&!onfocus.equals("")) {//onfocus
				inputHtml.append(" onfocus=\""+onfocus+"\"");
			}
			
//			if (!"true".equals(autocomplete)) {//autocomplete
				inputHtml.append("autocomplete=\"off");
				inputHtml.append("\" ");
				
//			}
			
			if ("true".equals(autofocus)) {
				inputHtml.append("autofocus ");
			}
			if (placeholder!=null&&placeholder.trim().length()>0) {//占位符输出
				inputHtml.append("placeholder=\"");
				inputHtml.append(placeholder);
				inputHtml.append("\" ");
				
			}
			String jsEvent = RenderKitUtils.renderISCAttributeForJSEventHtml5(context, component);
			if(!FacesUtils.isEmpty(jsEvent)){
				inputHtml.append(" "+jsEvent);
			}
			inputHtml.append("/> ");
			if(help!=null&&(!help.isEmpty())){
				inputHtml.append("<span class=\"help-block m-b-none\" style=\"margin-top:0px; margin-bottom:0px;\">");
				inputHtml.append("<i class=\"fa fa-info-circle\"></i>");
				inputHtml.append(help);
				inputHtml.append("</span>");
			}
			
			
			if (addon != null && addon.trim().length() > 0) {
				if (position!=null&&position.equals("right")) {
					inputHtml.append("<span class=\"input-group-addon\" style=\"background-color: #fff;border-radius: 1px;\">");
					inputHtml.append(addon);
					inputHtml.append("</span> ");
				}
			}
			if (btnText != null && btnText.trim().length() > 0) {
				if (position!=null&&position.equals("right")) {
					inputHtml.append("<span class=\"input-group-btn\"> <button type=\"button\" class=\"x-btn ok-btn\"");
					if (btnclick != null && btnclick.trim().length() > 0) {
						inputHtml.append("onclick=\""+btnclick+"\" ");
					}
					inputHtml.append(">");
					inputHtml.append(btnText);
					inputHtml.append("</button> </span>");
				}
			}
			if (icon != null && icon.trim().length() > 0) {//如果存在图标则加载
				inputHtml.append("<span class=\"fa fa-");
				inputHtml.append(icon);
				inputHtml.append(" form-control-feedback ");
				if (position != null && position.trim().length() > 0) {
					inputHtml.append(position);
				} else {
					inputHtml.append("left");
				}
				inputHtml.append("\" aria-hidden=\"true\" ");
				inputHtml.append(" style=\"margin-top:5px; ");
				if (position != null && position.trim().length() > 0) {
					inputHtml.append(position+":3px;");
				} else {
					inputHtml.append("left:3px;");
				}
				if(iconclick!=null&&(!iconclick.isEmpty())){
					inputHtml.append(" pointer-events:auto;\" onclick=\""+iconclick+"\" ");
				}else{
					inputHtml.append("\"");
				}
				
				inputHtml.append("></span>");
			}
			
				
			inputHtml.append("</div>");
			// String componentDiv =
			// RenderKitUtils.renderDisplayDivForFormItem(context,component,rendered);
			writer.write(inputHtml.toString());

			StringBuffer componentJS = new StringBuffer();
			if (mask != null && mask.trim().length() > 0) {//测试用可能删掉
				componentJS.append("<script>");
				componentJS.append("$(document).ready(function() {");
				componentJS.append("$(\":input\").inputmask();");
				componentJS.append("});");
				componentJS.append("</script>");
				
				
			}
			outJSFunctionValidator( inputText,  componentJS,  itemID);
			jsWriter.write(componentJS.toString());

		}
	}
	
	private void renderFilterInputText(MFacesContext context, MUIComponent component)	throws IOException {

		// 输出html
		MResponseWriter writer = context.getResponseWriter();
		// 输出js
		MResponseWriter jsWriter = context.getJsWriter();
		
		String currentValue = this.getCurrentValue(context, component);
		Boolean rendered = RenderKitUtils.isRenderCurrentComponent(context,
				component);
		InputText inputText = (InputText) component;
		inputText.getChildren();
		// String clientId = component.getId();
		String itemID = component.getClientId(context);
		String type = inputText.getType();
		String icon = inputText.getIcon();
		String position = inputText.getPosition();//定位
		String addon=inputText.getAddon();//插件
		String placeholder=inputText.getHint();//占位符
		Boolean isSecret=inputText.getIsSecret();
		String autocomplete=(String) component.getAttributes().get("autocomplete");
		String autofocus=(String) component.getAttributes().get("autofocus");
		Integer col=(Integer) component.getAttributes().get("col");
		String style = (String) component.getAttributes().get("style");//获得组件样式
		String min =inputText.getMin();
		String max =inputText.getMax();
		String step =inputText.getStep();
		String pattern =inputText.getPattern();
		String help =inputText.getHelp();
		String iconclick =inputText.getIconclick();
		String btnText=inputText.getBtnText();
		String btnclick=inputText.getBtnclick();
		String formProxyId = RenderKitUtils.getFormProxyId(component, context);
		Boolean toText = RenderKitUtils.isToTextCurrentComponent(context, component);
		String styleClass = (String) component.getAttributes().get("styleClass");
		
		// disabled
		boolean disabled = !RenderKitUtils.isEditableCurrentComponent(context, component);
		
		if (AjaxUtils.isAjaxRequest(context)) {
			// 异步刷新
			// 判断是否设置了强制刷新信息
			if (!RenderKitUtils.isRefreshCurrentComponent(context, component))
				return;
			RenderKitUtils.writeAjaxStart(jsWriter);
			if (currentValue == null)
				currentValue = "";
			if (toText != null && toText) {
				jsWriter.write(RenderKitUtils.writeISCToTextContentAjax(
						currentValue, currentValue, itemID, style, styleClass));
			} else {

				// change style javascript
				RenderKitUtils.writeISCStyleForAjax(context, component,
						jsWriter);

				// change value
//				currentValue = RenderKitUtils
//						.convertSpecialCharacter(currentValue);
				jsWriter.write("document.getElementById(\""+itemID + "\").value=\""+currentValue+"\";" );

				if (!disabled) {
					jsWriter.write("$(\"input#"+itemID+"\").bsSuggest('enable');" );
					boolean canEdit = RenderKitUtils
							.canEditableCurrentComponent(context, component);
					if (!canEdit) {
						jsWriter.write("$(\"input#"+itemID+"\").bsSuggest('enable');" );
					}
				} else {
					jsWriter.write("$(\"input#"+itemID+"\").bsSuggest('disable');" );
				}
			}
			RenderKitUtils.writeAjaxEnd(jsWriter);
			return;
		} else {
			//同步
			// String defaultValue = (String)
			// component.getAttributes().get("defaultValue");
			String defaultValue = RenderKitUtils.getDefaultValue(context,
					component);
			if (toText != null && toText) {
				String textValue = currentValue;
				if (textValue == null)
					textValue = defaultValue;
				RenderKitUtils.writeISCToTextContent(context, textValue,
						textValue, component, itemID);
				return;
			}
			// render componentDiv div for inputText
			StringBuffer inputHtml = new StringBuffer();

			inputHtml.append("<div id=\""+itemID+"_div\" class=\"input-group ");
			if (col != null ){
				inputHtml.append("col-md-"+col+" ");
			}else{
				
				inputHtml.append("col-md-12 ");
			}
			inputHtml.append(" default-width ");
			if (!FacesUtils.isEmpty(styleClass)) {//加载样式类
				inputHtml.append(styleClass+" ");

			} 
			if (icon != null && icon.trim().length() > 0) //判断是否加载图标，并控制格式
				inputHtml.append("has-feedback ");
			inputHtml.append("\" ");
			inputHtml.append("style=\"display: inline-table; vertical-align: middle; ");
			if (!rendered) {
				inputHtml.append(" display: none; ");
			}
			if (style != null && style.trim().length() > 0&& (!"null".equals(style.trim()))) {//加载样式
				inputHtml.append(style);//文本框宽度由div控制
			}
			inputHtml.append(" \"> ");
			
			inputHtml.append("<input id=\"");
			inputHtml.append(itemID);//组件编码
			inputHtml.append("\" name=\"");
			inputHtml.append(itemID);//组件编码
			//------asd 文本框限制长度
			if(inputText.getLength()!= null){
				inputHtml.append("\" maxlength=\"");
				inputHtml.append(inputText.getLength());//最大长度
			}
			//-------
			inputHtml.append("\" ");
			inputHtml.append("type=\"");
			inputHtml.append("text");
			inputHtml.append("\" ");
			boolean isRequired = RenderKitUtils.isRequiredCurrentComponent(
					context, component);
			if (isRequired) {
				inputHtml.append("required ");
			}
			inputHtml.append("class=\"");
			
				inputHtml.append("form-control ");
			
			if (icon != null && icon.trim().length() > 0) {//判断是否加载图标，并控制格式
				inputHtml.append("has-feedback-");
				if (position != null && position.trim().length() > 0) {
					inputHtml.append(position+" ");
				} else {
					inputHtml.append("left ");
				}
				
			}
			inputHtml.append("\" ");
		
			//if (style != null && style.trim().length() > 0&& (!"null".equals(style.trim()))) {//加载样式
				inputHtml.append("style=\" ");
				//String width=style.toLowerCase().substring(style.toLowerCase().indexOf("width"),style.toLowerCase().indexOf(";")+1);
				inputHtml.append("width:100%;height:100%;padding-left: 5px;");//文本框不控制宽度  高度
				inputHtml.append("\" ");
				
			//}
			
			String mask=inputText.getMask(); 
			if (mask != null && mask.trim().length() > 0) {//判断是否加载图标，并控制格式
				inputHtml.append("data-inputmask=\"'mask':'");
				inputHtml.append(mask);
				inputHtml.append("'\" ");
				
			}
			if (currentValue != null && currentValue.trim().length()>0) {
				//如果授权设置默认值有效了,将当前值强制设置为默认值
//				if(RenderKitUtils.isAuthedDefaultValue(context, component)){
//					String dValue = (String) component.getAttributes().get("defaultValue");
//					if(defaultValue == null || "null".equals(defaultValue.trim())){
//						dValue = "";
//					}else if(defaultValue instanceof String){
//						dValue = (String)defaultValue;
//					}else{
//						dValue = defaultValue+"";
//					}
//					currentValue = dValue;
//				}
//				currentValue = RenderKitUtils.convertSpecialCharacter(currentValue);
				inputHtml.append("value=\""+currentValue+"\"");
			}else if(defaultValue!=null && defaultValue.trim().length()>0){
				if(!FacesUtils.isPostBack(context)){//判断是否为第一次加载
					inputHtml.append("value=\""+defaultValue+"\"");
//					inputHtml.append("value=\""+RenderKitUtils.convertSpecialCharacter(defaultValue)+"\"");
				}
			}
			
			outValidations( inputText,  inputHtml,itemID);

			if (step!=null&&step.trim().length()>0) {//步数
				inputHtml.append("step=\"");
				inputHtml.append(step);
				inputHtml.append("\" ");
				
			}
			
			if (pattern !=null&&pattern .trim().length()>0) {//校验格式
				inputHtml.append("pattern =\"");
				inputHtml.append(pattern );
				inputHtml.append("\" ");
				
			}
			if (disabled) {//disabled
				inputHtml.append("disabled=\"disabled");
				inputHtml.append("\" ");
				
			}
			boolean canEdit = RenderKitUtils
			.canEditableCurrentComponent(context, component);//readonly
			if (!canEdit) {
				inputHtml.append("readonly=\"readonly ");
				inputHtml.append("\" ");
				
			}
			if (!"true".equals(autocomplete)) {//autocomplete
				inputHtml.append("autocomplete=\"off");
				inputHtml.append("\" ");
				
			}
			
			if ("true".equals(autofocus)) {
				inputHtml.append("autofocus ");
			}
			if (placeholder!=null&&placeholder.trim().length()>0) {//占位符输出
				inputHtml.append("placeholder=\"");
				inputHtml.append(placeholder);
				inputHtml.append("\" ");
				
			}
			String jsEvent = RenderKitUtils.renderISCAttributeForJSEventHtml5(context, component);
			if(!FacesUtils.isEmpty(jsEvent)){
				inputHtml.append(" "+jsEvent);
			}
			inputHtml.append("/> ");
			if(help!=null&&(!help.isEmpty())){
				inputHtml.append("<span class=\"help-block m-b-none\" style=\"margin-top:0px; margin-bottom:0px;\">");
				inputHtml.append("<i class=\"fa fa-info-circle\"></i>");
				inputHtml.append(help);
				inputHtml.append("</span>");
			}

			inputHtml.append("<div class=\"input-group-btn\">");
			inputHtml.append("<button type=\"button\" class=\"btn btn-white dropdown-toggle\" data-toggle=\"\">");
			inputHtml.append("<span class=\"caret\"></span>");
			inputHtml.append("</button>");
			inputHtml.append("<ul class=\"dropdown-menu dropdown-menu-right\" role=\"menu\" style=\"padding-top: 0px; max-height: 375px; max-width: 800px; overflow: auto; width: auto; transition: 0.3s; left: -367px; right: auto; min-width: 400px;\"></ul>");
			inputHtml.append("</div>");

			inputHtml.append("</div>");
			writer.write(inputHtml.toString());

			DataSource dataSource = null;
		
			jsWriter.append("<script>");
			jsWriter.append("var "+itemID+" = $(\"#"+itemID+"\").bsSuggest({");
			jsWriter.append(" allowNoKeyword: false, ");
			jsWriter.append(" multiWord: true, " );
			jsWriter.append(" separator: \",\",");
			jsWriter.append(" getAllowNoKeyword:" + inputText.getAllowNoKeyword()+",");
						
			String getDataMethod = inputText.getGetDataMethod();
			if(getDataMethod == null || getDataMethod.trim().length()==0){
				getDataMethod = "url";
			}
			jsWriter.append(" getDataMethod:'" + getDataMethod+"',");
			
			String fieldAlias = "";
			String dataSourceId = inputText.getDataSourceId();
			MUIComponent ui = FacesUtils.findComponentById(context.getViewRoot(),dataSourceId);
			if(ui != null){
				if(ui instanceof DataSource){
					dataSource = (DataSource)ui;
					fieldAlias = dataSource.getDataFieldsHeader();
				}
			}
			
			if("data".equals(inputText.getGetDataMethod())){
				if(dataSourceId != null && dataSourceId.trim().length()>0){
					String data = dataSource.getDataJsonForGrid(context); 
					data = "{\"value\": "+data+"}";
					jsWriter.append(" data: "+data+",");
				}
			}else{
				String url ="";
				String getDataUrl=inputText.getGetDataUrl();
				if(getDataUrl == null || dataSourceId.trim().length()<0){
					String formTid = context.getViewRoot().getFormTId();
					if(formTid == null)
						formTid = "";
					url = " url: webContextPath+\"/matrix.rform?mHtml5Flag=true&MATRIX_REFRESH_FORM_ID=form0&matrix_command_id=loadData&X-Requested-With=XMLHttpRequest&REFRESH_COMPONENT_IDS="+dataSourceId+",&matrix_form_tid="+formTid;
					url = url + "&keyword=\",";
					jsWriter.append(url);
				}
				if(getDataUrl != null && getDataUrl.trim().length()>0){
					url="url: \""+getDataUrl+"\",";
					jsWriter.append(url);
					if(inputText.getIsCrossDomain()) {
						jsWriter.append("jsonp: \"callback\",");
					}
					String processData=inputText.getProcessData();
					if(processData != null && processData.trim().length()>0) {
						jsWriter.append("processData:function(rData){ return "+processData+"(rData);},");
					}
				}
			}
			
			if(fieldAlias != null && fieldAlias.trim().length()>0)
				jsWriter.append(" effectiveFieldsAlias:" + fieldAlias+",");
			
			if(inputText.getIdField() != null && inputText.getIdField().trim().length()>0)
				jsWriter.append("idField: \""+inputText.getIdField()+"\",");
			if(inputText.getKeyField() != null && inputText.getKeyField().trim().length()>0)
				jsWriter.append("keyField: \""+inputText.getKeyField()+"\",");
			if(inputText.getShowBtn())
				jsWriter.append("showBtn: true,");
			else	
				jsWriter.append("showBtn: false,");
			if(inputText.getShowHeader())
				jsWriter.append("showHeader: true");
			else	
				jsWriter.append("showHeader: false");
			jsWriter.append("});");
			
			jsWriter.append("</script>");
			
			StringBuffer componentJS = new StringBuffer();
			if (mask != null && mask.trim().length() > 0) {//测试用可能删掉
				componentJS.append("<script>");
				componentJS.append("$(document).ready(function() {");
				componentJS.append("$(\":input\").inputmask();");
				componentJS.append("});");
				componentJS.append("</script>");
				
				
			}
			outJSFunctionValidator(inputText,  componentJS,  itemID);
			jsWriter.write(componentJS.toString());

		}

	}
	
	private void outValidations(InputText inputText, StringBuffer inputHtml, String itemID) {

		List<Validator> validators = inputText.getValidatorList();
		if (validators != null && validators.size() > 0) {
			for (Iterator it = validators.iterator(); it.hasNext();) {
				/**
				 * 设置Double类型的最大值最小之后 走默认的提示信息
				 */

				Object obj = it.next();
				if (obj == null)
					continue;
				if (obj instanceof DoubleRangeValidator) {
					DoubleRangeValidator doubleRangeValidator = (DoubleRangeValidator) obj;
					double maxLarge = doubleRangeValidator.getMaxValue();
					double minLarge = doubleRangeValidator.getMinValue();
					inputHtml.append("pattern=\"numberRange,");
					if (maxLarge > 0) {
						inputHtml.append(maxLarge);
					}
					inputHtml.append(",");
					if (minLarge >= 0) {
						inputHtml.append(minLarge);
					}
					inputHtml.append("\" ");
					String precisionMessage = doubleRangeValidator.getErrorMessage();
					if (precisionMessage != null && precisionMessage.trim().length() > 0) {
						inputHtml.append("data-errormessage=\"");
						inputHtml.append(precisionMessage);
						inputHtml.append("\" ");
					}
				}
				if (obj instanceof LongRangeValidator) {
					/**
					 * 设置Long类型的最大值和最小值之后 走默认的提示信息
					 */
					LongRangeValidator longRangeValidator = (LongRangeValidator) obj;
					Long maxLong = longRangeValidator.getMaxValue();
					Long minLong = longRangeValidator.getMinValue();
					inputHtml.append("pattern=\"numberRange,");
					if (maxLong > 0) {
						inputHtml.append(maxLong);
					}
					inputHtml.append(",");
					if (minLong >= 0) {
						inputHtml.append(minLong);
					}
					inputHtml.append("\" ");
					String precisionMessage = longRangeValidator.getErrorMessage();
					if (precisionMessage != null && precisionMessage.trim().length() > 0) {
						inputHtml.append("data-errormessage=\"");
						inputHtml.append(precisionMessage);
						inputHtml.append("\" ");
					}
				}
				if (obj instanceof LengthValidator) {
					/**
					 * 设置长度校验之后 输入框只能输入相应长度以及以内的字符 不会提示，但超出长度之后不能输入
					 */
					LengthValidator lengthValidator = (LengthValidator) obj;
					int maxLength = lengthValidator.getMaxLength();
					int minLength = lengthValidator.getMinLength();
					if (maxLength > 0) {
						inputHtml.append("maxlength=\"");
						inputHtml.append(maxLength);
						inputHtml.append("\" ");
					}
					if (minLength >= 0) {
						inputHtml.append("minlength=\"");
						inputHtml.append(minLength);
						inputHtml.append("\" ");
					}
				}
				if (obj instanceof EmailValidator) {
					/**
					 * email校验 是正则表达式的校验 走自定义的提示信息
					 */
					EmailValidator emailValidator = (EmailValidator) obj;
					String emailPatternName = emailValidator.getName();
					if (emailPatternName != null && emailPatternName.trim().length() > 0) {
						inputHtml.append("pattern =\"");
						String rule = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
						if (AjaxUtils.isRealAjaxRequest(MFacesContext.getCurrentInstance())) {
							rule = rule.replaceAll("\\\\", "\\\\\\\\");
						}
						inputHtml.append(rule);
//				inputHtml.append("^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$" );
						inputHtml.append("\" ");
					}
					String errorMessage = emailValidator.getErrorMessage();
					if (errorMessage != null && errorMessage.trim().length() > 0) {
						inputHtml.append("data-errormessage=\"");
						inputHtml.append(errorMessage);
						inputHtml.append("\" ");
					}
				}
				if (obj instanceof MobileTelephoneValidator) {
					/**
					 * 手机号码校验 也是正则表达式校验 走自定义的信息提示
					 */
					MobileTelephoneValidator phoneValidator = (MobileTelephoneValidator) obj;
					String phonePatternName = phoneValidator.getName();// ^(13[0-9]|14[0-9]|15[0-9]|18[0-9])[0-9]{8}$
					if (phonePatternName != null && phonePatternName.trim().length() > 0) {
						inputHtml.append("pattern =\"");
						inputHtml.append("^[1](([3][0-9])|([4][5-9])|([5][0-3,5-9])|([6][5,6])|([7][0-8])|([8][0-9])|([9][1,8,9]))[0-9]{8}$");
						inputHtml.append("\" ");
					}
					String phoneMessage = phoneValidator.getErrorMessage();
					if (phoneMessage != null && phoneMessage.trim().length() > 0) {
						inputHtml.append("data-errormessage=\"");
						inputHtml.append(phoneMessage);
						inputHtml.append("\" ");
					}
				}
				if (obj instanceof IdentityCardValidator) {
					// idcard
					// (^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$)|(^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|(\d|X)?)$)
					/**
					 * 身份证校验 也是正则表达式校验 走自定义的提示信息
					 */
					IdentityCardValidator idCard = (IdentityCardValidator) obj;
					String name = idCard.getName();
					if (name != null && name.trim().length() > 0) {
						inputHtml.append("pattern =\"");
						String rule = "^(\\d{6})(\\d{4})(\\d{2})(\\d{2})(\\d{3})([0-9]|X)$";
						if (AjaxUtils.isRealAjaxRequest(MFacesContext.getCurrentInstance())) {
							rule = rule.replaceAll("\\\\", "\\\\\\\\");
						}
						inputHtml.append(rule);
//				inputHtml.append("^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X)$" );
						inputHtml.append("\" ");
					}
					String idCardMessage = idCard.getErrorMessage();
					if (idCardMessage != null && idCardMessage.trim().length() > 0) {
						inputHtml.append("data-errormessage=\"");
						inputHtml.append(idCardMessage);
						inputHtml.append("\" ");
					}
				}

				if (obj instanceof PrecisionValidator) {
					/**
					 * 精度校验 也是正则表达式校验 走自定义的提示信息
					 */
					PrecisionValidator precisionValidator = (PrecisionValidator) obj;

					int precision = precisionValidator.getPrecision();
					if (precision > 0) {
						inputHtml.append("pattern =\"");
						String rule = "^\\d*\\.\\d{" + precision + "}$";
						if (AjaxUtils.isRealAjaxRequest(MFacesContext.getCurrentInstance())) {
							rule = rule.replaceAll("\\\\", "\\\\\\\\");
						}
						inputHtml.append(rule);
//				inputHtml.append("^\\d*\\.\\d{"+precision+"}$" );
						inputHtml.append("\" ");
					}
					String precisionMessage = precisionValidator.getErrorMessage();
					if (precisionMessage != null && precisionMessage.trim().length() > 0) {
						inputHtml.append("data-errormessage=\"");
						inputHtml.append(precisionMessage);
						inputHtml.append("\" ");
					}
				}
				if (obj instanceof RegexpValidator) {
					/**
					 * 正则校验
					 */
					RegexpValidator regExpValidator = (RegexpValidator) obj;
					String value = regExpValidator.getRegexp();
					if (AjaxUtils.isRealAjaxRequest(MFacesContext.getCurrentInstance())) {
						value = value.replaceAll("\\\\", "\\\\\\\\");
					}

					String regExpMessage = regExpValidator.getErrorMessage();
					if (value != null && value.trim().length() > 0) {
						inputHtml.append("pattern =\"");
						inputHtml.append(value);
						inputHtml.append("\" ");
					}
					if (regExpMessage != null && regExpMessage.trim().length() > 0) {
						inputHtml.append("data-errormessage=\"");
						inputHtml.append(regExpMessage);
						inputHtml.append("\" ");
					}
				}
				if (obj instanceof PostCodeValidator) {
					/**
					 * 邮编校验 走自定义的提示信息
					 */
					PostCodeValidator postCodeValidator = (PostCodeValidator) obj;
					String value = postCodeValidator.getName();
					String postCodeMessage = postCodeValidator.getErrorMessage();
					if (value != null && value.trim().length() > 0) {
						inputHtml.append("pattern =\"");
						String rule = "^\\d{6}$";
						if (AjaxUtils.isRealAjaxRequest(MFacesContext.getCurrentInstance())) {
							rule = rule.replaceAll("\\\\", "\\\\\\\\");
						}
						inputHtml.append(rule);
//				inputHtml.append("^\\d{6}$");
						inputHtml.append("\" ");
					}
					if (postCodeMessage != null && postCodeMessage.trim().length() > 0) {
						inputHtml.append("data-errormessage=\"");
						inputHtml.append(postCodeMessage);
						inputHtml.append("\" ");
					}
				}
				if (obj instanceof JSFunctionValidator) {
					/* js方法自定义的提示信息 */
					JSFunctionValidator jsFunctionValidator = (JSFunctionValidator) obj;
					String method = jsFunctionValidator.getFunctionName();
					if (method != null && method.trim().length() > 0) {
						inputHtml.append(" " + method + "" + itemID + "='true' ");
					}
				}
			}
		}
	}

	@Override
	public Object getConvertedValue(MFacesContext context,
			MUIComponent component, Object submittedValue)
			throws MConverterException {

		boolean isBigDecimal = ((InputText) component).isBigDecimal();
		if (isBigDecimal) {
			if (submittedValue == null || submittedValue.equals(""))
				return null;
			else {
				try {
					return new BigDecimal(submittedValue + "");
				} catch (Exception e) {
					e.printStackTrace();
					String title = Messages.getResourceString(component
							.getClientId(context));
					Object[] params = { submittedValue, title };
					throw new MConverterException(MessageFactory2.getMessage(
							context, MessageUtils2.CONVERSION_ERROR_MESSAGE_ID,
							params));
				}
			}
		} else {
			return super.getConvertedValue(context, component, submittedValue);
		}
	}

	@Override
	protected void getEndTextToRender(MFacesContext context,
			MUIComponent component, String currentValue) throws IOException {
	}
	/**
	 * 组件自定义js方法校验
	 * @param inputText
	 * @param componentJS
	 * @param itemID
	 */
	private void outJSFunctionValidator(InputText inputText, StringBuffer componentJS, String itemID) {
		List<Validator> validators = inputText.getValidatorList();
		if (validators != null && validators.size() > 0) {
			componentJS.append("<script>");
			for (Iterator it = validators.iterator(); it.hasNext();) {
				Object obj = it.next();
				if (obj == null)
					continue;
				if (obj instanceof JSFunctionValidator) {
					/* js方法自定义的提示信息 */
					JSFunctionValidator jsFunctionValidator = (JSFunctionValidator) obj;
					String method = jsFunctionValidator.getFunctionName();
					String message = jsFunctionValidator.getErrorMessage();
					if (method != null && method.trim().length() > 0) {

						componentJS.append(
								"$.validator.addMethod('" + method + "" + itemID + "',function(value,element,params){");
						componentJS.append("return " + method + "(value,element);");
						componentJS.append("},'" + message + "');");
					}
				}
			}
			componentJS.append("</script>");
		}
	}
}
