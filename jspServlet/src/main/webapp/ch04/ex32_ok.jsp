<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	String method = request.getMethod();
	String scheme = request.getScheme();
	String cp = request.getContextPath();
		// /study2 . 중요함 
	String uri = request.getRequestURI();
		// /study2/ch04/ex32_ok.jsp
	String url = request.getRequestURL().toString();
		// StringBuffer getRequestURL()
		// http://locolhost:9090/ex32_ok.jsp
	String query = request.getQueryString();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<p> 요청방식(method) : <%= method %> </p>
<p> scheme : <%= scheme %> </p>
<p> Context Path : <%= cp %> </p>
<p> URI : <%= uri %> </p>
<p> URL : <%= url %> </p>
<p> QueryString : <%= query %> </p>

</body>
</html>