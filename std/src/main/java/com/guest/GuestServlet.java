package com.guest;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.member.SessionInfo;
import com.util.MyServlet;
import com.util.MyUtil;

@WebServlet("/guest/*")
public class GuestServlet extends MyServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri = req.getRequestURI();
		
		// uri에 따른 작업 구분
		if(uri.indexOf("main.do") != -1) {
			guest(req, resp);
		} else if(uri.indexOf("list.do") != -1) {
			list(req, resp);
		} else if(uri.indexOf("insert.do") != -1) {
			writeSubmit(req, resp);
		} else if(uri.indexOf("delete.do") != -1) {
			delete(req, resp);
		}
	}
	
	protected void guest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/guest/main.jsp");
		
	}

	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 방명록 리스트
		GuestDAO dao = new GuestDAO();
		MyUtil util = new MyUtil(); 
		JSONObject job = new JSONObject();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			// 넘어온 페이지 번호
			String page = req.getParameter("pageNo");
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			int dataCount = dao.dataCount();
			
			int size = 5;
			int total_page = util.pageCount(dataCount, size);
			
			if(total_page < current_page) {
				total_page = current_page;
			}
			
			int offset = (current_page - 1) * size; 
			if(offset < 0) offset = 0;
			
			List<GuestDTO> list = dao.listGuest(offset, size);
			
			for(GuestDTO dto : list) {
				dto.setContent(util.htmlSymbols(dto.getContent()));
				
				if(info != null && (info.getUserId().equals("admin") || info.getUserId().equals(dto.getUserId()))) {
					dto.setDeletePermission(true);
				}
				
			}
			
			//String paging = util.pagingMethod(current_page, total_page, "listPage");
			// 더보기로 구현하므로 페이징처리 x 
			
			job.put("list", list);
			job.put("pageNo", current_page);
			job.put("total_page", total_page);
			job.put("dataCount", dataCount);
			//job.put("paging", paging);
			job.put("state", "true");
			
			
		} catch (Exception e) {
			job.put("state", "false");
			e.printStackTrace();
		}
		
		resp.setContentType("text/html; charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.print(job.toString());
	}

	
	// AJAX - POST : JSON. ajax 는 redirect / forward 안함. 
	protected void writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 방명록 저장
		GuestDAO dao = new GuestDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(info == null) {	// 로그인이 되지 않은 경우 
			resp.sendError(403);	// 강제로 에러 발생 시킴 
			return;
		}
		
		String state = "true";
		try {
			GuestDTO dto = new GuestDTO();
			dto.setUserId(info.getUserId());
			dto.setContent(req.getParameter("content"));
			dao.insertGuest(dto);
		} catch (Exception e) {
			state = "false";
		}
		
		// 요청 정보를 JSON 으로 응답 
		JSONObject job = new JSONObject();
		job.put("state", state);
		
		resp.setContentType("text/html; charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.print(job.toString());
		
	}
	
	
	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 방명록 삭제
		GuestDAO dao = new GuestDAO();
		JSONObject job = new JSONObject();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(info == null) {
			resp.sendError(403);
			return;
		}
		
		String state = "false";
		try {
			long num = Long.parseLong(req.getParameter("num"));
			dao.deleteGuest(num, info.getUserId());
			state = "true";
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		job.put("state", state);
		
		resp.setContentType("text/html; charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.print(job.toString());

	}
}
