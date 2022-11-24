package dao;
import vo.*;

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

}
