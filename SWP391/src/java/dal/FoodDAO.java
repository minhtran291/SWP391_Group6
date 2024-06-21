/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.Food;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author Dell
 */
public class FoodDAO extends DBContext {

    CategoryDAO cd = new CategoryDAO();

    public ArrayList<Food> getAllFood() {
        ArrayList<Food> listFood = new ArrayList<>();
        String sql = "select * from food "
                + "order by food_id asc";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listFood.add(new Food(rs.getInt("food_id"),
                        rs.getString("food_name"),
                        rs.getFloat("price"),
                        rs.getInt("stock"),
                        rs.getDate("create_date"),
                        rs.getString("description"),
                        rs.getInt("sold"),
                        cd.getCategoryById(rs.getInt("category_id")),
                        rs.getString("image")));
            }
        } catch (Exception e) {
        }
        return listFood;
    }

    public ArrayList<Food> getFoodByCategory(String categoryId) {
        ArrayList<Food> listFood = new ArrayList<>();
        String sql = "select * from food "
                + "where category_id = ? "
                + "order by food_id asc";
        try {
            int cid = Integer.parseInt(categoryId);
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listFood.add(new Food(rs.getInt("food_id"),
                        rs.getString("food_name"),
                        rs.getFloat("price"),
                        rs.getInt("stock"),
                        rs.getDate("create_date"),
                        rs.getString("description"),
                        rs.getInt("sold"),
                        cd.getCategoryById(rs.getInt("category_id")),
                        rs.getString("image")));
            }
        } catch (Exception e) {
        }
        return listFood;
    }

    public ArrayList<Food> getFoodBySearch(String search) {
        ArrayList<Food> listFood = new ArrayList<>();
        String sql = "select * from food "
                + "where food_name like ? "
                + "order by food_id asc";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listFood.add(new Food(rs.getInt("food_id"),
                        rs.getString("food_name"),
                        rs.getFloat("price"),
                        rs.getInt("stock"),
                        rs.getDate("create_date"),
                        rs.getString("description"),
                        rs.getInt("sold"),
                        cd.getCategoryById(rs.getInt("category_id")),
                        rs.getString("image")));
            }
        } catch (Exception e) {
        }
        return listFood;
    }

    public ArrayList<Food> getSort(int cid, String search, int index, String sort) {
        String sortBy = "";
        switch (sort) {
            case "1":
                sortBy = "order by f.create_date desc ";
                break;
            case "2":
                sortBy = "order by f.price asc ";
                break;
            case "3":
                sortBy = "order by f.price desc ";
                break;
            case "4":
                sortBy = "order by f.sold desc ";
                break;
            default:
                sortBy = "order by f.food_id asc";
                break;
        }

        ArrayList<Food> listFood = new ArrayList<>();
        String sql = "select * from [food] f, [category] c "
                + "where f.category_id = c.category_id "
                + "and f.category_id = ? and f.food_name like ? "
                + sortBy;
//                + "offset ? rows fetch next 6 rows only";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cid);
            ps.setString(2, "%" + search + "%");
//            ps.setInt(3, (index - 1) * 6);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listFood.add(new Food(rs.getInt("food_id"),
                        rs.getString("food_name"),
                        rs.getFloat("price"),
                        rs.getInt("stock"),
                        rs.getDate("create_date"),
                        rs.getString("description"),
                        rs.getInt("sold"),
                        cd.getCategoryById(rs.getInt("category_id")),
                        rs.getString("image")));
            }

        } catch (Exception e) {
        }

        return listFood;
    }

    public void addFood(String foodName, int price, int stock, int cid, String description, String image) {
        String sql = "insert into food "
                + "([food_name], "
                + "[price], "
                + "[stock], "
                + "[create_date], "
                + "[category_id], "
                + "[description], "
                + "[sold], "
                + "[image]) "
                + "values(?, ?, ?, getDate(), ?, ?, 0, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, foodName);
            ps.setDouble(2, price);
            ps.setInt(3, stock);
            ps.setInt(4, cid);
            ps.setString(5, description);
            ps.setString(6, image);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void updateFood(int id, String foodName, int price, int stock, int cid, String description, String image, int sold) {
        String sql = "update food "
                + "set [food_name] = ?, "
                + "[price] = ?, "
                + "[stock] = ?, "
                + "[category_id] = ?, "
                + "[description] = ?, "
                + "[image] = ?, "
                + "[sold] = ? "
                + "where [food_id] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, foodName);
            ps.setDouble(2, price);
            ps.setInt(3, stock);
            ps.setInt(4, cid);
            ps.setString(5, description);
            ps.setString(6, image);
            ps.setInt(7, sold);
            ps.setInt(8, id);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void deleteFood(int foodId) {
        String sql = "delete from food where food_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, foodId);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public int getNumberFood(int cid, String search) {
        String sql = "select count(*) "
                + "from food f, category c "
                + "where f.category_id = c.category_id "
                + "and f.category_id = ? and f.food_name like ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cid);
            ps.setString(2, "%" + search + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    public boolean checkFoodName(String foodName) {
        String sql = "select * from [food] where [food_name] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, foodName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return false;
            }
        } catch (SQLException e) {
        }
        return true;
    }

    public boolean checkFoodName(String foodName, String idS) {
        String sql = "select * from [food] where [food_name] = ? AND [food_id] != ?";
        int id = Integer.parseInt(idS);
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, foodName);
            ps.setInt(2, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return false;
            }
        } catch (SQLException e) {
        }
        return true;
    }

    public Food getFoodByID(String foodId) {
        String sql = "select * from food "
                + "where food_id =? ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, foodId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Food(rs.getInt("food_id"),
                        rs.getString("food_name"),
                        rs.getFloat("price"),
                        rs.getInt("stock"),
                        rs.getDate("create_date"),
                        rs.getString("description"),
                        rs.getInt("sold"),
                        cd.getCategoryById(rs.getInt("category_id")),
                        rs.getString("image"));
            }
        } catch (Exception e) {
        }
        return null;
    }

    public List<Food> getsameFood(String id) {
        List<Food> list = new ArrayList<>();
        String sql = "SELECT *\n"
                + "FROM [SWP391].[dbo].[food]\n"
                + "WHERE [category_id] = (\n"
                + "        SELECT [category_id]\n"
                + "        FROM [SWP391].[dbo].[food]\n"
                + "        WHERE [food_id] = ?\n"
                + "      )\n"
                + "  AND [food_id] <> ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            st.setString(2, id);

            //   st.setString(2, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Food s = new Food(rs.getInt(1),
                        rs.getString(2),
                        rs.getDouble(3),
                        rs.getInt(4),
                        rs.getDate(5),
                        rs.getString(6),
                        rs.getInt(7),
                        cd.getCategoryById(rs.getInt("category_id")),
                        rs.getString(9));
                list.add(s);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return list;
    }
    public List<Food> getlistfoodbyId(String id) {
        List<Food> list = new ArrayList<>();
        String sql = "  select * from dbo.food where food_id=? ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);

            //   st.setString(2, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Food s = new Food(rs.getInt("food_id"),
                        rs.getString("food_name"),
                        rs.getFloat("price"),
                        rs.getInt("stock"),
                        rs.getDate("create_date"),
                        rs.getString("description"),
                        rs.getInt("sold"),
                        cd.getCategoryById(rs.getInt("category_id")),
                        rs.getString("image"));
                list.add(s);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return list;
    }
     public Food getFoodByName(String foodName) {
        String sql = "select * from food "
                + "where food_name =? ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, foodName);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Food(rs.getInt("food_id"),
                        rs.getString("food_name"),
                        rs.getFloat("price"),
                        rs.getInt("stock"),
                        rs.getDate("create_date"),
                        rs.getString("description"),
                        rs.getInt("sold"),
                        cd.getCategoryById(rs.getInt("category_id")),
                        rs.getString("image"));
            }
        } catch (Exception e) {
        }
        return null;
    }
}
