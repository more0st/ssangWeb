<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");
	String[] ss= request.getParameterValues("itemRight");
	String msg = request.getParameter("msg");
	
	msg = msg.replaceAll("&","&amp;")
			.replaceAll("\"","&quot;")
			.replaceAll("\'","&apos;")
			.replaceAll(">","&gt;")
			.replaceAll("<","&lt;")
			.replaceAll("\n","<br>")
			.replaceAll("\\s","&nbsp;");
	
	String name = "";
	if(ss != null){
		for(String s : ss) {
			name += s + " ";
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

<h3>요청 받은 메시지 정보</h3>

<p>
	<%=name %>
</p>
<div style="white-space: pre;"><%=msg %></div>
	


</body>
</html>