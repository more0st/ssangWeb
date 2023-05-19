<%@page import="ch10.user.User"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	request.setCharacterEncoding("utf-8");
	User user = new User("이자바", 20, null);

	request.setAttribute("vo", user);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<jsp:forward page="ex03_ok.jsp">
	<jsp:param value="서울" name="city"/>
</jsp:forward>

</body>
</html>