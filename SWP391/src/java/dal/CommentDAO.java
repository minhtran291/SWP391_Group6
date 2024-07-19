/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Comment;

/**
 *
 * @author anhdo
 */
public class CommentDAO extends DBContext {

    UserDAO udao = new UserDAO();
    FoodDAO fdao = new FoodDAO();

    public void addComment(String foodId, String name, String content) {
        String sql = "INSERT INTO [dbo].[comments]\n"
                + "           ([food_id]\n"
                + "           ,[user_name]\n"
                + "           ,[comment_text]\n"
                + "           ,[create_date])\n"
                + "     VALUES\n"
                + "           (?,?,?,getDate())";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, foodId);
            ps.setString(2, name);
            ps.setString(3, content);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

//    public Comment getCommentbyFoodID(String foodId, int num) {
//        String sql = "WITH OrderedComments AS (\n"
//                + "    SELECT \n"
//                + "        [comment_id],\n"
//                + "        [food_id],\n"
//                + "        [user_name],\n"
//                + "        [comment_text],\n"
//                + "        [create_date],\n"
//                + "        ROW_NUMBER() OVER (ORDER BY [comment_id] DESC) AS RowNum\n"
//                + "    FROM [SWP391].[dbo].[comments]\n"
//                + "    WHERE [food_id] = ?\n"
//                + ")\n"
//                + "SELECT * \n"
//                + "FROM OrderedComments\n"
//                + "WHERE RowNum = ?;";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ps.setString(1, foodId);
//            ps.setInt(2, num);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                return new Comment(rs.getInt("comment_id"),
//                        fdao.getFoodDetailByID(rs.getString("food_id")),
//                        udao.getUser(rs.getString("user_name")),
//                        rs.getString("comment_text"),
//                        rs.getDate("create_date"));
//            }
//        } catch (Exception e) {
//        }
//        return null;
//    }
    public ArrayList<Comment> getCommentbyFoodID(String foodId) {
        String sql = "SELECT TOP (1000) [comment_id]\n"
                + "      ,[food_id]\n"
                + "      ,[user_name]\n"
                + "      ,[comment_text]\n"
                + "      ,[create_date]\n"
                + "  FROM [SWP391].[dbo].[comments]\n"
                + "  where food_id = ?"
                + "  ORDER BY [comment_id] DESC ";
        ArrayList<Comment> list = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, foodId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Comment(rs.getInt("comment_id"),
                        fdao.getFoodDetailByID(rs.getString("food_id")),
                        udao.getUser(rs.getString("user_name")),
                        rs.getString("comment_text"),
                        rs.getDate("create_date")));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public ArrayList<Comment> getCommentByUserName(String username) {
        String sql = "select * from dbo.comments where user_name = ? ORDER BY comment_id DESC";
        ArrayList<Comment> list = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Comment(rs.getInt("comment_id"),
                        fdao.getFoodDetailByID(rs.getString("food_id")),
                        udao.getUser(rs.getString("user_name")),
                        rs.getString("comment_text"),
                        rs.getDate("create_date")));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public void UpdateCmt(String commentText, int commentId) {
        String sql = "UPDATE [dbo].[comments]\n"
                + "   SET [comment_text] = ? \n"
                + " WHERE comment_id =?\n";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, commentText);
            ps.setInt(2, commentId);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void deleteCmt(int cmtid) {
        String sql = "delete from [dbo].[comments] where comment_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cmtid);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void addRating(String foodId, String name, int rating) {
        String sql = "INSERT INTO [dbo].[rating]\n"
                + "           ([food_id]\n"
                + "           ,[user_name]\n"
                + "           ,[rating]\n"
                + "           ,[created_date])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,getDate())\n"
                + "\n"
                + "";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, foodId);
            ps.setString(2, name);
            ps.setInt(3, rating);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public Comment getRatingbyFoodID(String foodId) {
        String sql = "SELECT TOP (1000) [rating_id], [rating]\n"
                + "      \n"
                + "  FROM [SWP391].[dbo].[rating]"
                + " where food_id = ? ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, foodId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Comment(rs.getInt("rating_id"),
                        rs.getInt("rating"));
            }
        } catch (Exception e) {
        }
        return null;
    }
}
