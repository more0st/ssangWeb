<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3> include 지시어 </h3>
<pre>
	- JSP 페이지에 다른 페이지의 내용을 포함할 때 사용 
	- JSP 파일을 JAVA로 변환할 때 처리하며, 복사/붙여넣기 개념과 유사하다.
</pre>

<%@ include file="sub.jsp" %>

<p>
	<%= subject %> 강좌 입니다.
</p>

</body>
</html>