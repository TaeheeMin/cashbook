package dao;

import java.sql.*;
import vo.Member;

public class MemberDao {
	public Member login(Member paramMember) throws Exception { 
		// login 성공하면 리스트로 이동
		// 멤버 타입으로 받고 세션에 멤버로 넣음
		Member resultMember = null;
		
		// db연결 -> 따로 분리해서 사용
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_id, member_name FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			resultMember = new Member();
			resultMember.setMemberId(rs.getString("member_id"));
			resultMember.setMemberName(rs.getString("member_name"));
		}
		
		rs.close();
		stmt.close();
		conn.close();
		return resultMember;
	}
	
	
	// 회원가입
	public int insertMember(Member paramMember) throws Exception {
		int resultRow = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT * FROM member WHERE member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			
		}
		
		return resultRow;
	}
	
}
