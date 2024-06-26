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
import model.OrderDetail;

/**
 *
 * @author hieua
 */
public class OrderDAO extends DBContext {

    UserDAO ud = new UserDAO();
    PaymentDAO pd = new PaymentDAO();
    FoodDAO fd = new FoodDAO();

    public boolean insert(double total, String name) {
        String sql = "INSERT INTO orders (user_name, total, status, orderDate, orderTime) VALUES (?, ?, 1, GETDATE(), CONVERT(TIME, GETDATE()))";
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
                Order o = new Order(rs.getInt(1), 
                        rs.getString(2), 
                        rs.getString(5), 
                        rs.getInt(4), 
                        rs.getDouble("total"), 
                        rs.getString(6));
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
        String sql = "update orders set status = ? where order_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, status);
            ps.setString(2, id);
            ps.executeUpdate();
        } catch (Exception e) {

            System.out.println(e);
        }
    }
    
    public void updateStatus(int status, int id) {
        String sql = "update orders set status = ? where order_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, status);
            ps.setInt(2, id);
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

    public void insertDelivery(int id, String address) {
        String sql = "insert into delivery (order_id, delivery_location) values (?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.setString(2, address);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public String getaddress(int id) {
        String sql = "  select delivery_location from delivery where order_id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String s = rs.getString(1);
                return s;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public String getDate(int id) {
        String sql = " select top 1 order_date from orderDetail where order_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String s = rs.getString(1);
                return s;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public ArrayList<Order> getDeliveryByUserName(String userName) {
        ArrayList<Order> listDelivery = new ArrayList<>();
        String sql = "SELECT "
                + "    o.order_id, "
                + "    o.user_name AS customerName, "
                + "    o.total, "
                + "    o.status, "
                + "    o.paymentID, "
                + "    p.paymentType, "
                + "    o.statusPayment, "
                + "    o.shopNotes, "
                + "    d.user_name AS shipperName, "
                + "    d.delivery_location "
                + "FROM "
                + "    orders o "
                + "JOIN "
                + "    delivery d ON o.order_id = d.order_id "
                + "LEFT JOIN "
                + "    payment p ON o.paymentID = p.paymentID "
                + "WHERE "
                + "    d.user_name = ? and o.status in (3,4,5)"
                + "ORDER BY "
                + "    CASE "
                + "        WHEN o.status = 3 THEN 0 "
                + "        WHEN o.status IN (4, 5) THEN 1 "
                + "    END ASC, "
                + "    CASE "
                + "        WHEN o.status = 3 THEN o.order_id "
                + "    END ASC, "
                + "    CASE "
                + "        WHEN o.status IN (4, 5) THEN o.order_id "
                + "    END DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, userName);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listDelivery.add(new Order(rs.getInt("order_id"),
                        ud.getUser(rs.getString("customerName")),
                        rs.getDouble("total"),
                        rs.getInt("status"),
                        pd.getPaymentById(rs.getInt("paymentID")),
                        rs.getInt("statusPayment"),
                        rs.getString("shopNotes"),
                        rs.getString("delivery_location")));
            }
            return listDelivery;
        } catch (Exception e) {
        }
        return listDelivery;
    }

    public void updateStatus(int statusDelivery, int statusPayment, int orderID, String shipperNotes) {
        if (shipperNotes != null) {
            String sql = "update [orders] "
                    + "set [status] = ?, "
                    + "[statusPayment] = ?, "
                    + "[shipperNotes] = ? "
                    + "where [order_id] = ?";
            try {
                PreparedStatement ps = connection.prepareStatement(sql);
                ps.setInt(1, statusDelivery);
                ps.setInt(2, statusPayment);
                ps.setString(3, shipperNotes);
                ps.setInt(4, orderID);
                ps.executeUpdate();
            } catch (Exception e) {
            }
        } else {
            String sql = "update [orders] "
                    + "set [status] = ?, "
                    + "[statusPayment] = ? "
                    + "where [order_id] = ?";
            try {
                PreparedStatement ps = connection.prepareStatement(sql);
                ps.setInt(1, statusDelivery);
                ps.setInt(2, statusPayment);
                ps.setInt(3, orderID);
                ps.executeUpdate();
            } catch (Exception e) {
            }
        }
    }

    public void updateDeliveryDate(int orderId) {
        String sql = "update [delivery] "
                + "set [delivery_date] = getdate(), "
                + "[delivery_time] = convert(time, getdate()) "
                + "where [order_id] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderId);
            ps.executeQuery();
        } catch (Exception e) {
        }
    }

    public ArrayList getOD(int orderId) {          // xem chi tiet don hang o trang dash board
        ArrayList<OrderDetail> listOrderDetail = new ArrayList<>();
        String sql = "SELECT od.order_id, od.price, od.quantity, f.food_name, f.image, f.food_id "
                + "FROM orderDetail od "
                + "LEFT JOIN food f ON od.food_id = f.food_id "
                + "WHERE od.order_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderDetail od = new OrderDetail(getOrderByID(rs.getInt("order_id")),
                        fd.getFoodByID(rs.getInt("food_id")),
                        rs.getDouble("price"),
                        rs.getInt("quantity"));
                listOrderDetail.add(od);
            }
            return listOrderDetail;
        } catch (Exception e) {
        }
        return null;
    }

    public Order getOrderByID(int id) {
        Order o = null;
        String sql = " select * from [orders] where [order_id] = ? ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                o = new Order(rs.getInt("order_id"),
                        ud.getUser(rs.getString("user_name")),
                        rs.getDouble("total"),
                        rs.getInt("status"),
                        rs.getDate("orderDate"),
                        rs.getTime("orderTime"));
            }
        } catch (Exception e) {
        }
        return o;
    }

    public ArrayList<Order> getOrderConfirm() {
        ArrayList<Order> listOrder = new ArrayList<>();
        String sql = "SELECT TOP 5 o.order_id, o.user_name, o.total, d.delivery_location, o.status "
                + "FROM orders o "
                + "LEFT JOIN delivery d ON o.order_id = d.order_id "
                + "WHERE status = 1";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order(rs.getInt("order_id"),
                        ud.getUser(rs.getString("user_name")),
                        rs.getDouble("total"),
                        rs.getInt("status"),
                        rs.getString("delivery_location"));
                listOrder.add(o);
            }
            if (!listOrder.isEmpty()) {
                return listOrder;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public int getNumberOrder() {
        String sql = "select count(*) from orders where status = 3";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public double getTotalProfit() {
        String sql = "select SUM(total) from orders where statusPayment = 2 and status = 4";
        int total = 0;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
            return total;
        } catch (Exception e) {
        }
        return 0;
    }

    public double getTotalByMonth(int month) {
        String sql = "select SUM(total) from orders where statusPayment = 2 and status = 4 AND MONTH(orderDate) = 6";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
//            ps.setInt(1, month);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public void updateStatusConfirm(int orderID, String shopNotes) {
        if (shopNotes != null) {
            String sql = "update [orders] "
                    + "set [status] = 5, "
                    + "[statuspayment] = 3, "
                    + "[shopNotes] = ? "
                    + "where [order_id] = ?";
            try {
                PreparedStatement ps = connection.prepareStatement(sql);
                ps.setString(1, shopNotes);
                ps.setInt(2, orderID);
                ps.executeUpdate();
            } catch (Exception e) {
            }
        } else {
            String sql = "update [orders] "
                    + "set [status] = 2 "
                    + "where [order_id] = ?";
            try {
                PreparedStatement ps = connection.prepareStatement(sql);
                ps.setInt(1, orderID);
                ps.executeUpdate();
            } catch (Exception e) {
            }
        }
    }
}
