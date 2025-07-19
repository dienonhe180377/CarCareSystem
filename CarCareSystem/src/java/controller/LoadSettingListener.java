/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.SettingDAO;
import entity.Setting;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author GIGABYTE
 */
@WebListener
public class LoadSettingListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        SettingDAO sDao = new SettingDAO();
        List<Setting> settings = sDao.getAllSettings();
        Map<String, String> settingMap = new HashMap<>();
        for (Setting s : settings) {
            settingMap.put(s.getName(), s.getValue());
        }
        sce.getServletContext().setAttribute("settingMap", settingMap);
    }
}
