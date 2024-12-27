<%-- 
    Document   : beranda
    Created on : 25 Dec 2024, 15.31.48
    Author     : Microsoft
--%>

<%@page import="java.io.File"%>
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
                    // Mendapatkan koneksi database
                    conn = Config.getkoneksi();

                    // Query untuk mengambil data film
                    String sql = "SELECT nama_film, durasi, rating FROM film";
                    ps = conn.prepareStatement(sql);
                    rs = ps.executeQuery();

                    // Iterasi hasil query dan menampilkan data film
                    while (rs.next()) {
                        String nama_film = rs.getString("nama_film");
                        int durasi = rs.getInt("durasi");
                        double rating = rs.getDouble("rating");
                        
                        String nama_gambar = nama_film.replaceAll(" ", "_") + ".jpeg";
            %>
                        <div class="film">
                            <img src="images/<%= nama_gambar %>" alt="<%= nama_film %>" class="film-image">
                            <div class="film-info">
                                <h3><%= nama_film %></h3>
                                <p>Durasi: <%= durasi %> menit</p>
                                <p>Rating: <%= rating %>/10</p>
                            </div>
                        </div>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
                    <p>Error: Tidak dapat memuat daftar film.</p>
            <%
                } finally {
                    // Menutup koneksi database
                    if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                    if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
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