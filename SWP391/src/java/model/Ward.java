/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Dell
 */
public class Ward {

    private int wardId;
    private String wardName;
    private int isDeleted;
    private int districtId;
    private District district;

    public Ward() {
    }

    public Ward(int wardId, String wardName, int isDeleted, int districtId, District district) {
        this.wardId = wardId;
        this.wardName = wardName;
        this.isDeleted = isDeleted;
        this.districtId = districtId;
        this.district = district;
    }

    public int getWardId() {
        return wardId;
    }

    public void setWardId(int wardId) {
        this.wardId = wardId;
    }

    public String getWardName() {
        return wardName;
    }

    public void setWardName(String wardName) {
        this.wardName = wardName;
    }

    public int getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(int isDeleted) {
        this.isDeleted = isDeleted;
    }

    public int getDistrictId() {
        return districtId;
    }

    public void setDistrictId(int districtId) {
        this.districtId = districtId;
    }

    public District getDistrict() {
        return district;
    }

    public void setDistrict(District district) {
        this.district = district;
    }

    

    @Override
    public String toString() {
        return "Ward{"
                + "wardId=" + wardId
                + ", wardName='" + wardName + '\''
                + ", isDeleted=" + isDeleted
                + ", districtId=" + districtId
                + ", distric=" + district
                + '}';
    }

}
