package com.bbs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class BoardDAO {
	private Connection conn = DBConn.getConnection();
	
	public void insertBoard(BoardDTO dto) throws SQLException{
		PreparedStatement pstmt = null;
		String sql;
		
		// INSERT INTO 테이블명(컬럼,컬럼) VALUES (값, 값)
		try {
			sql = "INSERT INTO bbs(num, name, pwd, subject, content, ipAddr, hitCount, reg_date)"
					+ "  VALUES (bbs_seq.NEXTVAL, ?, ?, ?, ?, ?, 0, SYSDATE)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getPwd());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getIpAddr());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
		
	}
	
	
	public int dataCount() {
		int result = 0;
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT COUNT(*) FROM bbs";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
			
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
		
		return result;
	}
	
	
	public int dataCount(String condition, String keyword) {
		int result = 0;
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT COUNT(*) FROM bbs";
			if(condition.equals("all")) {
				sql += "  WHERE INSTR(subject, ?)>= 1 OR INSTR(content, ?) >= 1 ";
			} else if(condition.equals("reg_date")) {
				keyword = keyword.replaceAll("(\\-|\\.|\\/)", "");
				sql += "   WHERE TO_CHAR(reg_date, 'YYYYMMDD') = ? ";
			} else {	// subject, content, name 
				sql += "   WHERE INSTR(" + condition + ", ?) >= 1";
			}
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, keyword);
			if(condition.equals("all")) {
				pstmt.setString(2, keyword);
			}
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
			
			
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
			
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
		return result;
	}
	
	public List<BoardDTO> listBoard(int offset, int size) {
		List<BoardDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT num,name,subject,hitCount, TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date "
					+ "  FROM bbs  "
					+ "  ORDER BY num DESC  "
					+ "  OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setNum(rs.getLong("num"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setReg_date(rs.getString("reg_date"));
				
				list.add(dto);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
			
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
		return list;
	}
	
	public List<BoardDTO> listBoard(int offset, int size, String condition, String keyword) {
		List<BoardDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "SELECT num,name,subject,hitCount, TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date "
					+ "  FROM bbs  ";
					
			if(condition.equals("all")) {
				sql += "   WHERE INSTR(subject, ?)>= 1 OR INSTR(content, ?) >= 1 ";
			} else if(condition.equals("reg_date")) {
				keyword = keyword.replaceAll("(\\-|\\.|\\/)", "");
				sql += "   WHERE TO_CHAR(reg_date, 'YYYYMMDD') = ? ";
			} else {	// subject, content, name 
				sql += "   WHERE INSTR(" + condition + ", ?) >= 1";
			}
			
			sql += "  ORDER BY num DESC  ";
			sql += "  OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt = conn.prepareStatement(sql);
			
			if(condition.equals("all")) {
				pstmt.setString(1, keyword);
				pstmt.setString(2, keyword);
				pstmt.setInt(3, offset);
				pstmt.setInt(4, size);
			} else {
				pstmt.setString(1, keyword);
				pstmt.setInt(2, offset);
				pstmt.setInt(3, size);
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setNum(rs.getLong("num"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setReg_date(rs.getString("reg_date"));
				
				list.add(dto);
			}
			
			
			
			
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
			
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
		
		return list;
	}
	
	
	
	public BoardDTO readBoard(long num) {
		BoardDTO dto = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		String sql; 
		
		try {
			sql = "SELECT num, name, subject, content, pwd, ipAddr, hitCount, reg_date "
					+ "  FROM bbs "
					+ "  WHERE num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new BoardDTO();
				
				dto.setNum(rs.getLong("num"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setPwd(rs.getString("pwd"));
				dto.setIpAddr(rs.getString("ipAddr"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setReg_date(rs.getString("reg_date"));
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
			
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
		
		return dto; 
	}
	
	
	
	public BoardDTO preReadBoard(long num, String condition, String keyword) {
		BoardDTO dto = null;
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		StringBuilder sb = new StringBuilder();
		
		try {
			if(keyword != null && keyword.length() != 0) {
				// 검색
				sb.append("SELECT num, subject ");
				sb.append(" FROM bbs ");
				sb.append(" WHERE num > ? ");
				if(condition.equals("all")) {
					sb.append("   AND (INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1) ");
					
				} else if (condition.equals("reg_date")) {
					keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
					sb.append("   AND (TO_CHAR(reg_date, 'YYYYMMDD') = ?)");
					
				} else {
					sb.append("   AND (INSTR(" +condition +", ?) >= 1");
				}
				
				sb.append(" ORDER BY num ASC ");
				sb.append(" FETCH FIRST 1 ROWS ONLY");
				
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setLong(1, num);
				pstmt.setString(2, keyword);
				if(condition.equals("all")) {
					pstmt.setString(3, keyword);
				}
				
				
			} else {
				// 검색이 아닐 때 
				sb.append("SELECT num, subject ");
				sb.append(" FROM bbs ");
				sb.append(" WHERE num > ? ");
				sb.append(" ORDER BY num ASC ");
				sb.append(" FETCH FIRST 1 ROWS ONLY");
				
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setLong(1, num);
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new BoardDTO();
				dto.setNum(rs.getLong("num"));
				dto.setSubject(rs.getString("subject"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
			
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
		
		
		return dto; 
	}
	
	
	public BoardDTO nextReadBoard(long num, String condition, String keyword) {
		BoardDTO dto = null;
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		StringBuilder sb = new StringBuilder();
		
		try {
			
			if(keyword != null && keyword.length() != 0) {
				// 검색
				sb.append("SELECT num, subject ");
				sb.append(" FROM bbs ");
				sb.append(" WHERE num < ? ");
				if(condition.equals("all")) {
					sb.append("   AND (INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1) ");
					
				} else if (condition.equals("reg_date")) {
					keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
					sb.append("   AND (TO_CHAR(reg_date, 'YYYYMMDD') = ?)");
					
				} else {
					sb.append("   AND (INSTR(" +condition +", ?) >= 1");
				}
				
				sb.append(" ORDER BY num DESC ");
				sb.append(" FETCH FIRST 1 ROWS ONLY");
				
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setLong(1, num);
				pstmt.setString(2, keyword);
				if(condition.equals("all")) {
					pstmt.setString(3, keyword);
				}
				
				
			} else {
				// 검색이 아닐 때 
				sb.append("SELECT num, subject ");
				sb.append(" FROM bbs ");
				sb.append(" WHERE num < ? ");
				sb.append(" ORDER BY num DESC ");
				sb.append(" FETCH FIRST 1 ROWS ONLY");
				
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setLong(1, num);
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new BoardDTO();
				dto.setNum(rs.getLong("num"));
				dto.setSubject(rs.getString("subject"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
			
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
		
		
		return dto; 
	}
	
	
	
	public void updateHitCount(long num) throws SQLException {
		PreparedStatement pstmt = null; 
		String sql; 
		
		try {
			sql = "UPDATE bbs SET hitCount = hitCount +1 WHERE num = ? ";
			
			pstmt = conn.prepareStatement(sql); 
			pstmt.setLong(1, num);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e; 
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
		
	}
	

	public void updateBoard(BoardDTO dto) throws Exception {
		PreparedStatement pstmt = null; 
		String sql; 
		
		try {
			sql = "UPDATE bbs SET name = ?, pwd = ?, subject = ?, content = ?"
					+ "  WHERE num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getPwd());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setLong(5, dto.getNum());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
		
		
	}
	
	
	public void deleteBoard(long num) throws Exception {
		PreparedStatement pstmt = null; 
		String sql; 
		
		try {
			sql = "DELETE FROM bbs WHERE num = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
		
	}
	
	
	
	
}
