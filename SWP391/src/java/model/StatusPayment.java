/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import static model.StatusEnum.values;

/**
 *
 * @author Dell
 */
public enum StatusPayment {
    UNPAID(1, "Chưa thanh toán"),
    PAID(2, "Đã thanh toán"),
    NOTPAID(3, "Không thanh toán");
    
    public final Integer code;
    public final String description;
    
    StatusPayment(Integer code,
            String name
    ) {
        this.code = code;
        this.description = name;
    }
    
    public static StatusPayment findByCode(Integer code) {
        for (StatusPayment value : values()) {
            if (value.code.equals(code)) {
                return value;
            }
        }
        return StatusPayment.UNPAID;
    }
}
