/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author ADMIN
 */
public class PartService {
    private int id, serviceId, partId;

    public PartService() {
    }

    public PartService(int id, int serviceId, int partId) {
        this.id = id;
        this.serviceId = serviceId;
        this.partId = partId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public int getPartId() {
        return partId;
    }

    public void setPartId(int partId) {
        this.partId = partId;
    }

    @Override
    public String toString() {
        return "PartService{" + "id=" + id + ", serviceId=" + serviceId + ", partId=" + partId + '}';
    }
    
    
}
