/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.Date;
/**
 *
 * @author Dell
 */
public class Food {
    private int foodIid;
    private String foodNname;
    private double price;
    private int stock;
    private Date createDate;
    private String description;
    private int sold;
    private Category categoryIid;
    private String image;

    public Food() {
    }

    public Food(int foodIid, String foodNname, double price, int stock, Date createDate, String description, int sold, Category categoryIid, String image) {
        this.foodIid = foodIid;
        this.foodNname = foodNname;
        this.price = price;
        this.stock = stock;
        this.createDate = createDate;
        this.description = description;
        this.sold = sold;
        this.categoryIid = categoryIid;
        this.image = image;
    }

    public int getFoodIid() {
        return foodIid;
    }

    public void setFoodIid(int foodIid) {
        this.foodIid = foodIid;
    }

    public String getFoodNname() {
        return foodNname;
    }

    public void setFoodNname(String foodNname) {
        this.foodNname = foodNname;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getSold() {
        return sold;
    }

    public void setSold(int sold) {
        this.sold = sold;
    }

    public Category getCategoryIid() {
        return categoryIid;
    }

    public void setCategoryIid(Category categoryIid) {
        this.categoryIid = categoryIid;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    
}
