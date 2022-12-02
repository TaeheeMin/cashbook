package dao;

import java.sql.*;
import java.util.ArrayList;
import vo.*;

public class MemberDao {
	// 관리자 회원 목록
	public ArrayList<Member> selectMemverListByPage(int beginRow, int rowPerPage) {
		String sql = "SELECT"
				+ " member_no memberNo"
				+ ", member_id memberId"
				+ ", member_level memberLevel"
				+ ", member_name memberName"
				+ ", updatedate"
				+ ", createdate"
				+ " FROM member ORDER BY createdate DESC LIMIT ?, ?";
		DBUtil dbutil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null; 
		ResultSet rs = null;
		ArrayList<Member> list = null;
		
		try {
			conn = dbutil.getConnection();
			
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			
			rs = stmt.executeQuery();
			list = new ArrayList<Member>();
			while(rs.next()) {
				Member m = new Member();
				m.setMemberNo(rs.getInt("memberNo"));
				m.setMemberId(rs.getString("memberId"));
				m.setMemberLevel(rs.getInt("memberLevel"));
				m.setMemberName(rs.getString("memberName"));
				m.setUpdatedate(rs.getString("updatedate"));
				m.setCreatedate(rs.getString("createdate"));
				list.add(m);
			}
		}catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			dbutil.close(rs, stmt, conn);
		}
		
