<%-- 
    Document   : pesantiket2
    Created on : Dec 28, 2024, 4:09:06 PM
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
            /* Previous styles remain the same */
            .seat-selection {
                display: grid;
                grid-template-columns: repeat(8, 1fr);
                gap: 10px;
                margin: 15px 0;
            }
            .seat {
                padding: 8px;
                text-align: center;
                background: #eee;
                border: 1px solid #ddd;
                border-radius: 4px;
                cursor: pointer;
            }
            .seat.selected {
                background: #2575fc;
                color: white;
            }
            .seat.disabled {
                background: #ccc;
                cursor: not-allowed;
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
                        <option value="Oppenheimer" <%= "Oppenheimer".equals(selectedFilm) ? "selected" : ""%>>Oppenheimer</option>
                        <option value="Forrest Gump" <%= "Forrest Gump".equals(selectedFilm) ? "selected" : ""%>>Forrest Gump</option>
                        <option value="The King's Man" <%= "The King's Man".equals(selectedFilm) ? "selected" : ""%>>The King's Man</option>
                        <option value="Avatar: The Way of Water" <%= "Avatar: The Way of Water".equals(selectedFilm) ? "selected" : ""%>>Avatar: The Way of Water</option>
                        <option value="Spider-Man: No Way Home" <%= "Spider-Man: No Way Home".equals(selectedFilm) ? "selected" : ""%>>Spider-Man: No Way Home</option>
                        <option value="Transformers: Rise of the Beasts" <%= "Transformers: Rise of the Beasts".equals(selectedFilm) ? "selected" : ""%>>Transformers: Rise of the Beasts</option>
                    </select>
                    <img id="filmImage" src="images/<%= selectedFilm.replaceAll(" ", "%20")%>.jpeg" alt="Film Image">
                </div>
                <div class="form-group">
                    <label for="tanggal">Tanggal Tonton:</label>
                    <input type="text" id="tanggal" name="tanggal" readonly>
                </div>
                <div class="form-group">
                    <label for="waktu">Waktu Tonton:</label>
                    <input type="text" id="waktu" name="waktu" readonly>
                </div>
                <!-- Tambahan form ruangan -->
                <div class="form-group">
                    <label for="ruangan">Ruangan:</label>
                    <select id="ruangan" name="ruangan">
                        <option value="Studio 1">Studio 1</option>
                        <option value="Studio 2">Studio 2</option>
                        <option value="Studio 3">Studio 3</option>
                        <option value="IMAX">IMAX</option>
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
                               oninput="updateSeats(); validateInput(this)">
                        <button type="button" onclick="increase()">+</button>
                    </div>
                    <span id="error-msg" style="color:red; display:none;">Jumlah tiket harus lebih dari 0</span>
                </div>

                <div class="form-group">
                    <label>Pilih Kursi:</label>
                    <div id="seat-container">
                        <!-- Kursi akan di-generate berdasarkan jumlah tiket -->
                    </div>
                </div>



                <!-- Tambahan form kursi -->
                <div class="form-group">
                    <label for="kursi">Pilih Kursi:</label>
                    <input type="hidden" id="selectedSeats" name="selectedSeats">
                    <div class="seat-selection" id="seatContainer">
                        <!-- Seats will be generated by JavaScript -->
                    </div>
                </div>
                <div class="form-group">
                    <label for="harga">Harga Satuan:</label>
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
            <table id="tiketTable">
                <thead>
                    <tr>
                        <th>ID Tiket</th>
                        <th>Film</th>
                        <th>Tanggal</th>
                        <th>Waktu</th>
                        <th>Ruangan</th>
                        <th>Kursi</th>
                        <th>Jumlah Tiket</th>
                        <th>Harga Satuan</th>
                        <th>Total Harga</th>
                        <th>Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Map<String, String> tiket : tiketList) {
                    %>
                    <tr>
                        <td><%= tiket.get("idTiket")%></td>
                        <td><%= tiket.get("film")%></td>
                        <td><%= tiket.get("tanggal")%></td>
                        <td><%= tiket.get("waktu")%></td>
                        <td><%= tiket.get("ruangan")%></td>
                        <td><%= tiket.get("kursi")%></td>
                        <td><%= tiket.get("jumlahTiket")%></td>
                        <td><%= tiket.get("harga")%></td>
                        <td><%= tiket.get("totalHarga")%></td>
                        <td>
                            <form action="TiketServlet" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="idTiket" value="<%= tiket.get("idTiket")%>">
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
            // Previous filmData object remains the same
            function decrease() {
                const input = document.getElementById('jumlah');
                if (input.value > 1) {
                    input.value = parseInt(input.value) - 1;
                    updateSeats();
                }
            }

            function increase() {
                const input = document.getElementById('jumlah');
                input.value = parseInt(input.value) + 1;
                updateSeats();
            }
            function validateInput(input) {
                const errorMsg = document.getElementById('error-msg');
                if (input.value < 1) {
                    errorMsg.style.display = 'block';
                } else {
                    errorMsg.style.display = 'none';
                }
            }

            function updateFilm() {
                const film = document.getElementById("film").value;
                const filmInfo = filmData[film];

                if (filmInfo) {
                    document.getElementById("harga").value = filmInfo.harga;
                    document.getElementById("filmImage").src = filmInfo.image;
                    document.getElementById("filmImage").alt = film;
                    document.getElementById("tanggal").value = filmInfo.tanggal;
                    document.getElementById("waktu").value = filmInfo.waktu;
                    calculateTotal();
                }
            }

            function calculateTotal() {
                const harga = parseInt(document.getElementById("harga").value);
                const jumlah = parseInt(document.getElementById("jumlahTiket").value) || 0;
                document.getElementById("totalHarga").value = harga * jumlah;
            }

            function updateSeats() {
                const container = document.getElementById("seatContainer");
                const jumlahTiket = parseInt(document.getElementById("jumlahTiket").value) || 0;
                const selectedSeats = [];

                // Clear previous seats
                container.innerHTML = '';

                // Generate 64 seats (8x8 grid)
                for (let i = 1; i <= 64; i++) {
                    const seat = document.createElement("div");
                    seat.className = "seat";
                    seat.textContent = i;
                    seat.onclick = function () {
                        if (!seat.classList.contains('disabled')) {
                            seat.classList.toggle('selected');
                            updateSelectedSeats();
                        }
                    }
                    container.appendChild(seat);
                }

                function updateSelectedSeats() {
                    const selected = document.querySelectorAll('.seat.selected');
                    if (selected.length > jumlahTiket) {
                        selected[selected.length - 1].classList.remove('selected');
                    }
                    const selectedSeats = Array.from(document.querySelectorAll('.seat.selected'))
                            .map(seat => seat.textContent)
                            .join(', ');
                    document.getElementById('selectedSeats').value = selectedSeats;
                }
            }

            // Initial updates
            updateFilm();
            updateSeats();
        </script>
    </body>
</html>