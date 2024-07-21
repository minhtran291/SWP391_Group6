/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Favorite;

/**
 *
 * @author anhdo
 */
public class FavoriteDAO extends DBContext {

    UserDAO udao = new UserDAO();
    FoodDAO fdao = new FoodDAO();
    ImageDAO idao = new ImageDAO();

    public void addtoFavoite(String foodId, String username, String foodname, String image) {
        String sql = "INSERT INTO [dbo].[wishlist]\n" +
"           ([food_id]\n" +
"           ,[user_name]\n" +
"           ,[food_name]\n" +
"           ,[image])\n" +
"     VALUES\n" +
"           (?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, foodId);
            ps.setString(2, username);
            ps.setString(3, foodname);
            ps.setString(4, image);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public ArrayList<Favorite> getFoodbyUserName(String name) {
        String sql = "SELECT TOP (1000) [wish_id]\n" +
"      ,[food_id]\n" +
"      ,[user_name]\n" +
"      ,[food_name]\n" +
"      ,[image]\n" +
"  FROM [SWP391].[dbo].[wishlist]\n" +
"  where [user_name] = ?";
        ArrayList<Favorite> list = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Favorite(rs.getInt("wish_id"),
                        rs.getInt("food_id"),
                        rs.getString("user_name"),
                        rs.getString("food_name"),
                       rs.getString("image")));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public void deleteFoodFavorite(int cmtid) {
        String sql = "DELETE FROM [dbo].[wishlist]\n"
                + "      WHERE [wish_id] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cmtid);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }
     public boolean checkFoodName(String foodname) {
        String sql = "select * from [wishlist] where [food_name] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, foodname);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return false;
            }
        } catch (SQLException e) {
        }
        return true;
    }
     public void deleteFoodFavoritebyName(String foodname) {
        String sql = "DELETE FROM [dbo].[wishlist]\n"
                + "      WHERE [food_name] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, foodname);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }
}
