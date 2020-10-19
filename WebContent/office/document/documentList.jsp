<%@ page contentType="text/html; charset=gb2312"%>
<%@ page
	import="java.util.*,java.sql.*,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Date,DBstep.iDBManager2000.*"%>
<%!DBstep.iDBManager2000 DbaObj = new DBstep.iDBManager2000();

	//�г�����ģ��
	public String GetTemplateList(String ObjType, String FileType) {
		String mTemplateList, mstr = "";
		mTemplateList = "<select name=" + ObjType + " >";
		mTemplateList = mTemplateList
				+ "<option value=''>--------����ģ��--------</option>";
		String Sql = "select RecordID,Descript from Template_File where FileType='"
				+ FileType + "'"; //�����ݿ�
		try {
			if (DbaObj.OpenConnection()) {
				try {
					ResultSet result = DbaObj.ExecuteQuery(Sql);
					mstr = "selected";
					while (result.next()) {
						mTemplateList = mTemplateList + "<option value='"
								+ result.getString("RecordID") + "'" + mstr
								+ ">" + result.getString("Descript")
								+ "</option>";
					}
					result.close();
				} catch (SQLException sqlex) {
					System.out.println(sqlex.toString());
				}
			} else {
				System.out.println("GetTemplateList: OpenDatabase Error");
			}
		} finally {
			DbaObj.CloseConnection();
		}
		mTemplateList = mTemplateList + "</select>";
		return (mTemplateList);
	}
	/**
   * ���ܻ����ã���ʽ������ʱ��
   * @param DateValue �������ڻ�ʱ��
   * @param DateType ��ʽ�� EEEE������, yyyy����, MM����, dd����, HH��Сʱ, mm�Ƿ���,  ss����
   * @return ����ַ���
   */
  public String FormatDate(String DateValue,String DateType)
  {
    String Result;
    SimpleDateFormat formatter = new SimpleDateFormat(DateType);
    try{
      Date mDateTime = formatter.parse(DateValue);
      Result = formatter.format(mDateTime);
    }catch(Exception ex){
      Result = ex.getMessage();
    }
    if (Result.equalsIgnoreCase("1900-01-01")){
      Result = "";
    }
    return Result;
  }
	%>
