-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: ecommerce_system
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `loyalty_points` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Ahmed Hassan','ahmed@example.com','01012345678',1017,'2025-11-25 11:52:19'),(2,'Sara Mohamed','sara@example.com','01098765432',528,'2025-11-25 11:52:19'),(3,'Omar Ali','omar@example.com','01055555555',332,'2025-11-25 11:52:19');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(100) NOT NULL,
  `quantity_available` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `last_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (1,'Laptop',48,999.99,'2025-11-25 11:51:59'),(2,'Mouse',195,29.99,'2025-11-25 11:51:59'),(3,'Keyboard',146,79.99,'2025-11-25 11:51:59'),(4,'Monitor',70,299.99,'2025-11-25 11:51:59'),(5,'Headphones',96,149.99,'2025-11-25 11:51:59');
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_log`
--

DROP TABLE IF EXISTS `notification_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_log` (
  `notification_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `notification_type` varchar(50) DEFAULT NULL,
  `message` text,
  `sent_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`notification_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_log`
--

LOCK TABLES `notification_log` WRITE;
/*!40000 ALTER TABLE `notification_log` DISABLE KEYS */;
INSERT INTO `notification_log` VALUES (1,1,1,'EMAIL','Order #1 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-24 22:12:41'),(2,1,1,'EMAIL','Order #1 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-25 13:41:58'),(3,1,1,'EMAIL','Order #1 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-25 13:50:07'),(4,1,1,'EMAIL','Order #1 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-26 05:10:03'),(5,1,1,'EMAIL','Order #1 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-26 05:11:50'),(6,1,1,'EMAIL','Order #1 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-26 05:57:22'),(7,1,1,'EMAIL','Order #1 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-26 06:07:52'),(8,5,1,'EMAIL','Order #5 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-26 09:18:06'),(9,6,1,'EMAIL','Order #6 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-26 09:23:37'),(10,7,1,'EMAIL','Order #7 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-26 09:23:45'),(11,8,1,'EMAIL','Order #8 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-26 09:23:47'),(12,9,1,'EMAIL','Order #9 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-26 16:14:13'),(13,10,1,'EMAIL','Order #10 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-26 16:19:45'),(14,11,1,'EMAIL','Order #11 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-26 16:25:30'),(15,12,1,'EMAIL','Order #12 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-26 16:26:36'),(16,13,2,'EMAIL','Order #13 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-27 21:11:43'),(17,14,3,'EMAIL','Order #14 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-27 21:12:44'),(18,15,3,'EMAIL','Order #15 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-27 22:58:25'),(19,16,2,'EMAIL','Order #16 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-27 23:12:31'),(20,17,2,'EMAIL','Order #17 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-27 23:22:56'),(21,18,3,'EMAIL','Order #18 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-27 23:38:25'),(22,19,2,'EMAIL','Order #19 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-27 23:42:32'),(23,20,2,'EMAIL','Order #20 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-28 00:14:26'),(24,21,3,'EMAIL','Order #21 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-28 02:35:48'),(25,22,2,'EMAIL','Order #22 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-28 02:38:44'),(26,23,2,'EMAIL','Order #23 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-28 02:40:25'),(27,24,1,'EMAIL','Order #24 confirmed.\nProduct: Laptop\nEstimated Delivery: 3 days','2025-12-28 02:44:13'),(28,25,1,'EMAIL','Product: Laptop\nEstimated Delivery: 3 days','2025-12-28 14:50:18'),(29,25,1,'EMAIL','Product: Laptop\nEstimated Delivery: 3 days','2025-12-28 14:50:24'),(30,26,3,'EMAIL','Product: Laptop\nEstimated Delivery: 3 days','2025-12-28 14:55:19'),(31,26,3,'EMAIL','Product: Laptop\nEstimated Delivery: 3 days','2025-12-28 14:55:25'),(32,27,3,'EMAIL','Product: Laptop\nEstimated Delivery: 3 days','2025-12-28 20:40:15'),(33,27,3,'EMAIL','Product: Laptop\nEstimated Delivery: 3 days','2025-12-28 20:40:24'),(34,28,3,'EMAIL','Product: Laptop\nEstimated Delivery: 3 days','2025-12-28 21:29:23'),(35,28,3,'EMAIL','Product: Laptop\nEstimated Delivery: 3 days','2025-12-28 21:29:29');
/*!40000 ALTER TABLE `notification_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`item_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,4,1,1,999.99),(2,5,1,1,999.99),(3,5,2,1,29.99),(4,6,3,1,79.99),(5,7,3,1,79.99),(6,8,3,1,79.99),(7,9,1,1,999.99),(8,9,2,1,29.99),(9,10,2,1,29.99),(10,10,3,1,79.99),(11,11,3,1,79.99),(12,12,4,1,299.99),(13,12,5,1,149.99),(14,13,5,1,149.99),(15,14,4,2,299.99),(16,15,4,1,299.99),(17,16,1,1,999.99),(18,17,5,2,149.99),(19,18,1,1,999.99),(20,19,2,3,29.99),(21,20,3,1,79.99),(22,20,4,1,299.99),(23,20,5,1,149.99),(24,21,5,1,149.99),(25,22,4,1,299.99),(26,23,3,1,79.99),(27,24,3,1,79.99),(28,25,4,1,299.99),(29,26,3,1,79.99),(30,27,2,1,29.99),(31,27,4,1,299.99),(32,28,2,1,29.99);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'PENDING',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,126.48,'PENDING','2025-12-26 05:11:44'),(2,1,206.98,'PENDING','2025-12-26 05:38:59'),(3,1,1149.99,'PENDING','2025-12-26 05:57:16'),(4,1,1149.99,'PENDING','2025-12-26 06:07:45'),(5,1,1184.48,'PENDING','2025-12-26 09:17:58'),(6,1,91.99,'PENDING','2025-12-26 09:23:29'),(7,1,91.99,'PENDING','2025-12-26 09:23:36'),(8,1,91.99,'PENDING','2025-12-26 09:23:39'),(9,1,1184.48,'PENDING','2025-12-26 16:14:08'),(10,1,126.48,'PENDING','2025-12-26 16:19:40'),(11,1,91.99,'PENDING','2025-12-26 16:25:24'),(12,1,517.48,'PENDING','2025-12-26 16:26:30'),(13,2,172.49,'PENDING','2025-12-27 21:11:38'),(14,3,689.98,'PENDING','2025-12-27 21:12:38'),(15,3,344.99,'PENDING','2025-12-27 22:58:18'),(16,2,1149.99,'PENDING','2025-12-27 23:12:23'),(17,2,344.98,'PENDING','2025-12-27 23:22:49'),(18,3,1149.99,'PENDING','2025-12-27 23:38:18'),(19,2,103.47,'PENDING','2025-12-27 23:42:24'),(20,2,609.47,'PENDING','2025-12-28 00:14:08'),(21,3,172.49,'PENDING','2025-12-28 02:35:40'),(22,2,344.99,'PENDING','2025-12-28 02:38:36'),(23,2,91.99,'PENDING','2025-12-28 02:40:17'),(24,1,91.99,'PENDING','2025-12-28 02:44:05'),(25,1,344.99,'PENDING','2025-12-28 14:50:08'),(26,3,91.99,'PENDING','2025-12-28 14:55:09'),(27,3,379.48,'PENDING','2025-12-28 20:40:05'),(28,3,34.49,'PENDING','2025-12-28 21:29:12');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pricing_rules`
--

DROP TABLE IF EXISTS `pricing_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pricing_rules` (
  `rule_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `min_quantity` int DEFAULT NULL,
  `discount_percentage` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`rule_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pricing_rules`
--

LOCK TABLES `pricing_rules` WRITE;
/*!40000 ALTER TABLE `pricing_rules` DISABLE KEYS */;
INSERT INTO `pricing_rules` VALUES (1,1,5,10.00),(2,2,10,15.00),(3,3,10,12.00);
/*!40000 ALTER TABLE `pricing_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax_rates`
--

DROP TABLE IF EXISTS `tax_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tax_rates` (
  `region` varchar(50) NOT NULL,
  `tax_rate` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`region`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_rates`
--

LOCK TABLES `tax_rates` WRITE;
/*!40000 ALTER TABLE `tax_rates` DISABLE KEYS */;
INSERT INTO `tax_rates` VALUES ('default',15.00);
/*!40000 ALTER TABLE `tax_rates` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-28 23:33:15
