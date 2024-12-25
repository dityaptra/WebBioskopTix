<%-- 
    Document   : index
    Created on : Dec 25, 2024, 4:59:23 PM
    Author     : gdrad
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BioskopTix</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
            text-align: center;
            background-color: #f4f4f4;
        }
        header {
            padding: 20px;
            background-color: #333;
            color: white;
        }
        header h1 {
            margin: 0;
            font-size: 36px;
        }
        .content {
            margin: 20px auto;
            max-width: 1200px;
        }
        .content h2 {
            margin-bottom: 20px;
            font-size: 24px;
        }
        .films {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
        }
        .film {
            border: 1px solid #ddd;
            padding: 10px;
            margin: 10px;
            width: 200px;
            text-align: center;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .film:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }
        .film img {
            max-width: 100%;
            height: auto;
            display: block;
            margin: 0 auto 10px;
            border-radius: 5px;
        }
        .film-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .button-container {
            margin: 20px 0;
        }
        .button-container button {
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            color: white;
            background-color: #007BFF;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.2s ease;
        }
        .button-container button:hover {
            background-color: #0056b3;
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
            <div class="film">
                <img src="images/Oppenheimer.jpeg" alt="Oppenheimer">
                <div class="film-title">Oppenheimer</div>
            </div>
            <div class="film">
                <img src="images/Forrest Gump.jpeg" alt="Forrest Gump">
                <div class="film-title">Forrest Gump</div>
            </div>
            <div class="film">
                <img src="images/The King's Man.jpeg" alt="The King's Man">
                <div class="film-title">The King's Man</div>
            </div>
        </div>
        <div class="button-container">
            <button onclick="pesantiket()">Pesan Tiket</button>
        </div>
    </div>
    <script>
        function pesantiket() {
            // Arahkan ke laman "pesantiket.html"
            window.location.href = 'pesantiket.jsp';
        }
    </script>
</body>
</html>