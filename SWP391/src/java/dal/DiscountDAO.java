package dal;

import model.Discount;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DiscountDAO extends DBContext {


    public void addDiscount(Discount discount) {
        try {
            String query = "INSERT INTO discount (food_id, discount_rate, start_date, end_date) VALUES (?, ?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, discount.getFoodId());
            preparedStatement.setInt(2, discount.getDiscountRate());
            preparedStatement.setDate(3, discount.getStartDate());
            preparedStatement.setDate(4, discount.getEndDate());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateDiscount(Discount discount) {
        try {
            String query = "UPDATE discount SET discount_rate=?, start_date=?, end_date=? WHERE food_id=?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, discount.getDiscountRate());
            preparedStatement.setDate(2, discount.getStartDate());
            preparedStatement.setDate(3, discount.getEndDate());
            preparedStatement.setInt(4, discount.getFoodId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteDiscount(int discountId) {
        try {
            String query = "DELETE FROM discount WHERE discount_id=?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, discountId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<Discount> getAllDiscounts() {
        ArrayList<Discount> discounts = new ArrayList<>();
        try {
            String query = "SELECT * FROM discount";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Discount discount = new Discount(
                        resultSet.getInt("discount_id"),
                        resultSet.getInt("food_id"),
                        resultSet.getInt("discount_rate"),
                        resultSet.getDate("start_date"),
                        resultSet.getDate("end_date")
                );
                discounts.add(discount);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return discounts;
    }

    public Discount getDiscountById(int discountId) {
        Discount discount = null;
        try {
            String query = "SELECT * FROM discount WHERE discount_id=?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, discountId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                discount = new Discount(
                        resultSet.getInt("discount_id"),
                        resultSet.getInt("food_id"),
                        resultSet.getInt("discount_rate"),
                        resultSet.getDate("start_date"),
                        resultSet.getDate("end_date")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return discount;
    }
        public boolean checkFoodId(int foodId) {
        String sql = "select * from [discount] where [food_id] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, foodId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return false;
            }
        } catch (SQLException e) {
        }
        return true;
    }
        
}
