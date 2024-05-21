/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.Food;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Dell
 */
public class FoodDAO extends DBContext {

    CategoryDAO cd = new CategoryDAO();

    public ArrayList<Food> getAllFood(String categoryId, String search) {
        ArrayList<Food> listFood = new ArrayList<>();
        String sql = "select * from food f, category c "
                + "where f.category_id = c.category_id ";
        if (!categoryId.isEmpty() && search.isEmpty()) {
            sql = sql + "and f.category_id = ? "
                    + " order by f.food_id asc";
            try {
                int cid = Integer.parseInt(categoryId);
                PreparedStatement ps = connection.prepareStatement(sql);
                ps.setInt(1, cid);
//                ps.setString(2, "%" + search + "%");
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    listFood.add(new Food(rs.getInt("food_id"),
                            rs.getString("food_name"),
                            rs.getFloat("price"),
                            rs.getInt("stock"),
                            rs.getDate("create_date"),
                            rs.getString("description"),
                            rs.getInt("sold"),
                            cd.getCategoryById(rs.getInt("category_id")),
                            rs.getString("image")));
                }
            } catch (Exception e) {
            }
        } else if (categoryId.isEmpty() && !search.isEmpty()) {
            sql = sql + "and f.food_name like ? "
                    + " order by f.food_id asc";
            try {
                PreparedStatement ps = connection.prepareStatement(sql);
                ps.setString(1, "%" + search + "%");
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    listFood.add(new Food(rs.getInt("food_id"),
                            rs.getString("food_name"),
                            rs.getFloat("price"),
                            rs.getInt("stock"),
                            rs.getDate("create_date"),
                            rs.getString("description"),
                            rs.getInt("sold"),
                            cd.getCategoryById(rs.getInt("category_id")),
                            rs.getString("image")));
                }
            } catch (Exception e) {
            }
        } else if (!categoryId.isEmpty() && !search.isEmpty()) {
            sql = sql + "and f.category_id = ? and f.food_name like ? "
                    + " order by f.food_id asc";
            try {
                int cid = Integer.parseInt(categoryId);
                PreparedStatement ps = connection.prepareStatement(sql);
                ps.setInt(1, cid);
                ps.setString(2, "%" + search + "%");
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    listFood.add(new Food(rs.getInt("food_id"),
                            rs.getString("food_name"),
                            rs.getFloat("price"),
                            rs.getInt("stock"),
                            rs.getDate("create_date"),
                            rs.getString("description"),
                            rs.getInt("sold"),
                            cd.getCategoryById(rs.getInt("category_id")),
                            rs.getString("image")));
                }
            } catch (Exception e) {
            }
        } else {
            sql = sql + " order by f.food_id asc";
            try {
                PreparedStatement ps = connection.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    listFood.add(new Food(rs.getInt("food_id"),
                            rs.getString("food_name"),
                            rs.getFloat("price"),
                            rs.getInt("stock"),
                            rs.getDate("create_date"),
                            rs.getString("description"),
                            rs.getInt("sold"),
                            cd.getCategoryById(rs.getInt("category_id")),
                            rs.getString("image")));
                }
            } catch (Exception e) {
            }
        }

        return listFood;
    }
}
