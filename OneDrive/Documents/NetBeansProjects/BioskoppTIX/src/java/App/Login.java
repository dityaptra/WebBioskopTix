/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package App;
import java.sql.*;

/**
 *
 * @author Microsoft
 */
public class Login {
    public static boolean validate(User gt) {
        boolean status = false;
        try {
            Connection conn=Config.getkoneksi();
            PreparedStatement ps=conn.prepareStatement("select * from akun where username=? AND password=?");
            ps.setString(1,gt.getUsername());
            ps.setString(2,gt.getPassword());
            ResultSet rs=ps.executeQuery();
            status=rs.next();
            System.out.println(gt.getPassword());
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
}