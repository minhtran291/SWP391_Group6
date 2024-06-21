/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

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
        String sql = "select top(1) *\n"
                + "from dbo.image\n"
                + "where food_id = ?\n"
                + "order by image_id asc";
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
}
