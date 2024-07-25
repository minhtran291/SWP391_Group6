/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Dell
 */
public class District {

    
    private int districtId;
    private String districtName;
    private int districtDelete;

    public District() {
    }

    public District(int districtId, String districtName, int districtDelete) {
        this.districtId = districtId;
        this.districtName = districtName;
        this.districtDelete = districtDelete;
    }

    public int getDistrictId() {
        return districtId;
    }

    public void setDistrictId(int districtId) {
        this.districtId = districtId;
    }

    public String getDistrictName() {
        return districtName;
    }

    public void setDistrictName(String districtName) {
        this.districtName = districtName;
    }

    public int getDistrictDelete() {
        return districtDelete;
    }

    public void setDistrictDelete(int districtDelete) {
        this.districtDelete = districtDelete;
    }

    @Override
    public String toString() {
        return "District{"
                + "districtId=" + districtId
                + ", districtName='" + districtName + '\''
                + ", districtDelete=" + districtDelete
                + '}';
    }
}
