<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<style type="text/css">
table td {width=150; background:#F9F9F9; }

</style>

</head>
<body>

<h3>표현식, 스크립릿</h3>
<hr>

<h3>구구단</h3>


<% for(int dan=2; dan<=9; dan++) { %>
	<p> ** <%= dan %> ** </p>
	<% for(int n=1; n<=9; n++) { %>
		<p> <%= dan %> * <%= n %> = <%= dan*n %> </p>
	<%} %>
	<p> ----------------------- </p>
<%} %>
<hr>


<%
	for(int dan=2; dan<=9; dan++){
		out.println("<p>**" + dan + "**</p>");
		for(int n=1; n<=9; n++) {
			out.println(dan + "*" + n + "=" + (dan*n) + "</p>");
		}
		out.println("<p> ------------------- </p>");
	}
%>


<!--  
<table border="1" style="margin: 30px auto; width: 1000px; border-collapse: collapse">
<%for(int i=2; i<10; i++) { %>
	<tr height="30" align="center">
		<td width="60px;" style="background: #D4F4FA;"> <%= i %> 단 </td>
		<%for(int j=1; j<10; j++) { %>
			<td > <%= i %> * <%= j %> = <%= i*j %> </td>
		<% } %>
	</tr>
<% } %>
</table>
-->

</body>
</html>