package com.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.SessionInfo;

@WebFilter("/*")
public class LoginFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// request 필터
		
		// 로그인 체크
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		String cp = req.getContextPath();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if(info == null && isExcludeUri(req)==false) {
			if(isAjaxRequest(req)) {
				resp.sendError(403);
			} else {
				
				// 로그인 전 주소 저장
				String uri = req.getRequestURI();
				String qs = req.getQueryString();
				if(qs != null) {
					uri += "?" + qs;
				}
				session.setAttribute("preLoginURI", uri);
				
				
				resp.sendRedirect(cp+ "/member/login.do");
			}
			
			return;
		}
				
		chain.doFilter(request, response);
		
		// response 필터
		
	}
	
	// 요청이 AJAX 인지를 확인하는 메소드
	protected boolean isAjaxRequest(HttpServletRequest req) {
		String h = req.getHeader("AJAX");
		
		return h != null && h.equals("true");
	}
	
	// 로그인 체크가 필요하지 않은지의 여부 파악 
	protected boolean isExcludeUri(HttpServletRequest req) {
		String uri = req.getRequestURI();
		String cp = req.getContextPath();
		uri = uri.substring(cp.length());
		
		if(uri.length() <= 1) {
			return true;
		}
		
		String[] uris = {
				"/index.jsp", "/main.do",
				"/member/login.do", "/member/login_ok.do",
				"/member/member.do", "/member/member_ok.do",
				"/member/userIdCheck.do", "/member/complete.do",
				"/member/pwdFind.do", "/member/pwdFind_ok.do",
				"/notice/list.do",
				"/resources/**"
		};
		
		for(String s : uris) {
			if(s.lastIndexOf("**") != -1) {
				s = s.substring(0, s.lastIndexOf("**"));
				if(uri.indexOf(s) == 0 ) {
					return true;
				}
			} else if (uri.equals(s)){
				return true;
			}
		}
		
		return false;
	}
	
	

}
