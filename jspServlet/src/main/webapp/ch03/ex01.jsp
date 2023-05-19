<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
	// 자바 코드 영역 
	
	Calendar cal = Calendar.getInstance();
	String t = String.format("%tF %tA %tT", cal, cal, cal);
	
	// 합 구하기. 자바 주석
	int s = 0;
	for(int i=1; i<=100; i++){
		s += i;
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

<h3>간단한 JSP 예제</h3>

<!-- HTML 주석입니다. -->
<%-- JSP 주석입니다. --%>
<%-- HTML은 클라이언트에게 전송. JSP 주석은 전송x --%>

<p>
	접속 날짜 및 시간은 <%= t %> 입니다. 
</p>

<p>
	1 부터 100까지 합은 <%= s %> 입니다. 
</p>

</body>
</html>