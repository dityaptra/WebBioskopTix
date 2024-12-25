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
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pemesanan Tiket Bioskop</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group select, .form-group input {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        .form-group img {
            max-width: 200px;
            border: 2px solid #ccc;
            margin-top: 10px;
        }
        .actions {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }
        .btn {
            padding: 10px 15px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table th, table td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: center;
        }
        table th {
            background-color: #f0f0f0;
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
                    <option value="Oppenheimer">Oppenheimer</option>
                    <option value="Forrest Gump">Forrest Gump</option>
                    <option value="The King's Man">The King's Man</option>
                </select>
                <img id="filmImage" src="images/Oppenheimer.jpeg" alt="Film Image">
            </div>
            <div class="form-group">
                <label for="tanggal">Tanggal Tonton:</label>
                <input type="date" id="tanggal" name="tanggal" required>
            </div>
            <div class="form-group">
                <label for="waktu">Waktu Tonton:</label>
                <select id="waktu" name="waktu">
                    <option>10:00</option>
                    <option>12:00</option>
                    <option>14:00</option>
                </select>
            </div>
            <div class="form-group">
                <label for="jumlahTiket">Jumlah Tiket:</label>
                <input type="number" id="jumlahTiket" name="jumlahTiket" placeholder="Masukkan jumlah tiket" oninput="calculateTotal()" required>
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
                <button class="btn" type="submit">Pesan Tiket</button>
            </div>
        </form>

        <!-- Tabel untuk Menampilkan Tiket -->
        <table id="tiketTable">
            <thead>
                <tr>
                    <th>Film</th>
                    <th>Tanggal</th>
                    <th>Waktu</th>
                    <th>Jumlah Tiket</th>
                    <th>Total Harga</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    for (Map<String, String> tiket : tiketList) { 
                %>
                    <tr>
                        <td><%= tiket.get("film") %></td>
                        <td><%= tiket.get("tanggal") %></td>
                        <td><%= tiket.get("waktu") %></td>
                        <td><%= tiket.get("jumlahTiket") %></td>
                        <td><%= tiket.get("totalHarga") %></td>
                    </tr>
                <% 
                    } 
                %>
            </tbody>
        </table>
    </div>

    <script>
        const filmData = {
            "Oppenheimer": { harga: 50000, image: "images/Oppenheimer.jpeg" },
            "Forrest Gump": { harga: 45000, image: "images/ForrestGump.jpeg" },
            "The King's Man": { harga: 40000, image: "images/TheKingsMan.jpeg" }
        };

        function updateFilm() {
            const film = document.getElementById("film").value;
            document.getElementById("harga").value = filmData[film].harga;
            document.getElementById("filmImage").src = filmData[film].image;
        }

        function calculateTotal() {
            const harga = parseInt(document.getElementById("harga").value);
            const jumlah = parseInt(document.getElementById("jumlahTiket").value) || 0;
            document.getElementById("totalHarga").value = harga * jumlah;
        }
    </script>
</body>
</html>
