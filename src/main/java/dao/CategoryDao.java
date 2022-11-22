package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import vo.*;

public class CategoryDao {
	public ArrayList<Category> selectCategoryList() throws Exception {

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT"
				+ "category_no categoryNo"
				+ ", category_kind categoryKind"
				+ ", category_name categoryName"
				+ "FROM category"
				+ "ORDER BY category_kind ASC";
		// ORDER BY category_kind
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<Category> categoryList = new ArrayList<Category>();
	
		while(rs.next()) {
			Category category = new Category();
			category.setCategoryNo(rs.getInt("categoryNo"));
			category.setCategoryKind(rs.getString("categoryKind"));
			category.setCategoryName(rs.getString("categoryName"));
			categoryList.add(category);
		}
		return categoryList;
	}
}
