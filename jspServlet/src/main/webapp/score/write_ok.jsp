<%@page import="java.sql.SQLException"%>
<%@page import="com.score.ScoreDAOImpl"%>
<%@page import="com.score.ScoreDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="dto" class="com.score.ScoreDTO" />
<jsp:setProperty property="*" name="dto" />

<%
	ScoreDAO dao = new ScoreDAOImpl();
	
	String s = "";

	try{
		dao.insertScore(dto);
		response.sendRedirect("list.jsp");
		// redirect 했으면 밑으로 내려오면 안됨
		return;
	} catch(SQLException e) {
		if(e.getErrorCode() == 1){
			s = "[" + dto.getHak() + "] 학번은 등록된 학번입니다."; 
		} else {
			s = "자료 등록이 실패했습니다.";
		}
	
		request.setAttribute("msg", s);
	}
%>


<jsp:forward page="write.jsp"/>
