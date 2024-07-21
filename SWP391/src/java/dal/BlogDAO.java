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
        String sql = "SELECT * FROM blog ORDER BY date_created DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                blogs.add(new Blog(rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("content"),
                        rs.getString("author"),
                        rs.getDate("date_created"),
                        rs.getString("imagePath")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogs;
    }

    public void addBlog(Blog blog) {
        String sql = "INSERT INTO blog (title, content, author, date_created, imagePath) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, blog.getTitle());
            ps.setString(2, blog.getContent());
            ps.setString(3, blog.getAuthor());
            ps.setDate(4, new java.sql.Date(blog.getDateCreated().getTime()));
            ps.setString(5, blog.getImagePath());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public void updateBlog(Blog blog) {
        String sql = "UPDATE blog SET title=?, content=?, author=?, imagePath=? WHERE id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, blog.getTitle());
            ps.setString(2, blog.getContent());
            ps.setString(3, blog.getAuthor());
            ps.setString(4, blog.getImagePath());
            ps.setInt(5, blog.getId());
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
                        resultSet.getDate("date_created"),
                        resultSet.getString("imagePath")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blog;
    }

    public ArrayList<Blog> listAllBlogsHome() {
        ArrayList<Blog> blogs = new ArrayList<>();
        String sql = " Select top 3 *\n"
                + "  From blog\n"
                + "  ORDER BY date_created DESC;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Blog s = new Blog(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("content"),
                        rs.getString("author"),
                        rs.getDate("date_created"),
                        rs.getString("imagePath"));
                blogs.add(s);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogs;
    }

    public static void main(String[] args) throws ClassNotFoundException {
        try {
            String username = "sa";
            String password = "1";
            String url = "jdbc:sqlserver://localhost:1433;databaseName=SWP391";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection connection = DriverManager.getConnection(url, username, password);
            BlogDAO bd = new BlogDAO();
            ArrayList<Blog> listAllBlogsHome = bd.listAllBlogsHome();
            for (Blog blog : listAllBlogsHome) {
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
