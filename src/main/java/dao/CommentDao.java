package dao;
import java.sql.*;
import java.util.*;
import vo.*;
import dao.*;

public class CommentDao {
	// insert comment
	public int insertComment(Comment comment) {
		String sql = "INSERT INTO COMMENT("
				+ " help_no"
				+ ", comment_memo"
				+ ", member_id"
				+ ", updatedate"
				+ ", createdate"
				+ ") VALUES (?, ?, ?, NOW(), NOW())";
		DBUtil dbutil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null; 
		int insertRow = 0;
		
		try {
			conn = dbutil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, comment.getHelpNo());
			stmt.setString(2, comment.getCommentMemo());
			stmt.setString(3, comment.getMemberId());
			
			insertRow = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			// db자원 반납(jdbc api자원)
			dbutil.close(null, stmt, conn);
		}
		return insertRow;
	}
	
	// update comment
	// 1-1 comment One
	public Comment updateOne(int commentNo) {
		String sql = "SELECT"
				+ " comment_no commentNo"
				+ ", comment_memo commentMemo"
				+ " FROM COMMENT"
				+ " WHERE comment_no =?";
		
		DBUtil dbutil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null; 
		ResultSet rs = null;
		Comment comment = null;
		
		try {
			conn = dbutil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, commentNo);
			
			rs = stmt.executeQuery();
			comment = new Comment();
			while(rs.next()) {
				comment.setCommentNo(rs.getInt("commentNo"));
				comment.setCommentMemo(rs.getString("commentMemo"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			// db자원 반납(jdbc api자원)
			dbutil.close(rs, stmt, conn);
		}
		return comment;
	}
	
	// 1-2 comment update
	public int updateComment(String commentMemo, int commentNo) {
		String sql = "UPDATE comment SET"
				+ " comment_memo = ?"
				+ ", updatedate = NOW()"
				+ " WHERE comment_no = ?";
		DBUtil dbutil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null; 
		int updateRow = 0;
		
		try {
			
			conn = dbutil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, commentMemo);
			stmt.setInt(2, commentNo);
			
			updateRow = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			// db자원 반납(jdbc api자원)
			dbutil.close(null, stmt, conn);
		}
		return updateRow;
	}
	
	// delete comment
	public int deleteComment (int commentNo) {
		String sql = "DELETE FROM comment WHERE comment_no =?";
		DBUtil dbutil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null; 
		int deleteRow = 0;
		
		try {
			conn = dbutil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, commentNo);
			
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
