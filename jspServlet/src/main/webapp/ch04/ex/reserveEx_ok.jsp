<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");
	
	String[] cc= request.getParameterValues("chks");
	String checks = "";
	if(cc != null){
		for(String c : cc){
			checks += c + "  ";
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

<h3>좌석 예약</h3>
<p>
	<span> 선택한 좌석 : <%=checks %> </span>
</p>

</body>
</html>