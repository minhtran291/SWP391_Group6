/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.Date;
/**
 *
 * @author admin
 */
public class Discount {
    private int discountId;
    private int foodId;
    private int discountRate;
    private Date startDate;
    private Date endDate;

    public Discount(int discountId, int foodId, int discountRate, Date startDate, Date endDate) {
        this.discountId = discountId;
        this.foodId = foodId;
        this.discountRate = discountRate;
        this.startDate = startDate;
        this.endDate = endDate;
    }
    public Discount( int foodId, int discountRate, Date startDate, Date endDate) {
        this.foodId = foodId;
        this.discountRate = discountRate;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public int getDiscountId() {
        return discountId;
    }

    public void setDiscountId(int discountId) {
        this.discountId = discountId;
    }

    public int getFoodId() {
        return foodId;
    }

    public void setFoodId(int foodId) {
        this.foodId = foodId;
    }

    public int getDiscountRate() {
        return discountRate;
    }

    public void setDiscountRate(int discountRate) {
        this.discountRate = discountRate;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }


}

