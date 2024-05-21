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
}
