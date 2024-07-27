/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.Delivery;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.DriverManager;
import model.User;

/**
 *
 * @author Dell
 */
public class DeliveryDAO extends DBContext {

    OrderDAO od = new OrderDAO();
    UserDAO ud = new UserDAO();

    public ArrayList<Delivery> getAllDelivery() {
        ArrayList<Delivery> listDelivery = new ArrayList<>();
        String sql
                = "SELECT "
                + "    o.order_id, "
                + "    o.user_name AS CustomerName, "
                + "    o.total, "
                + "    o.status, "
                + "    d.delivery_id, "
                + "    d.user_name AS EmployeeName, "
                + "    d.delivery_location, "
                + "    d.delivery_date, "
                + "    d.delivery_time "
                + "FROM "
                + "    orders o "
                + "JOIN "
                + "    delivery d ON o.order_id = d.order_id "
                + "WHERE "
                + "    o.status in (2,3)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listDelivery.add(new Delivery(rs.getInt("delivery_id"),
                        od.getOrderByID(rs.getInt("order_id")),
                        ud.getUser(rs.getString("EmployeeName")),
                        rs.getString("delivery_location"),
                        rs.getDate("delivery_date"),
                        rs.getTime("delivery_time"),
                        rs.getInt("status")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listDelivery;
    }

    public void addEmployeeToDelivery(String name, int id) {
        String sql = "update [delivery] "
                + "set [user_name] = ? "
                + "where [delivery_id] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public ArrayList<User> getOrderNumber() {
        ArrayList<User> numberOrder = new ArrayList<>();
        String sql = "SELECT u.user_name, COALESCE(sub.quantity, 0) AS quantity, sub.user_name "
                + "FROM dbo.users u "
                + "LEFT JOIN ( "
                + "    SELECT COALESCE(COUNT(o.user_name), 0) AS quantity, d.user_name "
                + "    FROM delivery d "
                + "    LEFT JOIN orders o ON o.order_id = d.order_id AND o.status IN (2, 3) "
                + "    WHERE d.user_name IS NOT NULL "
                + "    GROUP BY d.user_name "
                + ") AS sub ON u.user_name = sub.user_name "
                + "WHERE u.role_id = 3";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                numberOrder.add(new User(rs.getString(1),
                        rs.getInt(2)));
            }
        } catch (Exception e) {
        }
        return numberOrder;
    }

    public Delivery getDeliveryByOrderId(int orderId) {
        String sql = "select delivery_location from delivery where order_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Delivery d = new Delivery(rs.getString("delivery_location"));
                return d;
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
            DeliveryDAO deliveryDAO = new DeliveryDAO();
            Delivery d = deliveryDAO.getDeliveryByOrderId(11);
            System.out.println(d);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
