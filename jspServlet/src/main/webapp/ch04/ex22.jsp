<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script type="text/javascript">
function send(op) {
	// form 태그 찾을 때 배열로 찾지말고 이름으로 찾기
	const f = document.frm;
	
	
	// 유효성 검사
	if(! /^\d+$/.test(f.num1.value)){
		f.num1.focus();
		return;
	}
	if(! /^\d+$/.test(f.num2.value)){
		f.num2.focus();
		return;
	}
	
	f.operator.value = op; 
	f.submit();
}


</script>
</head>
<body>

<h3> hidden </h3>
<form name="frm" action="ex22_ok.jsp" method="post">
<p>
	<input type="text" name="num1" placeholder="첫번째수" style="height: 20px">
	<input type="text" name="num2" placeholder="두번째수" style="height: 20px">
	<input type="hidden" name="operator">
</p>
<p>
	<button type="button" onclick="send('+')"> + </button>
	<button type="button" onclick="send('-')"> - </button>
	<button type="button" onclick="send('*')"> * </button>
	<button type="button" onclick="send('/')"> / </button>
</p>


</form>

</body>
</html>