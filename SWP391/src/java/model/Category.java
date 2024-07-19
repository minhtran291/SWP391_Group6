/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Dell
 */
public class Category {
    private int category_id;
    private String category_name;
    private int status;
    public Category() {
    }

    public Category(int category_id, String category_name) {
        this.category_id = category_id;
        this.category_name = category_name;
    }
    public Category(int category_id, String category_name,int status) {
        this.category_id = category_id;
        this.category_name = category_name;
        this.status = status;
    }

    public int getCategory_id() {
        return category_id;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

    public String getCategory_name() {
        return category_name;
    }

    public void setCategory_name(String category_name) {
        this.category_name = category_name;
    }
    
    
}
