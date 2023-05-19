package com.memo;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.util.FileManager;
import com.util.MyUtil;

/*
 * - @MultipartConfig
 * 	: 서블릿 3.0 에서 파일 업로드를 지원하는 애노테이션
 * 	: @MultipartConfig를 사용한 경우
 * 	: enctype="multipart/form-data" 로 넘어온 일반 파라미터를
 * 	  req.getParmeter("이름") 으로 받을 수 있다.
 *  : 하나의 파라미터당 하나의 Part 객체가 생성된다.
 *  : 모든 Part 반환
 *     Collection<Part> part = req.getParts();
 */

@WebServlet("/memo/*")
@MultipartConfig
public class MemoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private String pathname;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		execute(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		execute(req, resp);
	}
	
	protected void forward(HttpServletRequest req, HttpServletResponse resp, String path) throws ServletException, IOException {
		RequestDispatcher rd = req.getRequestDispatcher(path);
		rd.forward(req, resp);
	}

	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		HttpSession session = req.getSession();
		String root = session.getServletContext().getRealPath("/"); //루트경로의 설제 서버컴퓨터 위치
		
		pathname = root + "uploads" + File.separator + "memo";
		
		File f = new File(pathname);
		if( ! f.exists()) { // 폴더가 없으면
			f.mkdirs(); // 모든 폴더 만들기
		}
		
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
		} else if(uri.indexOf("download.do") != -1) {
			download(req, resp);
		}
		
	}
	
	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemoDAO dao = new MemoDAO();
		MyUtil util = new MyUtil();
		
		String cp = req.getContextPath();
		
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			// 전체 데이터 개수
			int dataCount = dao.dataCount();
			
			// 전체 페이지수
			int size = 10;
			int total_page = util.pageCount(dataCount, size);
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			// 게시글 가져오기
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			List<MemoDTO> list = dao.listMemo(offset, size);
			
			// 페이징 처리
			String listUrl = cp + "/memo/list.do";
			String articleUrl = cp + "/memo/article.do?page=" + current_page;
			
			String paging = util.paging(current_page, total_page, listUrl);
			
			req.setAttribute("list", list);
			req.setAttribute("page", current_page);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("size", size);
			req.setAttribute("total_page", total_page);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("paging", paging);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		forward(req, resp, "/WEB-INF/views/memo/list.jsp");
	}
	
	protected void writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("mode", "write");
		forward(req, resp, "/WEB-INF/views/memo/write.jsp");
	}
	
	protected void writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemoDAO dao = new MemoDAO();
		String cp = req.getContextPath();
		
		if(! req.getMethod().equalsIgnoreCase("POST")) {
			resp.sendRedirect(cp + "/memo/list.do");
			return;
		}
		
		
		try {
			MemoDTO dto = new MemoDTO();
			
			// 내용 받기
			dto.setContent(req.getParameter("content"));
			
			// 파일 받기
			Part p = req.getPart("selectFile");
			String originalFilename = getOriginalFilename(p);
			String saveFilename = null;
			if(originalFilename != null && originalFilename.length() != 0) { // 첨부 파일이 존재하면
				// 클라이언트가 올린 파일의 확장자
				String fileExt = originalFilename.substring(originalFilename.lastIndexOf("."));
				//서버에 저장할 파일 이름
				saveFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance());
				saveFilename += System.nanoTime();
				saveFilename += fileExt;
				
				//서버에 파일 저장하기
				String path = pathname + File.separator + saveFilename;
				p.write(path);
				
				dto.setOriginalFilename(originalFilename);
				dto.setSaveFilename(saveFilename);
			}
			
			dao.insertMemo(dto);
			 
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp + "/memo/list.do");

	}
	
	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemoDAO dao = new MemoDAO();
		String cp = req.getContextPath();
		
		String page = req.getParameter("page");
		String query = "page=" + page;
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			
			MemoDTO dto = dao.readMemo(num);
			if(dto == null) {
				resp.sendRedirect(cp + "/memo/list.do?" + query);
				return;
			}
			
			// 글내용 엔터를  <br>로
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			
			forward(req, resp, "/WEB-INF/views/memo/article.jsp");
			return;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp + "/memo/list.do?" + query);

	}
	
	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemoDAO dao = new MemoDAO();
		String cp = req.getContextPath();
		String page = req.getParameter("page");
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			
			MemoDTO dto = dao.readMemo(num);
			if(dto == null) {
				resp.sendRedirect(cp + "/memo/list.do?page=" + page);
				return;
			}
			
			req.setAttribute("mode", "update");
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			
			forward(req, resp, "/WEB-INF/views/memo/write.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp + "/memo/list.do?page=" + page);

	}
	
	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemoDAO dao = new MemoDAO();
		String cp = req.getContextPath();
		
		String page = req.getParameter("page");
		
		try {
			MemoDTO dto = new MemoDTO();
			
			dto.setContent(req.getParameter("content"));
			
			dto.setNum(Long.parseLong(req.getParameter("num")));
			dto.setSaveFilename(req.getParameter("saveFilename"));
			dto.setOriginalFilename(req.getParameter("originalFilename"));
			
			
			// 파일을 다시 업로드한 경우 
			Part p = req.getPart("selectFile");
			String originalFilename = getOriginalFilename(p);
			String saveFilename = null;
			
			if(originalFilename != null && originalFilename.length() != 0) { // 첨부 파일이 존재하면
				if(dto.getSaveFilename().length() != 0) {
					
					// 기존에 업로드된 파일 지우기
					String s = pathname + File.separator + dto.getSaveFilename();
					FileManager.doFileDelete(s); 
				}
				
				// 클라이언트가 올린 파일의 확장자
				String fileExt = originalFilename.substring(originalFilename.lastIndexOf("."));
				//서버에 저장할 파일 이름
				saveFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance());
				saveFilename += System.nanoTime();
				saveFilename += fileExt;
				
				//서버에 파일 저장하기
				String path = pathname + File.separator + saveFilename;
				p.write(path);
				
				dto.setOriginalFilename(originalFilename);
				dto.setSaveFilename(saveFilename);
			}
			
			
			
			dao.updateMemo(dto);
			
			resp.sendRedirect(cp + "/memo/article.do?page=" + page+"&num="+dto.getNum());
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp + "/memo/list.do?page=" + page);
	}
	
	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemoDAO dao = new MemoDAO();
		String cp = req.getContextPath();
		
		String page = req.getParameter("page");
		String query = "page=" + page;
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			MemoDTO dto = dao.readMemo(num); 
			
			if(dto.getSaveFilename()!=null && dto.getSaveFilename().length() != 0) {
				// 첨부된 파일 삭제
				String s = pathname + File.separator + dto.getSaveFilename();
				FileManager.doFileDelete(s);
			}
			
			// 게시글 지우기
			dao.deleteMemo(num);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp + "/memo/list.do?" + query);

	}
	
	protected void download(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemoDAO dao = new MemoDAO();
		boolean b = false;
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			MemoDTO dto = dao.readMemo(num);
			
			if( dto != null) {
				b = FileManager.doFileDownload(dto.getSaveFilename(), dto.getOriginalFilename(),
						pathname, resp);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if( ! b ) {
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.print("<script>alert('파일 다운로드가 실패했습니다.');history.back();</script>");
		}
	}
	
	// 클라이언트가 올린 파일 이름
	private String getOriginalFilename(Part p) {
		String[] ss = p.getHeader("content-disposition").split(";");
		for(String s : ss) {
			if(s.trim().startsWith("filename")) {
				return s.substring(s.indexOf("=")+1).trim().replace("\"", "");
			}
		}
		return null;
	}
	
}
