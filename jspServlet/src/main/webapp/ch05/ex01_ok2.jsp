<%@page import="ch05.calc.Calculator"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");

	Calculator calc = new Calculator(); 
	calc.setNum1(Integer.parseInt(request.getParameter("num1")));
	calc.setNum2(Integer.parseInt(request.getParameter("num2")));
	calc.setOperator(request.getParameter("operator"));
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<%= calc.toString() %>

</body>
</html>