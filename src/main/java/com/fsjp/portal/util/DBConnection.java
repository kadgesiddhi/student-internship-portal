package com.fsjp.portal.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = System.getenv().getOrDefault(
            "DB_URL",
            "jdbc:mysql://localhost:3306/student_internship_portal?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC"
    );
    private static final String USER = System.getenv("DB_USERNAME");
    private static final String PASSWORD = System.getenv("DB_PASSWORD");

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found.", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        if (USER == null || USER.isBlank() || PASSWORD == null) {
            throw new SQLException(
                    "Missing MySQL database credentials. Set DB_USERNAME and DB_PASSWORD environment variables before starting the app."
            );
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
