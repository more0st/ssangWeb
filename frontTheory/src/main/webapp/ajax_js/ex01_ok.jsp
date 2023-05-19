<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");
	
	int num1 = Integer.parseInt(request.getParameter("num1"));
	int num2 = Integer.parseInt(request.getParameter("num2"));
	
	String oper = request.getParameter("oper");
	
	String result = "";
	
	switch(oper){
	case "+" : result = String.format("%d + %d = %d", num1, num2, num1 + num2); break;
	case "-" : result = String.format("%d - %d = %d", num1, num2, num1 - num2); break;
	case "*" : result = String.format("%d * %d = %d", num1, num2, num1 * num2); break;
	case "/" : result = String.format("%d / %d = %d", num1, num2, num1 / num2); break;
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<p>




</p>

</body>
</html>