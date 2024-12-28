<%-- 
    Document   : pesantiket
    Created on : Dec 25, 2024, 5:02:02 PM
    Author     : gdrad
--%>

<%@page import="App.Config"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="App.Config"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pesan Tiket Film</title>
        <link rel="stylesheet" href="css/desainpesantiket.css"/>
    </head>
    <body>
        <h2>Form Pemesanan Tiket Film</h2>

        <form action="" method="POST">
            <div class="form-group">
                <label>Pilih Film:</label>
                <select name="film" required>
                    <option value="">-- Pilih Film --</option>
                    <%
                        try {
                            Connection conn = Config.getkoneksi();
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT * FROM film");
                            while (rs.next()) {
                                out.println("<option value='" + rs.getString("id_film") + "'>"
                                        + rs.getString("judul_film") + "</option>");
                            }
                        } catch (Exception e) {
                            out.println(e);
                        }
                    %>
                </select>
            </div>

            <div class="form-group">
                <label>Tanggal Tonton:</label>
                <input type="date" name="tanggal" required>
            </div>

            <div class="form-group">
                <label>Waktu Tonton:</label>
                <select name="waktu" required>
                    <option value="">-- Pilih Waktu --</option>
                    <option value="10:00">10:00</option>
                    <option value="13:00">13:00</option>
                    <option value="16:00">16:00</option>
                    <option value="19:00">19:00</option>
                </select>
            </div>

            <div class="form-group">
                <label>Jumlah Tiket:</label>
                <div class="quantity-input">
                    <button type="button" onclick="decrease()">-</button>
                    <input type="number" 
                           name="jumlah" 
                           id="jumlah"
                           min="1" 
                           value="1"
                           required 
                           oninput="validateInput(this)">
                    <button type="button" onclick="increase()">+</button>
                </div>
                <span id="error-msg" style="color:red; display:none;">Jumlah tiket harus lebih dari 0</span>
            </div>

            <div class="form-group">
                <label>Harga Tiket:</label>
                <input type="number" name="harga" value="50000" readonly>
            </div>

            <div class="form-group">
                <label>Total Harga:</label>
                <input type="number" name="total_harga" readonly>
            </div>

            <input type="submit" name="pesan" value="Pesan Tiket" class="btn">
        </form>

        <script>
            function validateInput(input) {
                var value = parseInt(input.value);
                var errorMsg = document.getElementById('error-msg');
                var submitBtn = document.getElementById('submit-btn');
                var totalInput = document.getElementsByName('total_harga')[0];

                if (value < 1) {
                    errorMsg.style.display = 'block';
                    submitBtn.disabled = true;
                    totalInput.value = '0';
                } else {
                    errorMsg.style.display = 'none';
                    submitBtn.disabled = false;
                    hitungTotal();
                }
            }

            function hitungTotal() {
                var jumlah = document.getElementsByName('jumlah')[0].value;
                var harga = document.getElementsByName('harga')[0].value;
                var total = jumlah * harga;
                document.getElementsByName('total_harga')[0].value = total;
            }

            function increase() {
                var value = parseInt(document.getElementById('jumlah').value);
                value = isNaN(value) ? 0 : value;
                value++;
                document.getElementById('jumlah').value = value;
                hitungTotal();
            }

            function decrease() {
                var value = parseInt(document.getElementById('jumlah').value);
                value = isNaN(value) ? 0 : value;
                if (value > 1) {
                    value--;
                    document.getElementById('jumlah').value = value;
                    hitungTotal();
                }
            }
        </script> 
        <%
            if (request.getMethod().equals("POST")) {
                try {
                    Connection conn = Config.getkoneksi();
                    String film = request.getParameter("film");
                    String tanggal = request.getParameter("tanggal");
                    String waktu = request.getParameter("waktu");
                    int jumlah = Integer.parseInt(request.getParameter("jumlah"));
                    int harga = Integer.parseInt(request.getParameter("harga"));
                    int total = jumlah * harga;

                    PreparedStatement pst = conn.prepareStatement(
                            "INSERT INTO pesan_tiket (judul_film, tanggal, waktu, jumlah, harga, total) "
                            + "VALUES (?, ?, ?, ?, ?, ?)"
                    );

                    // Get film name from film table
                    Statement stmt = conn.createStatement();
                    PreparedStatement pstFilm = conn.prepareStatement("SELECT judul_film FROM film WHERE id_film = ?");
                    pstFilm.setString(1, film);
                    ResultSet rs = pstFilm.executeQuery();
                    if (rs.next()) {
                        String judul = rs.getString("judul_film");
                        pst.setString(1, judul);
                    } else {
                        throw new SQLException("Film dengan ID tersebut tidak ditemukan");
                    }

                    pst.setString(2, tanggal);
                    pst.setString(3, waktu);
                    pst.setInt(4, jumlah);
                    pst.setInt(5, harga);
                    pst.setInt(6, total);

                    pst.executeUpdate();
                    out.println("<script>alert('Pemesanan tiket berhasil!');</script>");
                } catch (Exception e) {
                    out.println(e);
                }
            }
        %>

        <h2>Data Pemesanan Tiket</h2>
        <table>
            <tr>
                <th>ID Tiket</th>
                <th>Judul Film</th>
                <th>Tanggal</th>
                <th>Waktu</th>
                <th>Jumlah</th>
                <th>Harga</th>
                <th>Total</th>
                <th>Aksi</th>
            </tr>
            <%
                try {
                    Connection conn = Config.getkoneksi();
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM pesan_tiket ORDER BY id_tiket DESC");
                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("id_tiket")%></td>
                <td><%= rs.getString("judul_film")%></td>
                <td><%= rs.getString("tanggal")%></td>
                <td><%= rs.getString("waktu")%></td>
                <td><%= rs.getString("jumlah")%></td>
                <td>Rp <%= rs.getString("harga")%></td>
                <td>Rp <%= rs.getString("total")%></td>
                <td>
                    <!-- Form untuk hapus data -->
                    <form action="" method="POST" style="display:inline;">
                        <input type="hidden" name="id_tiket" value="<%= rs.getString("id_tiket")%>">
                        <input type="submit" name="hapus" value="Hapus" onclick="return confirm('Apakah Anda yakin ingin menghapus data ini?')">
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println(e);
                }
            %>
        </table>

        <%
            // Logika untuk menghapus data
            if (request.getParameter("hapus") != null) {
                try {
                    String idTiket = request.getParameter("id_tiket");
                    Connection conn = Config.getkoneksi();
                    PreparedStatement pst = conn.prepareStatement("DELETE FROM pesan_tiket WHERE id_tiket = ?");
                    pst.setString(1, idTiket);

                    int rowsAffected = pst.executeUpdate();
                    if (rowsAffected > 0) {
                        out.println("<script>alert('Data berhasil dihapus!');</script>");
                        response.sendRedirect(request.getRequestURI()); // Reload halaman setelah penghapusan
                    } else {
                        out.println("<script>alert('Gagal menghapus data!');</script>");
                    }
                } catch (Exception e) {
                    out.println(e);
                }
            }
        %>

    </table>
</body>
</html>