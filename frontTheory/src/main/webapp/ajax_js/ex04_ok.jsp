<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");
	
	String name = request.getParameter("name");
	String content = request.getParameter("content");
%>

<guest>
	<dataCount>5</dataCount>
	<% for(int n=1; n<=5; n++) {%>
		<record num="<%=n%>">
			<name><%= (char)(n+64)+"-"+name %> </name>
			<content><![CDATA[<%=(char)(n+64)+"-"+content%>]]></content>
		</record>
	<% } %>
</guest>

