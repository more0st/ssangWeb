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

<h3> disabled 속성 </h3>

<form action="ex23_ok.jsp" method="post">
	<p> 번호 : <input type="text" name="num" value="1000" readonly="readonly"> </p>
	<p> 이름 : <input type="text" name="name"> </p>
	<p> 나이 : <input type="text" name="age" value="20" disabled="disabled"> </p>
	<p>
		<input type="hidden" name="id">
		<button type="submit"> 전송하기 </button>
	</p>
	
</form>

</body>
</html>