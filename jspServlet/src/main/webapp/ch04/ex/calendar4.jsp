<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	request.setCharacterEncoding("utf-8"); 
	
	Calendar cal = Calendar.getInstance();
	int ty = cal.get(Calendar.YEAR);
	int tm = cal.get(Calendar.MONTH) + 1;
	int td = cal.get(Calendar.DATE);
	
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH) + 1;
	
	String sy = request.getParameter("year");
	String sm = request.getParameter("month");
	
	if(sy != null){
		year = Integer.parseInt(sy);
	}
	
	if(sm != null){
		month = Integer.parseInt(sm);
	}
	
	cal.set(year, month-1, 1);
	year = cal.get(Calendar.YEAR);
	month = cal.get(Calendar.MONTH) + 1;
	
	int week = cal.get(Calendar.DAY_OF_WEEK);	// 1~7 (주의) 자바스크립트는 0~6 임 
	
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
* { margin: 0; padding: 0; }
*, *::after, *::before { box-sizing: border-box; }

body { font-size: 14px; font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif; }

a { color: #000; text-decoration: none; cursor: pointer; }
a:active, a:hover { text-decoration: underline; color: #F28011; }

.btn {
	padding: 5px 10px;
	font-size: 14px; font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	color: #333; font-weight: 500;
	border: 1px solid #999; border-radius: 4px;
	background-color: #fff;
	cursor:pointer;
	vertical-align: baseline;
}
.btn:active, .btn:focus, .btn:hover {
	color:#333;
	background-color: #f8f9fa;
}
.btn[disabled], fieldset[disabled] .btn {
	pointer-events: none;
	cursor: default;
	opacity: .65;
}

.form-control {
	padding: 5px 5px; 
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	border: 1px solid #999; border-radius: 4px; background-color: #fff;
	vertical-align: baseline;
}
.form-control[readonly] { background-color:#f8f9fa; }

textarea.form-control { height: 170px; resize : none; }

.form-select {
	padding: 4px 5px; 
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	border: 1px solid #999; border-radius: 4px; background-color: #fff;
	vertical-align: baseline;
}
.form-select[readonly] { background-color:#f8f9fa; }

textarea:focus, input:focus { outline: none; }
input[type=checkbox], input[type=radio] { vertical-align: middle; }

/* table */
.table { width: 100%; border-spacing: 0; border-collapse: collapse; }
.table th, .table td { padding-top: 10px; padding-bottom: 10px; }

.table-border thead > tr { border-top: 2px solid #212529; border-bottom: 1px solid #ced4da; }
.table-border tbody > tr { border-bottom: 1px solid #ced4da; }
.table-border tfoot > tr { border-bottom: 1px solid #ced4da; }
.td-border td { border: 1px solid #ced4da; }

.border { border: 1px solid #ced4da; }
.border-top { border-top: 1px solid #ced4da; }
.border-bottom { border-bottom: 1px solid #ced4da; }

.text-left { text-align: left; padding-left: 10px; }
.text-right { text-align: right; padding-right: 10px; }
.text-center { text-align: center; }

.clear { clear: both; }
.clear:after { content:''; display:block; clear: both; }

/* layout */
.calendar { width: 700px; margin: 30px auto; }
.calendar .title{ padding: 7px; text-align: center; font-weight: 600; }

.calendar select.form-select { padding: 2px 6px; }

.calendar table thead tr:first-child { background: #f6f6f6; }
.calendar table td { padding: 6px; text-align: center; border: 1px solid #ced4da; width: 100px;}


.calendar tr.date {text-align: right; }
.calendar tr.date td { cursor:pointer; }
.calendar tr.date td:hover { font-weight:600; }
.calendar tr.date td.today { font-weight:700; background: #e6ffff; }

.calendar tr.date td:nth-child(7n+1) { color: red; }
.calendar tr.date td:nth-child(7n) { color: blue; }
.calendar tr.date td.gray { color: #ccc; }

.calendar tr.schedule { height: 100px; text-align: left; }
.calendar tr.schedule td { vertical-align: top; }

.calendar .footer{ height: 25px; line-height: 25px; text-align: right; font-size: 11px; }
</style>

<script type="text/javascript">
function change() {
	let year = document.querySelector(".yearSelect").value;
	let month = document.querySelector(".monthSelect").value;
	
	let url = "calendar4.jsp?year="+year+"&month="+month;
	
	location.href = url;
}
	
</script>

</head>
<body>

<div class="calendar">
	<div class="title">
			<select class="form-select yearSelect" onchange="change()">
				<% for(int i=year-5; i<=year+5; i++){ %>
					<option value="<%=i%>" <%=year==i ? "selected='selected'":"" %>><%=i%>년</option>
				<% } %>
			</select>
			
			<select class="form-selector monthSelect" onchange="change()">
				<% for(int i=1; i<=12; i++){ %>
					<option value="<%=i%>" <%=month==i ? "selected='selected'":"" %>><%=i%>월</option>
				<% } %>
			</select>
	</div>
	
	<table class="table">
		<thead>
			<tr>
				<td>일</td>
				<td>월</td>
				<td>화</td>
				<td>수</td>
				<td>목</td>
				<td>금</td>
				<td>토</td>
			</tr>
		</thead>
		<tbody>
			<%
			
			Calendar preCal = (Calendar)cal.clone();
			preCal.add(Calendar.DATE, -(week-1));
			int preDate = preCal.get(Calendar.DATE);
			
			// 1일 이전
			out.print("<tr class='date'>");
			for(int i=1; i<week; i++) {
				//out.print("<td>&nbsp;</td>");
				out.print("<td class='gray'>"+(preDate++)+"</td>");
			}
			
			// 1일~말일
			int lastDay = cal.getActualMaximum(Calendar.DATE);
			String cls; 
			for(int i=1; i<=lastDay; i++){
				cls = year==ty&&month==tm&&i==td ? "today" : "";
				
				out.print("<td class='" + cls + "'>" + i + "</td>");
				
				if(lastDay!=i && (++week)%7==1){
					out.print("</tr>");
					out.print("<tr class='schedule'>");
					for(int n=i-6; n<=i; n++) {
						out.print("<td>");
						out.print("&nbsp;");
						//out.print(n+"일 일정");
						out.print("</td>");
					}
					out.print("</tr>");
					out.print("<tr class='date'>");
				}
			}
			
			int n=1;
			
			for(int i=(week-1)%7; i<6; i++) {
				out.print("<td class='gray'>"+(n++)+"</td>");
			}
			out.print("</tr>");
			
			week++;
			n = week%7-1;
			if(week%7==0) n=6;
			if(week%7==1) n=7;
			out.print("<tr class='schedule'>");
			for(int i=lastDay-n+1; i<=lastDay-n+7; i++){
				out.print("<td>");
				out.print("&nbsp;");
				//out.print(i+"일 일정");
				out.print("</td>");
			}
			out.print("</tr>");
			
			%>
		</tbody>
	</table>
	
	<div class="footer">
		<a href="calendar4.jsp">오늘날짜로</a>	
	</div>

</div>

</body>
</html>