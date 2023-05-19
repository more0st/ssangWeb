<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	String msg = (String) request.getAttribute("msg");
				// Object 형이기때문에 다운캐스팅
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<p> <%=msg %> </p>

<p> ${msg} </p>

</body>
</html>