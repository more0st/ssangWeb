<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page errorPage = "error.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3> exception 내장 객체 </h3>
<!-- 
	JSP 페이지에서 발생한 예외를 처리할 페이지를 지정한 경우 에러 페이지에 전달되는 예외 객체 
 -->
 
 <%
 	//String s = null;
 	//int a = s.length();	// NullpointerException
 	
 	//String s = "";
 	//int a = s.length();	// 0 
 	
 	String name = request.getParameter("name").toUpperCase();
 %>
 
 <p>
 	이름 : <%= name %>
 </p>


</body>
</html>