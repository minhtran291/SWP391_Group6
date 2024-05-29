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
public class ImageDAO extends DBContext{
    public ArrayList<Image> getImgbyFoodId(String foodIid){
        ArrayList<Image> listimg = new ArrayList<>();
        String sql = "select * from dbo.image where food_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, foodIid);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                listimg.add(new Image(rs.getInt(1), rs.getString(2), rs.getInt(3)));
            }
        } catch (Exception e) {
        }
        return listimg;
    }
}
