/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Dell
 */
public enum StatusEnum {
    UNPENDING(1, "Chưa xử lý"),
    PENDING(2, "Đang xử lý"),
    SHIPPING(3, "Đang giao hàng"),
    DELIVERED(4, "Đã giao hàng"),
    CANCELED(5, "Đã hủy"),;
    
    public final Integer code;
    public final String description;
    
    StatusEnum(Integer code,
            String name
    ) {
        this.code = code;
        this.description = name;
    }
    
    public static StatusEnum findByCode(Integer code) {
        for (StatusEnum value : values()) {
            if (value.code.equals(code)) {
                return value;
            }
        }
        return StatusEnum.CANCELED;
    }
}
