package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import vo.*;
import dao.*;

public class HelpDao {
	
	// 관리자 admin
	// admin helpList -> 전체 개수 필요
	public int selectHelpCount() {
		//db 자원 초기화(jdbc api자원) 
		String sql = "SELECT COUNT(*) FROM help"; 
		DBUtil dbutil = new DBUtil();
		Connection conn = null; 
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int count = 0;
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
	
	// admin helpList -> 오버로딩 메서드의 리턴값같음, 매개변수만 다름
	public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage) throws Exception {
		//db 자원 초기화(jdbc api자원) 
		String sql = "SELECT"
				+ " h.help_no helpNo"
				+ ", h.help_memo helpMemo"
				+ ", h.createdate helpCreatedate"
				+ ", h.member_id memberId"
				+ ", c.comment_memo commentMemo"
				+ ", c.comment_no commentNo"
				+ ", c.createdate commentCreatedate"
				+ " FROM HELP h LEFT OUTER JOIN COMMENT c"
				+ " ON h.help_no=c.help_no"
				+ " ORDER BY h.help_no DESC"
				+ " LIMIT ?,?";
		
		DBUtil dbutil = new DBUtil();
		Connection conn = null; 
		PreparedStatement stmt = null; 
		ResultSet rs = null;
		ArrayList<HashMap<String, Object>> list = null;
		
		try {
			conn = dbutil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			
			list = new ArrayList<HashMap<String, Object>>();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("helpNo", rs.getInt("helpNo"));
				m.put("helpMemo", rs.getString("helpMemo"));
				m.put("helpCreatedate", rs.getString("helpCreatedate"));
				m.put("commentNo", rs.getInt("commentNo"));
				m.put("commentMemo", rs.getString("commentMemo"));
				m.put("commentCreatedate", rs.getString("commentCreatedate"));
				m.put("memberId", rs.getString("memberId"));
				list.add(m);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			// db자원 반납(jdbc api자원)
			dbutil.close(rs, stmt, conn);
			
		}
		
		return list;
		}
	
	
	// 회원 member
	// insert help
	public int insertHelp(Help help) {
		//db 자원 초기화(jdbc api자원) 
		String sql = "INSERT INTO HELP("
				+ "help_memo"
				+ ", member_id"
				+ ", updatedate"
				+ ", createdate"
				+ ") VALUES (?, ?, NOW(), NOW())";
		DBUtil dbutil = new DBUtil();
		Connection conn = null; 
		PreparedStatement stmt = null; 
		int insertRow = 0;
		
		try {
			conn = dbutil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, help.getHelpMemo());
			stmt.setString(2, help.getMemberId());
			insertRow = stmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			// db자원 반납(jdbc api자원)
			dbutil.close(null, stmt, conn);
			
		}
		
		return insertRow;
	}
	
	// helpList
	public ArrayList<HashMap<String, Object>> selectHelpList(Member member) {
		//db 자원 초기화(jdbc api자원) 
		String sql = "SELECT"
				+ " h.help_no helpNo"
				+ ", h.help_memo helpMemo"
				+ ", h.createdate helpCreatedate"
				+ ", c.comment_memo commentMemo"
				+ ", c.comment_no commentNo"
				+ ", c.createdate commentCreatedate"
				+ " FROM HELP h LEFT OUTER JOIN COMMENT c"
				+ " ON h.help_no=c.help_no"
				+ " WHERE h.member_id = ?";
		DBUtil dbutil = new DBUtil();
		Connection conn = null; 
		PreparedStatement stmt = null; 
		ResultSet rs = null;
		ArrayList<HashMap<String, Object>> list = null;
		
		try {
			conn = dbutil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, member.getMemberId());
			rs = stmt.executeQuery();
			
			list = new ArrayList<HashMap<String, Object>>();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("helpNo", rs.getInt("helpNo"));
				m.put("helpMemo", rs.getString("helpMemo"));
				m.put("helpCreatedate", rs.getString("helpCreatedate"));
				m.put("helpNo", rs.getInt("helpNo"));
				m.put("commentMemo", rs.getString("commentMemo"));
				m.put("commentCreatedate", rs.getString("commentCreatedate"));
				list.add(m);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			// db자원 반납(jdbc api자원)
			dbutil.close(rs, stmt, conn);
			
		}
		
		return list;
	}
	
	// update help
	// 1-1 updateOne
	public Help helpOne(Help help) {
		//db 자원 초기화(jdbc api자원) 
		String sql = "SELECT "
				+ "help_no helpNo"
				+ ", help_memo helpMemo"
				+ ", member_id memberId"
				+ " FROM HELP"
				+ " WHERE help_no =?";
		DBUtil dbutil = new DBUtil();
		Connection conn = null; 
		PreparedStatement stmt = null; 
		ResultSet rs = null;
		Help updateHelp = null;
		
		try {
			conn = dbutil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, help.getHelpNo());
			rs = stmt.executeQuery();
			
			updateHelp = new Help();
			while(rs.next()) {
				updateHelp.setHelpNo(rs.getInt("helpNo"));
				updateHelp.setHelpMemo(rs.getString("helpMemo"));
				updateHelp.setMemberId(rs.getString("memberId"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			// db자원 반납(jdbc api자원)
			dbutil.close(rs, stmt, conn);
			
		}
		
		return updateHelp;
	}
	
	// 1-2 update
	public int updateHelp (String helpMemo, int helpNo) {
		//db 자원 초기화(jdbc api자원) 
		String sql = "UPDATE HELP SET"
				+ " help_memo = ?"
				+ ", updatedate = NOW()"
				+ " WHERE help_no = ?";
		DBUtil dbutil = new DBUtil();
		Connection conn = null; 
		PreparedStatement stmt = null;
		int updateRow = 0;
		
		try {
			conn = dbutil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, helpMemo);
			stmt.setInt(2, helpNo);
			updateRow = stmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			// db자원 반납(jdbc api자원)
			dbutil.close(null, stmt, conn);
			
		}
		
		return updateRow;
	}
	
	
	// delete help
	public int deleteHelp (int helpNo) {
		//db 자원 초기화(jdbc api자원) 
		String sql = "DELETE FROM HELP WHERE help_no =?";
		DBUtil dbutil = new DBUtil();
		Connection conn = null; 
		PreparedStatement stmt = null; 
		int deleteRow = 0; 
		
		try {
			conn = dbutil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, helpNo);
			deleteRow = stmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			// db자원 반납(jdbc api자원)
			dbutil.close(null, stmt, conn);
			
		}
		
		return deleteRow;
	}
}
