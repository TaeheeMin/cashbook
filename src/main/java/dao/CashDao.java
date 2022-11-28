package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import vo.*;

public class CashDao {
	// cash insert 등록
	public int insertCash (Cash cash) throws Exception { 
		// db연결 
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO cash("
				+ "category_no"
				+ ", cash_date"
				+ ", cash_memo"
				+ ", cash_price"
				+ ", member_id"
				+ ", updatedate"
				+ ", createdate"
				+ ") VALUES (?, ?, ?, ?, ?, NOW(), NOW());";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cash.getCategoryNo());
		stmt.setString(2, cash.getCashDate());
		stmt.setString(3, cash.getCashMemo());
		stmt.setLong(4, cash.getCashPrice());
		stmt.setString(5, cash.getMemberId());
	
		int insertRow = 0;
		insertRow = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return insertRow;
	}
	
	// cash list 달력목록
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT "
				+ "c.cash_no cashNo"
				+ ", c.cash_date cashDate"
				+ ", c.cash_price cashPrice"
				+ ", ct.category_no categoryNo"
				+ ", ct.category_kind categoryKind"
				+ ", ct.category_name categoryName "
				+ "FROM cash c INNER JOIN category ct "
				+ "ON c.category_no = ct.category_no "
				+ "WHERE c.member_id = ? "
				+ "AND YEAR(c.cash_date) = ? "
				+ "AND MONTH(c.cash_date) = ? "
				+ "ORDER BY c.cash_date ASC, ct.category_no ASC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashNo",rs.getInt("cashNo"));
			m.put("cashDate",rs.getString("cashDate"));
			m.put("cashPrice",rs.getInt("cashPrice"));
			m.put("categoryKind",rs.getString("categoryKind"));
			m.put("categoryName",rs.getString("categoryName"));
			list.add(m);
		}
		
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	
	// cashDateList 날짜별 목록
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) throws Exception{
		ArrayList<HashMap<String, Object>> dateList = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT "
				+ " c.cash_no cashNo"
				+ ", c.cash_date cashDate"
				+ ", c.cash_price cashPrice"
				+ ", ct.category_kind categoryKind"
				+ ", ct.category_name categoryName"
				+ ", c.cash_memo cashMemo"
				+ " FROM cash c INNER JOIN category ct"
				+ " ON c.category_no = ct.category_no"
				+ " WHERE c.member_id = ?"
				+ " AND YEAR(c.cash_date) = ?"
				+ " AND MONTH(c.cash_date) = ?"
				+ " AND DAY(c.cash_date) = ?"
				+ " ORDER BY c.cash_date ASC, ct.category_no ASC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		stmt.setInt(4, date);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashNo",rs.getInt("cashNo"));
			m.put("cashDate",rs.getString("cashDate"));
			m.put("cashPrice",rs.getInt("cashPrice"));
			m.put("categoryKind",rs.getString("categoryKind"));
			m.put("categoryName",rs.getString("categoryName"));
			m.put("cashMemo",rs.getString("cashMemo"));
			dateList.add(m);
		}
		
		dbUtil.close(rs, stmt, conn);
		return dateList;
	}
	
	// cashOne 하나만 출력
		public Cash cashOne(String memberId, int cashNo) throws Exception{
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql = "SELECT "
					+ " cash_no cashNo"
					+ ", category_no categoryNo"
					+ ", cash_date cashDate"
					+ ", cash_price cashPrice"
					+ ", category_no categoryNo"
					+ ", cash_memo cashMemo"
					+ " FROM cash"
					+ " WHERE member_id = ?"
					+ " AND cash_no = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, cashNo);
			ResultSet rs = stmt.executeQuery();
			Cash resultCash = null;
			while(rs.next()) {
				resultCash  = new Cash();
				resultCash.setCashNo(rs.getInt("cashNo"));
				resultCash.setCategoryNo(rs.getInt("categoryNo"));
				resultCash.setCashDate(rs.getString("cashDate"));
				resultCash.setCashPrice(rs.getLong("cashPrice"));;
				resultCash.setCategoryNo(rs.getInt("categoryNo"));;
				resultCash.setCashMemo(rs.getString("cashMemo"));;
			}
			dbUtil.close(rs, stmt, conn);
			return resultCash;
		}
		
	// cash update
	public int updateCash (Cash cash) throws Exception { 
		// db연결 
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 수정
		String sql = "UPDATE cash SET"
				+ " category_no = ?"
				+ ", cash_price = ?"
				+ ", cash_memo = ?"
				+ " WHERE cash_no = ? AND member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cash.getCategoryNo());
		stmt.setLong(2, cash.getCashPrice());
		stmt.setString(3, cash.getCashMemo());
		stmt.setInt(4, cash.getCashNo());;
		stmt.setString(5, cash.getMemberId());
		int updateRow = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return updateRow;
	}
	
	// cash delete 삭제
	public int deleteCash (int cashNo, String memberId, String memberPw) throws Exception { 
		// db연결 
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 삭제
		String sql = "DELETE c.* FROM cash c INNER JOIN member m ON c.member_id = m.member_id WHERE c.cash_no = ? AND c.member_id = ? AND m.member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		stmt.setString(2, memberId);
		stmt.setString(3, memberPw);
		int deleteRow = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return deleteRow;
	}
}
