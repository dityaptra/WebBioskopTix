/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package App;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/TiketServlet")
public class TiketServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private List<Map<String, String>> tiketList = new ArrayList<>();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Ambil data dari form
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            String idTiket = request.getParameter("idTiket");
            tiketList.removeIf(tiket -> tiket.get("idTiket").equals(idTiket));
        } else {
            String film = request.getParameter("film");
            String tanggal = request.getParameter("tanggal");
            String waktu = request.getParameter("waktu");
            String jumlahTiket = request.getParameter("jumlahTiket");
            String totalHarga = request.getParameter("totalHarga");

            // Generate ID Tiket
            String idTiket = UUID.randomUUID().toString().replace("-", "").substring(0, 8);

            // Simpan data tiket
            Map<String, String> tiket = new HashMap<>();
            tiket.put("idTiket", idTiket);
            tiket.put("film", film);
            tiket.put("tanggal", tanggal);
            tiket.put("waktu", waktu);
            tiket.put("jumlahTiket", jumlahTiket);
            tiket.put("totalHarga", totalHarga);

            tiketList.add(tiket);
        }

        String selectedFilm = request.getParameter("film");
        request.setAttribute("selectedFilm", selectedFilm);

        // Kirim data ke JSP
        request.setAttribute("tiketList", tiketList);
        request.getRequestDispatcher("pesantiket.jsp").forward(request, response);
    }
}
