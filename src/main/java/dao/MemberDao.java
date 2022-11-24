package dao;

import java.sql.*;

import org.apache.jasper.tagplugins.jstl.core.Param;

import vo.Member;

public class MemberDao {
	// 로그인
	public Member login(Member paramMember) throws Exception { 
		// login 성공하면 리스트로 이동
		// 멤버 타입으로 받고 세션에 멤버로 넣음
		Member resultMember = null;
		
		// db연결 -> 따로 분리해서 사용
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_id, member_name, member_level FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			resultMember = new Member();
			resultMember.setMemberId(rs.getString("member_id"));
			resultMember.setMemberName(rs.getString("member_name"));
		}
		dbUtil.close(rs, stmt, conn);
		return resultMember;
	}
	
	// 회원가입
	// 1-1 중복확인
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
		
		if(rs.next()){	//중복되는 아이디가 없다면
			checkRow = 1;
		}
		dbUtil.close(rs, stmt, conn);
		return checkRow;
	}
	
	// 중복확인 다른 방법으로 확인
	// 반환값 t -> 중복있음, f -> 사용 가능
	public boolean selectMemberIdCk(String memberId) throws Exception{
		boolean result = false;
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 중복검사
		String sql = "SELECT memberId FROM member WHERE member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()){
			result = true;
		}
		dbUtil.close(rs, stmt, conn);
		return result;
	}
	
	// 1-2 회원가입
	public int insertMemeber(Member insertMember) throws Exception{
		int insertRow = 0;
		
		// db추가
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		String sql = "INSERT INTO member("
				+ "member_id"
				+ ", member_pw"
				+ ", member_name"
				+ ", updatedate"
				+ ", createdate"
				+ ") VALUES ("
				+ " ?, PASSWORD(?), ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, (String)insertMember.getMemberId());
		stmt.setString(2, (String)insertMember.getMemberPw());
		stmt.setString(3, (String)insertMember.getMemberName());
		insertRow = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return insertRow;
	}
	
	// 회원정보 수정
	public int updateMember(Member paraMember) throws Exception { 
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE member SET member_name =? WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paraMember.getMemberName());
		stmt.setString(2, paraMember.getMemberId());
		stmt.setString(3, paraMember.getMemberPw());
		int updateRow = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return updateRow;
	}
	
	// 회원탈퇴
	public int deleteMember(String memberId, String memberPw) throws Exception {
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 삭제
		String sql = "DELETE FROM member WHERE member_id=? AND member_pw=PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setString(2, memberPw);
		int deleteRow = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return deleteRow;
	}
}