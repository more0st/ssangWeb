<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%

	pageContext.setAttribute("msg", "안녕하세요..."); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3> pageContext 내장 객체 </h3>
<!-- 
	JSP 페이지 실행에 필요한 Context 정보를 담고 있는 객체 
	쓸데없음
 -->
 
 <%
 	String s = (String) pageContext.getAttribute("msg");	// 다운캐스팅
 	
 	pageContext.getOut().print(s);
 	
 %>

</body>
</html>