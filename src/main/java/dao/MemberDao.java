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
	
	// 2-1 중복확인
	public int memeberIdCheck(String memberId) throws Exception {
		int checkRow = 0;
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 중복검사
		String sql = "SELECT * FROM member WHERE member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		ResultSet rs = stmt.executeQuery();
		
		if(!rs.next()){	//중복되는 아이디가 없다면
			checkRow = 1;
		}
		stmt.close();
		conn.close();
		return checkRow;
	}
	
	// 2-2 회원가입
	public int insertMemeber(Member insertMember) throws Exception{
		int insertRow = 0;
		
		// db추가
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		String sql = "INSERT INTO member (member_id, member_pw, member_name, updatedate, createdate) VALUES ( ?, PASSWORD(?), ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, (String)insertMember.getMemberId());
		stmt.setString(2, (String)insertMember.getMemberPw());
		stmt.setString(3, (String)insertMember.getMemberName());
		insertRow = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		return insertRow;
	}
	
	
	// 회원정보 수정
	public int updateMember(String memberId, String memberPw, String memberName) throws Exception { 
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE member SET member_name =? WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberName);
		stmt.setString(2, memberId);
		stmt.setString(3, memberPw);
		int updateRow = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		return updateRow;
	}
	
}