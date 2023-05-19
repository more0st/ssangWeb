<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");
	
	String name = request.getParameter("name");
	String studentID = request.getParameter("studentID");
	String gender = request.getParameter("gender");
	String []ss = request.getParameterValues("subject");
	String subject = "";
	if(ss != null){
		for(String s : ss) {
			subject += s + " ";
		}
	}
	
	String city = request.getParameter("city");
	String []hh = request.getParameterValues("hobby");
	String hobby = "";
	if(ss != null){
		for(String s : ss) {
			hobby += s + " ";
		}
	}
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>
<%



%>
</body>
</html>