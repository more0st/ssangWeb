<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.guest.GuestDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="dto" class="com.guest.GuestDTO" />
<jsp:setProperty property="*" name="dto" />
 
<%	
	String content = dto.getContent();
	content = content.replaceAll("&","&amp;")
			.replaceAll("\"","&quot;")
			.replaceAll("\'","&apos;")
			.replaceAll(">","&gt;")
			.replaceAll("<","&lt;")
			.replaceAll("\n","<br>")
			.replaceAll("\\s","&nbsp;");
	
	dto.setContent(content);

	//Calendar cal = Calendar.getInstance();
	//String reg_date = String.format("%tF", cal);
	
	//dto.setReg_date(reg_date);
	
	GuestDAO dao = new GuestDAO();
	String s = "";
	
	try {
		dao.insertGuest(dto);
		response.sendRedirect("guest.jsp");
		return;
		
	} catch(SQLException e) {
		if(e.getErrorCode() == 1){
			s = "[" + dto.getNum() + "] 번은 등록된 번호입니다."; 
		} else {
			s = "자료 등록이 실패했습니다.";
		}
	}
%>

<jsp:forward page="guest.jsp"/>