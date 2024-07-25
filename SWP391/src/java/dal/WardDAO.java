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
import model.District;
import model.Ward;

/**
 *
 * @author Dell
 */
public class WardDAO extends DBContext {

    public ArrayList<Ward> getWardByDistrict(String districtName) {
        ArrayList<Ward> listWard = new ArrayList<>();
        String sql = "  select * from ward w, district d\n"
                + "  where w.district_id = d.district_id and w.isDeleted = 1 and d.district_name = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, districtName);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Ward w = new Ward();
                w.setWardId(rs.getInt("ward_id"));
                w.setWardName(rs.getString("ward_name"));
                w.setIsDeleted(rs.getInt("isDeleted"));
                w.setDistrictId(rs.getInt("district_id"));
                listWard.add(w);
            }
            return listWard;
        } catch (Exception e) {
        }
        return null;
    }

    public ArrayList<Ward> getAllWard() {
        ArrayList<Ward> listWard = new ArrayList<>();
        String sql = "select * from ward";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Ward w = new Ward();
                w.setWardId(rs.getInt("ward_id"));
                w.setWardName(rs.getString("ward_name"));
                w.setIsDeleted(rs.getInt("isDeleted"));
                w.setDistrictId(rs.getInt("district_id"));
                w.setDistrict(getDistrictByWard(rs.getInt("district_id")));
                listWard.add(w);
            }
            return listWard;
        } catch (Exception e) {
        }
        return null;
    }

    public District getDistrictByWard(int districtId) {
        String sql = "select * from district where district_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, districtId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                District d = new District();
                d.setDistrictId(rs.getInt("district_id"));
                d.setDistrictName(rs.getString("district_name"));
                d.setDistrictDelete(rs.getInt("isDeleted"));
                return d;
            }
        } catch (Exception e) {
        }
        return null;
    }
    
    public void deleteWard(int wardId, int type) {
        String sql = "update ward "
                + "set [isDeleted] = ? "
                + "where [ward_id] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, type);
            ps.setInt(2, wardId);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }
    
    public boolean checkDuplicateWard(String wardName) {
        String sql = "select * from [ward] where [ward_name] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, wardName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return false;
            }
        } catch (SQLException e) {
        }
        return true;
    }
    
    public boolean checkDuplicateWardUpdate(String wardName, int wardId) {
        String sql = "select * from [ward] where [ward_name] = ? and ward_id <> ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, wardName);
            ps.setInt(2, wardId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return false;
            }
        } catch (SQLException e) {
        }
        return true;
    }
    
    public void addWard(String wardName, int districtId) {
        String sql = "insert into ward "
                + "([ward_name], "
                + "[isDeleted], "
                + "[district_id]) "
                + "values(?, 1, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, wardName);
            ps.setInt(2, districtId);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }
    
    public void updateWard(String wardName, int wardId, int districId) {
        String sql = "update ward "
                + "set [ward_name] = ?,"
                + "[district_id] = ? "
                + "where [ward_id] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, wardName);
            ps.setInt(2, districId);
            ps.setInt(3, wardId);
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
            WardDAO wd = new WardDAO();
            ArrayList<Ward> list = wd.getAllWard();
            for (Ward ward : list) {
                System.out.println(ward);
            }
            wd.deleteWard(1, 0);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
