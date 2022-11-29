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
	public int selectHelpCount() throws Exception {
		String sql = "SELECT COUNT(*) FROM help"; 
		
		DBUtil dbutil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbutil.getConnection();
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		int count =0;
		if(rs.next()) {
			count = rs.getInt("COUNT(*)");
		}	
		
		dbutil.close(rs, stmt, conn);
		return count;
	}
	
	// admin helpList -> 오버로딩 메서드의 리턴값같음, 매개변수만 다름
	public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage) throws Exception {
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
				+ " LIMIT ?,?";
		
		DBUtil dbutil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null; 
		ResultSet rs = null;
		
		conn = dbutil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
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
		
		// db자원 반납(jdbc api자원)
		dbutil.close(rs, stmt, conn);
		return list;
		}
	
	
	// 회원 member
	// insert help
	public int insertHelp(Help help) throws Exception {
		String sql = "INSERT INTO HELP(help_memo, member_id, updatedate, createdate) VALUES (?, ?, NOW(), NOW())";
		
		DBUtil dbutil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null; 
		int insertRow = 0;
		
		conn = dbutil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, help.getHelpMemo());
		stmt.setString(2, help.getMemberId());
		
		insertRow = stmt.executeUpdate();
		
		// db자원 반납(jdbc api자원)
		dbutil.close(null, stmt, conn);
		return insertRow;
	}
	
	// helpList
	public ArrayList<HashMap<String, Object>> selectHelpList(Member member) throws Exception {
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
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null; 
		ResultSet rs = null;
		
		conn = dbutil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		rs = stmt.executeQuery();
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
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
		
		// db자원 반납(jdbc api자원)
		dbutil.close(rs, stmt, conn);
		return list;
	}
	
	// update help
	// 1-1 updateOne
	public Help helpOne(Help help) throws Exception {
		String sql = "SELECT help_no helpNo, help_memo helpMemo, member_id memberId FROM HELP WHERE help_no =?";
		DBUtil dbutil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null; 
		ResultSet rs = null;
		
		conn = dbutil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, help.getHelpNo());
		rs = stmt.executeQuery();
		Help updateHelp = new Help();
		while(rs.next()) {
			updateHelp.setHelpNo(rs.getInt("helpNo"));
			updateHelp.setHelpMemo(rs.getString("helpMemo"));
			updateHelp.setMemberId(rs.getString("memberId"));
		}
		// db자원 반납(jdbc api자원)
		dbutil.close(rs, stmt, conn);
		return updateHelp;
	}
	
	// 1-2 update
	public int updateHelp (String helpMemo, int helpNo) throws Exception {
		String sql = "UPDATE HELP SET"
				+ " help_memo = ?"
				+ ", updatedate = NOW()"
				+ " WHERE help_no = ?";
		DBUtil dbutil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null; 
		
		conn = dbutil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, helpMemo);
		stmt.setInt(2, helpNo);
		int updateRow = stmt.executeUpdate();
		
		// db자원 반납(jdbc api자원)
		dbutil.close(null, stmt, conn);
		return updateRow;
	}
	
	
	// delete help
	public int deleteHelp (int helpNo) throws Exception {
		String sql = "DELETE FROM HELP WHERE help_no =?";
		DBUtil dbutil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null; 
		
		conn = dbutil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, helpNo);
		int deleteRow = stmt.executeUpdate();
		
		// db자원 반납(jdbc api자원)
		dbutil.close(null, stmt, conn);
		return deleteRow;
	}
}
