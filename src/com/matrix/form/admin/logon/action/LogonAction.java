package com.matrix.form.admin.logon.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.matrix.api.MFExecutionAgent;
import com.matrix.api.MFExecutionService;
import com.matrix.api.identity.MFUser;
import com.matrix.app.MAppContext;
import com.matrix.app.MAppProperties;
import com.matrix.commonservice.data.DataService;
import com.matrix.extention.SessionContextHolder;
import com.matrix.form.admin.common.action.BaseAction;
import com.matrix.form.admin.common.utils.CommonUtil;
import com.matrix.form.admin.common.utils.CompTypeConstant;
import com.matrix.form.api.MFormContext;
import com.matrix.form.engine.FormConstants;
import com.matrix.form.render.message.Messages;
import com.matrix.form.render.message.MultiLanManager;
import com.matrix.office.FlowBizConcurrentHelper;
import com.matrix.office.common.oplog.AuditInfoHelper;

@Controller
@Scope("prototype")
public class LogonAction extends BaseAction {

	private String m_appId;
	/**
	 * 登陆
	 *
	 * @return
	 */
	public String logon() {
		String errorResult = "matrix_" + this.ERROR;
		MultiLanManager.getInstance();
		//是否是主应用登录 还是租户登录
		boolean isMainApp = true;
		//是否启用了租户
		boolean isTenantEnable = MAppProperties.getInstance().isTenantEnable();

		if(!com.matrix.form.util.CommonUtil.isNullOrEmpty(m_appId)) {
			isMainApp = false;
		}

//		FormDesignVueAction action = new FormDesignVueAction();
//		action.loadForm();

		//登录前判断
		HttpSession httpSession = SessionContextHolder.getSession();
		Object userNa = httpSession.getValue(FormConstants.MATRIX_USER);
		if(userNa!=null){
			response.setContentType("text/html; charset=UTF-8"); //转码
		    PrintWriter out = null;
			try {
				out = response.getWriter();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		    out.flush();
		    out.println("<script type='text/javascript'>");
		    out.println("alert('已有账号登录，请注销后再登录此账号~!');");
		    out.println("</script>");

		}else{
			DataService dataService = MFormContext.getService("DataService");
			
//			DataObject adminO = dataService.load("foundation.org.User", "admin");
//			adminO.setString("userId", adminO.getString("userId"));
//			dataService.update(adminO);
			
//			Session session = DASAgent.getFormDASService().getSession();
//			Object value = session.createQuery("select u.userId from foundation.org.User as u,foundation.org.Department as d where u.depId = d.depId");
//			Object value = session.createQuery("select u.userId from foundation.org.User as u,foundation.org.Department as d where u.userId = d.depId");
//			Object value = session.createQuery("select u.userId from foundation.org.User as u where u.userId = 'asdf'");
//			List list3 = dataService.queryList("select u.userId from foundation.org.User as u,foundation.org.Department as d where u.orgId = d.depId", null);
			
			//默认普通用户登录
			String viewType = "user";
			String resultView = "index";

			if(isMainApp){   //主应用登录时
				if(isTenantEnable){  //支持租户
					resultView = "config";
					viewType = "admin";
				}
			}else
				{   //租户登录时
				errorResult = "app_" + this.ERROR;

				response.setContentType("text/html; charset=UTF-8"); //转码
			    PrintWriter out = null;
				try {
					out = response.getWriter();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				if(isTenantEnable){  //支持租户
					String appName = (String) dataService.querySqlValue("select APP_NAME from mf_tmpl_application where APP_ID = '"+m_appId+"'", null, null);
					if(appName == null || appName.trim().length() == 0){
//						out.flush();
//					    out.println("<script type='text/javascript'>");
//					    out.println("alert('该应用不存在~!');");
//					    out.println("</script>");
					    return errorResult;
					}

				}else{
//					out.flush();
//				    out.println("<script type='text/javascript'>");
//				    out.println("alert('不支持租户~!');");
//				    out.println("</script>");
				    return errorResult;
				}

				Cookie cookie = new Cookie(MAppContext.LOGON_APP, request.getParameter(MAppContext.LOGON_APP));
				cookie.setHttpOnly(true);
				cookie.setPath("/");
		        response.addCookie(cookie);
		        //存放应用编码
				MAppContext.setCurrentAppId(m_appId);
			}

			if("admin".equals(viewType)){  //管理员
				String isChrome = request.getParameter("isChrome");
				if("false".equals(isChrome)){     //非谷歌无法登录
					this.request.setAttribute("isChrome", "false");
					return errorResult;
				}else{

				}
			}

			AuditInfoHelper ah = new AuditInfoHelper();
			boolean isMobile = this.isMobile();
			if (false) { // 移动端不校验验证码
				// 验证码验证
				String code = request.getParameter("code");

				if (code == null
						|| this.request.getSession().getAttribute("matrix_verify_code") ==null ||  !code.toLowerCase().equals(this.request.getSession().getAttribute(
								"matrix_verify_code").toString().toLowerCase())) {
					this.request.setAttribute("InvalidCode", "true");
					return errorResult;
				}
			}

			// 登陆
			String logonName = request.getParameter("logonName");
			String password = request.getParameter("password");
			String objSql;
			String numHql;
			if (logonName != null && logonName.trim().length() > 0) {
			try {
				logonName = logonName.trim();
				MFExecutionService executionService = MFExecutionAgent.getExecutionService();
				executionService.logon(logonName, password);

				MFUser user = executionService.getMFUser();
				String userName = user.getUserName();

				if (user != null) {
					this.setMFExecutionService(executionService);
					MFormContext.setUser(user);
					
					//默认非定制设计器
					MFormContext.setIsCustomFormDesign(false);
					MFormContext.setIsCustomProcessDesign(false);  

					if("user".equals(viewType)){   //普通用户
						MFormContext.setPhaseId(CompTypeConstant.ORDINARY_USER);
						//加载门户信息
						String getDepSpace = "select uuid,title from com.matrix.client.foundation.portal.model.Portal where type=3 order by index asc";
						List<Object[]> list = dataService.queryList(getDepSpace, null);
						request.setAttribute("portals", list);

					}else if("admin".equals(viewType)){  //管理员
						boolean isAdmin = CommonUtil.isAdmin();  //是否是admin
						if (isAdmin) {  //管理员
							MFormContext.setPhaseId(CompTypeConstant.PHASE_CUSTOMIZE);

						}else{
							ah.saveAudit("注销成功");
							try {
								if (executionService != null && executionService.isValidSession()) {
									executionService.logoff();
								}
								this.setMFExecutionService(null);
								MFormContext.setUser(null);
							} catch (Exception e) {
							}

							response.setContentType("text/html; charset=UTF-8"); //转码
						    PrintWriter out = null;
							try {
								out = response.getWriter();
							} catch (IOException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
							out.flush();
						    out.println("<script type='text/javascript'>");
						    out.println("alert('租户启用状态下请使用管理员角色登录~!');");
						    out.println("</script>");
						    return errorResult;
						}
					}

					objSql = "UPDATE MF_ORG_USER set FLAG='1' where USER_ID = '" + user.getUserId() + "'";
					numHql = "select count(*) from foundation.org.User where flag=1";
					if(!MFormContext.isOutterOrg())
						dataService.executeSql(objSql, null, null);

					int n = 0;
					Object num = (Object) dataService.queryObject(numHql, null);
					if (num != null) {
						n = Integer.valueOf(num.toString());

					}
					ah.saveAudit("登录成功");
					MFormContext.setSessionAttribute("Logon_User_Num", n);
					request.setAttribute("userName", userName);
					request.setAttribute("logonMode", viewType);   //直接登录默认登录方式是普通用户视图
					setCurrentLangge();
					//皮肤类型
					String skin = (String) dataService.queryValue("select skin from SysInfo where uuid = 'mbpm'", null);
					if(skin != null && skin.trim().length() >0){
						request.getSession().setAttribute("skin", skin);
					}else{
						request.getSession().setAttribute("skin", "primary");  //默认皮肤
					}
					return resultView;

				} else {
					this.request.setAttribute("InvalidUser", "true");
					return errorResult;
				}
			} catch (Exception e) {

//				e.printStackTrace();
				this.request.setAttribute("InvalidUser", "true");
				this.request.setAttribute("InvalidPsd", "true");
				return errorResult;
			}
		  }
		}
		return errorResult;
	}

	/**
	 * 注销
	 *
	 * @return
	 */
	public String logoff() {
//		if(2>1)
//			return null;
		request.setAttribute(MAppContext.LOGON_APP, m_appId);
		String formUser = CommonUtil.getFormUser();
		String logoffResult=formUser + "_logoff";
		AuditInfoHelper ah = new AuditInfoHelper();
		String objsql;
		MFExecutionService executionService = this.getMFExecutionService();
		DataService dataService = MFormContext.getService("DataService");
		if(executionService!=null ){
			MFUser user = executionService.getMFUser();
			if(user != null){
				// 设置在线标志
				objsql = "UPDATE MF_ORG_USER set FLAG='0' where USER_ID = '"
						+ user.getUserId() + "'";
				if(!MFormContext.isOutterOrg())
					dataService.executeSql(objsql, null, null);

//				//清除并发信息
//				FlowBizConcurrentHelper.clearCurrentInfoOfUser();

				ah.saveAudit("注销成功");
				try {
					if (executionService != null && executionService.isValidSession()) {
						executionService.logoff();
					}
					this.setMFExecutionService(null);
					MFormContext.setUser(null);
				} catch (Exception e) {
				}
			}

		}
		if(!com.matrix.form.util.CommonUtil.isNullOrEmpty(m_appId) && !("null").equals(m_appId)) {
			logoffResult= "app_logoff";
		}
		boolean isMobile = this.isMobile();
		if(isMobile){//移动端
			return "mobileHome";
		}else{
			//清除应用程序Id
			MAppContext.cleanSessionAppId();
			return logoffResult;
		}
	}

	/**
	 * 切换账号视图
	 * @return
	 */
	public String switchView() {
		DataService dataService = MFormContext.getService("DataService");
		String viewType = request.getParameter("viewType");  //切换视图类型

		//移除session操作标志
		request.getSession().removeAttribute("operation");

		//获得当前流程服务对象
		MFExecutionService executionService = this.getMFExecutionService();
		MFUser user = executionService.getMFUser();
		String userName = user.getUserName();

		String resultView = null;
		if("user".equals(viewType)){   //普通用户
			MFormContext.setPhaseId(CompTypeConstant.ORDINARY_USER);
			//加载门户信息
			String getDepSpace = "select uuid,title from com.matrix.client.foundation.portal.model.Portal where type=3 order by index asc";
			List<Object[]> list = dataService.queryList(getDepSpace, null);
			request.setAttribute("portals", list);
			resultView = "index";

		}else if("admin".equals(viewType)){  //管理员
			 MFormContext.setPhaseId(CompTypeConstant.PHASE_CUSTOMIZE);
			 resultView = "config";

		}else if("designer".equals(viewType)){   //设计人员
			MFormContext.setPhaseId(CompTypeConstant.PHASE_IMPLEMENT);
			resultView = "catalogH5";

		}else if("changeSkin".equals(viewType)){   //更换皮肤时自动刷新管理员界面  并展开皮肤管理子菜单
			request.setAttribute("operation", "changeSkin");
			MFormContext.setSessionAttribute("operation", "changeSkin");  //切换皮肤时操作标志
			viewType = "admin";
			MFormContext.setPhaseId(CompTypeConstant.PHASE_CUSTOMIZE);
			resultView = "config";
		}else if("changeApp".equals(viewType)){   //切换应用刷新主页  展开应用配置菜单
			request.setAttribute("operation", "changeApp");
			MFormContext.setSessionAttribute("operation", "changeApp");  //切换应用时操作标志
			viewType = "admin";
			MFormContext.setPhaseId(CompTypeConstant.PHASE_CUSTOMIZE);
			resultView = "config";
		}

		//统计当前在线人数
		String numHql = "select count(*) from foundation.org.User where flag=1";
		Object num = (Object) dataService.queryObject(numHql,null);
		int n = 0;
		if (num != null) {
			n = Integer.valueOf(num.toString());
		}
		MFormContext.setSessionAttribute("Logon_User_Num", n);
		request.setAttribute("userName", userName);
		request.setAttribute("logonMode", viewType);   //切换不同视图登录 user普通视图  admin管理员视图  designer设计开发视图
		setCurrentLangge();
		return resultView;
	}

//	public LogonService getLogonService() {
//		return logonService;
//	}
//
//	public void setLogonService(LogonService logonService) {
//		this.logonService = logonService;
//	}

	private boolean isMobile() {
		String userAgent = this.getRequest().getHeader("USER-AGENT")
				.toLowerCase();

		// 移动端
		if (userAgent.indexOf("iphone") > 0 || userAgent.indexOf("mobile") > 0) {
			return true;
		}

		return false;
	}



	public String getM_appId() {
		return m_appId;
	}

	public void setM_appId(String m_appId) {
		this.m_appId = m_appId;
	}

	private void setCurrentLangge(){
		request.getSession().setAttribute(Messages.sessionLocaleKey, com.matrix.form.util.CommonUtil.getCookie(request,"langge"));
	}
}