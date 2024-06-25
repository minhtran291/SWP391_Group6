/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import model.Food;

import model.Order;

/**
 *
 * @author hieua
 */
public class OrderDAO extends DBContext {

    public boolean insert(double total, String name ) {
        String sql = "insert into orders (user_name, total,status) values(?,?,0)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name);
            ps.setDouble(2, total);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println(e);
        }
        return false;
    }

    public int getLast() {
        String sql = "  select top 1 order_id from orders order by order_id desc";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int oid = rs.getInt(1);
                return oid;
            }
        } catch (Exception e) {
        }
        return -1;
    }

    public void insert_detail(int id, Food f) {
        String sql = "insert into orderDetail (order_id,food_id,order_date,order_time,price,quantity) values (?,?,?,?,?,?)";
        LocalDateTime now = LocalDateTime.now();

        // Định dạng thời gian theo mẫu mong muốn
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedDateTime = now.format(formatter);
        String time_arr[] = formattedDateTime.split(" ");
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.setInt(2, f.getFoodId());
            ps.setString(3, time_arr[0]);
            ps.setString(4, time_arr[1]);
            ps.setDouble(5, f.getPrice());
            ps.setInt(6, f.getQuantity());
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public List<Order> getOrder(String name) {
        List<Order> list = new ArrayList<>();
        String sql = "select * from orders where user_name=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order(rs.getInt(1), rs.getString(2), rs.getString(5), rs.getInt(4), rs.getDouble("total"), rs.getString(6));
                list.add(o);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Order> getOrderAll() {
        List<Order> list = new ArrayList<>();
        String sql = "select * from orders";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order(rs.getInt(1), rs.getString(2), rs.getString(5), rs.getInt(4), rs.getDouble("total"), rs.getString(6));
                list.add(o);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Food> GetOrderDetail(int id) {
        String sql = "select * from orderDetail where order_id = ?";
        List<Food> list = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                FoodDAO fd = new FoodDAO();
                Food f = fd.getFoodByID(rs.getInt(3) + "");
                f.setQuantity(rs.getInt(7));
                list.add(f);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public Order getOrderById(int id) {

        String sql = "select * from orders where order_id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, id + "");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Order o = new Order(rs.getInt(1), rs.getString(2), rs.getString(5), rs.getInt(4), rs.getDouble("total"), rs.getString(6));
                return o;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public void updateStatus(int status, String id) {
        String sql = "update orders set status=? where order_id =?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, status);
            ps.setString(2, id);
            ps.executeUpdate();
        } catch (Exception e) {

            System.out.println(e);
        }
    }

    public void delete(String id) {
        String sql = "delete from orderDetail where order_id = ?\n"
                + "delete from delivery where order_id = ?"
                + "delete from orders where order_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, id);
            ps.setString(2, id);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    public void insertDelivery(int id, String address,String name){
       String sql =  "insert into delivery (order_id, delivery_location, [user_name]) values (?,?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.setString(2,address);
            ps.setString(3, name);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    
    public String getaddress(int id){
        String sql = "  select delivery_location from delivery where order_id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                String s = rs.getString(1);
                return s;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    public String getDate(int id){
        String sql = " select top 1 order_date from orderDetail where order_id = ?";
         try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                String s = rs.getString(1);
                return s;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
}
