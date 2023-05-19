<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

</head>
<body>

<h2>jQuery AJAX : POST - $.ajax() </h2>

<form name="calcForm">
	<input type="text" name="num1" id="num1">
	<select name="oper" id="oper">
		<option value="+">더하기</option>
		<option value="-">빼기</option>
		<option value="*">곱하기</option>
		<option value="/">나누기</option>
	</select>
	<input type="text" name="num2" id="num2">
	<button type="button" class="btnSend">결과</button>
</form>
<hr>
<div class="result-box"></div>

<script type="text/javascript">
$(function() {	// script가 밑에 있어서 없어도 됨
	$(".btnSend").click(function() {
		/*
		let n1 = $("#num1").val();
		let n2 = $("#num2").val();
		let op = $("#oper").val();
		*/
		// 여기서 유효성 검사 가능 
		
		let query = $("form[name=calcForm]").serialize();
		let url = "ex05_ok.jsp";
		
		
		$.ajax({
			type:"post",
			url:url,
			data:query,
			success:function(data) {
				$(".result-box").html(data);
			},
			beforeSend:check,	// 서버 전송전에 헤더등을 추가하거나 유효성 검사할때 방법
								// check가 true 일때만 서버로 전송. 
			error:function(e){
				console.log(e.status);	// 에러 상태코드(404, 500 등)
				console.log(e.responseText);// 에러 메시지
			}
		});
	});
	
	function check() {
		if(! /^(\d+)$/.test($("#num1").val())) {
			$("#num1").focus();
			return false;	// 서버로 전송 안함 
		}
		
		if(! /^(\d+)$/.test($("#num2").val())) {
			$("#num2").focus();
			return false;
		}
		
		return true;	// 서버로 전송 		
	}
	
});

</script>

</body>
</html>