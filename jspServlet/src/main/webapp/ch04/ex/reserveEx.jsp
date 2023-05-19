<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	int rows = 10;
	int cols = 15;
	
	int width = cols * 30 + 20 * (cols/5) + 30;
	if(cols/5 == 0) width -= 20;
	
	// String []cc = {"2:3","2:4","5:6","5:7", "8:2","8:3"};
	String []cc = {"B-3","B-4","E-6","E-7", "H-2","H-3"};
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

.reserve-container { margin:30px auto; width: <%=width%>px; }
.reserve-container table td { padding: 5px 0; }
.reserve-container .screen {
	width:100%;
	font-size: 15px;
	font-weight: 500;
	padding: 10px 0;
	text-align: center;
	background: #e4e4e4;
}
</style>

<script type="text/javascript">
function sendOk() {
	const f = document.frm;
	
	/*
	let cnnt = 0;
	for(let el of f.chks){
		if(el.checked && ! el.disabled){
			cnnt++;
		}
	}
	if(cnnt > 4 || cnnt < 1){
		alert('좌석은 1-4개 선택가능합니다.')
		return;
	}
	*/
	
	
	/*
	// type보다는 name을 이용해서 찾는게 안전. 앞에 form[name=myForm] 까지 쓰면 더 안전.
	// 범위를 작게 줘야함. 크게주면 위험함
	
	const els = document.querySelectorAll("form input[name=chks]:checked:not(:disabled)");
	let cnnt = els.length;
	if(cnnt > 4 || cnnt < 1){
		alert('좌석은 1-4개 선택가능합니다.')
		return;
	}
	*/
	
	
	// 내꺼
	const selectedElements = f.querySelectorAll('input[name="chks"]:checked');
	const cnt = selectedElements.length;
	if(cnt-6 > 4 || cnt-6 < 1){
		alert('좌석은 1-4개 선택가능합니다.')
		return;
	}
		
	f.submit();
}

</script>

</head>
<body>

<div class="reserve-container">
	<div class="screen">
		스크린
	</div>
	
	<form action="reserveEx_ok.jsp" method="post" name="frm">
		<table class="table">
			<tr align="center">
			<%
				out.print("<td width='30'>&nbsp;</td>");
				for(int i=1; i<=cols; i++){
					if(i!=1 && i%5==1) {
						out.print("<td width='20'>&nbsp;</td>");
					}
					out.print("<td width='30'>"+i+"</td>");
				}
			%>	
			</tr>
			
			<%
				String s, p;
				for(int i=1; i<=rows; i++){
					out.print("<tr align='center'>");
					
					out.print("<td>"+String.format("%c", 64+i)+"</td>");
					for(int j=1; j<=cols; j++){
						if(j!=1 && j%5==1){
							out.print("<td>&nbsp;</td>");
						}
						s = String.format("%c-%d", 64+i, j);
						p = "";
						for(int k=0; k<cc.length; k++){
							if(s.equals(cc[k])){
								p="checked='checked' disabled='disabled'";
								break;
							}
						}
						out.print("<td>");
						out.print("<input type='checkbox' name='chks' value='" + s +"'  " + p + ">");
						out.print("</td>");
					
					}
					
					out.print("</tr>");
				}
			%>
			
		</table>
		
		<table class="table">
			<tr align="right">
				<td>
					<button type="button" class="btn" onclick="sendOk();">좌석예약</button>
				</td>
			</tr>
		</table>
		
	</form>


</div>

</body>
</html>