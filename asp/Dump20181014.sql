-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: asp
-- ------------------------------------------------------
-- Server version	5.7.21-log

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
-- Table structure for table `tb_city`
--

DROP TABLE IF EXISTS `tb_city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_city` (
  `city_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_icelandic_ci DEFAULT NULL,
  PRIMARY KEY (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_city`
--

LOCK TABLES `tb_city` WRITE;
/*!40000 ALTER TABLE `tb_city` DISABLE KEYS */;
INSERT INTO `tb_city` VALUES (1,'Hồ Chí Minh'),(2,'Hà Nội'),(3,'Nha Trang');
/*!40000 ALTER TABLE `tb_city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_district`
--

DROP TABLE IF EXISTS `tb_district`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_district` (
  `district_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_icelandic_ci DEFAULT NULL,
  `city_id` int(11) NOT NULL,
  PRIMARY KEY (`district_id`),
  KEY `fk_tb_district_tb_city1_idx` (`city_id`),
  CONSTRAINT `fk_tb_district_tb_city1` FOREIGN KEY (`city_id`) REFERENCES `tb_city` (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_district`
--

LOCK TABLES `tb_district` WRITE;
/*!40000 ALTER TABLE `tb_district` DISABLE KEYS */;
INSERT INTO `tb_district` VALUES (1,'1',1),(2,'2',1),(3,'3',1),(4,'4',1),(5,'5',1),(6,'6',1),(7,'7',1),(8,'8',1),(9,'9',1),(10,'10',1),(11,'Tân Bình',1),(12,'Tân Phú',1),(13,'Thủ Đức',1),(14,'Gò Vấp',1),(15,'Phú Nhuận',1),(16,'12',1),(17,'Bình Thạnh',1);
/*!40000 ALTER TABLE `tb_district` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_favourite`
--

DROP TABLE IF EXISTS `tb_favourite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_favourite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tb_user_has_tb_room_info_tb_room_info1_idx` (`post_id`),
  KEY `fk_tb_user_has_tb_room_info_tb_user1_idx` (`user_id`),
  CONSTRAINT `fk_tb_user_has_tb_room_info_tb_room_info1` FOREIGN KEY (`post_id`) REFERENCES `tb_post` (`post_id`),
  CONSTRAINT `fk_tb_user_has_tb_room_info_tb_user1` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_favourite`
--

LOCK TABLES `tb_favourite` WRITE;
/*!40000 ALTER TABLE `tb_favourite` DISABLE KEYS */;
INSERT INTO `tb_favourite` VALUES (1,23,1),(2,23,2),(3,23,3),(4,23,4),(5,26,5),(6,23,6),(7,24,7),(8,24,8),(9,24,9),(10,25,10),(11,25,11),(12,28,12),(13,28,13),(14,28,14),(15,28,15),(16,28,16);
/*!40000 ALTER TABLE `tb_favourite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_image`
--

DROP TABLE IF EXISTS `tb_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_image` (
  `image_id` int(11) NOT NULL AUTO_INCREMENT,
  `link_url` varchar(255) COLLATE utf8_icelandic_ci DEFAULT NULL,
  `room_id` int(11) NOT NULL,
  PRIMARY KEY (`image_id`),
  KEY `fk_tb_image_tb_room1_idx` (`room_id`),
  CONSTRAINT `fk_tb_image_tb_room1` FOREIGN KEY (`room_id`) REFERENCES `tb_room` (`room_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_image`
--

LOCK TABLES `tb_image` WRITE;
/*!40000 ALTER TABLE `tb_image` DISABLE KEYS */;
INSERT INTO `tb_image` VALUES (26,'https://nhaxinhcenter.com.vn/source/pic/noi-that/NT199/phong-an-trang-tri-dep-124.jpg',1),(27,'https://nhaxinhcenter.com.vn/source/pic/noi-that/NT199/phong-an-trang-tri-dep-124.jpg',2),(28,'https://nhaxinhcenter.com.vn/source/pic/noi-that/NT199/phong-an-trang-tri-dep-124.jpg',3),(29,'https://nhaxinhcenter.com.vn/source/pic/noi-that/NT199/phong-an-trang-tri-dep-124.jpg',4),(30,'https://nhaxinhcenter.com.vn/source/pic/noi-that/NT199/phong-an-trang-tri-dep-124.jpg',5),(31,'https://nhaxinhcenter.com.vn/source/pic/noi-that/NT199/phong-an-trang-tri-dep-124.jpg',6),(32,'https://nhaxinhcenter.com.vn/source/pic/noi-that/NT199/phong-an-trang-tri-dep-124.jpg',7),(33,'https://nhaxinhcenter.com.vn/source/pic/noi-that/NT199/phong-an-trang-tri-dep-124.jpg',8),(34,'https://nhaxinhcenter.com.vn/source/pic/noi-that/NT199/phong-an-trang-tri-dep-124.jpg',9),(35,'https://nhaxinhcenter.com.vn/source/pic/noi-that/NT199/phong-an-trang-tri-dep-124.jpg',10),(36,'https://nhaxinhcenter.com.vn/source/pic/noi-that/NT199/phong-an-trang-tri-dep-124.jpg',11),(37,'https://nhaxinhcenter.com.vn/source/pic/noi-that/NT199/phong-an-trang-tri-dep-124.jpg',12),(38,'https://nhaxinhcenter.com.vn/source/pic/noi-that/NT199/phong-an-trang-tri-dep-124.jpg',13),(39,'https://nhaxinhcenter.com.vn/source/pic/noi-that/NT199/phong-an-trang-tri-dep-124.jpg',14),(40,'https://nhaxinhcenter.com.vn/source/pic/noi-that/NT199/phong-an-trang-tri-dep-124.jpg',15),(41,'https://nhaxinhcenter.com.vn/source/pic/noi-that/NT199/phong-an-trang-tri-dep-124.jpg',16),(42,'https://nhaxinhcenter.com.vn/source/pic/noi-that/NT199/phong-an-trang-tri-dep-124.jpg',17);
/*!40000 ALTER TABLE `tb_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_post`
--

DROP TABLE IF EXISTS `tb_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_post` (
  `post_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_icelandic_ci DEFAULT NULL,
  `phone_contact` varchar(15) COLLATE utf8_icelandic_ci DEFAULT NULL,
  `number_partner` int(11) DEFAULT NULL,
  `gender_partner` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `type_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `room_id` int(11) DEFAULT NULL,
  `longtitude` double DEFAULT NULL,
  `lattitude` double DEFAULT NULL,
  PRIMARY KEY (`post_id`),
  KEY `fk_tb_post_tb_type1_idx` (`type_id`),
  KEY `fk_tb_post_tb_user1_idx` (`user_id`),
  KEY `fk_tb_post_tb_room1_idx` (`room_id`),
  CONSTRAINT `fk_tb_post_tb_type1` FOREIGN KEY (`type_id`) REFERENCES `tb_type` (`type_id`),
  CONSTRAINT `fk_tb_post_tb_user1` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_post`
--

LOCK TABLES `tb_post` WRITE;
/*!40000 ALTER TABLE `tb_post` DISABLE KEYS */;
INSERT INTO `tb_post` VALUES (1,'Tìm nữ ở ghép','0124578963',2,2,'2018-06-01',1,5,1,106.75886,10.8508),(2,'Tìm 3 nam ở ghép','1234567890',2,1,'2018-06-01',1,6,2,106.68298,10.77912),(3,'căn hộ chung cư','1235468735',2,2,'2018-06-01',1,7,3,106.68061,10.803),(4,'Phòng q3 full nội thất ngay trung tâm','9089818237',2,2,'2018-06-01',1,8,4,106.68133,10.78589),(5,'Phòng Thủ đức','1231415123',2,1,'2018-06-01',1,9,5,106.68002,10.78079),(6,'Phòng Q3','1231423555',2,2,'2018-06-01',1,10,6,106.682854,10.77918),(7,'Phòng mặt tiền','1234213421',2,2,'2018-06-01',1,11,7,106.68173,10.75865),(8,'Tìm nữ ở ghép','3334342234',2,2,'2018-06-01',1,12,8,106.68057,10.75821),(9,'căn hộ chung cư','3334342234',2,2,'2018-06-01',1,13,9,106.66955,10.75119),(10,'Phòng mặt tiền','3334342234',2,2,'2018-06-01',1,14,10,106.66903,10.77273),(11,'Tìm nữ ở ghép','3334342234',2,1,'2018-06-01',1,15,11,106.66899,10.77417),(12,'Phòng mặt tiền','1231231231',2,2,'2018-06-01',1,16,12,106.61519,10.78054),(13,'căn hộ chung cư','2221313546',2,1,'2018-06-01',1,17,13,106.67639,10.84147),(14,'Phòng mặt tiền','8657567566',2,1,'2018-06-01',1,18,14,106.67603,10.83138),(15,'Tìm nữ ở ghép','4435786888',2,1,'2018-06-01',1,19,15,106.68071,10.83604),(16,'Phòng mặt tiền','6573436777',2,2,'2018-06-01',1,20,16,106.65305,10.79322),(17,'Tìm nữ ở ghép','3534534535',2,2,'2018-06-01',1,21,17,106.653,10.79325),(18,'căn hộ chung cư','2345242346',2,1,'2018-06-01',1,22,18,106.63647,10.80322),(93,'string','string',0,1,'0016-07-10',2,28,0,0,0),(94,'string','string',0,1,'2018-02-11',2,28,0,0,0);
/*!40000 ALTER TABLE `tb_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_post_has_tb_district`
--

DROP TABLE IF EXISTS `tb_post_has_tb_district`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_post_has_tb_district` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL,
  `district_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tb_post_has_tb_district_tb_district1_idx` (`district_id`),
  KEY `fk_tb_post_has_tb_district_tb_post1_idx` (`post_id`),
  CONSTRAINT `fk_tb_post_has_tb_district_tb_district1` FOREIGN KEY (`district_id`) REFERENCES `tb_district` (`district_id`),
  CONSTRAINT `fk_tb_post_has_tb_district_tb_post1` FOREIGN KEY (`post_id`) REFERENCES `tb_post` (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_post_has_tb_district`
--

LOCK TABLES `tb_post_has_tb_district` WRITE;
/*!40000 ALTER TABLE `tb_post_has_tb_district` DISABLE KEYS */;
INSERT INTO `tb_post_has_tb_district` VALUES (1,1,13),(2,2,3),(3,3,3),(4,4,3),(5,5,3),(6,6,3),(7,7,5),(8,8,5),(9,9,5),(10,10,10),(11,11,10),(12,12,10),(13,13,14),(14,14,14),(15,15,14),(16,16,11),(17,17,11),(18,18,11);
/*!40000 ALTER TABLE `tb_post_has_tb_district` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_rate`
--

DROP TABLE IF EXISTS `tb_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_rate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tb_user_user_id` int(11) NOT NULL,
  `tb_room_room_id` int(11) NOT NULL,
  `security_rating` double DEFAULT NULL,
  `location_rating` double DEFAULT NULL,
  `utility_rating` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tb_user_has_tb_room_tb_room1_idx` (`tb_room_room_id`),
  KEY `fk_tb_user_has_tb_room_tb_user1_idx` (`tb_user_user_id`),
  CONSTRAINT `fk_tb_user_has_tb_room_tb_room1` FOREIGN KEY (`tb_room_room_id`) REFERENCES `tb_room` (`room_id`),
  CONSTRAINT `fk_tb_user_has_tb_room_tb_user1` FOREIGN KEY (`tb_user_user_id`) REFERENCES `tb_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_rate`
--

LOCK TABLES `tb_rate` WRITE;
/*!40000 ALTER TABLE `tb_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_role`
--

DROP TABLE IF EXISTS `tb_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(45) COLLATE utf8_icelandic_ci DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_role`
--

LOCK TABLES `tb_role` WRITE;
/*!40000 ALTER TABLE `tb_role` DISABLE KEYS */;
INSERT INTO `tb_role` VALUES (1,'admin'),(2,'houseowner'),(3,'roommaster'),(4,'member');
/*!40000 ALTER TABLE `tb_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_room`
--

DROP TABLE IF EXISTS `tb_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_room` (
  `room_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `price` float DEFAULT NULL,
  `area` int(11) DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `max_guest` int(11) DEFAULT NULL,
  `current_number` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `district_id` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `status_id` int(11) NOT NULL,
  `longtitude` double DEFAULT NULL,
  `lattitude` double DEFAULT NULL,
  PRIMARY KEY (`room_id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `fk_tb_room_tb_user1_idx` (`user_id`),
  KEY `fk_tb_room_tb_city1_idx` (`city_id`),
  KEY `fk_tb_room_tb_district1_idx` (`district_id`),
  KEY `fk_tb_room_tb_status1_idx` (`status_id`),
  CONSTRAINT `fk_tb_room_tb_city1` FOREIGN KEY (`city_id`) REFERENCES `tb_city` (`city_id`),
  CONSTRAINT `fk_tb_room_tb_district1` FOREIGN KEY (`district_id`) REFERENCES `tb_district` (`district_id`),
  CONSTRAINT `fk_tb_room_tb_status1` FOREIGN KEY (`status_id`) REFERENCES `tb_status` (`status_id`),
  CONSTRAINT `fk_tb_room_tb_user1` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_room`
--

LOCK TABLES `tb_room` WRITE;
/*!40000 ALTER TABLE `tb_room` DISABLE KEYS */;
INSERT INTO `tb_room` VALUES (1,'Phòng có gác',2000000,30,'85/24 Võ Văn Ngân',3,1,'có gác lửng',2,1,13,'2018-05-01',1,106.75886,10.8508),(2,'Căn hộ mini 1 gác',5000000,40,'44/104 Nguyễn Thông',3,1,'có gác lửng',2,1,3,'2018-05-01',1,106.68298,10.77912),(3,'Căn hộ 1 gác đúc',1000000,40,'50 Nguyễn Thông',3,1,'có gác lửng',2,1,3,'2018-05-01',1,106.68061,10.803),(4,'Phòng Quận 3',15000000,40,'31/12 Lê Văn Sỹ',3,1,'có gác lửng',2,1,3,'2018-05-01',1,106.68133,10.78589),(5,'Căn hộ mini 1 trệt 1 gác đúc ',5000000,40,'70 Nguyễn Thông',3,1,'có gác lửng',2,1,3,'2018-05-01',1,106.68002,10.78079),(6,'Cửa hàng giày',8000000,40,'80 Nguyễn Thông',3,1,'có gác lửng',2,1,3,'2018-05-01',1,106.682854,10.77918),(7,'Phòng rất đẹp, ',8000000,23,'22 Nguyễn Trãi, phường 3',3,1,'Cho thuê mặt bằng',3,1,5,'2018-05-02',1,106.68173,10.75865),(8,'Phòng  giá phù hợp',8000000,44,'50 Nguyễn Trãi, phường 3',3,1,'Cho thuê mặt bằng',3,1,5,'2018-05-02',1,106.68057,10.75821),(9,'Phòng đẹp, giá phù hợp',8000000,13,'22 Nguyễn Tri Phương, phường 6',3,1,'Mặt tiền toáng',3,1,5,'2018-05-02',1,106.66955,10.75119),(10,'Phòng  giá thơm',1000000,16,'497/4 Sư Vạn Hạnh, phường 12',3,1,'Cho thuê mặt bằng',3,1,10,'2018-05-02',1,106.66903,10.77273),(11,'Phòng đẹp, giá ngon',8000000,46,'796/19 Sư Vạn Hạnh, Phường 12',3,1,'Mặt tiền làm ăn',3,1,10,'2018-05-02',1,106.66899,10.77417),(12,'Phòng  giá ngon',86000000,68,'157 Hoà Hưng, Phường 12',3,1,'Mặt tiền thoáng mát',3,1,10,'2018-05-02',1,106.61519,10.78054),(13,'Phòng rất đẹp, giá rất phù hợp',83000000,58,'11 Nguyễn Oanh',3,1,'Hẻm 5m',4,1,14,'2018-05-03',1,106.67639,10.84147),(14,'Phòng đẹp, giá rẻ',83000000,87,'1077 Phan Văn Trị, Phường 10',3,1,'có gác lửng',4,1,14,'2018-05-03',1,106.67603,10.83138),(15,'Phòng đẹp',38000000,87,'77 Lê Thị Hồng, Phường 7',3,1,'Cho thuê mặt bằng',4,1,14,'2018-05-03',1,106.68071,10.83604),(16,'Phòng mặt tiền',18000000,67,'22 Trường Chinh, Phường 4',3,1,'Hẻm rộng',4,1,11,'2018-05-03',1,106.65305,10.79322),(17,'Cho thuê mặt bằng',80000000,121,' 47/6/11 Trường Chinh, Phường 11',3,1,'Cho thuê mặt bằng',4,1,11,'2018-05-03',1,106.653,10.79325),(18,'Căn hộ mini 1 trệt 2 gác đúc',80000000,121,'20 Trường Chinh',3,1,'NULL',4,1,11,'2018-05-03',1,106.63647,10.80322),(19,'Căn hộ mini 1 trệt 3 gác đúc',80000000,121,'1 Trường Chinh, Phường 13',3,1,'NULL',4,1,11,'2018-05-03',1,106.63637,10.80328);
/*!40000 ALTER TABLE `tb_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_room_has_user`
--

DROP TABLE IF EXISTS `tb_room_has_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_room_has_user` (
  `room_has_user_id` int(11) NOT NULL AUTO_INCREMENT,
  `date_in` date DEFAULT NULL,
  `date_out` date DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  PRIMARY KEY (`room_has_user_id`),
  KEY `fk_tb_room_has_user_tb_user1_idx` (`user_id`),
  KEY `fk_tb_room_has_user_tb_room1_idx` (`room_id`),
  CONSTRAINT `fk_tb_room_has_user_tb_room1` FOREIGN KEY (`room_id`) REFERENCES `tb_room` (`room_id`),
  CONSTRAINT `fk_tb_room_has_user_tb_user1` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_room_has_user`
--

LOCK TABLES `tb_room_has_user` WRITE;
/*!40000 ALTER TABLE `tb_room_has_user` DISABLE KEYS */;
INSERT INTO `tb_room_has_user` VALUES (1,'2018-06-01','2018-12-01',1,1),(2,'2018-06-01','2018-12-01',2,2),(3,'2018-06-01','2018-12-01',3,3),(4,'2018-06-01','2018-12-01',4,4),(5,'2018-06-01','2018-12-01',5,5),(6,'2018-06-01','2018-12-01',6,6),(7,'2018-06-01','2018-12-01',7,7),(8,'2018-06-01','2018-12-01',8,8),(9,'2018-06-01','2018-12-01',9,9),(10,'2018-06-01','2018-12-01',10,10),(11,'2018-06-01','2018-12-01',11,11),(12,'2018-06-01','2018-12-01',12,12),(13,'2018-06-01','2018-12-01',13,13),(14,'2018-06-01','2018-12-01',14,14),(15,'2018-06-01','2018-12-01',15,15),(16,'2018-06-01','2018-12-01',16,16),(17,'2018-06-01','2018-12-01',17,17),(18,'2018-06-01','2018-12-01',18,18),(19,'2018-06-01','2018-12-01',19,19),(20,'2018-06-02','2018-12-01',23,19);
/*!40000 ALTER TABLE `tb_room_has_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_room_has_utility`
--

DROP TABLE IF EXISTS `tb_room_has_utility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_room_has_utility` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `room_id` int(11) NOT NULL,
  `utility_id` int(11) NOT NULL,
  `brand` varchar(45) COLLATE utf8_icelandic_ci DEFAULT NULL,
  `description` varchar(45) COLLATE utf8_icelandic_ci DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tb_utilities_has_tb_room_tb_room1_idx` (`room_id`),
  KEY `fk_tb_utilities_has_tb_room_tb_utilities1_idx` (`utility_id`),
  CONSTRAINT `fk_tb_utilities_has_tb_room_tb_room1` FOREIGN KEY (`room_id`) REFERENCES `tb_room` (`room_id`),
  CONSTRAINT `fk_tb_utilities_has_tb_room_tb_utilities1` FOREIGN KEY (`utility_id`) REFERENCES `tb_utilities` (`utility_id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_room_has_utility`
--

LOCK TABLES `tb_room_has_utility` WRITE;
/*!40000 ALTER TABLE `tb_room_has_utility` DISABLE KEYS */;
INSERT INTO `tb_room_has_utility` VALUES (1,1,1,'NULL','NULL',1),(2,1,2,'NULL','NULL',1),(3,1,3,'NULL','NULL',1),(4,1,4,'NULL','NULL',1),(5,2,5,'NULL','NULL',1),(6,2,6,'NULL','NULL',1),(7,2,7,'NULL','NULL',1),(8,3,8,'NULL','NULL',1),(9,3,9,'NULL','NULL',1),(10,3,10,'NULL','NULL',1),(11,4,11,'NULL','NULL',1),(12,4,12,'NULL','NULL',1),(13,4,13,'NULL','NULL',1),(14,4,14,'NULL','NULL',1),(15,5,15,'NULL','NULL',1),(16,5,1,'NULL','NULL',1),(17,5,2,'NULL','NULL',1),(18,5,3,'NULL','NULL',1),(19,6,4,'NULL','NULL',1),(20,6,5,'NULL','NULL',1),(21,6,6,'NULL','NULL',1),(22,7,7,'NULL','NULL',1),(23,7,8,'NULL','NULL',1),(24,7,9,'NULL','NULL',1),(25,8,10,'NULL','NULL',1),(26,8,11,'NULL','NULL',1),(27,8,12,'NULL','NULL',1),(28,9,13,'NULL','NULL',1),(29,9,14,'NULL','NULL',1),(30,9,15,'NULL','NULL',1),(31,10,1,'NULL','NULL',1),(32,10,2,'NULL','NULL',1),(33,10,3,'NULL','NULL',1),(34,11,4,'NULL','NULL',1),(35,11,5,'NULL','NULL',1),(36,11,6,'NULL','NULL',1),(37,12,7,'NULL','NULL',1),(38,12,8,'NULL','NULL',1),(39,12,9,'NULL','NULL',1),(40,13,10,'NULL','NULL',1),(41,13,11,'NULL','NULL',1),(42,13,12,'NULL','NULL',1),(43,14,13,'NULL','NULL',1),(44,14,14,'NULL','NULL',1),(45,14,15,'NULL','NULL',1),(46,14,1,'NULL','NULL',1),(47,15,2,'NULL','NULL',1),(48,15,3,'NULL','NULL',1),(49,15,4,'NULL','NULL',1),(50,15,5,'NULL','NULL',1),(51,15,6,'NULL','NULL',1),(52,16,7,'NULL','NULL',1),(53,16,8,'NULL','NULL',1),(54,16,9,'NULL','NULL',1),(55,16,10,'NULL','NULL',1),(56,16,11,'NULL','NULL',1),(57,17,12,'NULL','NULL',1),(58,17,13,'NULL','NULL',1),(59,17,14,'NULL','NULL',1),(60,17,15,'NULL','NULL',1),(61,17,1,'NULL','NULL',1);
/*!40000 ALTER TABLE `tb_room_has_utility` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_room_reference`
--

DROP TABLE IF EXISTS `tb_room_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_room_reference` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `room_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tb_room_has_tb_user_tb_user1_idx` (`user_id`),
  KEY `fk_tb_room_has_tb_user_tb_room1_idx` (`room_id`),
  CONSTRAINT `fk_tb_room_has_tb_user_tb_room1` FOREIGN KEY (`room_id`) REFERENCES `tb_room` (`room_id`),
  CONSTRAINT `fk_tb_room_has_tb_user_tb_user1` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_room_reference`
--

LOCK TABLES `tb_room_reference` WRITE;
/*!40000 ALTER TABLE `tb_room_reference` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_room_reference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_status`
--

DROP TABLE IF EXISTS `tb_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_status` (
  `status_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_status`
--

LOCK TABLES `tb_status` WRITE;
/*!40000 ALTER TABLE `tb_status` DISABLE KEYS */;
INSERT INTO `tb_status` VALUES (1,'approved'),(2,'declined');
/*!40000 ALTER TABLE `tb_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_type`
--

DROP TABLE IF EXISTS `tb_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_type` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_type`
--

LOCK TABLES `tb_type` WRITE;
/*!40000 ALTER TABLE `tb_type` DISABLE KEYS */;
INSERT INTO `tb_type` VALUES (1,'findroommate'),(2,'findroom');
/*!40000 ALTER TABLE `tb_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_user`
--

DROP TABLE IF EXISTS `tb_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) COLLATE utf8_icelandic_ci NOT NULL,
  `password` varchar(60) COLLATE utf8_icelandic_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_icelandic_ci NOT NULL,
  `fullname` varchar(100) COLLATE utf8_icelandic_ci DEFAULT NULL,
  `image_profile` varchar(255) COLLATE utf8_icelandic_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `phone` varchar(15) COLLATE utf8_icelandic_ci DEFAULT NULL,
  `gender` tinyint(4) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  KEY `fk_tb_user_tb_role1_idx` (`role_id`),
  CONSTRAINT `fk_tb_user_tb_role1` FOREIGN KEY (`role_id`) REFERENCES `tb_role` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_user`
--

LOCK TABLES `tb_user` WRITE;
/*!40000 ALTER TABLE `tb_user` DISABLE KEYS */;
INSERT INTO `tb_user` VALUES (1,'admin','admin','admin@gmail.com','admin','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',1,1),(2,'test_nhat','1234','nhat@gmail.com','Nguyễn Quang Nhật','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',1,2),(3,'test_ban','1234','ban@gmail.com','Trần Thôn Bản','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',1,2),(4,'test_tro','1234','tro@gmail.com','Bành Thị Xóm Trọ','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',2,2),(5,'test_duc','1234','duc@gmail.com','Nguyễn Đỗ Minh Đức','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',1,3),(6,'test_trinh','1234','trinh@gmail.com','Hồ Công Trình','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',2,3),(7,'test_so','1234','so@gmail.com','Hoàng Hà Xa Số','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',1,3),(8,'test_van','1234','van@gmail.com','Khân Đẩu Vân','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',2,3),(9,'test_thong','1234','thong@gmail.com','Vương Minh Thông','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',2,3),(10,'test_hai','1234','hai@gmail.com','Trần Hải','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',2,3),(11,'test_phong','1234','phong@gmail.com','Phong Đòn Gánh','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',1,3),(12,'test_hong','1234','hong@gmail.com','Hoa Hồng','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',2,3),(13,'test_phan','1234','phan@gmail.com','Hồng Nhan Bạc Phận','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',2,3),(14,'test_ha','1234','ha@gmail.com','Hoàng Hà','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',2,3),(15,'test_thuc','1234','thuc@gmail.com','Thục','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',2,3),(16,'test_thao','1234','thao@gmail.com','Thảo','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',1,3),(17,'test_vo','1234','vo@gmail.com','Vô','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',2,3),(18,'test_ngan','1234','ngan@gmail.com','Ngân','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',2,3),(19,'test_mu','1234','mu@gmail.com','Mu','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',2,3),(20,'test_mu1','1234','mu@gmail.com','Mu','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',1,3),(21,'test_mu2','1234','mu@gmail.com','Mu','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',1,3),(22,'test_mu3','1234','mu@gmail.com','Mu','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',2,3),(23,'test_mu4','1234','mu@gmail.com','Mu','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',1,4),(24,'test_mu5','1234','mu@gmail.com','Mu','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',1,4),(25,'test_mu6','1234','mu@gmail.com','Mu','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',2,4),(26,'test_mu7','1234','mu@gmail.com','Mu','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',2,4),(27,'test_mu8','1234','mu@gmail.com','Mu','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',2,4),(28,'test_mu9','1234','mu@gmail.com','Mu','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1999-02-01','0123456789',2,4);
/*!40000 ALTER TABLE `tb_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_utilities`
--

DROP TABLE IF EXISTS `tb_utilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_utilities` (
  `utility_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_icelandic_ci DEFAULT NULL,
  PRIMARY KEY (`utility_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_utilities`
--

LOCK TABLES `tb_utilities` WRITE;
/*!40000 ALTER TABLE `tb_utilities` DISABLE KEYS */;
INSERT INTO `tb_utilities` VALUES (1,'Camera an ninh'),(2,'Giờ giấc tự do'),(3,'Máy lạnh'),(4,'Tủ quần áo'),(5,'Quạt'),(6,'Giường ngủ'),(7,'Internet'),(8,'Không chung chủ'),(9,'Chỗ đậu xe'),(10,'Bảo vệ'),(11,'Tủ lạnh'),(12,'Tivi'),(13,'WC riêng'),(14,'Máy giặt'),(15,'Máy nước nóng');
/*!40000 ALTER TABLE `tb_utilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_utilities_reference`
--

DROP TABLE IF EXISTS `tb_utilities_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_utilities_reference` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `utility_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tb_utilities_has_tb_user_tb_user1_idx` (`user_id`),
  KEY `fk_tb_utilities_has_tb_user_tb_utilities1_idx` (`utility_id`),
  CONSTRAINT `fk_tb_utilities_has_tb_user_tb_user1` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`user_id`),
  CONSTRAINT `fk_tb_utilities_has_tb_user_tb_utilities1` FOREIGN KEY (`utility_id`) REFERENCES `tb_utilities` (`utility_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_utilities_reference`
--

LOCK TABLES `tb_utilities_reference` WRITE;
/*!40000 ALTER TABLE `tb_utilities_reference` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_utilities_reference` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-10-14 17:10:30
