<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("utf-8");

// form 데이터에서 enctype="multipart/form-data"로 전송한 데이터는
// request.getParameter("이름")으로 받을 수 없다.
	
	// "/contextPath" 경로의 실제 경로 (로컬 서버컴퓨터의 실제 위치)
	String root = session.getServletContext().getRealPath("/");
	String pathname = root + "uploads" + File.separator + "pds";
	File f = new File(pathname);
	if(! f.exists()){
		f.mkdirs();
	}
	
	String encType = "utf-8";
	int maxFileSize = 5*1024*1024;
	
	MultipartRequest mreq = null;
							// request, 파일저장경로, 파일최대크기, 인코딩, 중복파일보호여부
	mreq = new MultipartRequest(request, pathname, maxFileSize, encType,
			new DefaultFileRenamePolicy());
							
	// 제목
	String subject = mreq.getParameter("subject");
	// 이름
	String name = mreq.getParameter("name");
	// 서버에 저장된 파일 이름
	String saveFilename = mreq.getFilesystemName("selectFile");
	// 클라이언트가 올린 파일 이름
	String originalFilename = mreq.getOriginalFileName("selectFile");
	// 파일크기
	long fileSize = 0L;
	if(mreq.getFile("selectFile") != null) {
		fileSize = mreq.getFile("selectFile").length();
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

<h3> cos.jar 을 이용한 파일 업로드 </h3>

<%=root %>

<p> 제목 : <%=subject %> </p>
<p> 이름 : <%=name %> </p>
<p> 클라이언트가 올린 파일명 : <%=originalFilename %> </p>
<p> 서버에 저장된 파일명 : <%=saveFilename %> </p>
<p> 파일크기 : <%=fileSize %> Byte. </p>


</body>
</html>