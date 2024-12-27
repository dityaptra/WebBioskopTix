<%-- 
    Document   : pesantiket
    Created on : Dec 25, 2024, 5:02:02 PM
    Author     : gdrad
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<%
    // Ambil data dari server (dikirim oleh Servlet)
    List<Map<String, String>> tiketList = (List<Map<String, String>>) request.getAttribute("tiketList");

    // Defaultkan tiketList jika null
    if (tiketList == null) {
        tiketList = new java.util.ArrayList<>();
    }
    
    // Ambil film terakhir yang dipilih dari atribut request
    String selectedFilm = (String) request.getAttribute("selectedFilm");
    if (selectedFilm == null) {
        selectedFilm = "Oppenheimer"; // Default film
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pemesanan Tiket Bioskop</title>
    <style>
    body {
        font-family: 'Roboto', sans-serif;
        background: linear-gradient(to right, #6a11cb, #2575fc);
        color: #333;
        margin: 0;
        padding: 0;
    }
    .container {
        max-width: 900px;
        margin: 30px auto;
        background: #ffffff;
        padding: 20px;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
    }
    h2 {
        text-align: center;
        color: #2575fc;
    }
    .form-group label {
        font-weight: 600;
        color: #444;
    }
    .form-group input, .form-group select {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 6px;
        margin-top: 5px;
        font-size: 14px;
    }
    .form-group img {
        width: 200px; /* Atur ukuran gambar */
        height: auto; /* Pertahankan aspek rasio */
        border-radius: 8px; /* Tambahkan sedikit sudut membulat */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Tambahkan bayangan */
        display: block; /* Membuat elemen gambar menjadi block */
        margin: 10px auto; /* Memposisikan di tengah */
    }

    .btn {
        padding: 10px 20px;
        background: #2575fc;
        color: #fff;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        transition: background 0.3s ease;
    }
    .btn:hover {
        background: #185abd;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    table th, table td {
        padding: 10px;
        border: 1px solid #ddd;
        text-align: left;
    }
    table th {
        background: #2575fc;
        color: #fff;
    }
    table tr:hover {
        background: rgba(37, 117, 252, 0.1);
    }
    .actions {
        display: flex;
        justify-content: space-between;
    }
    @media (max-width: 768px) {
        .form-group label, .form-group input, .form-group select {
            font-size: 12px;
        }
        .btn {
            padding: 8px 15px;
            font-size: 12px;
        }
    }
</style>

</head>
<body>
    <div class="container">
        <h2>Pemesanan Tiket Bioskop</h2>

        <!-- Form untuk Pesan Tiket -->
        <form action="TiketServlet" method="post">
            <div class="form-group">
                <label for="film">Pilih Film:</label>
                <select id="film" name="film" onchange="updateFilm()">
                    <option value="Oppenheimer" <%= "Oppenheimer".equals(selectedFilm) ? "selected" : "" %>>Oppenheimer</option>
                    <option value="Forrest Gump" <%= "Forrest Gump".equals(selectedFilm) ? "selected" : "" %>>Forrest Gump</option>
                    <option value="The King's Man" <%= "The King's Man".equals(selectedFilm) ? "selected" : "" %>>The King's Man</option>
                    <option value="Avatar: The Way of Water" <%= "Avatar: The Way of Water".equals(selectedFilm) ? "selected" : "" %>>Avatar: The Way of Water</option>
                    <option value="Spider-Man: No Way Home" <%= "Spider-Man: No Way Home".equals(selectedFilm) ? "selected" : "" %>>Spider-Man: No Way Home</option>
                    <option value="Transformers: Rise of the Beasts" <%= "Transformers: Rise of the Beasts".equals(selectedFilm) ? "selected" : "" %>>Transformers: Rise of the Beasts</option>
                </select>
                <img id="filmImage" src="images/<%= selectedFilm.replaceAll(" ", "%20") %>.jpeg" alt="Film Image">
            </div>
            <div class="form-group">
                <label for="tanggal">Tanggal Tonton:</label>
                <input type="text" id="tanggal" name="tanggal" readonly>
            </div>
            <div class="form-group">
                <label for="waktu">Waktu Tonton:</label>
                <input type="text" id="waktu" name="waktu" readonly>
            </div>
            <div class="form-group">
                <label for="jumlahTiket">Jumlah Tiket:</label>
                <input type="number" id="jumlahTiket" name="jumlahTiket" placeholder="Masukkan jumlah tiket" oninput="calculateTotal()" required min="1">
            </div>
            <div class="form-group">
                <label for="harga">Harga:</label>
                <input type="text" id="harga" name="harga" value="50000" readonly>
            </div>
            <div class="form-group">
                <label for="totalHarga">Total Harga:</label>
                <input type="text" id="totalHarga" name="totalHarga" readonly>
            </div>
            <div class="actions">
                <button class="btn" type="submit">Beli Tiket</button>
            </div>
        </form>

        <!-- Tabel untuk Menampilkan Tiket -->
        <!-- Tabel untuk Menampilkan Tiket -->
<table id="tiketTable">
    <thead>
        <tr>
            <th>ID Tiket</th>
            <th>Film</th>
            <th>Tanggal</th>
            <th>Waktu</th>
            <th>Jumlah Tiket</th>
            <th>Total Harga</th>
            <th>Aksi</th>
        </tr>
    </thead>
    <tbody>
        <% 
            for (Map<String, String> tiket : tiketList) { 
        %>
            <tr>
                <td><%= tiket.get("idTiket") %></td>
                <td><%= tiket.get("film") %></td>
                <td><%= tiket.get("tanggal") %></td>
                <td><%= tiket.get("waktu") %></td>
                <td><%= tiket.get("jumlahTiket") %></td>
                <td><%= tiket.get("totalHarga") %></td>
                <td>
                    <form action="TiketServlet" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="idTiket" value="<%= tiket.get("idTiket") %>">
                        <button type="submit" class="btn">Hapus</button>
                    </form>
                </td>
            </tr>
        <% 
            } 
        %>
    </tbody>
</table>

    </div>

    <script>
    const filmData = {
        "Oppenheimer": {
            harga: 50000,
            image: "images/Oppenheimer.jpeg",
            tanggal: "2024-12-27",
            waktu: "10:00"
        },
        "Forrest Gump": {
            harga: 45000,
            image: "images/Forrest_Gump.jpeg",
            tanggal: "2024-12-29",
            waktu: "12:00"
        },
        "The King's Man": {
            harga: 40000,
            image: "images/The_King's_Man.jpeg",
            tanggal: "2024-12-31",
            waktu: "14:00"
        },
        "Avatar: The Way of Water": {
            harga: 60000,
            image: "images/Avatar_The_Way_of_Water.jpeg",
            tanggal: "2024-12-28",
            waktu: "16:00"
        },
        "Spider-Man: No Way Home": {
            harga: 75000,
            image: "images/Spider_Man_No_Way_Home.jpeg",
            tanggal: "2024-12-30",
            waktu: "18:00"
        },
        "Transformers: Rise of the Beasts": {
            harga: 70000,
            image: "images/Transformers_Rise_of_the_Beasts.jpeg",
            tanggal: "2025-01-01",
            waktu: "20:00"
        }
    };

    function updateFilm() {
        const film = document.getElementById("film").value;
        const filmInfo = filmData[film];

        if (filmInfo) {
            // Update harga dan gambar
            document.getElementById("harga").value = filmInfo.harga;
            document.getElementById("filmImage").src = filmInfo.image;
            document.getElementById("filmImage").alt = film;

            // Update tanggal dan waktu
            document.getElementById("tanggal").value = filmInfo.tanggal;
            document.getElementById("waktu").value = filmInfo.waktu;
        } else {
            // Handle jika data film tidak ditemukan
            document.getElementById("filmImage").src = "";
            document.getElementById("filmImage").alt = "Image not found";
        }
    }

    function calculateTotal() {
        const harga = parseInt(document.getElementById("harga").value);
        const jumlah = parseInt(document.getElementById("jumlahTiket").value) || 0;
        document.getElementById("totalHarga").value = harga * jumlah;
    }

    // Initial update saat halaman pertama kali dimuat
    updateFilm();
</script>

</body>
</html>