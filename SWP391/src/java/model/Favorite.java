/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author anhdo
 */
public class Favorite {
     private int wishid;
    private int foodId;
    private String userName;
    private String foodName;
    private String image;

    public Favorite() {
    }

    public Favorite(int wishid, int foodId, String userName, String foodName, String image) {
        this.wishid = wishid;
        this.foodId = foodId;
        this.userName = userName;
        this.foodName = foodName;
        this.image = image;
    }

    public int getWishid() {
        return wishid;
    }

    public void setWishid(int wishid) {
        this.wishid = wishid;
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

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
    
}
