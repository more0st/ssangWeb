<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h3>Servlet 예제</h3>

<p>
	<a href="/study2/demo?name=이자바&age=20">전송</a>
</p>
<hr>

<form action="/study2/demo" method="post">
	<p> 이름: <input type="text" name="name" required="required"> </p>
	<p> 나이: <input type="text" name="age" required="required" pattern="\d+"> </p>
	<p>
		<button type="submit">전송</button>
	</p>
</form>

</body>
</html>