/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Dell
 */
public class User {

    private int userid;
    private String username;
    private String password;
    private int gender;
    private String email;
    private String phone;
    private int roleid;
    private int orderNumber;
    private String rolename;
    private String avatar;

    public User() {
    }

    public User(int roleid, String rolename) {
        this.roleid = roleid;
        this.rolename = rolename;
    }

    public User(int userid, String username, String password, int gender, String email, String phone, int roleid, String rolename) {
        this.userid = userid;
        this.username = username;
        this.password = password;
        this.gender = gender;
        this.email = email;
        this.phone = phone;
        this.roleid = roleid;
        this.orderNumber = orderNumber;
        this.rolename = rolename;
    }

    public User(int userid, String username, String password, int gender, String email, String phone, int roleid) {
        this.userid = userid;
        this.username = username;
        this.password = password;
        this.gender = gender;
        this.email = email;
        this.phone = phone;
        this.roleid = roleid;
    }

    public User(String avatar) {
        this.avatar = avatar;
    }
    
    public User(String username, String password, int gender, String email, String phone) {
        this.username = username;
        this.password = password;
        this.gender = gender;
        this.email = email;
        this.phone = phone;
    }

    public User(String username, int orderNumber) {
        this.username = username;
        this.orderNumber = orderNumber;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getRoleidString() {
        if (roleid == 2) {
            return "Quản lí cửa hàng";
        }
        if (roleid == 3) {
            return "Nhân viên giao hàng";
        }
        if (roleid == 4) {
            return "Quản trị hệ thống";
        }
        return "Khách hàng";
    }

    public void setRoleid(int roleid) {
        this.roleid = roleid;
    }

    public int getRoleid() {
        return roleid;
    }

    public int getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(int orderNumber) {
        this.orderNumber = orderNumber;
    }

    public String getRolename() {
        return rolename;
    }

    public void setRolename(String rolename) {
        this.rolename = rolename;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

//    @Override
//    public String toString() {
//        return "User{"
//                + "userid=" + userid
//                + ", username='" + username + '\''
//                + ", password='" + password + '\''
//                + ", gender=" + gender
//                + ", email='" + email + '\''
//                + ", phone='" + phone + '\''
//                + ", roleid=" + roleid
//                + ", numberOrder=" + orderNumber
//                + '}';
//    }
    @Override
    public String toString() {
        return username;
    }
}
