<%@ page contentType="text/html; charset=UTF-8"%>

<%!
	// 선언부 - 클래스의 선언부에 포함하는 코드 : 필드, 메소드 등을 정의, 실제 사용하는 일은 없음
	// 이렇게 쓸 일 죽어도 없음. 이렇게 코딩 x 
	int n; // 필드
	
	public int sum(int num){
		int s = 0; 
		for(int i=1; i<=num; i++) {
			s += i;
		}
		return s;
	}
%>

<%
	// 스크립릿(scriptlet) : 자바코드를 작성하는 영역, _jspService() 메소드 영역에 포함됨
	// 이것도 지금만 사용하고 나중엔 사용안함
	int a; 
	
	//a++;	// 컴파일에러. a는 초기화 되지 않음
	a = 0;	// 스크립릿 변수는 실행할때마다(클라이언트가 접속할때마다) 초기화
	a++;
	
	n++;	// 선언부 변수(필드)는 초기화하지 않아도 0으로 초기화
			// 선언부 변수는 jsp의 객체가 만들어지는 시점에 한번만 초기화가 됨 
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<h3>scripting 요소</h3>

<p> 선언부 변수(필드) : <%= n %> </p>
<p> 스크립릿 변수 : <%= a %> </p>
<p>
	1 ~ 100 까지의 합 : <%= sum(100) %>
</p>


</body>
</html>