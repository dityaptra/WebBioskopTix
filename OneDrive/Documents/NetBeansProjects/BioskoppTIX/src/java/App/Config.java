/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package App;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Class untuk mengatur koneksi ke database MySQL
 * @author Microsoft
 */
public class Config {
    private static final String URL = "jdbc:mysql://localhost:3306/bioskopdb";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    public static Connection getkoneksi() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Koneksi ke database berhasil!");
        } catch (ClassNotFoundException e) {
            System.out.println("Driver JDBC tidak ditemukan: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Koneksi database gagal: " + e.getMessage());
        }
        return con;
    }
}