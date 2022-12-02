package dao;
import vo.*;
import dao.*;

import java.lang.annotation.Native;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class NoticeDao {
	// 마지막 페이지 구하려면 전체 페이지 필요
	public int selectNoticeCount()  {
		String sql = "SELECT COUNT(*) FROM notice"; 
		DBUtil dbutil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int count =0;
		
		try {
			conn = dbutil.getConnection();
			stmt = conn.prepareStatement(sql);
			
			rs = stmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("COUNT(*)");
			}	
			
		} catch (Exception e) {
			e.printStackTrace();
		
		} finally {
			dbutil.close(rs, stmt, conn);
		}
		return count;
	}
	
	// loginForm 공지목록
	public ArrayList<Notice> selectNoticeByPage(int beginRow, int rowPerPage)  {
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate"
				+ " FROM notice ORDER BY createdate DESC"
				+ " LIMIT ?, ?";
		DBUtil dbutil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<Notice> list = null;
		
		try {
			conn = dbutil.getConnection();
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			list = new ArrayList<Notice>();
			while(rs.next()) {
				Notice n = new Notice();
				n.setNoticeNo(rs.getInt("noticeNo"));
				n.setNoticeMemo(rs.getString("noticeMemo"));
				n.setCreatedate(rs.getString("createdate"));
				list.add(n);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		
		} finally {
			dbutil.close(rs, stmt, conn);
		}
		
		return list;
	}
	
	// 공지 등록
	public int insertNotice(String noticeMemo)  {
		String sql = "INSERT INTO notice("
				+ "notice_memo"
				+ ", updatedate"
				+ ", createdate"
				+ ") VALUES (?, NOW(), NOW());";
		// db연결
		DBUtil dbutil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null;
		int insertRow = 0;
		
		try {
			conn = dbutil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, noticeMemo);
			insertRow = stmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		
		} finally {
			dbutil.close(null, stmt, conn);
		}
		return insertRow;
	}
	
	// 공지 수정
	// 1-1 공지 하나 가져오기
	public Notice noticeOne(int noticeNo)  {
		String sql = "SELECT notice_memo noticeMemo FROM notice WHERE notice_no = ?";
		// db연결
		DBUtil dbutil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null;
		ResultSet rs = null;
		Notice n = null;
		
		try {
			conn = dbutil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, noticeNo);
			rs = stmt.executeQuery();
			n = new Notice();
			while(rs.next()) {
				n.setNoticeMemo(rs.getString("noticeMemo"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		
		} finally {
			dbutil.close(rs, stmt, conn);
		}
		return n;
	}
	
	// 1-2 공지 수정
	public int updateNotice(int noticeNo, String noticeMemo)  {
		String sql = "UPDATE notice SET notice_memo = ? WHERE notice_no = ?";
		// db연결
		DBUtil dbutil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null;
		int updateRow = 0;
		
		try {
			conn = dbutil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, noticeMemo);
			stmt.setInt(2, noticeNo);
			updateRow = stmt.executeUpdate();
					
		} catch (Exception e) {
			e.printStackTrace();
		
		} finally {
			dbutil.close(null, stmt, conn);
		}
		return updateRow;
	}
	
	// 공지 삭제
	public int deleteNotice(int noticeNo) {
		String sql = "DELETE FROM notice WHERE notice_no = ?";
		// db연결
		DBUtil dbutil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null;
		int deleteRow = 0;
		
		try {
			conn = dbutil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, noticeNo);
			deleteRow = stmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		
		} finally {
			dbutil.close(null, stmt, conn);
		}
		return deleteRow;
	}
}
