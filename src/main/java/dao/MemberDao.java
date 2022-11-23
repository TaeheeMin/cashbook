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
	// 중복확인위해 boolean타입으로 만들어??-> insert도 boolean으로 만들어서 확인
	// action페이지에서는 메서드 하나씩 호출해서 true/false로 체크하고 가입확인/실패 안내
	public boolean memeberIdCheck(String memberId) throws Exception {
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 중복검사
		String sql = "SELECT * FROM member WHERE member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		
		boolean result = false;
		int row = stmt.executeUpdate();
		if(row == 1) {
			result = true;
			System.out.println("가입성공");
			return true;
		}
		stmt.close();
		conn.close();
		return result;
	}
	
	// 회원가입
	public boolean insertMemeber(Member paramMember) throws Exception {
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// db추가
		String sql = "INSERT INTO member (member_id, member_pw, member_name, updatedate, createdate) VALUES ( ?, PASSWORD(?), ?, NOW(), NOW())";
		/*
			INSERT INTO member (member_id, member_pw, member_name, updatedate, createdate) VALUES ( ?, PASSWORD(?), ?, NOW(), NOW())
		*/
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		stmt.setString(3, paramMember.getMemberName());
		
		boolean result = false;
		int row = stmt.executeUpdate();
		if(row == 1) {
			result = true;
			System.out.println("가입성공");
			return true;
		}
		stmt.close();
		conn.close();
		return result;
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