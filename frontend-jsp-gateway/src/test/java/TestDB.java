package com.mycompany.project1.db;

import java.sql.Connection;

public class TestDB {
    public static void main(String[] args) {
        Connection conn = DBconnection.getConnection();
        if (conn != null) {
            System.out.println("Connection successful!");
        } else {
            System.out.println("Connection failed!");
        }
    }
}

