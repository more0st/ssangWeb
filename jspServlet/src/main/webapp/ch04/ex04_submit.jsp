<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3> submit 버튼 </h3>

<form name="frm" action="ex04_ok.jsp" method="post" onsubmit="return check();">
	<p> 이름 : <input type="text" name="name"> </p>
	<p> 나이 : <input type="text" name="age"> </p>
	<p>
		<button type="submit">확인</button>
		<button type="reset">다시입력</button>
	</p>
</form>

<script type="text/javascript">
function check() {
	const f = document.frm;
	
	if(! f.name.value){
		f.name.focus();
		return false;
	}
	
	if(! /^\d+$/.test(f.age.value)){
		f.age.focus();
		return false;
	}
	
	return true; 
}



</script>

</body>
</html>