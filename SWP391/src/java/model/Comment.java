/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalTime;
import java.util.Date;

/**
 *
 * @author anhdo
 */
public class Comment {
    private int commentId;
    private FoodDetail foodId;
    private User userName;
    private String commentText;
    private Date createDate;
    private Food foodName;

    public Comment() {
    }

    public Comment(int commentId, FoodDetail foodId, User userName, String commentText, Date createDate) {
        this.commentId = commentId;
        this.foodId = foodId;
        this.userName = userName;
        this.commentText = commentText;
        this.createDate = createDate;
    }

    public Comment(int commentId, FoodDetail foodId, User userName, String commentText, Date createDate, Food foodName) {
        this.commentId = commentId;
        this.foodId = foodId;
        this.userName = userName;
        this.commentText = commentText;
        this.createDate = createDate;
        this.foodName = foodName;
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public FoodDetail getFoodId() {
        return foodId;
    }

    public void setFoodId(FoodDetail foodId) {
        this.foodId = foodId;
    }

    public User getUserName() {
        return userName;
    }

    public void setUserName(User userName) {
        this.userName = userName;
    }

    public String getCommentText() {
        return commentText;
    }

    public void setCommentText(String commentText) {
        this.commentText = commentText;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Food getFoodName() {
        return foodName;
    }

    public void setFoodName(Food foodName) {
        this.foodName = foodName;
    }

    
}
