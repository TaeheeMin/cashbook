package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import vo.*;

public class CategoryDao {
	// cash 입력 카테고리 리스트
	public ArrayList<Category> selectCategoryList() {
		String sql = "SELECT "
				+ "category_no categoryNo"
				+ ", category_kind categoryKind"
				+ ", category_name categoryName "
				+ "FROM category";
		// ORDER BY category_kind
		DBUtil dbUtil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null; 
		ResultSet rs = null; 
		ArrayList<Category> categoryList = null;
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			categoryList = new ArrayList<Category>();
			while(rs.next()) {
				Category category = new Category();
				category.setCategoryNo(rs.getInt("categoryNo"));
				category.setCategoryKind(rs.getString("categoryKind"));
				category.setCategoryName(rs.getString("categoryName"));
				categoryList.add(category);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			
		}
		return categoryList;
	}
	
	// 관리자 카테고리 관리 -> 카테고리 목록 -> 수정/삭제기능
	public ArrayList<Category> selectCategoryListByAdmin() {
		String sql ="SELECT"
				+ " category_no categoryNo"
				+ ", category_kind categoryKind"
				+ ", category_name categoryName"
				+ ", updatedate"
				+ ", createdate"
				+ " FROM category";
		//db 자원 초기화(jdbc api자원) 
		DBUtil dbUtil = new DBUtil();
		Connection conn = null; 
		PreparedStatement stmt = null; 
		ResultSet rs = null; 
		ArrayList<Category> list = null;
		
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			// executeQuery -> ResultSet 리턴 값이 행을 반환함, 논리적으로 사용하는 테이블
			// executeUpdate -> 결과값이 있냐 없냐
			// 반환 스타일만 다름
			list = new ArrayList<Category>();

			while(rs.next()) {
				Category c = new Category();
				c.setCategoryNo(rs.getInt("categoryNo"));
				//rs.getInt(1) -> 간단하게 한 개만?? 1-> select절에 첫번깨
				c.setCategoryKind(rs.getString("categoryKind"));
				c.setCategoryName(rs.getString("categoryName"));
				c.setUpdatedate(rs.getString("updatedate"));
				// db 날짜 타입이지만 문자열로 받는다
				c.setCreatedate(rs.getString("createdate"));
				list.add(c);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			// db자원 반납(jdbc api자원)
			dbUtil.close(rs, stmt, conn);
			
		}
		
		return list;
	}
	
	// insert category
	// admin -> insert category Action
	public int insertCategory(Category category) {
		String sql = "INSERT INTO category ("
				+ "category_kind"
				+ ", category_name"
				+ ", updatedate"
				+ ", createdate"
				+ ") VALUES(?, ?, CURDATE(), CURDATE());";
		
		DBUtil dbutil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null; 
		int insertRow = 0;
		
		try {
			conn = dbutil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category.getCategoryKind());
			stmt.setString(2, category.getCategoryName());
			
			insertRow = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			// db자원 반납(jdbc api자원)
			dbutil.close(null, stmt, conn);
		}
		return insertRow;
	}
	
	// delete category
	public int deleteCategory(Category category) {
		String sql = "DELETE FROM category WHERE category_no = ?";
		
		DBUtil dbutil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null; 
		int deleteRow = 0;
		
		try {
			conn = dbutil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, category.getCategoryNo());
			
			deleteRow = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			// db자원 반납(jdbc api자원)
			dbutil.close(null, stmt, conn);
		}
		
		return deleteRow;
	}
	
	// update category
	// 1-1 categoryOne
	public Category categoryOne(int categoryNo) {
		String sql = "SELECT"
				+ " category_no categoryNo"
				+ ", category_kind categoryKind"
				+ ", category_name categoryName"
				+ ", updatedate"
				+ ", createdate"
				+ " FROM category"
				+ " WHERE category_no = ?";
		
		DBUtil dbutil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null; 
		ResultSet rs = null;
		Category category = null;
		
		try {
			conn = dbutil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
			rs = stmt.executeQuery();
			category = new Category();
			while(rs.next()) {
				category.setCategoryNo(rs.getInt("categoryNo"));
				category.setCategoryKind(rs.getString("categoryKind"));
				category.setCategoryName(rs.getString("categoryName"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			// db자원 반납(jdbc api자원)
			dbutil.close(rs, stmt, conn);
		}
		
		return category;
	}
	
	// 1-2 categoryUpdate
	public int updateCategory(int categoryNo, String categoryName) {
		String sql = "UPDATE category"
				+ " SET category_name = ?"
				+ ", updatedate = CURDATE()"
				+ " WHERE category_no = ?";
		DBUtil dbutil = new DBUtil();
		//db 자원 초기화(jdbc api자원) 
		Connection conn = null; 
		PreparedStatement stmt = null; 
		int updateRow = 0;
		
		try {
			conn = dbutil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, categoryName);
			stmt.setInt(2, categoryNo);
			updateRow = stmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			// db자원 반납(jdbc api자원)
			dbutil.close(null, stmt, conn);
		}
		
		return updateRow;
	}
}
