/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utilities;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author kimbe
 */
public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/asset_management_db";
    private static final String USER = "root"; // or your DB username
    private static final String PASSWORD = "12345"; // or your DB password

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
