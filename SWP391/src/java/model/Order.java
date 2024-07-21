/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
import java.sql.Time;

/**
 *
 * @author hieua
 */
public class Order {
    private int id;
    private String name;
    private String address;
    private int status;
    private double total;
    private String date;
    private String status_text;
    private Payment payment;
    private int statusPayment;
    private String statusPaymentName;
    private String shopNotes;
    private String shipperNotes;
    private String customerNotes;
    private Date orderDate;
    private Time orderTime;
    private User users;
    private String statusName;

    public Order() {
    }

    public Order(int id, User users, double total, int status, Date orderDate, Time orderTime, Payment payment, int statusPayment) {
        this.id = id;
        this.users = users;
        this.total = total;
        this.status = status;
        this.statusName = StatusEnum.findByCode(status).description;
        this.orderDate = orderDate;
        this.orderTime = orderTime;
        this.payment = payment;
        this.statusPaymentName = StatusPayment.findByCode(statusPayment).description;
    }
    
    public Order(int id, String name, int status, double total, Date orderDate) {
        this.id = id;
        this.name = name;
        this.status = status;
        this.total = total;
        this.orderDate = orderDate;
        this.statusName = StatusEnum.findByCode(status).description;
    }
    
    public Order(int id, String name, double total, int status, Date orderDate, Time orderTime, Payment payment, int statusPayment) {
        this.id = id;
        this.name = name;
        this.status = status;
        this.total = total;
        this.orderDate = orderDate;
        this.orderTime = orderTime;
        this.payment = payment;
        this.statusPaymentName = StatusPayment.findByCode(statusPayment).description;
    }
    
    public Order(int id, String name, double total, int status, Date orderDate, Time orderTime, Payment payment, int statusPayment, String shipperNotes, String customerNotes, String shopNotes) {
        this.id = id;
        this.name = name;
        this.status = status;
        this.total = total;
        this.orderDate = orderDate;
        this.orderTime = orderTime;
        this.payment = payment;
        this.statusPaymentName = StatusPayment.findByCode(statusPayment).description;
        this.shipperNotes = shipperNotes;
        this.customerNotes = customerNotes;
        this.shopNotes = shopNotes;
    }
    
    public Order(int id, User users, double total, int status, Payment payment, int statusPayment, String shopNotes, String address) {
        this.id = id;
        this.users = users;
        this.total = total;
        this.status = status;
        this.statusName = StatusEnum.findByCode(status).description;
        this.payment = payment;
        this.statusPayment = statusPayment;
        this.statusPaymentName = StatusPayment.findByCode(statusPayment).description;
        this.shopNotes = shopNotes;
        this.address = address;
    }
    
    public Order(int id, User users, double total, int status, String address) {
        this.id = id;
        this.users = users;
        this.total = total;
        this.status = status;
        this.statusName = StatusEnum.findByCode(status).description;
        this.address = address;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

  

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public String getStatus_text() {
        return status_text;
    }

    public void setStatus_text(String status_text) {
        this.status_text = status_text;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public Payment getPayment() {
        return payment;
    }

    public void setPayment(Payment payment) {
        this.payment = payment;
    }

    public int getStatusPayment() {
        return statusPayment;
    }

    public void setStatusPayment(int statusPayment) {
        this.statusPayment = statusPayment;
    }

    public String getStatusPaymentName() {
        return statusPaymentName;
    }

    public void setStatusPaymentName(String statusPaymentName) {
        this.statusPaymentName = statusPaymentName;
    }

    public String getShopNotes() {
        return shopNotes;
    }

    public void setShopNotes(String shopNotes) {
        this.shopNotes = shopNotes;
    }

    public String getShipperNotes() {
        return shipperNotes;
    }

    public void setShipperNotes(String shipperNotes) {
        this.shipperNotes = shipperNotes;
    }

    public String getCustomerNotes() {
        return customerNotes;
    }

    public void setCustomerNotes(String customerNotes) {
        this.customerNotes = customerNotes;
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

    public User getUsers() {
        return users;
    }

    public void setUsers(User users) {
        this.users = users;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }
    
     @Override
    public String toString() {
        return "Order{"
                + "id=" + id
                + ", users=" + users
                + ", total=" + total
                + ", status=" + status
                + ", statusName='" + statusName + '\''
                + ", payment=" + payment
                + ", statusPayment=" + statusPayment
                + ", statusPaymentName='" + statusPaymentName + '\''
                + ", shopNotes='" + shopNotes + '\''
                + ", shipperNotes'" + shipperNotes + '\''
                + ", customerNotes'" + customerNotes + '\''
                + ", address='" + address + '\''
                + '}';
    }
    
}
