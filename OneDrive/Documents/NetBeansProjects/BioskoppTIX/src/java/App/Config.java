/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package App;
import java.sql.Connection;
import java.sql.DriverManager;
/**
 *
 * @author Microsoft
 */
public class Config {
    public static Connection getkoneksi(){
        Connection con=null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/bioskopdb","root","");
        } catch (Exception e) {
            System.out.println(e);
        }
        return con;
    }
}