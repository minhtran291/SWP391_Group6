/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.Payment;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author Dell
 */
public class PaymentDAO extends DBContext{
    public ArrayList<Payment> getAllPayment(){
        ArrayList<Payment> listPayment = new ArrayList<>();
        String sql = "select * payment";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                listPayment.add(new Payment(rs.getInt("paymentID"), rs.getString("paymentType")));
            }
            return listPayment;
        } catch (Exception e) {
        }
        return null;
    }
    
    public Payment getPaymentById(int paymentId){
        String sql = "select * from payment where paymentID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, paymentId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                Payment p = new Payment(rs.getInt("paymentID"), rs.getString("paymentType"));
                return p;
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
            PaymentDAO pd = new PaymentDAO();
            Payment p = pd.getPaymentById(2);
            System.out.println(p);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
