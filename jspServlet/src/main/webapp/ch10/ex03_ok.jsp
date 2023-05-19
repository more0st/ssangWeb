<%@page import="ch10.user.User"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	request.setCharacterEncoding("utf-8");
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
 * EL의 주목적
   request, pageContext, session 등에서 설정한 속성(attribute)을
   클라이언트에게 전송하기 위해 사용한다.
 -->

<h3>EL을 사용하지 않는 경우</h3>
<%
	User user = (User)request.getAttribute("vo");
	String s = request.getParameter("city");
%>

<!-- 필드값이 null인 경우 null로 출력 -->
<p> <%=user.getName() %>, <%=user.getAge() %>, <%=user.getSubject() %> </p>
<p> <%=s %> </p>
<hr>


<h3>EL을 사용한 경우</h3>
<!-- EL을 쓰는 주된 목적 : 필드이름 틀릴 때 빼고는 안터짐 -->
<!-- 필드값이 null인 경우 아무것도 출력되지 않는다. -->
<p> ${vo.name }, ${vo.age }, ${vo.age >= 19 ? "성인" : "미성년자" }, ${vo.subject } </p>

<!-- 파라미터는 param 이라는 EL 내장 객체 사용(request.getParameter("이름") 과 유사  -->
<p> ${param.city } </p>


</body>
</html>