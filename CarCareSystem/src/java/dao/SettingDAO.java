/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Setting;
import jakarta.servlet.ServletContext;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author GIGABYTE
 */
public class SettingDAO extends DBConnection {

    public List<Setting> getAllSettings() {
        List<Setting> list = new ArrayList<>();
        String sql = "SELECT * FROM [Setting]";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Setting s = new Setting();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setValue(rs.getString("value"));
                list.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countSettings() {
        String sql = "SELECT COUNT(*) FROM [Setting]";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Setting> getSettingsPaginated(int offset, int limit) {
        List<Setting> list = new ArrayList<>();
        String sql = "SELECT * FROM [Setting] ORDER BY id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, offset);
            ps.setInt(2, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Setting s = new Setting(rs.getInt("id"), rs.getString("name"), rs.getString("value"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Setting getSettingById(int id) {
        String sql = "SELECT * FROM [Setting] WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Setting s = new Setting();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setValue(rs.getString("value"));
                return s;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateSetting(Setting setting) {
        String sql = "UPDATE [Setting] SET value = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, setting.getValue());
            ps.setInt(2, setting.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Setting> searchSettings(String keyword) {
        List<Setting> list = new ArrayList<>();
        String sql = "SELECT * FROM [Setting] WHERE name LIKE ? OR value LIKE ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Setting(rs.getInt("id"), rs.getString("name"), rs.getString("value")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void reloadSettingMap(ServletContext context) {
        List<Setting> settings = getAllSettings();
        Map<String, String> settingMap = new HashMap<>();
        for (Setting s : settings) {
            settingMap.put(s.getName(), s.getValue());
        }
        context.setAttribute("settingMap", settingMap);
    }
}
