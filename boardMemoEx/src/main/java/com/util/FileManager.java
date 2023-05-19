package com.util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

public class FileManager {
	
	/**
	 * 파일 다운로드
	 * @param saveFilename			서버에 저장된 파일명
	 * @param originalFilename		클라이언트가 업로드한 파일명
	 * @param pathname				서버에 파일이 저장된 경로
	 * @param resp					HttpServletResponse 객체
	 * @return						파일 다운로드 성공 여부
	 */
	public static boolean doFileDownload(String saveFilename, String originalFilename, String pathname, HttpServletResponse resp) {
		
		BufferedInputStream bis = null;
		OutputStream os = null;
		
		try {
			originalFilename = new String(originalFilename.getBytes("euc-kr"), "8859_1");
			pathname = pathname + File.separator + saveFilename;
			File f = new File(pathname);
			if( ! f.exists()) {
				return false;
			}
			
			// 클라이언트에게 전송할 문서 타입
			resp.setContentType("application/octet-stream");
			
			// 파일명 전송 : 파일명은 헤더에 실어서 보냄
			resp.setHeader("Content-disposition", "attactment;filename=" + originalFilename);
			
			// 클라이언트에게 파일 전송
			byte [] b = new byte[8192];
			bis = new BufferedInputStream(new FileInputStream(f));
			
			// 클라이언트에게 전송할 출력 스트림
			os = resp.getOutputStream();
			
			int n;
			while((n = bis.read(b)) != -1) {
				os.write(b, 0, n);
			}
			os.flush();
			
			return true;
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(bis != null) {
				try {
					bis.close();
				} catch (Exception e2) {
				}
			}
			if(os != null) {
				try {
					os.close();
				} catch (Exception e2) {
				}
			}
		}
		
		return false;
	}
	
	
	/**
	 * 파일 또는 폴더 삭제
	 * @param pathname	삭제할 폴더 또는 파일명
	 * @return			파일 삭제 여부 
	 */
	
	public static boolean doFileDelete(String pathname) {
		try {
			File f = new File(pathname);
			
			if(! f.exists()) {
				return false;
			}
			
			f.delete();
			
		} catch (Exception e) {
		}
		
		return true;
	}
	
	
}
