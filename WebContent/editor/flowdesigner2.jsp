
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<html>
   
    <head>
        <title>流程设计器</title>
      
         <script type="text/javascript">
         var mode = "flow";  //完整流程
         
         
			function use(targetid){
				var d=document.getElementById(targetid);
				if (d.style.display=="block"){
				} else {
					var p=document.getElementsByTagName("span");
					for(var i=0,l=p.length;i<l;i++){
						if(p[i]!=d){
						p[i].style.height=0;
						p[i].style.display="none";
					}
				}
				d.style.height="81%";
				d.style.display="block";
			}
		}
		
		</script>
	   
      <style>
* { margin:0; padding:0;}
body { text-align:center; height:100%;font:75% Verdana, Arial, Helvetica, sans-serif;}
h1 { font:125% Arial, Helvetica, sans-serif; text-align:left; font-weight:bolder; background:#333;   display:block; color:#99CC00}
.class1 { width:13%; background:#CEEFFD; position:relative; margin:0 auto;  }
span { position:absolute; /*right:10px;*/ top:8px; cursor: pointer; color:yellow;}
p { text-align:center; line-height:20px; /*background:#333;*/ padding:3px; margin-top:5px; color:#99CC00}
#class1content, #class2content,#class3content,#class4content { height:50px;overflow:hidden;display:none;}
span { display:-moz-inline-box; display:inline-block; }
.bujian:hover{background:#F5F5F5;}
</style>
   
        
  
       
    </head>
    <body  id="body" style="overflow:hidden;height:100%;">
        

      
        
       <div  class="class1" onClick="$use('class1content')">

<input type="button" value="活动连线" style="height:4%;width:100%;"  onClick="$use('class1content')"></input>
<span style="width: 80%; height:81%;text-align:center;position:relative;margin: 0px auto;" id="class1content">
<div class="bujian" style="width:100%;height:50px;">
<img src="image/xls.png" style="height:16px;width:16px;"></img>
<p>something.........</p>
</div>
</span>
</div>
<div class="class1"  onClick="$use('class2content')">

<input type="button" value="基本活动" style="height:4%;width:100%;"  onClick="$use('class2content')"></input>
<span style="width: 80%;height:81%; text-align:center;display:block;position:relative;margin: 0px auto;" id="class2content">
<div class="bujian" style="width:100%;height:50px;">
<img src="image/sql.png" style="height:16px;width:16px;"></img>
<p>something.........</p>
</div>
<div class="bujian" style="width:100%;height:50px;">
<img src="image/xml.png" style="height:16px;width:16px;"></img>
<p>something.........</p>
</div>
</span>

</div>
<div class="class1" >
<input type="button" value="逻辑活动" style="height:4%;width:100%;"  onClick="$use('class3content')"></input>
<span style="width: 80%; height:81%;text-align:center;position:relative;margin: 0px auto;" id="class3content">
<div class="bujian" style="width:100%;height:50px;">
<img src="image/xml.png" style="height:16px;width:16px;"></img>
<p>wojiade.........</p>
</div>
</span>

</div>
<div class="class1" >

<input type="button" value="流程泳道" style="height:4%;width:100%;"  onClick="$use('class4content')"></input>
<span style="width: 80%; height:81%;text-align:center;position:relative;margin: 0px auto;" id="class4content">
<div class="bujian" style="width:100%;height:50px;">
<img src="image/xml.png" style="height:16px;width:16px;"></img>
<p>wojiade.........</p>
</div>
</span>
</div>

	
    </body>
</html>
