/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class Part {
    private int id;
    private String name;
    private String image;
    private ArrayList<Service> services;
    private Category category;
    private ArrayList<Supplier> suppliers;
    private ArrayList<Size> sizes;
    private double price;

    public Part(int id, String name, String image, ArrayList<Service> services, Category category, ArrayList<Supplier> suppliers, ArrayList<Size> sizes, double price) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.services = services;
        this.category = category;
        this.suppliers = suppliers;
        this.sizes = sizes;
        this.price = price;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public ArrayList<Service> getServices() {
        return services;
    }

    public void setServices(ArrayList<Service> services) {
        this.services = services;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public ArrayList<Supplier> getSuppliers() {
        return suppliers;
    }

    public void setSuppliers(ArrayList<Supplier> suppliers) {
        this.suppliers = suppliers;
    }

    public ArrayList<Size> getSizes() {
        return sizes;
    }

    public void setSizes(ArrayList<Size> sizes) {
        this.sizes = sizes;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "Part{" + "id=" + id + ", name=" + name + ", image=" + image + ", services=" + services + ", category=" + category + ", suppliers=" + suppliers + ", sizes=" + sizes + ", price=" + price + '}' + "\n";
    }

    

}
