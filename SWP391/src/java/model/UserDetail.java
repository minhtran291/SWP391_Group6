/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Dell
 */
public class UserDetail {
    private int userid;
    private String username;
    private String password;
    private int gender;
    private String email;
    private String phone;
    private int roleid;
    private int orderNumber;

    public UserDetail() {
    }

    public UserDetail(int userid, String username, String password, int gender, String email, String phone, int roleid) {
        this.userid = userid;
        this.username = username;
        this.password = password;
        this.gender = gender;
        this.email = email;
        this.phone = phone;
        this.roleid = roleid;
    }

    public UserDetail(String username, String password, int gender, String email, String phone) {
        this.username = username;
        this.password = password;
        this.gender = gender;
        this.email = email;
        this.phone = phone;
    }

    public UserDetail(String username, int orderNumber) {
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


    @Override
    public String toString() {
        return username;
    }
}
