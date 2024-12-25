/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package App;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/TiketServlet")
public class TiketServlet extends HttpServlet {
    // List untuk menyimpan data tiket
    private final List<Map<String, String>> tiketList = new ArrayList<>();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Ambil data dari form
        String film = request.getParameter("film");
        String tanggal = request.getParameter("tanggal");
        String waktu = request.getParameter("waktu");
        String jumlahTiket = request.getParameter("jumlahTiket");
        String totalHarga = request.getParameter("totalHarga");

        // Simpan data ke dalam Map
        Map<String, String> tiket = new HashMap<>();
        tiket.put("film", film);
        tiket.put("tanggal", tanggal);
        tiket.put("waktu", waktu);
        tiket.put("jumlahTiket", jumlahTiket);
        tiket.put("totalHarga", totalHarga);

        // Tambahkan Map ke List
        synchronized (tiketList) {
            tiketList.add(tiket);
        }

        // Kirim data tiketList ke JSP
        request.setAttribute("tiketList", tiketList);

        // Redirect kembali ke halaman JSP
        request.getRequestDispatcher("pesantiket.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kirim data tiketList ke JSP saat halaman pertama kali dimuat
        request.setAttribute("tiketList", tiketList);
        request.getRequestDispatcher("pesantiket.jsp").forward(request, response);
    }
}
