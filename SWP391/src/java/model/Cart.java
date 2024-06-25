/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author hieua
 */
public class Cart {
    private int id;
    private int user;
    private String cart_detail;

    public Cart() {
    }

    public Cart(int id, int user, String cart_detail) {
        this.id = id;
        this.user = user;
        this.cart_detail = cart_detail;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUser() {
        return user;
    }

    public void setUser(int user) {
        this.user = user;
    }

    public String getCart_detail() {
        return cart_detail;
    }

    public void setCart_detail(String cart_detail) {
        this.cart_detail = cart_detail;
    }

    @Override
    public String toString() {
        return "Cart{" + "id=" + id + ", user=" + user + ", cart_detail=" + cart_detail + '}';
    }
    
    
}
