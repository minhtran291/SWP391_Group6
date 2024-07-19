/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
import java.sql.Time;

/**
 *
 * @author Dell
 */
public class OrderDetail {

    private int id;
    private Order orderId;
    private Food food;
    private Date orderDate;
    private Time orderTime;
    private double price;
    private int quantity;

    public OrderDetail() {
    }

    public OrderDetail(Order orderId, Food food, double price, int quantity) {
        this.orderId = orderId;
        this.food = food;
        this.price = price;
        this.quantity = quantity;
    }

    public OrderDetail(int id, Order orderId, Food food, Date orderDate, Time orderTime, double price, int quantity) {
        this.id = id;
        this.orderId = orderId;
        this.food = food;
        this.orderDate = orderDate;
        this.orderTime = orderTime;
        this.price = price;
        this.quantity = quantity;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Order getOrderId() {
        return orderId;
    }

    public void setOrderId(Order orderId) {
        this.orderId = orderId;
    }

    public Food getFood() {
        return food;
    }

    public void setFood(Food food) {
        this.food = food;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public Time getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(Time orderTime) {
        this.orderTime = orderTime;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "OrderDetail{"
                + "id=" + id
                + ", orderId=" + orderId
                + ", food=" + food
                + ", orderDate=" + orderDate
                + ", orderTime=" + orderTime
                + ", price=" + price
                + ", quantity=" + quantity
                + '}';
    }
}
