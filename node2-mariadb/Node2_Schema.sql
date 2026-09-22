-- ==========================================
-- NODE 2: MARIADB SCHEMA (DDL)
-- ==========================================

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;

DROP TABLE IF EXISTS `builds`;
CREATE TABLE `builds` (
  `build_id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` int(11) NOT NULL,
  `version_code` varchar(20) NOT NULL,
  `file_size_mb` int(11) DEFAULT NULL,
  `uploaded_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`build_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `games_v2`;
CREATE TABLE `games_v2` (
  `game_id` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  PRIMARY KEY (`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `library`;
CREATE TABLE `library` (
  `user_id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  `purchase_date` datetime DEFAULT current_timestamp(),
  `playtime_hours` decimal(10,1) DEFAULT 0.0,
  PRIMARY KEY (`user_id`,`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `library_indo`;
CREATE TABLE `library_indo` (
  `user_id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  `purchase_date` datetime DEFAULT current_timestamp(),
  `playtime_hours` decimal(10,1) DEFAULT 0.0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `library_indonesia`;
CREATE TABLE `library_indonesia` (
  `user_id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  `purchase_date` datetime DEFAULT current_timestamp(),
  `playtime_hours` decimal(10,1) DEFAULT 0.0,
  PRIMARY KEY (`user_id`,`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `library_usa`;
CREATE TABLE `library_usa` (
  `user_id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  `purchase_date` datetime DEFAULT current_timestamp(),
  `playtime_hours` decimal(10,1) DEFAULT 0.0,
  PRIMARY KEY (`user_id`,`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `wishlists`;
CREATE TABLE `wishlists` (
  `user_id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  `added_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`,`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `wishlists_indonesia`;
CREATE TABLE `wishlists_indonesia` (
  `user_id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  `added_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`,`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `wishlists_usa`;
CREATE TABLE `wishlists_usa` (
  `user_id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  `added_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`,`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ------------------------------------------------------
-- FEDERATED CONNECT TABLES (JEMBATAN KE NODE 1)
-- ------------------------------------------------------

DROP TABLE IF EXISTS `developer_members_remote`;
CREATE TABLE `developer_members_remote` (
  `user_id` int(11) DEFAULT NULL,
  `dev_id` int(11) DEFAULT NULL,
  `joined_at` date DEFAULT NULL
) ENGINE=CONNECT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci CONNECTION='DSN=PostgreSQL-Windows;' `TABLE_TYPE`=ODBC `TABNAME`='developer_members';

DROP TABLE IF EXISTS `developers_remote`;
CREATE TABLE `developers_remote` (
  `dev_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL
) ENGINE=CONNECT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci CONNECTION='DSN=PostgreSQL-Windows;' `TABLE_TYPE`=ODBC `TABNAME`='developers';

DROP TABLE IF EXISTS `game_developers_remote`;
CREATE TABLE `game_developers_remote` (
  `game_id` int(11) DEFAULT NULL,
  `dev_id` int(11) DEFAULT NULL
) ENGINE=CONNECT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci CONNECTION='DSN=PostgreSQL-Windows;' `TABLE_TYPE`=ODBC `TABNAME`='game_developers';

DROP TABLE IF EXISTS `game_tags_remote`;
CREATE TABLE `game_tags_remote` (
  `game_id` int(11) DEFAULT NULL,
  `tag_name` varchar(30) DEFAULT NULL
) ENGINE=CONNECT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci CONNECTION='DSN=PostgreSQL-Windows;' `TABLE_TYPE`=ODBC `TABNAME`='game_tags';

DROP TABLE IF EXISTS `games_remote`;
CREATE TABLE `games_remote` (
  `game_id` int(11) DEFAULT NULL,
  `title` varchar(150) DEFAULT NULL,
  `description` varchar(10000) DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=CONNECT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci CONNECTION='DSN=PostgreSQL-Windows;' `TABLE_TYPE`=ODBC `TABNAME`='games';

DROP TABLE IF EXISTS `games_v1_remote`;
CREATE TABLE `games_v1_remote` (
  `game_id` int(11) DEFAULT NULL,
  `title` varchar(150) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL
) ENGINE=CONNECT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci CONNECTION='Driver=PostgreSQL Unicode;Server=192.168.56.1;Port=5433;Database=digadi_node1;Uid=postgres;Pwd=postgres;' `TABLE_TYPE`=ODBC `TABNAME`='games_v1';

DROP TABLE IF EXISTS `games_v2_remote`;
CREATE TABLE `games_v2_remote` (
  `game_id` int(11) DEFAULT NULL,
  `description` varchar(10000) DEFAULT NULL,
  `release_date` date DEFAULT NULL
) ENGINE=CONNECT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci CONNECTION='Driver=PostgreSQL Unicode;Server=192.168.56.1;Port=5433;Database=digadi_node1;Uid=postgres;Pwd=postgres;' `TABLE_TYPE`=ODBC `TABNAME`='games_v2';

DROP TABLE IF EXISTS `users_remote`;
CREATE TABLE `users_remote` (
  `user_id` int(11) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=CONNECT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci CONNECTION='DSN=PostgreSQL-Windows;' `TABLE_TYPE`=ODBC `TABNAME`='users';

-- ------------------------------------------------------
-- TABEL HASIL TRANSPARANSI (PENGGABUNGAN REAL-TIME)
-- ------------------------------------------------------

DROP TABLE IF EXISTS `games_utuh`;
CREATE TABLE `games_utuh` (
  `game_id` int(11) DEFAULT NULL,
  `title` varchar(150) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `description` varchar(10000) DEFAULT NULL,
  `release_date` date DEFAULT NULL
) ENGINE=CONNECT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci CONNECTION='mysql://penghubung:buka_pintu@127.0.0.1/digadi_node2' `TABLE_TYPE`=MYSQL `SRCDEF`='SELECT v1.game_id, v1.title, v1.price, v1.status, v2.description, v2.release_date FROM games_v1_remote v1 JOIN games_v2 v2 ON v1.game_id = v2.game_id';