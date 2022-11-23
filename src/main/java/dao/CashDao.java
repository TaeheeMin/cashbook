package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class CashDao {
	/*
	SELECT c.cash_no cashNo
		, c.cash_date cashDate
		, c.cash_price cashPrce
		, ct.category_no categoryNo
		, ct.category_kind categoryKind
		, ct.category_name categoryName
	FROM cash c INNER JOIN category ct
	ON c.category_no = ct.category_no
	WHERE YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ?
	ORDER BY c.cash_date ASC;
	 */
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
		
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	
	// cashDateList
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
				+ ", c.cash_memo cashMemo "
				+ "FROM cash c INNER JOIN category ct "
				+ "ON c.category_no = ct.category_no "
				+ "WHERE c.member_id = ? "
				+ "AND YEAR(c.cash_date) = ? "
				+ "AND MONTH(c.cash_date) = ? "
				+ "AND DAY(c.cash_date) = ? "
				+ "ORDER BY c.cash_date ASC, ct.category_no ASC";
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
		
		rs.close();
		stmt.close();
		conn.close();
		return dateList;
	}
	
	 // cash delete 
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
		
		stmt.close();
		conn.close();
		return deleteRow;
	}
	
	// cash update
	public int updateCash (int cashNo, String memberId, int cashPrice, String cashMemo) throws Exception { 
	// db연결 
	DBUtil dbUtil = new DBUtil();
	Connection conn = dbUtil.getConnection();
	// 수정
	String sql = "UPDATE cash SET cash_price = ?, cash_memo = ? WHERE cash_no = ? AND member_id = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, cashPrice);
	stmt.setString(2, cashMemo);
	stmt.setInt(3, cashNo);
	stmt.setString(4, memberId);
	int updateRow = stmt.executeUpdate();
	
	stmt.close();
	conn.close();
	return updateRow;
	}
	
	// cash insert
	public int insertCash (int categoryNo, String cashDate, String cashMemo, String memberId) throws Exception { 
		// db연결 
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 수정
		String sql = "INSERT INTO cash("
				+ "category_no categoryNo"
				+ ", cash_date cashDate"
				+ ", cash_memo cashMemo"
				+ ", cash_price cashPrice"
				+ ", updatedate"
				+ ", createdate"
				+ ") VALUES (?, ?, ?, NOW(), NOW());";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		stmt.setString(2, cashDate);
		stmt.setString(3, cashMemo);
		stmt.setString(4, memberId);
		int insertRow = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		return insertRow;
		}
	
}
