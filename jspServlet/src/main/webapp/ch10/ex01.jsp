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

<h3>EL</h3>

<h3>사칙연산</h3>

<!-- EL 더하기는 숫자만 가능 -->
<!-- EL 은 절대 주석 안에 넣을 수 없음 -->
<p> ${3+5} </p>	<!-- 8 : Long 형 -->
<p> ${3+"5"} </p> <!-- 8 : Long 형 -->
<p> ${"3"+"3"} </p> <!-- 6 : Long 형 -->
<!-- 3+null = 3 -->
<!-- 3 : null 은 0 으로 변환되어 연산된다 -->

<p> ${ 10/5 } </p> <!-- 2.0 : Double형. 기본적으로 자료형이 Double 형 -->
<p> ${ 10 mod 3 } </p>	<!-- 1 -->
<p> ${ 10 % 3 } </p>  <!-- 1 -->
<!-- EL 에서는 "a" + "b" 처럼 문자열을 결합하면 에러 발생  -->
<hr>



<h3>비교/논리 연산</h3>
<p> 3 == 4 : ${3 == 4}, 3 eq 4 : ${3 eq 4 } </p>
<p> 3 != 4 : ${3 != 4}, 3 ne 4 </p>

<p> 3 lt 4 : ${3 lt 4}, ${3 < 4 } </p>
<p> 3 gt 4 : ${3 gt 4}, ${3 > 4 } </p>
<p> 3 le 4 : ${3 le 4}, ${3 <= 4 } </p>
<p> 3 ge 4 : ${3 ge 4}, ${3 >= 4 } </p>

<p> empty name : ${empty name} </p>
<!-- name 이름의 속성이 없으므로 true -->

<p> ${10%2 == 0 ? "짝수" : "홀수" } </p>
<hr>



<h3>기타 연산</h3>
<p> 문자열 결합 : ${ "서울" += "부산" } </p>
${"서울"}${"부산"}	<!-- EL 출력이 목적이므로 그냥 찍어 -->

<p> 세미콜론 연산자(;) - a;b 에서 a는 출력되지 않고 b만 출력 </p>
<p> ${1+2; 3+5} </p> <!-- 결과 : 8 -->

<p> 할당 연산 : 할당 연산 자체도 출력 </p>
<p> ${a = 10} ${a} </p> <!-- 결과 : 10 10. a 라는 이름으로 10을 저장 -->
<p> ${a = 10 ; a} </p> <!-- 10 하나만 찍힘.  -->


</body>
</html>