<%
  SimpleDateFormat f1 = new SimpleDateFormat("yyyyMMddHHmm");
  SimpleDateFormat f2 = new SimpleDateFormat("ss");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>���Ƽ�-iWebOffice2015�����ĵ��м��ʾ������</title>
		<meta http-equiv="X-UA-Compatible" content="IE=8" />
		<link rel='stylesheet' type='text/css' href='css/iWebProduct.css' />
		<script language="javascript">
		
  function CheckActiveX(){ 
    var mObject=true;
    try{
      var newAct =   new ActiveXObject("Kinggrid.iWebOffice");
     
      if(newAct == undefined ){
       mObject=false;
      }
    }catch(e){
      mObject=false;
    }
    newAct = null;
    if(!(window.ActiveXObject||"ActiveXObject" in window)){
    activex_install.innerHTML ="����������û���������أ��鿴˵��"
    return true;
    }
	    if(mObject){
		  activex_install.innerHTML = "�Ѿ���װiWebOffice2015�м����";
		  activex_install.style.color="#FFFFFF";
	    }else{
	      //�ؼ��޷�����
	      activex_install.innerHTML = "��ע�⣬δ��⵽iWebOffice2015�м������鿴˵��������˵����Ҫ������ʹ�õĻ�����";
		  activex_install.style.color="#FF0000";
	    }
   
    return mObject; 
  }

  function init(){
	  var mhtml = document.documentElement.clientHeight;
	  var mhead = document.getElementById("mhead").offsetHeight; 
	  var mtitle = document.getElementById("mtitle").offsetHeight;
	  var mfooter = document.getElementById("mfooter").offsetHeight; 
	  document.getElementById('mbody').style.height = mhtml- mhead-mtitle-mfooter+"px";
	  
	  document.getElementById('showlist').style.height = mhtml- mhead-mtitle-mfooter-160+"px";
	  document.getElementById('showlist').style.width = document.getElementById('titleTable').offsetWidth;
  }
	  
	  
  //��ȡid�ĸ߶�
  function  getHeight(id){
    return document.getElementById(id).offsetHeight; 
  }
  
  function ShowExplain(){
 	 window.open("UserExplain.html", 'newwindow','height=300px,width=780px,top=150,left=300,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');  

  }
  
  
  function OpenNewPage(value){
  	var mhtmlHeight = window.screen.availHeight;//��ô��ڵĴ�ֱλ��;
	var mhtmlWidth = window.screen.availWidth; //��ô��ڵ�ˮƽλ��; 
	var iTop = 0; //��ô��ڵĴ�ֱλ��;
	var iLeft = 0; //��ô��ڵ�ˮƽλ��;
    var values = new Array;
    values = value.split(",");    
    FileType = values[0];
    FileVal  = values[1];
    var title = document.getElementById("title").value;
    var subTitle = document.getElementById("subTitle").value;
    var sign = document.getElementById("sign").value;
    var templateId = document.getElementById("templateId").value;
    //var recordId = document.getElementById("recordId").value;
    var recordId = "123";
    if(FileType != -1){

     var aa =  window.open('documentEdit.jsp?FileType='+FileType+'&UserName='+ encodeURI(encodeURI(username.value))+'&EditType=2&title='+title+'&subTitle='+subTitle+'&sign='+sign+'&templateId='+templateId+"&recordId="+recordId,'iWebOffice2015�����ĵ��м��ʾ������','top='+iTop+',left='+iLeft+',toolbar=yes,menubar=yes,scrollbars=no,resizable=yes, location=yes,status=yes');  
    }
    document.getElementById("selectID").options[0].selected = true;
    
  }
  


  function openfile(medittype,RecordID){
  	var mhtmlHeight = window.screen.availHeight;//��ô��ڵĴ�ֱλ��;
	var mhtmlWidth = window.screen.availWidth; //��ô��ڵ�ˮƽλ��; 
	var iTop = 0; //��ô��ڵĴ�ֱλ��;
	var iLeft = 0; //��ô��ڵ�ˮƽλ��;
    window.open("documentEdit.jsp?RecordID="+RecordID+"&EditType="+medittype+"&UserName="+encodeURI(encodeURI(username.value)),'iWebOffice2015�����ĵ��м��ʾ������','height='+mhtmlHeight+',width='+mhtmlWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=yes,scrollbars=no,resizable=yes, location=no,status=no');  
  }
  function down(){
  	
  }
  
 </script>
	</head>
	<body onload="init()" onresize="init()"
		style="overflow-y: hidden; overflow-x: hidden">
		<input type="hidden" id="title" name="title" value="huachuangpower"/>
		<input type="hidden" id="subTitle" name="subTitle" value="hcp:">
		<input type="hidden" id="sign" name="sign" value="signhere"/>
		<input type="hidden" id="templateId" name="templateId" value="fawen001"/>
		<div id="mhead" class="mhead">
			<table id="header">
				<tr>
					<td>
						<img src="css/logo.jpg" />
					</td>
					<td>
						<span> iWebOffice2015</span> �����ĵ��м��ʾ������
					</td>
				</tr>
			</table>
		</div>

		<div id="mtitle" style="height: 34px;" class="title">
			<table>
				<tr>
					<td height="34px">
					   <div width="0px" height="0px" style="display:none" > <script src="js/iWebOffice2015.js"></script></div>
						<span id="activex_install" style="color: #FF0000">��ע�⣬δ��⵽iWebOffice2015�м������鿴˵��������˵����Ҫ������ʹ�õĻ�����</span>
						<a href="#" onclick="ShowExplain()">[˵��]</a><a href="#" onclick="down()">[����]</a>
						<div id="obj">					
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div id="mbody" style="text-align: center;">
			<img id="loading" src="css/load.gif" alt="" />
			<div id="loaded"
				style="margin: 30px; border: 1px solid #C3ADC3; text-align: center; display: none;">

				<table id="innerTable" border=0 cellspacing='0' cellpadding='0'
					style="height:40px;">
					<tr>
						<td align="left">
							<span style="padding-right: 14px;">��ǰ�༭�û���<input type=text
									name='username' id='username' size=20  onblur="if(this.value.length>8){alert('�û������ܳ���8����');this.focus()}"  value="�����û�<%=f2.format(new Date())%>"
									class="InputLine" /> </span>
						</td>
						<td align="right" colspan="3">
                            <span style="padding-right: 25px;">���½��ĵ���
                            <select  id="selectID" onchange="OpenNewPage(this.value)">
                              <option value="-1" selected="selected">��ѡ���ĵ�    ��</option>
                              <option value=".doc,1">���½�WORD�ĵ�</option>
                              <option value=".xls,2">���½�EXECL�ĵ�</option>

                              <option value=".wps,1">���½�WPS�ĵ�</option>
                              <option value=".et,2">���½�ET�ĵ�</option>
                            </select>
                            </span>������
						</td>
					</tr>


				</table>
				<table id="titleTable" cellspacing='0' cellpadding='0'
					align="center" style="height: 42px;">
					<tr>
						<td width="60px">
							���
						</td>
						<td>
							����
						</td>
						<td width="120px">
							����
						</td>
						<td width="115px">
							����
						</td>
						<td width="190px">
							����ʱ��
						</td>
						<td width="380px">
							����
						</td>

					</tr>
				</table>

				<div id="showlist"
					style="vertical-align: top; height: 300px; margin-right: auto; margin-left: auto;">
					<table align="center" cellspacing='0' cellpadding='0'
						style="height: 50px;">
						<%
							try {
								if (DbaObj.OpenConnection()) {
									try {
										ResultSet result = DbaObj
												.ExecuteQuery("select Status,RecordID,HtmlPath,DocumentID,Subject,Author,FileType,FileDate from Document order by DocumentID desc");
										int i = 1;
										while (result.next()) {
											String RecordID = result.getString("RecordID");
											String HTMLPath = result.getString("HtmlPath");
											if (HTMLPath == null)
												HTMLPath = "";
						%>


						<tr>
							<td width="60px"  class="TD<%=(i+1)%2 %>"><%=i++%></td>
			  <td class="TD<%=(i)%2%>"><%=result.getString("Subject")%></td>
			  <td width="100px" class="TD<%=(i)%2 %>"><%=result.getString("Author")%></td>
			  
			  <td width="190px" class="TD<%=(i)%2 %>"><%=FormatDate(result.getString("FileDate"),"yyyy-MM-dd HH:mm:ss")%></td>
							<td width="380px" align=center class="TD<%=(i) % 2%>">
								<a href="#"
									onclick="openfile('0','<%=RecordID%>')">�Ķ�</a>
								<a href="#"
									onclick="openfile('1','<%=RecordID%>')">�޸�[�޺ۼ�]</a>
								<a href="#"
									onclick="openfile('2','<%=RecordID%>')">�޸�[�кۼ�]</a>
							</td>
						</tr>
						<%
							}
										result.close();
									} catch (SQLException sqlex) {
										System.out.println(sqlex.toString());
									}
								} else {
									out.println("OpenDatabase Error");
								}
							} finally {
								DbaObj.CloseConnection();
							}
						%>
						<tr>
							<td style='border: none;'></td>
						</tr>
					</table>

				</div>
			</div>
		</div>

		<div id="mfooter">
			<table class="footer">
				<tr>
					<td align="center">
						�������Ƽ��ɷ����޹�˾ ��Ȩ����
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>
<script language="javascript" type="text/javascript">
 var checkActiveX  = CheckActiveX();
 if(checkActiveX){
 document.getElementById('loading').style.display = "none";
 document.getElementById('loaded').style.display = "";
 }else{
  document.getElementById('loading').style.display = "none";
  document.getElementById('loaded').style.display = "";
 }

</script>