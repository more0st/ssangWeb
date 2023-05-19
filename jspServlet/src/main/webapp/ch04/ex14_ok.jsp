<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
   request.setCharacterEncoding("utf-8");

   // getParmeterMap() : 파라미터를 Map<String, String[]> 로 변환
   Map<String, String[]> paramMap = request.getParameterMap();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3>파라미터를 Map으로 받기 : getParameterMap</h3>
<%
   String name = paramMap.get("name")[0];
   String pwd = paramMap.get("pwd")[0];
   int age = Integer.parseInt(paramMap.get("age")[0]);
   String gender = paramMap.get("gender")[0];
   
   String[] ss = paramMap.get("subject");
   String s = "";
   
   if(ss != null){
      for(String a : ss){
         s += a + " ";
      }
   }
   
%>

<p> 이름 : <%=name %></p>
<p> 패스워드 : <%=pwd %></p>
<p> 나이 : <%=age %></p>
<p> 성별 : <%=gender %></p>
<p> 좋아하는 과목 : <%=s %></p>

<hr>

<%
   Iterator<String> it = paramMap.keySet().iterator();
   while(it.hasNext()){
      String paramName = it.next();
      String [] paramValues = paramMap.get(paramName);
      if(paramValues != null){
         for(String a : paramValues){
            out.print("<p>" + paramName + " : " + a + "</p>");
         }
      }
   }
%>
</body>
</html>