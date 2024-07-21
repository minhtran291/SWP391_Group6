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
import model.UserDetail;

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
                User u = new User(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7));
                u.setAvatar(rs.getString("avatar"));
                return u;

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

    public User getUserEmail(String email) {
        User user = null;
        String sql = "SELECT * FROM users WHERE email = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, email);
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

    public void addUserLoginGG(User u) {
        String sql = "insert into [users] ([user_name], [password], [gender], [email], [role_id]) "
                + "values(?,?,?,?,1)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, u.getUsername());
            st.setString(2, u.getPassword());
            st.setInt(3, u.getGender());
            st.setString(4, u.getEmail());
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
                user.setAvatar(resultSet.getString("avatar"));
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

    public void UpdateEmp(String username, String password, String email, String phone, int userid) {
        String sql = "UPDATE [dbo].[users] "
                + "   SET [user_name] = ?, "
                + "      [password] = ?, "
                + "      [email] = ?, "
                + "      [phone_number] = ? "
                + " WHERE [user_id] = ? ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setInt(5, userid);
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

    public User getUserByName(String name) {
        String sql = "SELECT * FROM users WHERE user_name = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name);
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

    public int getNumberCustomer() {
        String sql = "select count(*) from users where role_id = 1";
        int numberCustomer = 0;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                numberCustomer = rs.getInt(1);
            }
            return numberCustomer;
        } catch (Exception e) {
        }
        return 0;
    }

    public UserDetail getUserDetail(String username) {
        UserDetail user = null;
        String sql = "SELECT * FROM users WHERE user_name = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                user = new UserDetail();
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

    public void UpdateAcc(String username, String password, int roleid, String email, String phone, int userid) {
        String sql = "UPDATE [dbo].[users] "
                + "   SET [user_name] = ?, "
                + "      [password] = ?, "
                + "      [role_id] = ?, "
                + "      [email] = ?, "
                + "      [phone_number] = ? "
                + " WHERE [user_id] = ? ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setInt(3, roleid);
            ps.setString(4, email);
            ps.setString(5, phone);
            ps.setInt(6, userid);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public ArrayList<User> getAccount() {
        ArrayList<User> listemp = new ArrayList<>();
        String sql = "SELECT TOP (1000) u.[user_id]\n"
                + "      ,u.[user_name]\n"
                + "      ,u.[password]\n"
                + "      ,u.[gender]\n"
                + "      ,u.[email]\n"
                + "      ,u.[phone_number]\n"
                + "      ,u.[role_id]\n"
                + "	  ,r.role_name\n"
                + "  FROM [SWP391].[dbo].[users] u join dbo.roles r on u.role_id=r.role_id";
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
                        rs.getInt(7),
                        rs.getString(8)));
            }
        } catch (Exception e) {
        }
        return listemp;
    }

    public void addAcc(String username, String password, int gender, String email, String phone, int roleid) {
        String sql = "INSERT INTO [dbo].[users]\n"
                + "           ([user_name]\n"
                + "           ,[password]\n"
                + "           ,[gender]\n"
                + "           ,[email]\n"
                + "           ,[phone_number]\n"
                + "           ,[role_id])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setInt(3, gender);
            ps.setString(4, email);
            ps.setString(5, phone);
            ps.setInt(6, roleid);
            ps.executeUpdate();
        } catch (Exception e) {
        }

    }

    public ArrayList<User> getAllRole() {
        ArrayList<User> listRole = new ArrayList<>();
        String sql = "SELECT TOP (1000) [role_id]\n"
                + "      ,[role_name]\n"
                + "  FROM [SWP391].[dbo].[roles]";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listRole.add(new User(rs.getInt("role_id"),
                        rs.getString("role_name")));
            }
        } catch (Exception e) {
        }
        return listRole;
    }

    public ArrayList<User> getUserByRole(String roleid) {
        ArrayList<User> listUser = new ArrayList<>();
        String sql = "SELECT TOP (1000) u.[user_id] \n"
                + "                     ,u.[user_name]\n"
                + "                    ,u.[password]\n"
                + "                  ,u.[gender]\n"
                + "                    ,u.[email]\n"
                + "                 ,u.[phone_number]\n"
                + "                  ,u.[role_id]\n"
                + "             	  ,r.role_name\n"
                + "               FROM [SWP391].[dbo].[users] u join dbo.roles r on u.role_id=r.role_id\n"
                + "             where u.role_id =?";
        try {
            int rid = Integer.parseInt(roleid);
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, rid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listUser.add(new User(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getString(8)));
            }
        } catch (Exception e) {
        }
        return listUser;
    }

    public void updateUserProfile(int gender, String email, String phone, String avatar, int userid) {
        String sql = "UPDATE [dbo].[users] "
                + "SET [gender] = ?, "
                + "[email] = ?, "
                + "[phone_number] = ?, "
                + "[avatar] = ? "
                + "WHERE [user_id] = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, gender);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, avatar);
            ps.setInt(5, userid);

            ps.executeUpdate();
        } catch (SQLException e) {
            // Ghi lỗi vào log
            e.printStackTrace();
        }
    }

    public boolean checkEmailUpdate(String email, String idemp) {
        String sql = "SELECT * FROM [users] WHERE [email] = ? AND user_id <> ?";
        int id;
        try {
            id = Integer.parseInt(idemp);
        } catch (NumberFormatException e) {
            // Xử lý lỗi khi id không phải là số
            return false;
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setInt(2, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // Nếu có kết quả, email đã tồn tại
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Ghi lỗi vào log
            return false;
        }
    }

    public boolean checkPhoneUpdate(String phone, String idemp) {
        String sql = "  SELECT * FROM [users] WHERE [phone_number] = ? and user_id <> ? ";
        int id = Integer.parseInt(idemp);
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, phone);
            ps.setInt(2, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
        }
        return false;
    }
}
