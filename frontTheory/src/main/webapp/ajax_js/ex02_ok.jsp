<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");
	
	int n1 = Integer.parseInt(request.getParameter("num1"));
	int n2 = Integer.parseInt(request.getParameter("num2"));
	
	String oper = request.getParameter("oper");
	
	String result = "";
	
	switch(oper){
	case "+" : result = String.format("%d + %d = %d", n1, n2, n1 + n2); break;
	case "-" : result = String.format("%d - %d = %d", n1, n2, n1 - n2); break;
	case "*" : result = String.format("%d * %d = %d", n1, n2, n1 * n2); break;
	case "/" : result = String.format("%d / %d = %d", n1, n2, n1 / n2); break;
	}

%>

<%=result %>

