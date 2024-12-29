<%@page import="App.Config"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BioskopTix</title>
        <link rel="stylesheet" href="css/beranda.css">
        <style>
            /* Gaya Umum Halaman */
            /* Gaya Umum Halaman */
            body {
                font-family: 'Arial', sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f0f8f8; /* Biru kehijauan lembut */
                color: #333;
            }

            header {
                text-align: center;
                padding: 20px;
                background: linear-gradient(45deg, #4db6ac, #2196f3); /* Gradien biru ke hijau */
                color: white;
            }

            header h1 {
                margin: 0;
                font-size: 36px;
            }

            /* Kontainer Konten */
            .content {
                max-width: 1200px;
                margin: 20px auto;
                padding: 20px;
                text-align: center;
            }

            .content h2 {
                font-size: 28px;
                color: #ffffff;
                background: linear-gradient(45deg, #4db6ac, #2196f3); /* Gradien biru-hijau */
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                text-align: center;
                margin-bottom: 20px;
            }

            /* Daftar Film */
            .films {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 15px;
                justify-items: center;
            }

            .film {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                width: 200px;
                transition: transform 0.3s, box-shadow 0.3s;
                cursor: pointer;
            }

            .film:hover {
                transform: translateY(-5px) scale(1.05);
                box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
                background: linear-gradient(45deg, #e0f7fa, #b2dfdb); /* Gradien lembut saat hover */
            }

            /* Gambar Film */
            .film img {
                width: 100%;
                height: 300px;
                object-fit: cover;
            }

            /* Informasi Film */
            .film-info {
                padding: 10px;
                text-align: center;
            }

            .film-info h3 {
                margin: 5px 0;
                font-size: 16px;
                background: linear-gradient(45deg, #4db6ac, #2196f3); /* Gradien biru-hijau */
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            .film-info p {
                margin: 3px 0;
                font-size: 12px;
                color: #555;
            }

            /* Tombol Pesan */
            .button-container {
                text-align: center;
                margin-top: 20px;
            }

            .button-container button {
                background: linear-gradient(45deg, #4db6ac, #2196f3); /* Gradien biru-hijau */
                color: white;
                border: none;
                padding: 15px 30px; /* Ukuran diperbesar */
                border-radius: 25px;
                cursor: pointer;
                font-size: 18px; /* Ukuran font diperbesar */
                transition: background-color 0.3s, transform 0.2s;
            }

            .button-container button:hover {
                background: linear-gradient(45deg, #2196f3, #4db6ac); /* Gradien terbalik saat hover */
                transform: translateY(-3px) scale(1.1); /* Tombol lebih besar */
            }

            .button-container button:active {
                background: linear-gradient(45deg, #00695c, #004d40); /* Gradien lebih gelap saat ditekan */
                transform: translateY(1px);
            }

            /* Responsif */
            @media (max-width: 768px) {
                .film img {
                    height: 250px;
                }

                .film {
                    width: 180px;
                }
            }
        </style>
    </head>
    <body>
        <header>
            <h1>BioskopTix</h1>
        </header>
        <div class="content">
            <h2>Daftar Film</h2>
            <div class="films">
                <%
                    Connection conn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;

                    try {
                        // Mendapatkan koneksi dari Config
                        conn = Config.getkoneksi();
                        if (conn == null) {
                            throw new Exception("Koneksi ke database gagal.");
                        }

                        // Query untuk mengambil data film
                        String sql = "SELECT judul_film, poster_url, durasi, rating, jadwal_tayang, harga FROM film";
                        ps = conn.prepareStatement(sql);
                        rs = ps.executeQuery();

                        // Iterasi hasil query dan menampilkan data film
                        while (rs.next()) {
                            String judulFilm = rs.getString("judul_film");
                            String posterUrl = rs.getString("poster_url");
                            int durasi = rs.getInt("durasi");
                            double rating = rs.getDouble("rating");
                            Timestamp jadwalTayang = rs.getTimestamp("jadwal_tayang");
                            int harga = rs.getInt("harga");
                %>
                <div class="film">
                    <img src="<%= posterUrl%>" alt="<%= judulFilm%>" class="film-image">
                    <div class="film-info">
                        <h3><%= judulFilm%></h3>
                        <p>Durasi: <%= durasi%> menit</p>
                        <p>Rating: <%= rating%>/10</p>
                        <p>Jadwal: <%= jadwalTayang%></p>
                        <p>Harga: Rp <%= harga%></p>
                    </div>
                </div>
                <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                %>
                <p>Error: Tidak dapat memuat daftar film. <br> Detail error: <%= e.getMessage()%></p>
                    <%
                        } finally {
                            // Menutup koneksi database
                            if (rs != null) try {
                                rs.close();
                            } catch (SQLException ignored) {
                            }
                            if (ps != null) try {
                                ps.close();
                            } catch (SQLException ignored) {
                            }
                            if (conn != null) try {
                                conn.close();
                            } catch (SQLException ignored) {
                            }
                        }
                    %>
            </div>
            <div class="button-container">
                <form action="pesantiket.jsp" method="get">
                    <button type="submit">Pesan Tiket</button>
                </form>
            </div>
        </div>
    </body>
</html>
