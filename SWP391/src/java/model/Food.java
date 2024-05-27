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
    private int foodId;
    private String foodName;
    private double price;
    private int stock;
    private Date createDate;
    private String description;
    private int sold;
    private Category categoryId;
    private String image;

    public Food() {
    }
    
    public Food(String foodName, double price, int stock, Category categoryId, String description, String image){
        this.foodName = foodName;
        this.price = price;
        this.stock = stock;
        this.categoryId = categoryId;
        this.description = description;
        this.image = image;
    }
    
    public Food(int foodId, String foodName, double price, int stock, Date createDate, String description, int sold, Category categoryId, String image) {
        this.foodId = foodId;
        this.foodName = foodName;
        this.price = price;
        this.stock = stock;
        this.createDate = createDate;
        this.description = description;
        this.sold = sold;
        this.categoryId = categoryId;
        this.image = image;
    }

    public int getFoodId() {
        return foodId;
    }

    public void setFoodId(int foodId) {
        this.foodId = foodId;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
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

    public Category getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Category categoryId) {
        this.categoryId = categoryId;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
    
}
