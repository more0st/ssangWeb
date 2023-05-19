<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");
	
	int n1 = Integer.parseInt(request.getParameter("num1"));
	int n2 = Integer.parseInt(request.getParameter("num2"));
	String op = request.getParameter("operator");
	
	String s = "";
	switch(op){
	case "+" : s = String.format("%d + %d = %d", n1, n2, n1+n2); break;
	case "-" : s = String.format("%d - %d = %d", n1, n2, n1-n2); break;
	case "*" : s = String.format("%d * %d = %d", n1, n2, n1*n2); break;
	case "/" : s = String.format("%d / %d = %d", n1, n2, n1/n2); break;
	}
	// switch는 문자열 자체가 비교 가능해서 
	// if 문 string equals 로 비교하는거 보다 낫다 
	
	/*
	int result = 0;

	if(op.equals("+")){
		result = n1 + n2;
	} else if(op.equals("-")){
		result = n1 - n2;
	} else if(op.equals("*")){
		result = n1 * n2;
	} else if(op.equals("/")){
		result = n1 / n2;
	}
	*/

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3> 결과 </h3>

<p>
	result = 
</p>

</body>
</html>