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
import model.Image;

/**
 *
 * @author anhdo
 */
public class ImageDAO extends DBContext {

    public Image getImgbyFoodId1(String foodIid) {
        String sql = "  select top (1) i.image_id, f.image, f.food_id\n"
                + "  from food f\n"
                + "  join image i on f.food_id = i.food_id\n"
                + "  where i.food_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, foodIid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Image(rs.getInt(1), rs.getString(2), rs.getInt(3));
            }
        } catch (Exception e) {
        }
        return null;
    }

    public Image getImgbyFoodId2(String foodIid) {
        String sql = "WITH OrderedImages AS (\n"
                + "    SELECT \n"
                + "        image_id,\n"
                + "        image,\n"
                + "        food_id,\n"
                + "        ROW_NUMBER() OVER (ORDER BY image_id) AS row_num,\n"
                + "        COUNT(*) OVER () AS total_count\n"
                + "    FROM [SWP391].[dbo].[image]\n"
                + "    WHERE food_id = ?\n"
                + ")\n"
                + "SELECT \n"
                + "    image_id,\n"
                + "    image,\n"
                + "    food_id\n"
                + "FROM OrderedImages\n"
                + "WHERE row_num = (total_count + 1) / 2;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, foodIid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Image(rs.getInt(1), rs.getString(2), rs.getInt(3));
            }
        } catch (Exception e) {
        }
        return null;
    }

    public Image getImgbyFoodId3(String foodIid) {
        String sql = "select top(1) *\n"
                + "from dbo.image\n"
                + "where food_id = ?\n"
                + "order by image_id desc";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, foodIid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Image(rs.getInt(1), rs.getString(2), rs.getInt(3));
            }
        } catch (Exception e) {
        }
        return null;
    }

    public Image getImgbyImage(String image) {
        String sql = "select top(1) image from dbo.image\n"
                + "                where food_id = ?\n"
                + "               order by image_id asc";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, image);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Image(rs.getInt(1), rs.getString(2), rs.getInt(3));
            }
        } catch (Exception e) {
        }
        return null;
    }

    public static void main(String[] args) throws ClassNotFoundException {
        try {
            String username = "sa";
            String password = "123";
            String url = "jdbc:sqlserver://localhost:1433;databaseName=SWP391";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection connection = DriverManager.getConnection(url, username, password);
            ImageDAO id = new ImageDAO();
            String foodId = "1";
            Image img1 = id.getImgbyFoodId1(foodId);
            Image img2 = id.getImgbyFoodId2(foodId);
            Image img3 = id.getImgbyFoodId3(foodId);
            System.out.println(img1);
            System.out.println(img2);
            System.out.println(img3);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
