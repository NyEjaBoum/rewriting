package com.rewriting.rewriting.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    private static final String URL = "jdbc:postgresql://"
            + env("DB_HOST", "localhost") + ":5432/"
            + env("DB_NAME", "rewriting");
    private static final String USER     = env("DB_USER",     "postgres");
    private static final String PASSWORD = env("DB_PASSWORD", "admin");

    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    private static String env(String key, String defaultValue) {
        String value = System.getenv(key);
        return (value != null && !value.isEmpty()) ? value : defaultValue;
    }
}
