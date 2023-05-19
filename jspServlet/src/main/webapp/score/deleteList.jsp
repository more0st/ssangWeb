<%@page import="com.score.ScoreDAOImpl"%>
<%@page import="com.score.ScoreDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");
	
	String[] haks = request.getParameterValues("haks");
	ScoreDAO dao = new ScoreDAOImpl();
	dao.deleteScore(haks);
	
	
	response.sendRedirect("list.jsp");

%>
