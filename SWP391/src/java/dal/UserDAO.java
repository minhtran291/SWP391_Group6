/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Dell
 */
public class UserDAO extends DBContext {

    public User login(String username, String password) {
        String sql = "select * from users "
                + "where [user_name] = ? "
                + "and password = ? ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new User(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7));
            }

        } catch (SQLException e) {
        }
        return null;

    }

    public boolean duplicatePhone(String phone) {
        String sql = "select * from users where [phone_number] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, phone);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return false;
            }
        } catch (SQLException e) {
        }
        return true;
    }

    public boolean duplicateEmail(String email) {
        String sql = "select * from users where [email] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return false;
            }
        } catch (SQLException e) {
        }
        return true;
    }

    public boolean duplicateAccount(String account) {
        String sql = "select * from users where [user_name] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, account);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return false;
            }
        } catch (SQLException e) {
        }
        return true;
    }

    public int getNumberUser() {
        String sql = "select count(*) "
                + "from Users";
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

    public void addUser(User u) {
        String sql = "insert into [users] ([user_name], [password], [gender], [email], [phone_number], [role_id]) "
                + "values(?,?,?,?,?,1)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, u.getUsername());
            st.setString(2, u.getPassword());
            st.setInt(3, u.getGender());
            st.setString(4, u.getEmail());
            st.setString(5, u.getPhone());

            st.executeUpdate();
        } catch (SQLException e) {
        }
    }
    
    public User getUser(String username) {
        User user = null;
        String sql = "SELECT * FROM users WHERE user_name = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                user = new User();
                user.setUserid(resultSet.getInt("user_id"));
                user.setUsername(resultSet.getString("user_name"));
                user.setPassword(resultSet.getString("password"));
                user.setGender(resultSet.getInt("gender"));
                user.setEmail(resultSet.getString("email"));
                user.setPhone(resultSet.getString("phone_number"));
                user.setRoleid(resultSet.getInt("role_id"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean updatePassword(User u, String newPassword) {
        String sql = "UPDATE users SET password = ? WHERE user_id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, newPassword);
            statement.setInt(2, u.getUserid());
            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserid(rs.getInt("user_id"));
                user.setUsername(rs.getString("user_name"));
                user.setPassword(rs.getString("password"));
                user.setGender(rs.getInt("gender"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone_number"));

                user.setRoleid(rs.getInt("role_id"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public ArrayList<User> getEmployee() {
        ArrayList<User> listemp = new ArrayList<>();
        String sql = "select * from dbo.users where role_id=3";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listemp.add(new User(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7)));
            }
        } catch (Exception e) {
        }
        return listemp;
    }

    public void addEmp(String username, String password, int gender, String email, String phone) {
        String sql = "INSERT INTO [dbo].[users]\n"
                + "           ([user_name]\n"
                + "           ,[password]\n"
                + "           ,[gender]\n"
                + "           ,[email]\n"
                + "           ,[phone_number]\n"
                + "           ,[role_id])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?,3)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setInt(3, gender);
            ps.setString(4, email);
            ps.setString(5, phone);
            ps.executeUpdate();
        } catch (Exception e) {
        }

    }

    public void UpdateEmp(String username, String password, int gender, String email, String phone, int userid) {
        String sql = "UPDATE [dbo].[users] "
                + "   SET [user_name] = ?, "
                + "      [password] = ?, "
                + "      [gender] = ?, "
                + "      [email] = ?, "
                + "      [phone_number] = ? "
                + " WHERE [user_id] = ? ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setInt(3, gender);
            ps.setString(4, email);
            ps.setString(5, phone);
            ps.setInt(6, userid);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void deleteEmp(int userid) {
        String sql = "delete from [dbo].[users] where user_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userid);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }
     public boolean checkEmpName(String username) {
        String sql = "select * from [users] where [user_name] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return false;
            }
        } catch (SQLException e) {
        }
        return true;
    }
        public boolean checkEmpNameUpdate(String username, String idemp) {
        String sql = "select * from [users] where [user_name] = ? AND [user_id] != ?";
        int id = Integer.parseInt(idemp);
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setInt(2, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return false;
            }
        } catch (SQLException e) {
        }
        return true;
    }
          public boolean checkEmail(String email) {
        String sql = "select * from [users] where [email] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return false;
            }
        } catch (SQLException e) {
        }
        return true;
    }
            public boolean checkPhone(String phone) {
        String sql = "select * from [users] where [phone_number] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return false;
            }
        } catch (SQLException e) {
        }
        return true;
    }
             public boolean checkEmpEmailUpdate(String email, String idemp) {
        String sql = "select * from [users] where [email] = ? AND [user_id] != ?";
        int id = Integer.parseInt(idemp);
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ps.setInt(2, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return false;
            }
        } catch (SQLException e) {
        }
        return true;
    }
              public boolean checkEmpPhoneUpdate(String phone, String idemp) {
        String sql = "select * from [users] where [phone_number] = ? AND [user_id] != ?";
        int id = Integer.parseInt(idemp);
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, phone);
            ps.setInt(2, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return false;
            }
        } catch (SQLException e) {
        }
        return true;
    }
}
