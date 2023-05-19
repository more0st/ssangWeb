<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3>JSTL : if</h3>

<form action="ex11.jsp" method="post">
<p>
	<input type="text" name="num" placeholder="숫자" required="required">
	<button type="submit">확인</button>
</p>
</form>

<!-- c:if 태그는 조건이 참인 경우 실행하며 else 구문은 없다. -->

<c:if test="${not empty param.num }">
	<p>
		${param.num} : ${param.num%2 == 0 ? "짝수" : "홀수"}
		
	</p>
	
	<p>
		${param.num} : 
		<c:if test="${param.num%2 == 0}">짝수</c:if>
		<c:if test="${param.num%2 == 1}">홀수</c:if>
	</p>
</c:if>

</body>
</html>