<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3> JSTL - fmt 태그 : 숫자, 날짜, 시간을 포멧팅하는 기능과 국제화, 다국어 지원</h3>

<p> default locale : <%= response.getLocale() %> </p>
<p> default locale : ${pageContext.response.locale} </p>
<!-- 한국 : ko_KR -->

<h3> 통화 기호 </h3>
<p> 기본 통화기호 : <fmt:formatNumber value="12345.6789" type="currency"/> </p>
<p>
	<!-- $ 로 통화기호 변경 -->
	<fmt:setLocale value="en_US"/>
	미국 통화기호 : <fmt:formatNumber value="12345.6789" type="currency"/>
</p>
<p>
	<!-- 일본 로 통화기호 변경 -->
	<fmt:setLocale value="ja_JP"/>
	일본 통화기호 : <fmt:formatNumber value="12345.6789" type="currency"/>
</p>
<p>
	<!-- 한국 로 통화기호 변경 -->
	<fmt:setLocale value="ko_KR"/>
	한국 통화기호 : <fmt:formatNumber value="12345.6789" type="currency"/>
</p>

<hr>

<h3>숫자</h3>
<p>number : <fmt:formatNumber value="12345.6789" type="number"/> </p>
<p>currency : <fmt:formatNumber value="12345.6789" type="currency"/> </p> 
<p>currency : <fmt:formatNumber value="12345.6789" type="currency" currencySymbol="￦"/> </p>
<p>percent : <fmt:formatNumber value="0.759" type="percent"/> </p>
<p>pattern : <fmt:formatNumber value="12345.6789" pattern=".0"/> </p> <!-- 소수점 한자리 -->
<p>pattern : <fmt:formatNumber value="12345.6789" pattern="#,##0.0"/> </p>
<p>pattern : <fmt:formatNumber value="0.6789" pattern="#,##0.0"/> </p> <!-- 0.7 -->
<p>pattern : <fmt:formatNumber value="0.6789" pattern="#,###.0"/> </p> <!--  .7 -->
<p>pattern : <fmt:formatNumber value="12345.6789" pattern="￦#,##0.0"/> </p>

<hr>


<h3>날짜</h3>
<c:set var="now" value="<%=new java.util.Date() %>"/>
<p>${now} </p>
<p> date : <fmt:formatDate value="${now}" type="date"/> </p>
<p> time : <fmt:formatDate value="${now}" type="time"/> </p>
<p> both : <fmt:formatDate value="${now}" type="both"/> </p>
<p> <fmt:formatDate value="${now}" type="both" dateStyle="full" timeStyle="full"/> </p>

</body>
</html>