		return list;
	}
	
	// 관리자 회원 목록 전체 페이지 수
	public int selectMemberCount() {
		DBUtil dbUtil = new DBUtil();
		String sql = "SELECT COUNT(*) FROM member";
		int count = 0;
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);;
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("COUNT(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		
		} finally {
			dbUtil.close(rs, stmt, conn);
			
		}
		
		return count;
	} 
	
	// 관리자 회원 강제 탈퇴 기능
	public int deleteMemberByAdmin(int memberNo) {
		String sql = "DELETE FROM member WHERE member_no=?";
		DBUtil dbUtil = new DBUtil();
		int deleteMember = 0;
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null; 
		
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, memberNo);
			
			deleteMember = stmt.executeUpdate();
				
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			// db자원 반납(jdbc api자원)
			dbUtil.close(null, stmt, conn);
		}
			
		return deleteMember;
	}
	
	// 관리자 회원 레벨 수정
	// 1-1 memberOne
	public Member memberOneByAdmin(int memberNo) {
		String sql = "SELECT"
				+ " member_no memberNo"
				+ ", member_id memberId"
				+ ", member_name memberName"
				+ ", member_level memberLevel"
				+ " FROM member"
				+ " WHERE member_no =?";
		
		DBUtil dbUtil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null; 
		ResultSet rs = null;
		Member memberOne = null;
		
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, memberNo);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				memberOne = new Member();
				memberOne.setMemberNo(rs.getInt("memberNo"));
				memberOne.setMemberId(rs.getString("memberId"));
				memberOne.setMemberName(rs.getString("memberName"));
				memberOne.setMemberLevel(rs.getInt("memberLevel"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			// db자원 반납(jdbc api자원)
			dbUtil.close(rs, stmt, conn);
		}
		
		return memberOne;
	}
	
	// 1-2 updateMember
	public int updateMemberByAdmin(Member member) {
		String sql = "UPDATE member"
				+ " SET member_name = ?"
				+ ", member_level = ?"
				+ ", updatedate = CURDATE()"
				+ " WHERE member_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		int updateMember = 0;
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null; 
		
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, member.getMemberName());
			stmt.setInt(2, member.getMemberLevel());
			stmt.setInt(3, member.getMemberNo());
			
			updateMember = stmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			// db자원 반납(jdbc api자원)
			dbUtil.close(null, stmt, conn);
		}
		
		return updateMember;
	}
	
	// 로그인
	public Member login(Member paramMember) { 
		String sql = "SELECT"
				+ " member_id"
				+ ", member_name"
				+ ", member_level"
				+ " FROM member"
				+ " WHERE member_id = ? AND member_pw = PASSWORD(?)";
		DBUtil dbUtil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null;
		ResultSet rs = null;
		Member resultMember = null;

		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			rs = stmt.executeQuery();
			while(rs.next()) {
				resultMember = new Member();
				resultMember.setMemberId(rs.getString("member_id"));
				resultMember.setMemberName(rs.getString("member_name"));
				resultMember.setMemberLevel(rs.getInt("member_level"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			dbUtil.close(rs, stmt, conn);
		}
		
		return resultMember;
	}
	
	// 회원가입
	// 1-1 중복확인
	public int memeberIdCheck(String memberId) {
		String sql = "SELECT * FROM member WHERE member_id = ?";
		DBUtil dbUtil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int checkRow = 0;
		
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs = stmt.executeQuery();
			
			if(rs.next()){	//중복되는 아이디가 없다면
				checkRow = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			dbUtil.close(rs, stmt, conn);
			
		}
		
		return checkRow;
	}
	
	// 중복확인 다른 방법으로 확인
	// 반환값 t -> 중복있음, f -> 사용 가능
	public boolean selectMemberIdCk(String memberId){
		String sql = "SELECT memberId FROM member WHERE member_id = ?";
		DBUtil dbUtil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null;
		ResultSet rs = null;
		boolean result = false;
		
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs = stmt.executeQuery();
			if(rs.next()){
				result = true;
			}
		}catch (Exception e) {
			e.printStackTrace();
					
		} finally {
			dbUtil.close(rs, stmt, conn);
					
		}
		
		return result;
	}
	
	// 1-2 회원가입
	public int insertMemeber(Member insertMember) {
		String sql = "INSERT INTO member("
				+ "member_id"
				+ ", member_pw"
				+ ", member_name"
				+ ", updatedate"
				+ ", createdate"
				+ ") VALUES ("
				+ " ?, PASSWORD(?), ?, NOW(), NOW())";
		DBUtil dbUtil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null;
		int insertRow = 0;
		
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, (String)insertMember.getMemberId());
			stmt.setString(2, (String)insertMember.getMemberPw());
			stmt.setString(3, (String)insertMember.getMemberName());
			insertRow = stmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			dbUtil.close(null, stmt, conn);
			
		}
		
		return insertRow;
	}
	
	// 회원정보 수정
	public int updateMember(Member paraMember) { 
		String sql = "UPDATE member"
				+ " SET member_name =?"
				+ " WHERE member_id = ? AND member_pw = PASSWORD(?)";
		DBUtil dbUtil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null;
		int updateRow = 0;
		
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paraMember.getMemberName());
			stmt.setString(2, paraMember.getMemberId());
			stmt.setString(3, paraMember.getMemberPw());
			updateRow = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		
		} finally {
			dbUtil.close(null, stmt, conn);
		}
		
		return updateRow;
	}
	
	// 회원 비밀번호 수정
	public int updatePwMember(String memberId, String newMemberPw, String memberPw) {
		// db연결
		DBUtil dbUtil = new DBUtil();
		String sql = "UPDATE member"
				+ " SET member_pw = PASSWORD(?)"
				+ " WHERE member_id = ? AND member_pw = PASSWORD(?)";
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null; 
		int updateMember = 0;
		
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, newMemberPw);
			stmt.setString(2, memberId);
			stmt.setString(3, memberPw);
			updateMember = stmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		
		} finally {
			// db자원 반납(jdbc api자원)
			dbUtil.close(null, stmt, conn);
		}
		
		return updateMember;
	}
	
	// 회원탈퇴
	public int deleteMember(String memberId, String memberPw) {
		String sql = "DELETE FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		// db연결
		DBUtil dbUtil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null;
		int deleteRow = 0;
		
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setString(2, memberPw);
			deleteRow = stmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			dbUtil.close(null, stmt, conn);
		}
		
		return deleteRow;
	}
}