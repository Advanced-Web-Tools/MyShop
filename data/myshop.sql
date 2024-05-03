-- phpMyAdmin SQL Dump
-- version 5.2.1deb1ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 11, 2024 at 11:31 AM
-- Server version: 8.0.36-0ubuntu0.23.10.1
-- PHP Version: 8.2.10-2ubuntu1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `awt_development`
--

-- --------------------------------------------------------

--
-- Table structure for table `myshop_avaliable_cities`
--

CREATE TABLE IF NOT EXISTS `myshop_avaliable_cities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `country_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `country_id` (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `myshop_avaliable_countries`
--

CREATE TABLE IF NOT EXISTS `myshop_avaliable_countries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `myshop_cart`
--

CREATE TABLE IF NOT EXISTS `myshop_cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `myshop_cart_content`
--

CREATE TABLE IF NOT EXISTS `myshop_cart_content` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cart_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `cart_id` (`cart_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `myshop_categories`
--

CREATE TABLE IF NOT EXISTS `myshop_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `image_link` varchar(255) NOT NULL,
  `album_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `album_id` (`album_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `myshop_orders`
--

CREATE TABLE IF NOT EXISTS `myshop_orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cart_id` int NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(32) NOT NULL,
  `street` varchar(255) NOT NULL,
  `city` int NOT NULL,
  `country` int NOT NULL,
  `zip` int NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_id` (`cart_id`),
  KEY `city` (`city`,`country`),
  KEY `country` (`country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `myshop_products`
--

CREATE TABLE IF NOT EXISTS `myshop_products` (
  `id` int NOT NULL,
  `category_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `productshot` varchar(255) NOT NULL,
  `album_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `album_id` (`album_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `myshop_avaliable_cities`
--
ALTER TABLE `myshop_avaliable_cities`
  ADD CONSTRAINT `myshop_avaliable_cities_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `myshop_avaliable_countries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `myshop_cart_content`
--
ALTER TABLE `myshop_cart_content`
  ADD CONSTRAINT `myshop_cart_content_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `myshop_cart` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `myshop_cart_content_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `myshop_products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `myshop_categories`
--
ALTER TABLE `myshop_categories`
  ADD CONSTRAINT `myshop_categories_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `awt_albums` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `myshop_orders`
--
ALTER TABLE `myshop_orders`
  ADD CONSTRAINT `myshop_orders_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `myshop_cart` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `myshop_orders_ibfk_2` FOREIGN KEY (`country`) REFERENCES `myshop_avaliable_countries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `myshop_orders_ibfk_3` FOREIGN KEY (`city`) REFERENCES `myshop_avaliable_cities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `myshop_products`
--
ALTER TABLE `myshop_products`
  ADD CONSTRAINT `myshop_products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `myshop_categories` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `myshop_products_ibfk_2` FOREIGN KEY (`album_id`) REFERENCES `awt_albums` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
