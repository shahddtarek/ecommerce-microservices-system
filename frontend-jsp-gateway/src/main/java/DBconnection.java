package com.mycompany.project1.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBconnection {

    private static final String URL = "jdbc:mysql://localhost:3306/ecommerce_system";
    private static final String USER = "root";
    private static final String PASSWORD = "farida123@gmail.com";

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}

