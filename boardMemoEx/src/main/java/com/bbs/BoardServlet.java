package com.bbs;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



@WebServlet("/bbs/*")
public class BoardServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		execute(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		execute(req, resp);
		
	}
	
	protected void forward(HttpServletRequest req, HttpServletResponse resp, String path) throws ServletException, IOException {
		// 포워딩
		RequestDispatcher rd = req.getRequestDispatcher(path);
		rd.forward(req, resp);
	}
	
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		// 주소 : http://localhost:9090/study3/bbs/list.do
		// uri : /study3/bbs/list.do	(cp에서부터 끝까지)
		String uri = req.getRequestURI();
		if(uri.indexOf("list.do") != -1) {
			list(req, resp);
		} else if(uri.indexOf("write.do") != -1) {
			writeForm(req, resp);
		} else if(uri.indexOf("write_ok.do") != -1) {
			writeSubmit(req, resp);
		} else if(uri.indexOf("article.do") != -1) {
			article(req, resp);
		} else if(uri.indexOf("update.do") != -1) {
			updateForm(req, resp);
		} else if(uri.indexOf("update_ok.do") != -1) {
			updateSubmit(req, resp);
		} else if(uri.indexOf("delete.do") != -1) {
			delete(req, resp);
		}
	}

	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 게시글 리스트 : 자바 스크립트로 페이징 처리 
		BoardDAO dao = new BoardDAO();
		
		try {
			// 파라미터 : [페이지번호], [검색컬럼, 검색값]
			
			// 페이지 번호 
			String page = req.getParameter("page");
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			// 검색
			String condition = req.getParameter("condition");
			String keyword = req.getParameter("keyword");
			if(condition == null) {	// 검색상태가 아니면
				condition = "all";
				keyword = "";
			}
			
			// GET 방식이면 디코딩 
			if(req.getMethod().equalsIgnoreCase("GET")) {
				keyword = URLDecoder.decode(keyword, "utf-8");
			}
			
			// 전체 데이터 개수
			int dataCount;
			if(keyword.length() == 0 ) {	// 검색이 아닐때
				dataCount = dao.dataCount();
			} else {
				dataCount = dao.dataCount(condition, keyword);
			}
			
			// 전체 페이지수
			//int size = 10;
			int size = 5;
			int total_page = dataCount/size + (dataCount%size > 0 ? 1:0);
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			// 게시글 가져오기 
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			List<BoardDTO> list = null;
			
			if(keyword.length() == 0) {
				list = dao.listBoard(offset, size);
 			} else {
 				list = dao.listBoard(offset, size, condition, keyword);
 			}
			
			
			
			// 포워딩할 JSP 에 전달할 속성(attribute)
			req.setAttribute("list", list);
			req.setAttribute("page", current_page);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("size", size);
			req.setAttribute("total_page", total_page);
			req.setAttribute("condition", condition);
			req.setAttribute("keyword", keyword);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 포워딩에서 / 는 cp(contextPath) 까지를 의미한다. 여기서는 study3
		forward(req, resp, "/WEB-INF/views/bbs/list.jsp");
	}
	
	
	protected void writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글쓰기폼
		req.setAttribute("mode", "write");
		
		forward(req, resp, "/WEB-INF/views/bbs/write.jsp");
	}
	
	protected void writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글저장
		BoardDAO dao = new BoardDAO();
		String cp = req.getContextPath();
		
		if(! req.getMethod().equalsIgnoreCase("POST")) {
			resp.sendRedirect(cp + "/bbs/list.do");
			return;
		}
		
		
		try {
			// 폼 데이터 : 이름, 제목, 내용, 패스워드 
			// 번호 - 시퀀스, 등록일 - SYSDATE, 조회수 - 0
			// ip 주소 - 클라이언트 ip
			
			BoardDTO dto = new BoardDTO();
			dto.setName(req.getParameter("name"));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			dto.setPwd(req.getParameter("pwd"));
			dto.setIpAddr(req.getRemoteAddr());
			
			dao.insertBoard(dto);
			
		} catch (Exception e) {
		}
		
		resp.sendRedirect(cp + "/bbs/list.do");	// insert/update/delete 후에는 반드시 리다이렉트
								// 리다이렉트를 해야 클라이언트가 보낸 정보를 초기화 
								// 초기화 안하고 새로고침을 하면 계속 데이터가 들어감
		//forward(req, resp, "/WEB-INF/views/bbs/list.jsp");
							// 캐시가 지워지지 않아서 계속 저장
							// 이렇게 하면 db에서 받아온 정보들이 없어서 올바른 페이지가 안보임
		
		// select만 포워딩. 화면에 뿌릴 것들만 포워딩 / insert, update, delete 는 반드시 리다이렉트
		
		// redirect 나 forward 밑에는 어떤 줄도 오면 안됨. 터짐 
	}
	
	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글 보기
		BoardDAO dao = new BoardDAO();
		String cp = req.getContextPath();
		
		String page = req.getParameter("page");
		String query = "page=" + page;
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			String condition = req.getParameter("condition");
			String keyword = req.getParameter("keyword");
			if(condition == null) {
				condition = "all";
				keyword = "";
			}
			keyword = URLDecoder.decode(keyword, "utf-8");
			
			if(keyword.length() != 0) {
				query += "&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
			}
			
			// 조회수 증가
			dao.updateHitCount(num);
			
			// 게시글 가져오기
			BoardDTO dto = dao.readBoard(num);
			if(dto == null) {
				resp.sendRedirect(cp + "/bbs/list.do?" + query);
				return;
			}
			
			// 글 내용 엔터를 <br> 로 
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			
			// 이전글 다음글
			BoardDTO preReadDto = dao.preReadBoard(num, condition, keyword);
			BoardDTO nextReadDto = dao.nextReadBoard(num, condition, keyword);
			
			
			//포워딩할 JSP 에 넘겨줄 속성
			req.setAttribute("dto", dto);
			req.setAttribute("preReadDto", preReadDto);
			req.setAttribute("nextReadDto", nextReadDto);

			req.setAttribute("page", page);
			req.setAttribute("query", query);
			
			forward(req, resp, "/WEB-INF/views/bbs/article.jsp");
			return;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp + "/bbs/list.do?" + query);
		
	}
	
	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글 수정폼
		BoardDAO dao = new BoardDAO();
		String cp = req.getContextPath();
		String page = req.getParameter("page");
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			
			BoardDTO dto =dao.readBoard(num);
			if(dto == null) {
				resp.sendRedirect(cp+"/bbs/list.do?page=" + page);
				return;
			}
			
			req.setAttribute("mode", "update");
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			
			forward(req, resp, "/WEB-INF/views/bbs/write.jsp");
			return;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp + "/bbs/list.do?page=" + page);
		
	}
	
	
	
	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글 수정 완료
		BoardDAO dao = new BoardDAO();
		String cp = req.getContextPath();
		String page = req.getParameter("page");
		
		
		
		try {
			
			BoardDTO dto = new BoardDTO();
			
			dto.setName(req.getParameter("name"));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			dto.setPwd(req.getParameter("pwd"));
			dto.setNum(Long.parseLong(req.getParameter("num")));
			
			dao.updateBoard(dto);
			
			resp.sendRedirect(cp + "/bbs/article.do?page=" + page +"&num=" + dto.getNum());
			return; 
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp + "/bbs/list.do?page=" + page);
		
	}
	
	
	
	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 게시글 삭제
		BoardDAO dao = new BoardDAO();
		String cp = req.getContextPath();
		
		String page = req.getParameter("page");
		String query = "page=" + page;
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			String condition = req.getParameter("condition");
			String keyword = req.getParameter("keyword");
			if(condition == null) {
				condition = "all";
				keyword = "";
			}
			keyword = URLDecoder.decode(keyword, "utf-8");
			
			if(keyword.length() != 0) {
				query += "&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
			}
			
			dao.deleteBoard(num);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp + "/bbs/list.do?" + query);
		
	}
	
}
