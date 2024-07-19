package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Blog;
import model.Food;

public class BlogDAO extends DBContext {

    public ArrayList<Blog> listAllBlogs() {
        ArrayList<Blog> blogs = new ArrayList<>();
        String sql = "SELECT * FROM blog";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                blogs.add(new Blog(rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("content"),
                        rs.getString("author"),
                        rs.getDate("date_created")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogs;
    }

    public void addBlog(Blog blog) {
        String sql = "INSERT INTO blog (title, content, author, date_created) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, blog.getTitle());
            ps.setString(2, blog.getContent());
            ps.setString(3, blog.getAuthor());
            ps.setDate(4, new java.sql.Date(blog.getDateCreated().getTime()));
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
       
    }

    public void updateBlog(Blog blog) {
        String sql = "UPDATE blog SET title=?, content=?, author=? WHERE id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, blog.getTitle());
            ps.setString(2, blog.getContent());
            ps.setString(3, blog.getAuthor());
            ps.setInt(4, blog.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
    }

    public void deleteBlog(int id) {
        String sql = "DELETE FROM blog WHERE id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
       
    }
    public Blog getBlogById(int id) {
        Blog blog = null;
        try {
            String query = "SELECT * FROM blog WHERE id=?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                blog = new Blog(
                        resultSet.getInt("id"),
                        resultSet.getString("title"),
                        resultSet.getString("content"),
                        resultSet.getString("author"),
                        resultSet.getDate("date_created")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blog;
    }
    public static void main(String[] args) throws ClassNotFoundException {
        try {
            String username = "sa";
            String password = "1";
            String url = "jdbc:sqlserver://localhost:1433;databaseName=SWP391";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection connection = DriverManager.getConnection(url, username, password);
            BlogDAO bd = new BlogDAO();
             ArrayList<Blog> listFood = bd.listAllBlogs();
            for (Blog blog : listFood) {
                System.out.println(blog);
            }
//            String s = null;
//            od.updateStatusConfirm(7, s);
//            double d = od.getTotalByMonth(6);
//            System.out.println(d);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
