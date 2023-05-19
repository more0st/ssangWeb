<%@page import="java.sql.SQLException"%>
<%@page import="com.guest.GuestDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	request.setCharacterEncoding("utf-8");

	Long num =  Long.parseLong(request.getParameter("num"));
	String pageNum = request.getParameter("page");
	
	String s = "";
		
	GuestDAO dao = new GuestDAO();
	 
	try {
		dao.deleteGuest(num);
		response.sendRedirect("guest.jsp?page="+pageNum);
		return;
		
	} catch(SQLException e) {
		if(e.getErrorCode() == 1){
			s = "번호입니다."; 
		} else {
			s = "자료 등록이 실패했습니다.";
		}
	}
	
	
	
%>

