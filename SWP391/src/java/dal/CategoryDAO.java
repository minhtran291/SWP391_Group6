/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Category;

/**
 *
 * @author Dell
 */
public class CategoryDAO extends DBContext{
    public Category getCategoryById(int id){
        String sql = "select * from Category where category_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if(rs.next()){
                Category c = new Category(rs.getInt("category_id"), 
                        rs.getString("category_name"));
                return c;
            }
        } catch (SQLException e) {
        }
        return null;
    }
    
    public ArrayList<Category> getAllCategory(){
        ArrayList<Category> listCategory = new ArrayList<>();
        String sql = "select * from category";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                listCategory.add(new Category(rs.getInt("category_id"), 
                        rs.getString("category_name")));
            }
        } catch (Exception e) {
        }
        return listCategory;
    }

    public void addCategory(String categoryName) {
        String sql = "Insert into Category ([category_name]) values(?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, categoryName);
            ps.executeUpdate();
        } catch (Exception e) {
        }

    }

    public void updateCategory(int categoryId, String categoryName) {
        String sql = "Update category set [category_name] = ? Where [category_id] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, categoryName);
            ps.setInt(2, categoryId);
            ps.executeUpdate();

        } catch (Exception e) {
        }
    }

    public void deleteCategory(int categoryId) {
        String sql = "delete from category where category_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ps.executeUpdate();

        } catch (Exception e) {
        }
    }
}
