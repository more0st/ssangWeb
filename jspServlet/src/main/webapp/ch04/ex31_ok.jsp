<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	String protocol = request.getProtocol();
	String serverName = request.getServerName();
	int serverPort = request.getServerPort();
	String remoteAddr = request.getRemoteAddr();
	String remoteHost = request.getRemoteHost();
	String method = request.getMethod();
	
	// header 정보
	String agent = request.getHeader("User-agent");
	String fileType = request.getHeader("Accept");
	String referer = request.getHeader("Referer");
	if(referer == null) {
		referer = "";
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3> request 정보 </h3>

<p> 프로토콜 : <%= protocol %> </p>
<p> 서버의 이름 : <%= serverName %> </p>
<p> 서버의 포트 번호 : <%= serverPort %> </p>
<p> 사용자 컴퓨터 아이피 주소 : <%= remoteAddr %> </p>
<p> 사용자 컴퓨터 이름 : <%= remoteHost %> </p>
<p> 메소드 : <%= method %> </p>
<p> 클라이언트 OS 및 브라우저 : <%= agent %> </p>
<p> 브라우저가 지원하는 매체의 타입 : <%= fileType %> </p>
<p> 이전 클라이언트 주소 : <%= referer %> </p>

</body>
</html>