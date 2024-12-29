<%-- 
    Document   : pesantiket
    Created on : Dec 25, 2024, 5:02:02 PM
    Author     : gdrad
--%>

<%@page import="App.Config"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Pesan Tiket Film</title>
        <link rel="stylesheet" href="css/pesantiket.css"/>
        <style>
            #moviePoster {
                display: flex;
                justify-content: center;
                align-items: center;
                margin: 20px auto; /* Center the poster horizontally */
                flex-direction: column; /* Ensure vertical alignment for future content */
                text-align: center; /* Optional: Center text below the image */
            }
            #posterImage {
                max-width: 200px;
                max-height: 300px;
                border: 1px solid #ccc;
                padding: 5px;
                border-radius: 10px;
                object-fit: cover; /* Ensure image scales nicely */
            }

            .quantity-input {
                display: flex;
                align-items: center;
            }
            .quantity-input button {
                width: 40px; /* Lebar tombol */
                height: 40px; /* Tinggi tombol */
                display: flex;
                justify-content: center; /* Pusatkan secara horizontal */
                align-items: center; /* Pusatkan secara vertikal */
                font-size: 18px; /* Ukuran font untuk simbol */
                font-weight: bold;
                background-color: #007bff; /* Warna tombol */
                color: white; /* Warna teks */
                border: none;
                border-radius: 5px; /* Membuat tombol sedikit melengkung */
                cursor: pointer;
                margin: 0 5px; /* Spasi antara tombol dan input */
            }
            .quantity-input input {
                width: 100px; /* Lebar input lebih besar */
                text-align: center;
                margin: 0 5px;
                font-size: 16px;
                padding: 5px;
            }
            .quantity-input button:active {
                background-color: #0056b3; /* Warna tombol saat ditekan */
            }
            .warning {
                color: red;
                font-size: 14px;
                margin-top: 10px;
            }
        </style>
        <script>
            function updatePoster() {
                const select = document.getElementById('filmSelect');
                const selectedOption = select.options[select.selectedIndex];
                const posterUrl = selectedOption.getAttribute('data-poster');
                const posterImage = document.getElementById('posterImage');
                const moviePoster = document.getElementById('moviePoster');

                if (posterUrl && posterUrl !== "") {
                    posterImage.src = posterUrl; // Set URL gambar
                    moviePoster.style.display = "block"; // Tampilkan poster
                } else {
                    posterImage.src = ""; // Kosongkan gambar
                    moviePoster.style.display = "none"; // Sembunyikan poster
                }
            }

            function decrease() {
                const jumlah = document.getElementById('jumlah');
                const warning = document.getElementById('warning');
                if (jumlah.value > 1) {
                    jumlah.value = parseInt(jumlah.value) - 1;
                    warning.style.display = "none"; // Sembunyikan peringatan
                    updateTotal(); // Perbarui total harga
                }
            }

            function increase() {
                const jumlah = document.getElementById('jumlah');
                const warning = document.getElementById('warning');
                jumlah.value = parseInt(jumlah.value || 0) + 1;
                warning.style.display = "none"; // Sembunyikan peringatan
                updateTotal(); // Perbarui total harga
            }

            function validateInput(input) {
                const warning = document.getElementById('warning');
                if (input.value === "" || input.value < 1) {
                    input.value = ""; // Kosongkan nilai jika tidak valid
                    warning.style.display = "block"; // Tampilkan peringatan
                    updateTotal(); // Tetap perbarui total harga
                } else {
                    warning.style.display = "none"; // Sembunyikan peringatan
                    updateTotal();
                }
            }

            function updateTotal() {
                const jumlah = document.getElementById('jumlah').value || 0; // Default 0 jika kosong
                const harga = document.getElementById('harga').value;
                const totalHarga = document.getElementById('totalHarga');
                totalHarga.value = parseInt(jumlah) * parseInt(harga); // Hitung total harga
            }

            function validateForm(e) {
                const jumlah = document.getElementById('jumlah').value || 0; // Default 0 jika kosong
                const warning = document.getElementById('warning');
                if (parseInt(jumlah) < 1) {
                    warning.style.display = "block"; // Tampilkan peringatan
                    e.preventDefault(); // Hentikan submit form
                }
            }

            document.addEventListener('DOMContentLoaded', () => {
                updatePoster(); // Set poster awal
                updateTotal();  // Hitung total harga awal
            });
        </script>
    </head>
    <body>
        <h2>Form Pemesanan Tiket Film</h2>

        <%
            String jadwalTayang = "";
            int hargaTiket = 0;
            String idFilm = request.getParameter("film");
            String posterUrl = "";

            if (idFilm != null && !idFilm.isEmpty()) {
                try {
                    Connection conn = Config.getkoneksi();
                    String sql = "SELECT poster_url, jadwal_tayang, harga FROM film WHERE id_film = ?";
                    PreparedStatement pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, idFilm);
                    ResultSet rs = pstmt.executeQuery();

                    if (rs.next()) {
                        jadwalTayang = rs.getString("jadwal_tayang");
                        hargaTiket = rs.getInt("harga");
                        posterUrl = rs.getString("poster_url");
                    }
                    rs.close();
                    pstmt.close();
                    conn.close();
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                }
            }
        %>

        <!-- Form for film selection -->
        <form action="" method="GET">
            <div class="form-group">
                <label>Pilih Film:</label>
                <select name="film" id="filmSelect" required onchange="this.form.submit();">
                    <option value="">-- Pilih Film --</option>
                    <%
                        try {
                            Connection conn = Config.getkoneksi();
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT * FROM film");
                            while (rs.next()) {
                                String selected = request.getParameter("film") != null
                                        && request.getParameter("film").equals(rs.getString("id_film"))
                                        ? "selected" : "";
                                out.println("<option value='" + rs.getString("id_film") + "' "
                                        + "data-poster='" + rs.getString("poster_url") + "' "
                                        + selected + ">"
                                        + rs.getString("judul_film") + "</option>");
                            }
                            rs.close();
                            stmt.close();
                            conn.close();
                        } catch (Exception e) {
                            out.println("Error: " + e.getMessage());
                        }
                    %>
                </select>
            </div>
        </form>

        <!-- Movie poster display -->
        <div id="moviePoster" style="display: none;">
            <img id="posterImage" src="<%= posterUrl%>" alt="Movie Poster">
        </div>

        <!-- Ticket booking form -->
        <form action="" method="POST" onsubmit="validateForm(event)">
            <div class="form-group">
                <label>Jadwal Tayang:</label>
                <input type="text" name="jadwal" value="<%= jadwalTayang%>" readonly required>
            </div>

            <div class="form-group">
                <label>Harga Tiket:</label>
                <input type="number" id="harga" name="harga" value="<%= hargaTiket%>" readonly>
            </div>

            <div class="form-group">
                <label>Jumlah Tiket:</label>
                <div class="quantity-input">
                    <button type="button" onclick="decrease()">-</button>
                    <input type="number" 
                           name="jumlah" 
                           id="jumlah"
                           value="1"
                           oninput="validateInput(this)"
                           onkeypress="return event.charCode >= 48"
                           min="1">
                    <button type="button" onclick="increase()">+</button>
                </div>
                <div id="warning" class="warning" style="display: none;">Jumlah tiket harus lebih dari 0!</div>
            </div>

            <div class="form-group">
                <label>Total Harga:</label>
                <input type="number" id="totalHarga" name="total_harga" readonly>
            </div>

            <input type="hidden" name="film" value="<%= request.getParameter("film")%>">
            <input type="submit" name="pesan" value="Pesan Tiket" class="btn">
        </form>
        <!-- Booking data processing -->
        <%
            if (request.getMethod().equals("POST")) {
                try {
                    Connection conn = Config.getkoneksi();
                    String film = request.getParameter("film");
                    String jadwal = request.getParameter("jadwal");
                    int jumlah = Integer.parseInt(request.getParameter("jumlah"));
                    int harga = Integer.parseInt(request.getParameter("harga"));
                    int total = jumlah * harga;

                    PreparedStatement pst = conn.prepareStatement(
                            "INSERT INTO pesan_tiket (judul_film, jadwal_tayang, jumlah, harga, total) "
                            + "VALUES (?, ?, ?, ?, ?)"
                    );

                    PreparedStatement pstFilm = conn.prepareStatement("SELECT judul_film FROM film WHERE id_film = ?");
                    pstFilm.setString(1, film);
                    ResultSet rs = pstFilm.executeQuery();
                    if (rs.next()) {
                        String judul = rs.getString("judul_film");
                        pst.setString(1, judul);
                    } else {
                        throw new SQLException("Film dengan ID tersebut tidak ditemukan");
                    }

                    pst.setString(2, jadwal);
                    pst.setInt(3, jumlah);
                    pst.setInt(4, harga);
                    pst.setInt(5, total);

                    pst.executeUpdate();
                    out.println("<script>alert('Pemesanan tiket berhasil!');</script>");
                } catch (Exception e) {
                    out.println(e);
                }
            }
        %>

        <!-- Booking data display -->
        <h2>Data Pemesanan Tiket</h2>
        <table>
            <tr>
                <th>ID Tiket</th>
                <th>Judul Film</th>
                <th>Jadwal</th>
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
                <td><%= rs.getString("jadwal_tayang")%></td>
                <td><%= rs.getString("jumlah")%></td>
                <td>Rp <%= rs.getString("harga")%></td>
                <td>Rp <%= rs.getString("total")%></td>
                <td>
                    <form action="" method="POST" style="display:inline;">
                        <input type="hidden" name="id_tiket" value="<%= rs.getString("id_tiket")%>">
                        <input type="submit" name="hapus" value="Hapus" 
                               onclick="return confirm('Apakah Anda yakin ingin menghapus data ini?')">
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

        <!-- Delete processing -->
        <%
            if (request.getParameter("hapus") != null) {
                try {
                    String idTiket = request.getParameter("id_tiket");
                    Connection conn = Config.getkoneksi();
                    PreparedStatement pst = conn.prepareStatement("DELETE FROM pesan_tiket WHERE id_tiket = ?");
                    pst.setString(1, idTiket);

                    int rowsAffected = pst.executeUpdate();
                    if (rowsAffected > 0) {
                        out.println("<script>alert('Data berhasil dihapus!');</script>");
                        response.sendRedirect(request.getRequestURI());
                    } else {
                        out.println("<script>alert('Gagal menghapus data!');</script>");
                    }
                } catch (Exception e) {
                    out.println(e);
                }
            }
        %>
    </body>
</html>