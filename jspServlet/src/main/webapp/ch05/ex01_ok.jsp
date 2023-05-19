<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");
%>


<%-- db작업을 jsp에서 하는 게 아니라서 쓸일이 없음. --%>

<%-- JSP 액션 태그 --%>
<%-- Calculator calc = new Calculator(); 와 유사 --%>
<%-- useBean : 객체를 생성하는 역할. new 생성자와 유사 
				id=calc 는 자바에서 변수명이 됨. --%>
<jsp:useBean id="calc" class="ch05.calc.Calculator"/>



<%--
	calc.setNum1(Integer.parseInt(request.getParameter("num1")));
	calc.setNum2(Integer.parseInt(request.getParameter("num2")));
	calc.setOperator(request.getParameter("operator"));
	=> 역할. 한줄로 끝남 
 --%>
<jsp:setProperty name="calc" property="*"/>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3>액션태그(jsp:useBean)을 이용한 연산</h3>
<p>
	<%= calc.toString() %>
</p>

</body>
</html>