<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<SCRIPT SRC="http://localhost:40003/mbpmV8.3/test/test.properties"></SCRIPT>
</head>
<body>

<script>
    test('MatrixMessages.test.p1');
   // test('aaaa'); 
    
    function test(value){

    	try{
        	var info = eval(value);
    	}catch(err){}
    	if(info){
    		alert(info);
    	}else{
    		alert(value);
    	}
    }
    
</script>

</body>
</html>