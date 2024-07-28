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
public class Rating {
    private int ratingId;
    private Food food;
    private int foodId;
    private String userName;
    private User user;
    private int rating;
    private Date createDate;

    public Rating() {
    }

    public Rating(int ratingId, Food food, int foodId, String userName, User user, int rating, Date createDate) {
        this.ratingId = ratingId;
        this.food = food;
        this.foodId = foodId;
        this.userName = userName;
        this.user = user;
        this.rating = rating;
        this.createDate = createDate;
    }

    public int getRatingId() {
        return ratingId;
    }

    public void setRatingId(int ratingId) {
        this.ratingId = ratingId;
    }

    public Food getFood() {
        return food;
    }

    public void setFood(Food food) {
        this.food = food;
    }

    public int getFoodId() {
        return foodId;
    }

    public void setFoodId(int foodId) {
        this.foodId = foodId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
    
    
}
