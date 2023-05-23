<%@ tag body-content="scriptless" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="trim" %>

<jsp:doBody var="content" scope="page" />

<%-- 엔터는 처리하지 않음 --%>
<c:out value="${content}" />