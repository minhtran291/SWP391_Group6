/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.ArrayList;
import model.District;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Dell
 */
public class DistrictDAO extends DBContext {

    public ArrayList<District> getAllDistrictCustomer() {
        ArrayList<District> listDistrict = new ArrayList<>();
        String sql = "select * from district where isDeleted = 1";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                District d = new District();
                d.setDistrictId(rs.getInt("district_id"));
                d.setDistrictName(rs.getString("district_name"));
                d.setDistrictDelete(rs.getInt("isDeleted"));
                listDistrict.add(d);
            }
            return listDistrict;
        } catch (Exception e) {
        }
        return null;
    }
    
    public ArrayList<District> getAllDistrictManager() {
        ArrayList<District> listDistrict = new ArrayList<>();
        String sql = "select * from district";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                District d = new District();
                d.setDistrictId(rs.getInt("district_id"));
                d.setDistrictName(rs.getString("district_name"));
                d.setDistrictDelete(rs.getInt("isDeleted"));
                listDistrict.add(d);
            }
            return listDistrict;
        } catch (Exception e) {
        }
        return null;
    }

    public boolean checkDuplicateDistrict(String districtName) {
        String sql = "select * from [district] where [district_name] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, districtName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return false;
            }
        } catch (SQLException e) {
        }
        return true;
    }

    public boolean checkDuplicateDistrictUpdate(String districtName, int districtId) {
        String sql = "select * from [district] where [district_name] = ? and district_id <> ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, districtName);
            ps.setInt(2, districtId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return false;
            }
        } catch (SQLException e) {
        }
        return true;
    }
    
    public void updateDistrict(String districtName, int districtId) {
        String sql = "update district "
                + "set [district_name] = ? "
                + "where [district_id] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, districtName);
            ps.setInt(2, districtId);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void addDistrict(String districtName) {
        String sql = "insert into district "
                + "([district_name], "
                + "[isDeleted]) "
                + "values(?, 1)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, districtName);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }
    
    public void deleteDistrict(int districtId, int type) {
        String sql = "update district "
                + "set [isDeleted] = ? "
                + "where [district_id] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, type);
            ps.setInt(2, districtId);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }
            

    public static void main(String[] args) throws ClassNotFoundException {
        try {
            String username = "sa";
            String password = "123";
            String url = "jdbc:sqlserver://localhost:1433;databaseName=SWP391";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection connection = DriverManager.getConnection(url, username, password);
            DistrictDAO dd = new DistrictDAO();
            ArrayList<District> list = dd.getAllDistrictCustomer();
            for (District district : list) {
                System.out.println(district);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
