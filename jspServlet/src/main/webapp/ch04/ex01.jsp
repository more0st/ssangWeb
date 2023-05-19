<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<script type="text/javascript">
function send() {
	let name = '자&바';
	let age = 20;
	
	name = encodeURIComponent(name);	// 주소형식으로 인코딩
	
	let query = "name="+name+"&age="+age;
	let url = "ex01_ok.jsp?"+query;
	
	location.href = url;
}

function sendOk() {
	const f = document.forms[0];
	
	let name = f.name.value;
	name = encodeURIComponent(name);	// 주소형식으로 인코딩
	f.name.value = name; 
	
	f.submit();
		// 서버로 전송할 수 있는 기능이 없는 일반버튼, select 박스 등을 이용하여 
		// 서버로 전송하기 위해서는 form 객체의 submit() 메소드를 호출한다. 
}
</script>

</head>
<body>

<h3> 파라미터 인코딩 - GET 방식 </h3>
<!-- 
	- GET 방식은 정보를 header에 실어서 보낸다. 
	- GET 방식은 주소줄에 정보가 모두 보이므로 보안에 취약하다. 
	- GET 방식은 용량에 제한이 있다.
	- GET 방식은 한글등을 그냥 전송하면 문제가 발생할 수 있으므로
		보낼때 인코딩하고 받을 때 디코딩한다.
	- 형식
		<a href="주소?이름1=값1&이름2=값2">확인</a>
 -->

<!-- a 태그를 이용하여 GET 방식으로 파라미터 전송 -->
<p>
	<a href="ex01_ok.jsp?name=홍길동&age=20">확인</a>
	<a href="ex01_ok.jsp?name=<%= URLEncoder.encode("홍길동", "UTF-8")%>">확인</a>
</p>
<hr>

<!-- 자바스크립트를 이용하여 GET 방식으로 전송 -->
<p>
	<button type="button" onclick="send();">확인</button>
</p>

<!-- form 태그를 이용하여 GET 방식으로 전송 : 일반적으로 form 태그는 post 방식으로 전송한다. -->
<!-- form 태그에서 method를 생략하면 get 방식으로 전송한다. -->
<form action="ex01_ok.jsp">
<p> 이름 : <input type="text" name="name"> </p>
<p> 나이 : <input type="text" name="age"> </p>
<p>
	<button type="button" onclick="sendOk();">확인</button>
</p>
</form>


</body>
</html>