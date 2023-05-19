<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	String cp = request.getContextPath();
	// getContextPath() : 문맥경로. 프로젝트 path 가져옴.
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<!-- 
	HTML 에서의 / 는 https://localhost:9090/ 여기까지 
 -->

<!-- WEB-INF 는 어떤 경우에도 클라이언트 접근 불가 -->

<form action="<%=cp%>/test" method="post">	<!-- cp = /study2 -->
	<p> 이름 : <input type="text" name="name"> </p>
	<p> 나이 : <input type="text" name="age"> </p>
	<p>
		<button type="submit"> 등록하기 </button>
	</p>
</form>

</body>
</html>