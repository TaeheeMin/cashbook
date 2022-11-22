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
				+ "c.cash_no cashNo"
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
				+ "AND DA(c.cash_date) = ? "
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
}
