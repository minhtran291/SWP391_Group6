/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Dell
 */
public class UserDAO extends DBContext{
    public User login(String username, String password){
        String sql = "select * from users "
                + "where [user_name] = ? "
                + "and password = ? ";
        try{
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                return new User(rs.getInt(1),
                        rs.getString(2), 
                        rs.getString(3), 
                        rs.getInt(4), 
                        rs.getString(5), 
                        rs.getInt(6), 
                        rs.getInt(7))      ;     
            }
                    
        }catch(SQLException e){          
        }
        return null;
        
    }
}
