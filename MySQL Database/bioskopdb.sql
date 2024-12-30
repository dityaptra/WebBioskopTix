-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 30, 2024 at 04:14 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bioskopdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `akun`
--

CREATE TABLE `akun` (
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `akun`
--

INSERT INTO `akun` (`username`, `password`) VALUES
('volatile', '12345');

-- --------------------------------------------------------

--
-- Table structure for table `daftar_film`
--

CREATE TABLE `daftar_film` (
  `id_film` varchar(50) NOT NULL,
  `nama_film` varchar(50) NOT NULL,
  `durasi` int(11) NOT NULL,
  `rating` double NOT NULL,
  `jadwal_tayang` date NOT NULL,
  `jam_tayang` time NOT NULL,
  `ruangan` varchar(50) NOT NULL,
  `harga` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `daftar_film`
--

INSERT INTO `daftar_film` (`id_film`, `nama_film`, `durasi`, `rating`, `jadwal_tayang`, `jam_tayang`, `ruangan`, `harga`) VALUES
('F001', 'Oppenheimer', 180, 7.3, '2025-01-09', '18:30:00', 'A', 50000),
('F002', 'Forrest Gump', 142, 8.8, '2025-01-04', '10:04:00', 'B', 67000),
('F003', 'The King\'s Man', 131, 6.3, '2025-02-21', '10:06:00', 'C', 60000),
('F004', 'Avatar: The Way of Water', 192, 7.5, '2025-03-14', '10:08:00', 'D', 90000),
('F005', 'Spider-Man: No Way Home', 148, 8.2, '2025-04-16', '10:15:00', 'E', 55000),
('F006', 'Transformers: Rise of the Beasts', 127, 6, '2025-05-22', '20:17:00', 'F', 70000);

-- --------------------------------------------------------

--
-- Table structure for table `film`
--

CREATE TABLE `film` (
  `id_film` varchar(50) NOT NULL,
  `judul_film` varchar(50) NOT NULL,
  `poster_url` varchar(70) NOT NULL,
  `durasi` int(100) NOT NULL,
  `rating` double NOT NULL,
  `jadwal_tayang` datetime DEFAULT NULL,
  `harga` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `film`
--

INSERT INTO `film` (`id_film`, `judul_film`, `poster_url`, `durasi`, `rating`, `jadwal_tayang`, `harga`) VALUES
('F001', 'Oppenheimer', 'images/Oppenheimer.jpeg', 180, 7.3, '2025-01-09 10:30:00', 60000),
('F002', 'Forrest Gump', 'images/Forrest_Gump.jpeg', 142, 8.8, '2025-02-13 17:00:00', 65000),
('F003', 'The King\'s Man', 'images/The_Kings_Man.jpeg', 131, 6.3, '2025-03-19 15:30:00', 80000),
('F004', 'Avatar: The Way of Water', 'images/Avatar_The_Way_of_Water.jpeg', 192, 7.5, '2025-05-04 20:30:00', 55000),
('F005', 'Spider-Man: No Way Home', 'images/Spider_Man_No_Way_Home.jpeg', 148, 8.2, '2025-04-01 10:30:00', 75000),
('F006', 'Transformers: Rise of the Beasts', 'images/Transformers_Rise_of_the_Beasts.jpg', 127, 6, '2025-03-01 21:00:00', 70000),
('F007', 'Sonic the Hedgehog 3', 'images/Sonic_the_Hedgehog_3.jpg', 110, 7.4, '2025-02-23 16:00:00', 85000),
('F008', 'Moana 2', 'images/Moana_2.jpg', 100, 6.9, '2025-05-23 15:00:00', 60000),
('F009', 'The Shawshank Redeption', 'images/The_Shawshank_Redeption.jpg', 142, 9.3, '2025-06-03 21:00:00', 85000),
('F010', 'WALL•E', 'images/WALL_E.jpg', 90, 8.4, '2025-06-27 16:00:00', 75000);

-- --------------------------------------------------------

--
-- Table structure for table `pesan_tiket`
--

CREATE TABLE `pesan_tiket` (
  `id_tiket` int(11) NOT NULL,
  `judul_film` varchar(100) NOT NULL,
  `jadwal_tayang` datetime NOT NULL,
  `jumlah` int(50) NOT NULL,
  `harga` int(11) NOT NULL,
  `total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pesan_tiket`
--

INSERT INTO `pesan_tiket` (`id_tiket`, `judul_film`, `jadwal_tayang`, `jumlah`, `harga`, `total`) VALUES
(56, 'Forrest Gump', '2025-02-13 17:00:00', 2, 65000, 130000),
(58, 'The Shawshank Redeption', '2025-06-03 21:00:00', 3, 85000, 255000);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `akun`
--
ALTER TABLE `akun`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `daftar_film`
--
ALTER TABLE `daftar_film`
  ADD PRIMARY KEY (`id_film`);

--
-- Indexes for table `film`
--
ALTER TABLE `film`
  ADD PRIMARY KEY (`id_film`);

--
-- Indexes for table `pesan_tiket`
--
ALTER TABLE `pesan_tiket`
  ADD PRIMARY KEY (`id_tiket`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pesan_tiket`
--
ALTER TABLE `pesan_tiket`
  MODIFY `id_tiket` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
