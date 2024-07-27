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
        String sql = "INSERT INTO orders (user_name, total, status, orderDate, orderTime, statusPayment, paymentID) VALUES (?, ?, 1, GETDATE(), CONVERT(TIME, GETDATE()), 1, 2)";
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

    public boolean insertOnline(double total, String name) {
        String sql = "INSERT INTO orders (user_name, total, status, orderDate, orderTime, paymentID, statusPayment) VALUES (?, ?, 1, GETDATE(), CONVERT(TIME, GETDATE()), 1, 2)";
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
            ps.setDouble(5, f.getPrice() - (f.getPrice() * f.getDicountRate() / 100));
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
                Order o = new Order(rs.getInt("order_id"),
                        rs.getString("user_name"),
                        rs.getInt("status"),
                        rs.getDouble("total"),
                        rs.getDate("orderDate"));
                list.add(o);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Order> getOrderAll() {
        List<Order> list = new ArrayList<>();
        String sql = "select * from orders where status <> 1 order by order_id desc";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order(rs.getInt("order_id"),
                        rs.getString("user_name"),
                        rs.getInt("status"),
                        rs.getDouble("total"),
                        rs.getDate("orderDate"));
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
                f.setPrice(rs.getDouble("price"));
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
                Order o = new Order(rs.getInt("order_id"),
                        rs.getString("user_name"),
                        rs.getDouble("total"),
                        rs.getInt("status"),
                        rs.getDate("orderDate"),
                        rs.getTime("orderTime"),
                        pd.getPaymentById(rs.getInt("paymentID")),
                        rs.getInt("statusPayment"),
                        rs.getString("shipperNotes"),
                        rs.getString("customerNotes"),
                        rs.getString("shopNotes"));
                o.setStatusPayment(rs.getInt("statusPayment"));
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

    public void updateStatus(int status, int id, int type, String reason, int statusPayment) {
        String sql = "";
        switch (type) {
            case 1:         // customer cancel order
                sql = "update orders set status = ?, customerNotes = ?, statusPayment = ? where order_id = ?";
                try {
                    PreparedStatement ps = connection.prepareStatement(sql);
                    ps.setInt(1, status);
                    ps.setString(2, reason);
                    ps.setInt(3, statusPayment);
                    ps.setInt(4, id);
                    ps.executeUpdate();
                } catch (SQLException e) {
                    System.out.println(e);
                }
                break;
            case 2:     // shop cacel order
                sql = "update orders set status = ?, shopNotes = ?, statusPayment = ? where order_id = ?";
                try {
                    PreparedStatement ps = connection.prepareStatement(sql);
                    ps.setInt(1, status);
                    ps.setString(2, reason);
                    ps.setInt(3, statusPayment);
                    ps.setInt(4, id);
                    ps.executeUpdate();
                } catch (SQLException e) {
                    System.out.println(e);
                }
                break;
            case 3:
                sql = "update orders set status = ?, shipperNotes = ?, statusPayment = ? where order_id = ?";
                try {
                    PreparedStatement ps = connection.prepareStatement(sql);
                    ps.setInt(1, status);
                    ps.setString(2, reason);
                    ps.setInt(3, statusPayment);
                    ps.setInt(4, id);
                    ps.executeUpdate();
                } catch (SQLException e) {
                    System.out.println(e);
                }
                break;
        }
    }

    public void delete(String id) {
        try {
            String sqlOrderDetail = "delete from orderDetail where order_id = ?";
            PreparedStatement psOrderDetail = connection.prepareStatement(sqlOrderDetail);
            psOrderDetail.setString(1, id);
            psOrderDetail.executeUpdate();

            String sqlDelivery = "delete from delivery where order_id = ?";
            PreparedStatement psDelivery = connection.prepareStatement(sqlDelivery);
            psDelivery.setString(1, id);
            psDelivery.executeUpdate();

            String sqlOrders = "delete from orders where order_id = ?";
            PreparedStatement psOrders = connection.prepareStatement(sqlOrders);
            psOrders.setString(1, id);
            psOrders.executeUpdate();
        } catch (SQLException e) {
            System.out.println("e: " + e);
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

    public void updateFood(int orderId, String status) {
        if (status.equals("done")) {
            String sql = "select * from orderDetail where [order_id] = ?";
            try {
                PreparedStatement ps = connection.prepareStatement(sql);
                ps.setInt(1, orderId);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    int foodId = rs.getInt("food_id");
                    int quantity = rs.getInt("quantity");
                    String sql1 = "update food "
                            + "set stock = stock - ?, "
                            + "sold = sold + ? "
                            + "where food_id = ? ";
                    try {
                        ps = connection.prepareCall(sql1);
                        ps.setInt(1, quantity);
                        ps.setInt(2, quantity);
                        ps.setInt(3, foodId);
                        ps.executeUpdate();
                    } catch (Exception e) {
                    }
                }
            } catch (Exception e) {
            }
        } else if (status.equals("break")) {
            String sql = "select * from orderDetail where [order_id] = ?";
            try {
                PreparedStatement ps = connection.prepareStatement(sql);
                ps.setInt(1, orderId);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    int foodId = rs.getInt("food_id");
                    int quantity = rs.getInt("quantity");
                    String sql1 = "update food "
                            + "set stock = stock - ? "
                            + "where food_id = ? ";
                    try {
                        ps = connection.prepareCall(sql1);
                        ps.setInt(1, quantity);
                        ps.setInt(2, foodId);
                        ps.executeUpdate();
                    } catch (Exception e) {
                    }
                }
            } catch (Exception e) {
            }
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
                        rs.getTime("orderTime"),
                        pd.getPaymentById(rs.getInt("paymentID")),
                        rs.getInt("statusPayment"));
            }
        } catch (Exception e) {
        }
        return o;
    }

    public ArrayList<Order> getOrderConfirm() {
        ArrayList<Order> listOrder = new ArrayList<>();
        String sql = "SELECT o.order_id, o.user_name, o.total, d.delivery_location, o.status "
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
        String sql = "select count(*) from orders where status = 2";
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

    public List<Double> getTotalByMonth(int year) {
        ArrayList<Double> listTotalByMonth = new ArrayList<>();
        String sql = "SELECT m.month, COALESCE(SUM(total), 0) AS TotalPrice "
                + "FROM (SELECT 1 AS month UNION ALL "
                + "SELECT 2 UNION ALL "
                + "SELECT 3 UNION ALL "
                + "SELECT 4 UNION ALL "
                + "SELECT 5 UNION ALL "
                + "SELECT 6 UNION ALL "
                + "SELECT 7 UNION ALL "
                + "SELECT 8 UNION ALL "
                + "SELECT 9 UNION ALL "
                + "SELECT 10 UNION ALL "
                + "SELECT 11 UNION ALL "
                + "SELECT 12) AS m "
                + "LEFT JOIN orders o ON MONTH(o.orderDate) = m.month AND YEAR(o.orderDate) = ? AND o.statusPayment = 2 AND o.status = 4 "
                + "GROUP BY m.month";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, year);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                double Price = rs.getDouble(2);
                listTotalByMonth.add(Price);
            }
        } catch (Exception e) {
        }
        return listTotalByMonth;
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

    public static void main(String[] args) throws ClassNotFoundException {
        try {
            String username = "sa";
            String password = "123";
            String url = "jdbc:sqlserver://localhost:1433;databaseName=SWP391";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection connection = DriverManager.getConnection(url, username, password);
            OrderDAO od = new OrderDAO();
            List<Double> list = od.getTotalByMonth(2024);
            for (Double double1 : list) {
                System.out.println(double1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
