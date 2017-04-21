-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: 138.197.33.88    Database: naexpire
-- ------------------------------------------------------
-- Server version	5.7.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carts` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `user-id` int(32) NOT NULL,
  `restaurant-id` int(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_carts_users_user-id_idx` (`user-id`),
  KEY `fk_carts_restaurants_restaurant-id_idx` (`restaurant-id`),
  CONSTRAINT `fk_carts_restaurants_restaurant-id` FOREIGN KEY (`restaurant-id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_carts_users_user-id` FOREIGN KEY (`user-id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `carts-deals`
--

DROP TABLE IF EXISTS `carts-deals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carts-deals` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `cart-id` int(32) NOT NULL,
  `deal-id` int(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_carts-deals_carts_cart-id_idx` (`cart-id`),
  KEY `fk_carts-deals_deals_deal-id_idx` (`deal-id`),
  CONSTRAINT `fk_carts-deals_carts_cart-id` FOREIGN KEY (`cart-id`) REFERENCES `carts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_carts-deals_deals_deal-id` FOREIGN KEY (`deal-id`) REFERENCES `deals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `carts-menuitems`
--

DROP TABLE IF EXISTS `carts-menuitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carts-menuitems` (
  `id` int(32) NOT NULL,
  `cart-id` int(32) NOT NULL,
  `menuitem-id` int(32) NOT NULL,
  `quantity` int(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_carts-menuitems_carts_cart-id_idx` (`cart-id`),
  KEY `fk_carts-menuitems_menuitems_menuitem-id_idx` (`menuitem-id`),
  CONSTRAINT `fk_carts-menuitems_carts_cart-id` FOREIGN KEY (`cart-id`) REFERENCES `carts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_carts-menuitems_menuitems_menuitem-id` FOREIGN KEY (`menuitem-id`) REFERENCES `menuitems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creditcards`
--

DROP TABLE IF EXISTS `creditcards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creditcards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `number` varchar(90) NOT NULL,
  `expiration` int(11) NOT NULL,
  `securitycode` int(11) NOT NULL,
  `zip` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cuisines`
--

DROP TABLE IF EXISTS `cuisines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cuisines` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deals`
--

DROP TABLE IF EXISTS `deals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deals` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `meal-id` int(32) NOT NULL,
  `deal-price` decimal(8,2) NOT NULL,
  `quantity` int(32) NOT NULL,
  `restaurant-id` int(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_deals_menuitems_meal-id_idx` (`meal-id`),
  KEY `fk_deals_restaurants_restaurants-id_idx` (`restaurant-id`),
  CONSTRAINT `fk_deals_menuitems_meal-id` FOREIGN KEY (`meal-id`) REFERENCES `menuitems` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_deals_restaurants_restaurants-id` FOREIGN KEY (`restaurant-id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `menuitems`
--

DROP TABLE IF EXISTS `menuitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menuitems` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `description` varchar(128) NOT NULL,
  `restaurantid` int(32) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `type` enum('grab-bag','menu-item') NOT NULL DEFAULT 'menu-item',
  PRIMARY KEY (`id`),
  KEY `FK_restaurantid` (`restaurantid`),
  CONSTRAINT `FK_restaurantid` FOREIGN KEY (`restaurantid`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchases`
--

DROP TABLE IF EXISTS `purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `restaurantid` int(11) NOT NULL,
  `ccid` int(11) NOT NULL,
  `items` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `date` date NOT NULL,
  `completed` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `restaurantcuisinejoin`
--

DROP TABLE IF EXISTS `restaurantcuisinejoin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restaurantcuisinejoin` (
  `restaurantid` int(16) NOT NULL,
  `cuisineid` int(16) NOT NULL,
  PRIMARY KEY (`restaurantid`,`cuisineid`),
  KEY `FK_rcj_cuisineid` (`cuisineid`),
  CONSTRAINT `FK_rcj_cuisineid` FOREIGN KEY (`cuisineid`) REFERENCES `cuisines` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_rcj_restaurantid` FOREIGN KEY (`restaurantid`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `restaurants`
--

DROP TABLE IF EXISTS `restaurants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restaurants` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `description` varchar(256) DEFAULT NULL,
  `registration-date` date NOT NULL,
  `address` varchar(64) DEFAULT NULL,
  `city` varchar(32) DEFAULT NULL,
  `state` varchar(32) DEFAULT NULL,
  `zip` int(5) DEFAULT NULL,
  `ownerid` int(32) NOT NULL,
  `items` varchar(1024) DEFAULT NULL,
  `pickup-time` varchar(45) DEFAULT NULL,
  `price` decimal(5,2) DEFAULT NULL,
  `pickup-max` int(3) DEFAULT NULL,
  `pickup-remaining` int(3) DEFAULT NULL,
  `phone-number` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ownerid` (`ownerid`),
  CONSTRAINT `FK_ownerid` FOREIGN KEY (`ownerid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scores`
--

DROP TABLE IF EXISTS `scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scores` (
  `purchaseid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `restaurantid` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `review` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`purchaseid`,`userid`,`restaurantid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `session-content` varchar(128) NOT NULL,
  `user-id` int(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions` (
  `id` int(32) NOT NULL,
  `user-id` int(32) NOT NULL,
  `restaurant-id` int(32) NOT NULL,
  `status` enum('open','cancelled','rejected','accepted','fulfilled') NOT NULL DEFAULT 'open',
  PRIMARY KEY (`id`),
  KEY `fk_transactions_restaurants_restaurant-id_idx` (`restaurant-id`),
  KEY `fk_transactions_users_user-id_idx` (`user-id`),
  CONSTRAINT `fk_transactions_restaurants_restaurant-id` FOREIGN KEY (`restaurant-id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_transactions_users_user-id` FOREIGN KEY (`user-id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactions-deals`
--

DROP TABLE IF EXISTS `transactions-deals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions-deals` (
  `id` int(32) NOT NULL,
  `transaction-id` int(32) NOT NULL,
  `deal-id` int(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_transaction-deals_transactions_transaction-id_idx` (`transaction-id`),
  KEY `fk_transaction-deals_deals_deal-id_idx` (`deal-id`),
  CONSTRAINT `fk_transaction-deals_deals_deal-id` FOREIGN KEY (`deal-id`) REFERENCES `deals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_transaction-deals_transactions_transaction-id` FOREIGN KEY (`transaction-id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactions-menuitems`
--

DROP TABLE IF EXISTS `transactions-menuitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions-menuitems` (
  `id` int(32) NOT NULL,
  `transaction-id` int(32) NOT NULL,
  `menuitem-id` int(32) NOT NULL,
  `quantity` int(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_transactions-menuitems_transactions_transaction-id_idx` (`transaction-id`),
  KEY `fk_transactions-menuitems_menuitems_menuitem-id_idx` (`menuitem-id`),
  CONSTRAINT `fk_transactions-menuitems_menuitems_menuitem-id` FOREIGN KEY (`menuitem-id`) REFERENCES `transactions-menuitems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_transactions-menuitems_transactions_transaction-id` FOREIGN KEY (`transaction-id`) REFERENCES `transactions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `type` enum('customer','restaurant','admin') NOT NULL DEFAULT 'customer',
  `email` varchar(64) NOT NULL,
  `password` varchar(128) NOT NULL,
  `firstname` varchar(32) DEFAULT NULL,
  `lastname` varchar(32) DEFAULT NULL,
  `registration-date` date NOT NULL,
  `last-login` datetime DEFAULT NULL,
  `card-number` int(20) DEFAULT NULL,
  `card-expiration` int(5) DEFAULT NULL,
  `card-zip` int(5) DEFAULT NULL,
  `confirmed` int(1) DEFAULT '0',
  `confirmation-code` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-04-21 16:46:11
