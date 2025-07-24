package entity;

import java.util.ArrayList;

public class Service {
    private int id;
    private String name;
    private String description;
    private double price;
    private String img; // Thêm dòng này
    private ArrayList<Part> parts;

    public Service() {
        this.parts = new ArrayList<>();
    }

    // Constructor có img
    public Service(int id, String name, String description, double price, String img) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.img = img;
        this.parts = new ArrayList<>();
    }

    public Service(int id, String name, String description, double price) {
        this(id, name, description, price, "default.jpg");
    }

    public Service(int id, String name, double price) {
        this(id, name, null, price, "default.jpg");
    }

    // Constructor đầy đủ
    public Service(int id, String name, String description, double price, String img, ArrayList<Part> parts) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.img = img;
        this.parts = parts;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public ArrayList<Part> getParts() {
        return parts;
    }

    public void setParts(ArrayList<Part> parts) {
        this.parts = parts;
    }

    /**
     * Hàm này trả về tổng giá dịch vụ + tổng giá tất cả part liên quan.
     */
    public double getTotalPriceWithParts() {
        double total = this.price;
        if (parts != null) {
            for (Part p : parts) {
                total += p.getPrice();
            }
        }
        return total;
    }

    @Override
    public String toString() {
        return "Service{" + "id=" + id + ", name=" + name + ", description=" + description + ", price=" + price + ", img=" + img + ", parts=" + parts + '}';
    }
}
