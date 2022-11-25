package dao;
import vo.*;
import dao.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class NoticeDao {
	// 마지막 페이지 구하려면 전체 페이지 필요
	public int selectNoticeCount() throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		int count =0;
		String sql = "SELECT COUNT(*) FROM notice"; 
		PreparedStatement stmt = conn.prepareStatement(sql);;
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			count = rs.getInt("COUNT(*)");
		}	
		
		dbUtil.close(rs, stmt, conn);
		return count;
	}
	// loginForm 공지목록
	public ArrayList<Notice> selectNoticeByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Notice> list = new ArrayList<Notice>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate"
				+ " FROM notice ORDER BY createdate DESC"
				+ " LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeMemo(rs.getString("noticeMemo"));
			n.setCreatedate(rs.getString("createdate"));
			list.add(n);
		}
		
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	
	// 공지 등록
	public int insertNotice(String noticeMemo) throws Exception {
		int insertRow = 0;
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO notice(notice_memo, updatedate, createdate) VALUES (?, NOW(), NOW());";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, noticeMemo);
		insertRow = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return insertRow;
	}
	
	// 공지 수정
	public int updateNotice(Notice notice) throws Exception {
		int updateRow = 0;
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE notice SET notice_memo = ? WHERE notice_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeMemo());
		stmt.setInt(2, notice.getNoticeNo());
		dbUtil.close(null, stmt, conn);
		return updateRow;
	}
	
	// 공지 삭제
	public int deleteNotice(Notice notice) {
		String sql = "DELETE FROM notice WHERE notice_no = ?";
		
		return 0;
	}
}
