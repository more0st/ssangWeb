<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	request.setCharacterEncoding("utf-8");

	String name = request.getParameter("name");
	if(name == null) name = "";	// 초기에 null 값이 나오는걸 방지
	String content = request.getParameter("content");
	if(content == null) content = "";
	
	content = content.replaceAll("&","&amp;")
					.replaceAll("\"","&quot;")
					.replaceAll("\'","&apos;")
					.replaceAll(">","&gt;")
					.replaceAll("<","&lt;")
					.replaceAll("\n","<br>")
					.replaceAll("\\s","&nbsp;");	// \\s : 공백, 탭, 엔터 . 윗줄이랑 순서 바뀌면 안됨. 
	
	
	Calendar cal = Calendar.getInstance();
	String reg_date = String.format("%tF %tT", cal, cal);

	
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>study</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
* { padding: 0; margin: 0; }
*, *::after, *::before { box-sizing: border-box; }

body {
	font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
	font-size: 14px;
	color: #222;
}

a { color: #222; text-decoration: none; cursor: pointer; }
a:active, a:hover { color: #f28011; text-decoration: underline; }

/* form-control */
.btn {
	color: #333;
	border: 1px solid #999;
	background-color: #fff;
	padding: 5px 10px;
	border-radius: 4px;
	font-weight: 500;
	cursor:pointer;
	font-size: 14px;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	vertical-align: baseline;
}
.btn:active, .btn:focus, .btn:hover {
	background-color: #f8f9fa;
	color:#333;
}
.btn[disabled], fieldset[disabled] .btn {
	pointer-events: none;
	cursor: default;
	opacity: .65;
}

.form-control {
	border: 1px solid #999; border-radius: 4px; background-color: #fff;
	padding: 5px 5px; 
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	vertical-align: baseline;
}
.form-control[readonly] { background-color:#f8f9fa; }

textarea.form-control { height: 170px; resize : none; }

.form-select {
	border: 1px solid #999; border-radius: 4px; background-color: #fff;
	padding: 4px 5px; 
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
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

/* guest */
.guest-container { margin: 30px auto; width: 600px; }

.title { width:100%; font-size: 16px; font-weight: bold; padding: 13px 0; }

.table-form td { padding: 7px 0; }
.table-form tr:first-child {  border-top: 2px solid #212529; }
.table-form tr > td:first-child { width: 100px; text-align: center; background: #f8f9fa; }
.table-form tr > td:nth-child(2) { padding-left: 10px; }
.table-form input[type=text], .table-form input[type=file], .table-form textarea { width: 97%; }
.table-form textarea { height: 75px; }

.guest-list { margin-top: 10px; table-layout:fixed; word-break:break-all; }
.guest-list tr:nth-child(2n+1) { border: 1px solid #d5d5d5; background: #f8f9fa; } 
.guest-list td { padding-left: 7px; padding-right: 7px; }

.right { text-align: right; padding-right: 10px; }

.page-navigation {
	clear: both;
	padding: 20px 0;
	text-align: center;
}
.paginate {
	text-align: center;
	white-space: nowrap;
	font-size: 14px;	
}
.paginate a {
	border: 1px solid #ccc;
	color: #000;
	font-weight: 600;
	text-decoration: none;
	padding: 3px 7px;
	margin-left: 3px;
	vertical-align: middle;
}
.paginate a:hover, .paginate a:active {
	color: #6771ff;
}
.paginate span {
	border: 1px solid #e28d8d;
	color: #cb3536;
	font-weight: 600;
	padding: 3px 7px;
	margin-left: 3px;
	vertical-align: middle;
}
.paginate :first-child {
	margin-left: 0;
}
</style>

<script type="text/javascript">

function check() {
	const f = document.guestForm;
	
	if(! f.name.value){
		f.name.focus();
		return false;
	}
	
	if(! f.content.value){
		f.content.focus();
		return false;
	}
	
	return true;
}
	


</script>

</head>

<body>

<div class="guest-container">
	<div class="title">
	    <h3><span>|</span> 방명록</h3>
	</div>
	
	<form name="guestForm" method="post" action="guest.jsp" onsubmit="return check();">
		<table class="table table-border table-form">
			<tr> 
				<td>작성자</td>
				<td> 
					<input type="text" name="name" maxlength="20" class="form-control" required="required">
				</td>
			</tr>
	  
			<tr> 
				<td valign="top">내&nbsp;&nbsp;&nbsp;용</td>
				<td valign="top"> 
					<textarea name="content" class="form-control" required="required"></textarea>
					<!-- textarea 사이에 절대 공백 입력 x  -->
				</td>
			</tr>
		</table>
	
		<table class="table">
			<tr> 
				<td class="right">
					<button type="submit" class="btn">등록하기</button>
					<button type="reset" class="btn">다시입력</button>	  
				</td>
			</tr>
		</table>
	</form>
	
	
	<%if(name.length() != 0)  { // 이게 없으면 초기화면에 테이블이 보임 %>
	
	<table class="table guest-list">
		<tr>
			<td width="50%">
				<span style="font-weight: 600"><%=name %></span>
			</td>
			<td width="50%" align="right">
				<%=reg_date %> | <a href="#">삭제</a>
			</td>
		</tr>
		<tr>
			<td colspan="2" valign="top"><%=content %></td>
		</tr>
	</table>
	
	<% } %>
</div>

</body>
</html>
