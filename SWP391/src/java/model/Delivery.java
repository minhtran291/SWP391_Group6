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
public class Delivery {
    private int id;
    private Order orderID;
    private User userName;
    private String deliveryLocation;
    private Date deliveryDate;
    private Time deliveryTime;
    private int status;
    private String statusName;

    public Delivery() {
    }
    
    public Delivery(String deliveryLocation) {
        this.deliveryLocation = deliveryLocation;
    }

    public Delivery(int id, Order orderID, User userName, String deliveryLocation, Date deliveryDate, Time deliveryTime, int status) {
        this.id = id;
        this.orderID = orderID;
        this.userName = userName;
        this.deliveryLocation = deliveryLocation;
        this.deliveryDate = deliveryDate;
        this.deliveryTime = deliveryTime;
        this.status = status;
        this.statusName = StatusEnum.findByCode(status).description;;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Order getOrderID() {
        return orderID;
    }

    public void setOrderID(Order orderID) {
        this.orderID = orderID;
    }

    public User getUserName() {
        return userName;
    }

    public void setUserName(User userName) {
        this.userName = userName;
    }

    public String getDeliveryLocation() {
        return deliveryLocation;
    }

    public void setDeliveryLocation(String deliveryLocation) {
        this.deliveryLocation = deliveryLocation;
    }

    public Date getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(Date deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

    public Time getDeliveryTime() {
        return deliveryTime;
    }

    public void setDeliveryTime(Time deliveryTime) {
        this.deliveryTime = deliveryTime;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    

    @Override
    public String toString() {
        return "Delivery{" +
                "id=" + id +
                ", orderID=" + orderID +
                ", userName=" + userName +
                ", deliveryLocation='" + deliveryLocation + '\'' +
                ", deliveryDate=" + deliveryDate +
                ", deliveryTime=" + deliveryTime +
                ", status=" + status +
                ", statusName=" + statusName +
                '}';
    }
}
