-- MySQL dump 10.13  Distrib 8.0.11, for Win64 (x86_64)
--
-- Host: localhost    Database: asp
-- ------------------------------------------------------
-- Server version	8.0.11

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
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
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tb_city` (
  `city_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_icelandic_ci DEFAULT NULL,
  PRIMARY KEY (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_city`
--

LOCK TABLES `tb_city` WRITE;
/*!40000 ALTER TABLE `tb_city` DISABLE KEYS */;
INSERT INTO `tb_city` VALUES (1,'Lai Châu'),(2,'Điện Biên'),(3,'Hoà Bình'),(4,'Thái Nguyên'),(5,'Lạng Sơn'),(6,'Yên Bái'),(7,'Lào Cai'),(8,'Sơn La'),(9,'Quảng Ninh'),(10,'Bắc Giang'),(11,'Phú Thọ'),(12,'Vĩnh Phúc'),(13,'Bắc Ninh'),(14,'Hải Dương'),(15,'Hải Phòng'),(16,'Hưng Yên'),(17,'Thái Bình'),(18,'Hà Nam'),(19,'Nam Định'),(20,'Ninh Bình'),(21,'Thanh Hóa'),(22,'Nghệ An'),(23,'Hà Tĩnh'),(24,'Quảng Bình'),(25,'Quảng Trị'),(26,'Thừa Thiên Huế'),(27,'Đà Nẵng'),(28,'Quảng Nam'),(29,'Quảng Ngãi'),(30,'Bình Định'),(31,'Phú Yên'),(32,'Khánh Hòa'),(33,'Ninh Thuận'),(34,'Bình Thuận'),(35,'Kon Tum'),(36,'Gia Lai'),(37,'Đắk Lắk'),(38,'Đắk Nông'),(39,'Lâm Đồng'),(40,'Bình Phước'),(41,'Tây Ninh'),(42,'Bình Dương'),(43,'Đồng Nai'),(44,'Bà Rịa - Vũng Tàu'),(45,'Hồ Chí Minh'),(46,'Long An'),(47,'Tiền Giang'),(48,'Bến Tre'),(49,'Trà Vinh'),(50,'Vĩnh Long'),(51,'Đồng Tháp'),(52,'An Giang'),(53,'Kiên Giang'),(54,'Cần Thơ'),(55,'Hậu Giang'),(56,'Sóc Trăng'),(57,'Bạc Liêu'),(58,'Cà Mau'),(59,'Tuyên Quang'),(60,'Hà Nội'),(61,'Hà Giang'),(62,'Cao Bằng'),(63,'Bắc Kạn');
/*!40000 ALTER TABLE `tb_city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_district`
--

DROP TABLE IF EXISTS `tb_district`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tb_district` (
  `district_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_icelandic_ci DEFAULT NULL,
  `city_id` int(11) NOT NULL,
  PRIMARY KEY (`district_id`),
  KEY `fk_tb_district_tb_city1_idx` (`city_id`),
  CONSTRAINT `fk_tb_district_tb_city1` FOREIGN KEY (`city_id`) REFERENCES `tb_city` (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=710 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_district`
--

LOCK TABLES `tb_district` WRITE;
/*!40000 ALTER TABLE `tb_district` DISABLE KEYS */;
INSERT INTO `tb_district` VALUES (1,'Lai Châu',1),(2,'Tam Đường',1),(3,'Mường Tè',1),(4,'Sìn Hồ',1),(5,'Phong Thổ',1),(6,'Than Uyên',1),(7,'Tân Uyên',1),(8,'Nậm Nhùn',1),(9,'Điện Biên',2),(10,'Điện Biên Đông',2),(11,'Mường Ảng',2),(12,'Nậm Pồ',2),(13,'Điện Biên Phủ',2),(14,'Mường Lay',2),(15,'Mường Nhé',2),(16,'Mường Chà',2),(17,'Tủa Chùa',2),(18,'Tuần Giáo',2),(19,'Thái Nguyên',4),(20,'Sông Công',4),(21,'Định Hóa',4),(22,'Phú Lương',4),(23,'Đồng Hỷ',4),(24,'Võ Nhai',4),(25,'Đại Từ',4),(26,'Phổ Yên',4),(27,'Phú Bình',4),(28,'Hòa Bình',3),(29,'Đà Bắc',3),(30,'Kỳ Sơn',3),(31,'Lương Sơn',3),(32,'Kim Bôi',3),(33,'Cao Phong',3),(34,'Tân Lạc',3),(35,'Mai Châu',3),(36,'Lạc Sơn',3),(37,'Yên Thủy',3),(38,'Lạc Thủy',3),(39,'Lạng Sơn',5),(40,'Tràng Định',5),(41,'Bình Gia',5),(42,'Văn Lãng',5),(43,'Cao Lộc',5),(44,'Văn Quan',5),(45,'Bắc Sơn',5),(46,'Hữu Lũng',5),(47,'Chi Lăng',5),(48,'Lộc Bình',5),(49,'Đình Lập',5),(50,'Yên Bái',6),(51,'Nghĩa Lộ',6),(52,'Lục Yên',6),(53,'Văn Yên',6),(54,'Mù Căng Chải',6),(55,'Trấn Yên',6),(56,'Trạm Tấu',6),(57,'Văn Chấn',6),(58,'Yên Bình',6),(59,'Sơn La',8),(60,'Quỳnh Nhai',8),(61,'Thuận Châu',8),(62,'Mường La',8),(63,'Bắc Yên',8),(64,'Phù Yên',8),(65,'Mộc Châu',8),(66,'Yên Châu',8),(67,'Mai Sơn',8),(68,'Sông Mã',8),(69,'Sốp Cộp',8),(70,'Vân Hồ',8),(71,'Lào Cai',7),(72,'Bát Xát',7),(73,'Mường Khương',7),(74,'Si Ma Cai',7),(75,'Bắc Hà',7),(76,'Bảo Thắng',7),(77,'Bảo Yên',7),(78,'Sa Pa',7),(79,'Văn Bàn',7),(80,'Hạ Long',9),(81,'Móng Cái',9),(82,'Cẩm Phả',9),(83,'Uông Bí',9),(84,'Bình Liêu',9),(85,'Tiên Yên',9),(86,'Đầm Hà',9),(87,'Hải Hà',9),(88,'Ba Chẽ',9),(89,'Vân Đồn',9),(90,'Hoành Bồ',9),(91,'Đông Triều',9),(92,'Quảng Yên',9),(93,'Cô Tô',9),(94,'Việt Trì',11),(95,'Phú Thọ',11),(96,'Đoan Hùng',11),(97,'Hạ Hoà',11),(98,'Thanh Ba',11),(99,'Phù Ninh',11),(100,'Yên Lập',11),(101,'Cẩm Khê',11),(102,'Tam Nông',11),(103,'Lâm Thao',11),(104,'Thanh Sơn',11),(105,'Thanh Thuỷ',11),(106,'Tân Sơn',11),(107,'Bắc Giang',10),(108,'Yên Thế',10),(109,'Tân Yên',10),(110,'Lạng Giang',10),(111,'Lục Nam',10),(112,'Lục Ngạn',10),(113,'Sơn Động',10),(114,'Yên Dũng',10),(115,'Việt Yên',10),(116,'Hiệp Hòa',10),(117,'Bắc Ninh',13),(118,'Yên Phong',13),(119,'Quế Võ',13),(120,'Tiên Du',13),(121,'Từ Sơn',13),(122,'Thuận Thành',13),(123,'Gia Bình',13),(124,'Lương Tài',13),(125,'Vĩnh Yên',12),(126,'Phúc Yên',12),(127,'Lập Thạch',12),(128,'Tam Dương',12),(129,'Tam Đảo',12),(130,'Bình Xuyên',12),(131,'Yên Lạc',12),(132,'Vĩnh Tường',12),(133,'Sông Lô',12),(134,'Hải Dương',14),(135,'Chí Linh',14),(136,'Nam Sách',14),(137,'Kinh Môn',14),(138,'Kim Thành',14),(139,'Thanh Hà',14),(140,'Cẩm Giàng',14),(141,'Bình Giang',14),(142,'Gia Lộc',14),(143,'Tứ Kỳ',14),(144,'Ninh Giang',14),(145,'Thanh Miện',14),(146,'Hưng Yên',16),(147,'Văn Lâm',16),(148,'Văn Giang',16),(149,'Yên Mỹ',16),(150,'Mỹ Hào',16),(151,'Ân Thi',16),(152,'Khoái Châu',16),(153,'Kim Động',16),(154,'Tiên Lữ',16),(155,'Phù Cừ',16),(156,'Hồng Bàng',15),(157,'Ngô Quyền',15),(158,'Lê Chân',15),(159,'Hải An',15),(160,'Kiến An',15),(161,'Đồ Sơn',15),(162,'Dương Kinh',15),(163,'Thuỷ Nguyên',15),(164,'An Dương',15),(165,'An Lão',15),(166,'Kiến Thuỵ',15),(167,'Tiên Lãng',15),(168,'Vĩnh Bảo',15),(169,'Cát Hải',15),(170,'Thái Bình',17),(171,'Quỳnh Phụ',17),(172,'Hưng Hà',17),(173,'Đông Hưng',17),(174,'Thái Thụy',17),(175,'Tiền Hải',17),(176,'Kiến Xương',17),(177,'Vũ Thư',17),(178,'Phủ Lý',18),(179,'Duy Tiên',18),(180,'Kim Bảng',18),(181,'Thanh Liêm',18),(182,'Bình Lục',18),(183,'Lý Nhân',18),(184,'Thanh Hóa',21),(185,'Bỉm Sơn',21),(186,'Sầm Sơn',21),(187,'Mường Lát',21),(188,'Quan Hóa',21),(189,'Bá Thước',21),(190,'Quan Sơn',21),(191,'Lang Chánh',21),(192,'Ngọc Lặc',21),(193,'Cẩm Thủy',21),(194,'Thạch Thành',21),(195,'Hà Trung',21),(196,'Vĩnh Lộc',21),(197,'Yên Định',21),(198,'Thọ Xuân',21),(199,'Thường Xuân',21),(200,'Triệu Sơn',21),(201,'Thiệu Hóa',21),(202,'Hoằng Hóa',21),(203,'Hậu Lộc',21),(204,'Nga Sơn',21),(205,'Như Xuân',21),(206,'Như Thanh',21),(207,'Nông Cống',21),(208,'Đông Sơn',21),(209,'Quảng Xương',21),(210,'Tĩnh Gia',21),(211,'Nam Định',19),(212,'Mỹ Lộc',19),(213,'Vụ Bản',19),(214,'Ý Yên',19),(215,'Nghĩa Hưng',19),(216,'Nam Trực',19),(217,'Trực Ninh',19),(218,'Xuân Trường',19),(219,'Giao Thủy',19),(220,'Hải Hậu',19),(221,'Ninh Bình',20),(222,'Tam Điệp',20),(223,'Nho Quan',20),(224,'Gia Viễn',20),(225,'Hoa Lư',20),(226,'Yên Khánh',20),(227,'Kim Sơn',20),(228,'Yên Mô',20),(229,'Vinh',22),(230,'Cửa Lò',22),(231,'Thái Hoà',22),(232,'Quế Phong',22),(233,'Quỳ Châu',22),(234,'Kỳ Sơn',22),(235,'Tương Dương',22),(236,'Nghĩa Đàn',22),(237,'Quỳ Hợp',22),(238,'Quỳnh Lưu',22),(239,'Con Cuông',22),(240,'Tân Kỳ',22),(241,'Anh Sơn',22),(242,'Diễn Châu',22),(243,'Yên Thành',22),(244,'Đô Lương',22),(245,'Thanh Chương',22),(246,'Nghi Lộc',22),(247,'Nam Đàn',22),(248,'Hưng Nguyên',22),(249,'Hoàng Mai',22),(250,'Hà Tĩnh',23),(251,'Hồng Lĩnh',23),(252,'Hương Sơn',23),(253,'Đức Thọ',23),(254,'Vũ Quang',23),(255,'Nghi Xuân',23),(256,'Can Lộc',23),(257,'Hương Khê',23),(258,'Thạch Hà',23),(259,'Cẩm Xuyên',23),(260,'Kỳ Anh',23),(261,'Lộc Hà',23),(262,'Kỳ Anh',23),(263,'Huế',26),(264,'Phong Điền',26),(265,'Quảng Điền',26),(266,'Phú Vang',26),(267,'Hương Thủy',26),(268,'Hương Trà',26),(269,'A Lưới',26),(270,'Phú Lộc',26),(271,'Nam Đông',26),(272,'Đông Hà',25),(273,'Quảng Trị',25),(274,'Vĩnh Linh',25),(275,'Hướng Hóa',25),(276,'Gio Linh',25),(277,'Đa Krông',25),(278,'Cam Lộ',25),(279,'Triệu Phong',25),(280,'Hải Lăng',25),(281,'Đồng Hới',24),(282,'Minh Hóa',24),(283,'Tuyên Hóa',24),(284,'Quảng Trạch',24),(285,'Bố Trạch',24),(286,'Quảng Ninh',24),(287,'Lệ Thủy',24),(288,'Ba Đồn',24),(289,'Liên Chiểu',27),(290,'Thanh Khê',27),(291,'Hải Châu',27),(292,'Sơn Trà',27),(293,'Ngũ Hành Sơn',27),(294,'Cẩm Lệ',27),(295,'Hòa Vang',27),(296,'Tam Kỳ',28),(297,'Hội An',28),(298,'Tây Giang',28),(299,'Đông Giang',28),(300,'Đại Lộc',28),(301,'Điện Bàn',28),(302,'Duy Xuyên',28),(303,'Quế Sơn',28),(304,'Nam Giang',28),(305,'Phước Sơn',28),(306,'Hiệp Đức',28),(307,'Thăng Bình',28),(308,'Tiên Phước',28),(309,'Bắc Trà My',28),(310,'Nam Trà My',28),(311,'Núi Thành',28),(312,'Phú Ninh',28),(313,'Nông Sơn',28),(314,'Quảng Ngãi',29),(315,'Bình Sơn',29),(316,'Trà Bồng',29),(317,'Tây Trà',29),(318,'Sơn Tịnh',29),(319,'Tư Nghĩa',29),(320,'Sơn Hà',29),(321,'Sơn Tây',29),(322,'Minh Long',29),(323,'Nghĩa Hành',29),(324,'Mộ Đức',29),(325,'Đức Phổ',29),(326,'Ba Tơ',29),(327,'Lý Sơn',29),(328,'Tuy Hoà',31),(329,'Sông Cầu',31),(330,'Đồng Xuân',31),(331,'Tuy An',31),(332,'Sơn Hòa',31),(333,'Sông Hinh',31),(334,'Tây Hoà',31),(335,'Phú Hoà',31),(336,'Đông Hòa',31),(337,'Qui Nhơn',30),(338,'An Lão',30),(339,'Hoài Nhơn',30),(340,'Hoài Ân',30),(341,'Phù Mỹ',30),(342,'Vĩnh Thạnh',30),(343,'Tây Sơn',30),(344,'Phù Cát',30),(345,'An Nhơn',30),(346,'Tuy Phước',30),(347,'Vân Canh',30),(348,'Nha Trang',32),(349,'Cam Ranh',32),(350,'Cam Lâm',32),(351,'Vạn Ninh',32),(352,'Ninh Hòa',32),(353,'Khánh Vĩnh',32),(354,'Diên Khánh',32),(355,'Khánh Sơn',32),(356,'Trường Sa',32),(357,'Phan Rang-Tháp Chàm',33),(358,'Bác Ái',33),(359,'Ninh Sơn',33),(360,'Ninh Hải',33),(361,'Ninh Phước',33),(362,'Thuận Bắc',33),(363,'Thuận Nam',33),(364,'Phan Thiết',34),(365,'La Gi',34),(366,'Tuy Phong',34),(367,'Bắc Bình',34),(368,'Hàm Thuận Bắc',34),(369,'Hàm Thuận Nam',34),(370,'Tánh Linh',34),(371,'Đức Linh',34),(372,'Hàm Tân',34),(373,'Phú Quí',34),(374,'Pleiku',36),(375,'An Khê',36),(376,'Ayun Pa',36),(377,'KBang',36),(378,'Đăk Đoa',36),(379,'Chư Păh',36),(380,'Ia Grai',36),(381,'Mang Yang',36),(382,'Kông Chro',36),(383,'Đức Cơ',36),(384,'Chư Prông',36),(385,'Chư Sê',36),(386,'Đăk Pơ',36),(387,'Ia Pa',36),(388,'Krông Pa',36),(389,'Phú Thiện',36),(390,'Chư Pưh',36),(391,'Kon Tum',35),(392,'Đắk Glei',35),(393,'Ngọc Hồi',35),(394,'Đắk Tô',35),(395,'Kon Plông',35),(396,'Kon Rẫy',35),(397,'Đắk Hà',35),(398,'Sa Thầy',35),(399,'Tu Mơ Rông',35),(400,'Ia H\' Drai',35),(401,'Phước Long',40),(402,'Đồng Xoài',40),(403,'Bình Long',40),(404,'Bù Gia Mập',40),(405,'Lộc Ninh',40),(406,'Bù Đốp',40),(407,'Hớn Quản',40),(408,'Đồng Phú',40),(409,'Bù Đăng',40),(410,'Chơn Thành',40),(411,'Phú Riềng',40),(412,'Đà Lạt',39),(413,'Bảo Lộc',39),(414,'Đam Rông',39),(415,'Lạc Dương',39),(416,'Lâm Hà',39),(417,'Đơn Dương',39),(418,'Đức Trọng',39),(419,'Di Linh',39),(420,'Bảo Lâm',39),(421,'Đạ Huoai',39),(422,'Đạ Tẻh',39),(423,'Cát Tiên',39),(424,'Gia Nghĩa',38),(425,'Đăk Glong',38),(426,'Cư Jút',38),(427,'Đắk Mil',38),(428,'Krông Nô',38),(429,'Đắk Song',38),(430,'Đắk R\'Lấp',38),(431,'Tuy Đức',38),(432,'Buôn Ma Thuột',37),(433,'Buôn Hồ',37),(434,'Ea H\'leo',37),(435,'Ea Súp',37),(436,'Buôn Đôn',37),(437,'Cư M\'gar',37),(438,'Krông Búk',37),(439,'Krông Năng',37),(440,'Ea Kar',37),(441,'M\'Đrắk',37),(442,'Krông Bông',37),(443,'Krông Pắc',37),(444,'Krông A Na',37),(445,'Lắk',37),(446,'Cư Kuin',37),(447,'Tây Ninh',41),(448,'Tân Biên',41),(449,'Tân Châu',41),(450,'Dương Minh Châu',41),(451,'Châu Thành',41),(452,'Hòa Thành',41),(453,'Gò Dầu',41),(454,'Bến Cầu',41),(455,'Trảng Bàng',41),(456,'Biên Hòa',43),(457,'Long Khánh',43),(458,'Tân Phú',43),(459,'Vĩnh Cửu',43),(460,'Định Quán',43),(461,'Trảng Bom',43),(462,'Thống Nhất',43),(463,'Cẩm Mỹ',43),(464,'Long Thành',43),(465,'Xuân Lộc',43),(466,'Nhơn Trạch',43),(467,'Vũng Tàu',44),(468,'Bà Rịa',44),(469,'Châu Đức',44),(470,'Xuyên Mộc',44),(471,'Long Điền',44),(472,'Đất Đỏ',44),(473,'Tân Thành',44),(474,'Thủ Dầu Một',42),(475,'Bàu Bàng',42),(476,'Dầu Tiếng',42),(477,'Bến Cát',42),(478,'Phú Giáo',42),(479,'Tân Uyên',42),(480,'Dĩ An',42),(481,'Thuận An',42),(482,'Bắc Tân Uyên',42),(483,'1',45),(484,'12',45),(485,'Thủ Đức',45),(486,'9',45),(487,'Gò Vấp',45),(488,'Bình Thạnh',45),(489,'Tân Bình',45),(490,'Tân Phú',45),(491,'Phú Nhuận',45),(492,'2',45),(493,'3',45),(494,'10',45),(495,'11',45),(496,'4',45),(497,'5',45),(498,'6',45),(499,'8',45),(500,'Bình Tân',45),(501,'7',45),(502,'Củ Chi',45),(503,'Hóc Môn',45),(504,'Bình Chánh',45),(505,'Nhà Bè',45),(506,'Cần Giờ',45),(507,'Tân An',46),(508,'Kiến Tường',46),(509,'Tân Hưng',46),(510,'Vĩnh Hưng',46),(511,'Mộc Hóa',46),(512,'Tân Thạnh',46),(513,'Thạnh Hóa',46),(514,'Đức Huệ',46),(515,'Đức Hòa',46),(516,'Bến Lức',46),(517,'Thủ Thừa',46),(518,'Tân Trụ',46),(519,'Cần Đước',46),(520,'Cần Giuộc',46),(521,'Châu Thành',46),(522,'Vĩnh Long',50),(523,'Long Hồ',50),(524,'Mang Thít',50),(525,'Vũng Liêm',50),(526,'Tam Bình',50),(527,'Bình Minh',50),(528,'Trà Ôn',50),(529,'Bình Tân',50),(530,'Mỹ Tho',47),(531,'Gò Công',47),(532,'Cai Lậy',47),(533,'Tân Phước',47),(534,'Cái Bè',47),(535,'Cai Lậy',47),(536,'Châu Thành',47),(537,'Chợ Gạo',47),(538,'Gò Công Tây',47),(539,'Gò Công Đông',47),(540,'Tân Phú Đông',47),(541,'Trà Vinh',49),(542,'Càng Long',49),(543,'Cầu Kè',49),(544,'Tiểu Cần',49),(545,'Châu Thành',49),(546,'Cầu Ngang',49),(547,'Trà Cú',49),(548,'Duyên Hải',49),(549,'Duyên Hải',49),(550,'Bến Tre',48),(551,'Châu Thành',48),(552,'Chợ Lách',48),(553,'Mỏ Cày Nam',48),(554,'Giồng Trôm',48),(555,'Bình Đại',48),(556,'Ba Tri',48),(557,'Thạnh Phú',48),(558,'Mỏ Cày Bắc',48),(559,'Cao Lãnh',51),(560,'Sa Đéc',51),(561,'Hồng Ngự',51),(562,'Tân Hồng',51),(563,'Hồng Ngự',51),(564,'Tam Nông',51),(565,'Tháp Mười',51),(566,'Cao Lãnh',51),(567,'Thanh Bình',51),(568,'Lấp Vò',51),(569,'Lai Vung',51),(570,'Châu Thành',51),(571,'Long Xuyên',52),(572,'Châu Đốc',52),(573,'An Phú',52),(574,'Tân Châu',52),(575,'Phú Tân',52),(576,'Châu Phú',52),(577,'Tịnh Biên',52),(578,'Tri Tôn',52),(579,'Châu Thành',52),(580,'Chợ Mới',52),(581,'Thoại Sơn',52),(582,'Vị Thanh',55),(583,'Ngã Bảy',55),(584,'Châu Thành A',55),(585,'Châu Thành',55),(586,'Phụng Hiệp',55),(587,'Vị Thuỷ',55),(588,'Long Mỹ',55),(589,'Long Mỹ',55),(590,'Rạch Giá',53),(591,'Hà Tiên',53),(592,'Kiên Lương',53),(593,'Hòn Đất',53),(594,'Tân Hiệp',53),(595,'Châu Thành',53),(596,'Giồng Riềng',53),(597,'Gò Quao',53),(598,'An Biên',53),(599,'An Minh',53),(600,'Vĩnh Thuận',53),(601,'Phú Quốc',53),(602,'Kiên Hải',53),(603,'U Minh Thượng',53),(604,'Giang Thành',53),(605,'Sóc Trăng',56),(606,'Châu Thành',56),(607,'Kế Sách',56),(608,'Mỹ Tú',56),(609,'Cù Lao Dung',56),(610,'Long Phú',56),(611,'Mỹ Xuyên',56),(612,'Ngã Năm',56),(613,'Thạnh Trị',56),(614,'Vĩnh Châu',56),(615,'Trần Đề',56),(616,'Ninh Kiều',54),(617,'Ô Môn',54),(618,'Bình Thuỷ',54),(619,'Cái Răng',54),(620,'Thốt Nốt',54),(621,'Vĩnh Thạnh',54),(622,'Cờ Đỏ',54),(623,'Phong Điền',54),(624,'Thới Lai',54),(625,'Bạc Liêu',57),(626,'Hồng Dân',57),(627,'Phước Long',57),(628,'Vĩnh Lợi',57),(629,'Giá Rai',57),(630,'Đông Hải',57),(631,'Hoà Bình',57),(632,'Mê Linh',60),(633,'Hà Đông',60),(634,'Sơn Tây',60),(635,'Ba Vì',60),(636,'Phúc Thọ',60),(637,'Đan Phượng',60),(638,'Hoài Đức',60),(639,'Quốc Oai',60),(640,'Thạch Thất',60),(641,'Chương Mỹ',60),(642,'Thanh Oai',60),(643,'Thường Tín',60),(644,'Phú Xuyên',60),(645,'Ứng Hòa',60),(646,'Mỹ Đức',60),(647,'Ba Đình',60),(648,'Hoàn Kiếm',60),(649,'Tây Hồ',60),(650,'Long Biên',60),(651,'Cầu Giấy',60),(652,'Đống Đa',60),(653,'Hai Bà Trưng',60),(654,'Hoàng Mai',60),(655,'Thanh Xuân',60),(656,'Sóc Sơn',60),(657,'Đông Anh',60),(658,'Gia Lâm',60),(659,'Nam Từ Liêm',60),(660,'Thanh Trì',60),(661,'Bắc Từ Liêm',60),(662,'Hà Giang',61),(663,'Đồng Văn',61),(664,'Mèo Vạc',61),(665,'Yên Minh',61),(666,'Quản Bạ',61),(667,'Vị Xuyên',61),(668,'Bắc Mê',61),(669,'Hoàng Su Phì',61),(670,'Xín Mần',61),(671,'Bắc Quang',61),(672,'Quang Bình',61),(673,'Tuyên Quang',59),(674,'Lâm Bình',59),(675,'Nà Hang',59),(676,'Chiêm Hóa',59),(677,'Hàm Yên',59),(678,'Yên Sơn',59),(679,'Sơn Dương',59),(680,'Cà Mau',58),(681,'U Minh',58),(682,'Thới Bình',58),(683,'Trần Văn Thời',58),(684,'Cái Nước',58),(685,'Đầm Dơi',58),(686,'Năm Căn',58),(687,'Phú Tân',58),(688,'Ngọc Hiển',58),(689,'Cao Bằng',62),(690,'Bảo Lâm',62),(691,'Bảo Lạc',62),(692,'Thông Nông',62),(693,'Hà Quảng',62),(694,'Trà Lĩnh',62),(695,'Trùng Khánh',62),(696,'Hạ Lang',62),(697,'Quảng Uyên',62),(698,'Phục Hoà',62),(699,'Hoà An',62),(700,'Nguyên Bình',62),(701,'Thạch An',62),(702,'Bắc Kạn',63),(703,'Pác Nặm',63),(704,'Ba Bể',63),(705,'Ngân Sơn',63),(706,'Bạch Thông',63),(707,'Chợ Đồn',63),(708,'Chợ Mới',63),(709,'Na Rì',63);
/*!40000 ALTER TABLE `tb_district` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_favourite`
--

DROP TABLE IF EXISTS `tb_favourite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
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
INSERT INTO `tb_favourite` VALUES (1,23,1),(2,23,2),(3,23,3),(4,24,4),(5,24,5),(6,24,6),(7,25,7),(8,25,8),(9,26,9),(10,27,10),(11,28,11),(12,28,12),(13,28,13),(14,28,14),(15,28,15),(16,28,16);
/*!40000 ALTER TABLE `tb_favourite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_image`
--

DROP TABLE IF EXISTS `tb_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tb_image` (
  `image_id` int(11) NOT NULL AUTO_INCREMENT,
  `link_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_icelandic_ci DEFAULT NULL,
  `room_id` int(11) NOT NULL,
  PRIMARY KEY (`image_id`),
  KEY `fk_tb_image_tb_room1_idx` (`room_id`),
  CONSTRAINT `fk_tb_image_tb_room1` FOREIGN KEY (`room_id`) REFERENCES `tb_room` (`room_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
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
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tb_post` (
  `post_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_icelandic_ci DEFAULT NULL,
  `phone_contact` varchar(15) CHARACTER SET utf8 COLLATE utf8_icelandic_ci DEFAULT NULL,
  `number_partner` int(11) DEFAULT NULL,
  `gender_partner` tinyint(4) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `type_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `longtitude` double DEFAULT NULL,
  `lattitude` double DEFAULT NULL,
  PRIMARY KEY (`post_id`),
  KEY `fk_tb_post_tb_type1_idx` (`type_id`),
  KEY `fk_tb_post_tb_user1_idx` (`user_id`),
  KEY `fk_tb_post_tb_room1_idx` (`room_id`),
  CONSTRAINT `fk_tb_post_tb_room1` FOREIGN KEY (`room_id`) REFERENCES `tb_room` (`room_id`),
  CONSTRAINT `fk_tb_post_tb_type1` FOREIGN KEY (`type_id`) REFERENCES `tb_type` (`type_id`),
  CONSTRAINT `fk_tb_post_tb_user1` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_post`
--

LOCK TABLES `tb_post` WRITE;
/*!40000 ALTER TABLE `tb_post` DISABLE KEYS */;
INSERT INTO `tb_post` VALUES (1,'Tìm nữ ở ghép','0124578963',2,2,'2018-06-01',1,1,1,106.75886,10.8508),(2,'Tìm 3 nam ở ghép','1234567890',2,1,'2018-06-01',1,2,2,106.68298,10.77912),(3,'căn hộ chung cư','1235468735',2,2,'2018-06-01',1,3,3,106.68061,10.803),(4,'Phòng q3 full nội thất ngay trung tâm','9089818237',2,2,'2018-06-01',1,4,4,106.68133,10.78589),(5,'Phòng Thủ đức','1231415123',2,1,'2018-06-01',1,5,5,106.68002,10.78079),(6,'Phòng Q3','1231423555',2,2,'2018-06-01',1,6,6,106.682854,10.77918),(7,'Phòng mặt tiền','1234213421',2,2,'2018-06-01',1,7,7,106.68173,10.75865),(8,'Tìm nữ ở ghép','3334342234',2,2,'2018-06-01',1,8,8,106.68057,10.75821),(9,'căn hộ chung cư','3334342234',2,2,'2018-06-01',1,9,9,106.66955,10.75119),(10,'Phòng mặt tiền','3334342234',2,2,'2018-06-01',1,10,10,106.66903,10.77273),(11,'Tìm nữ ở ghép','3334342234',2,1,'2018-06-01',1,11,11,106.66899,10.77417),(12,'Phòng mặt tiền','1231231231',2,2,'2018-06-01',1,12,12,106.61519,10.78054),(13,'căn hộ chung cư','2221313546',2,1,'2018-06-01',1,13,13,106.67639,10.84147),(14,'Phòng mặt tiền','8657567566',2,1,'2018-06-01',1,14,14,106.67603,10.83138),(15,'Tìm nữ ở ghép','4435786888',2,1,'2018-06-01',1,15,15,106.68071,10.83604),(16,'Phòng mặt tiền','6573436777',2,2,'2018-06-01',1,16,16,106.65305,10.79322),(17,'Tìm nữ ở ghép','3534534535',2,2,'2018-06-01',1,17,17,106.653,10.79325),(18,'căn hộ chung cư','2345242346',2,1,'2018-06-01',1,18,18,106.63647,10.80322),(19,'Phòng mặt tiền','2342342342',2,1,'2018-06-01',1,19,19,106.63637,10.80328);
/*!40000 ALTER TABLE `tb_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_post_has_tb_district`
--

DROP TABLE IF EXISTS `tb_post_has_tb_district`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tb_post_has_tb_district` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL,
  `district_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tb_post_has_tb_district_tb_district1_idx` (`district_id`),
  KEY `fk_tb_post_has_tb_district_tb_post1_idx` (`post_id`),
  CONSTRAINT `fk_tb_post_has_tb_district_tb_district1` FOREIGN KEY (`district_id`) REFERENCES `tb_district` (`district_id`),
  CONSTRAINT `fk_tb_post_has_tb_district_tb_post1` FOREIGN KEY (`post_id`) REFERENCES `tb_post` (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_post_has_tb_district`
--

LOCK TABLES `tb_post_has_tb_district` WRITE;
/*!40000 ALTER TABLE `tb_post_has_tb_district` DISABLE KEYS */;
INSERT INTO `tb_post_has_tb_district` VALUES (1,1,485),(2,2,493),(3,3,493),(4,4,493),(5,5,493),(6,6,493),(7,7,497),(8,8,497),(9,9,497),(10,10,494),(11,11,494),(12,12,494),(13,13,487),(14,14,487),(15,15,487),(16,16,489),(17,17,489),(18,18,489),(19,19,489);
/*!40000 ALTER TABLE `tb_post_has_tb_district` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_rate`
--

DROP TABLE IF EXISTS `tb_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
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
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tb_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(45) CHARACTER SET utf8 COLLATE utf8_icelandic_ci DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
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
 SET character_set_client = utf8mb4 ;
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
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_room`
--

LOCK TABLES `tb_room` WRITE;
/*!40000 ALTER TABLE `tb_room` DISABLE KEYS */;
INSERT INTO `tb_room` VALUES (1,'Phòng có gác',2000000,30,'85/24 Võ Văn Ngân',3,1,'có gác lửng',2,45,485,'2018-05-01',1,106.75886,10.8508),(2,'Căn hộ mini 1 gác',5000000,40,'44/104 Nguyễn Thông',3,1,'có gác lửng',2,45,493,'2018-05-01',1,106.68298,10.77912),(3,'Căn hộ 1 gác đúc',1000000,40,'50 Nguyễn Thông',3,1,'có gác lửng',2,45,493,'2018-05-01',1,106.68061,10.803),(4,'Phòng Quận 3',15000000,40,'31/12 Lê Văn Sỹ',3,1,'có gác lửng',2,45,493,'2018-05-01',1,106.68133,10.78589),(5,'Căn hộ mini 1 trệt 1 gác đúc ',5000000,40,'70 Nguyễn Thông',3,1,'có gác lửng',2,45,493,'2018-05-01',1,106.68002,10.78079),(6,'Cửa hàng giày',8000000,40,'80 Nguyễn Thông',3,1,'có gác lửng',2,45,493,'2018-05-01',1,106.682854,10.77918),(7,'Phòng rất đẹp, ',8000000,23,'22 Nguyễn Trãi, phường 3',3,1,'Cho thuê mặt bằng',3,45,497,'2018-05-02',1,106.68173,10.75865),(8,'Phòng  giá phù hợp',8000000,44,'50 Nguyễn Trãi, phường 3',3,1,'Cho thuê mặt bằng',3,45,497,'2018-05-02',1,106.68057,10.75821),(9,'Phòng đẹp, giá phù hợp',8000000,13,'22 Nguyễn Tri Phương, phường 6',3,1,'Mặt tiền toáng',3,45,497,'2018-05-02',1,106.66955,10.75119),(10,'Phòng  giá thơm',1000000,16,'497/4 Sư Vạn Hạnh, phường 12',3,1,'Cho thuê mặt bằng',3,45,494,'2018-05-02',1,106.66903,10.77273),(11,'Phòng đẹp, giá ngon',8000000,46,'796/19 Sư Vạn Hạnh, Phường 12',3,1,'Mặt tiền làm ăn',3,45,494,'2018-05-02',1,106.66899,10.77417),(12,'Phòng  giá ngon',86000000,68,'157 Hoà Hưng, Phường 12',3,1,'Mặt tiền thoáng mát',3,45,494,'2018-05-02',1,106.61519,10.78054),(13,'Phòng rất đẹp, giá rất phù hợp',83000000,58,'11 Nguyễn Oanh',3,1,'Hẻm 5m',4,45,487,'2018-05-03',1,106.67639,10.84147),(14,'Phòng đẹp, giá rẻ',83000000,87,'1077 Phan Văn Trị, Phường 10',3,1,'có gác lửng',4,45,487,'2018-05-03',1,106.67603,10.83138),(15,'Phòng đẹp',38000000,87,'77 Lê Thị Hồng, Phường 7',3,1,'Cho thuê mặt bằng',4,45,487,'2018-05-03',1,106.68071,10.83604),(16,'Phòng mặt tiền',18000000,67,'22 Trường Chinh, Phường 4',3,1,'Hẻm rộng',4,45,489,'2018-05-03',1,106.65305,10.79322),(17,'Cho thuê mặt bằng',80000000,121,' 47/6/11 Trường Chinh, Phường 11',3,1,'Cho thuê mặt bằng',4,45,489,'2018-05-03',1,106.653,10.79325),(18,'Căn hộ mini 1 trệt 2 gác đúc',80000000,121,'20 Trường Chinh',3,1,'NULL',4,45,489,'2018-05-03',1,106.63647,10.80322),(19,'Căn hộ mini 1 trệt 3 gác đúc',80000000,121,'1 Trường Chinh, Phường 13',3,1,'NULL',4,45,489,'2018-05-03',1,106.63637,10.80328);
/*!40000 ALTER TABLE `tb_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_room_has_user`
--

DROP TABLE IF EXISTS `tb_room_has_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
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
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tb_room_has_utility` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `room_id` int(11) NOT NULL,
  `utility_id` int(11) NOT NULL,
  `brand` varchar(45) CHARACTER SET utf8 COLLATE utf8_icelandic_ci DEFAULT NULL,
  `description` varchar(45) CHARACTER SET utf8 COLLATE utf8_icelandic_ci DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tb_utilities_has_tb_room_tb_room1_idx` (`room_id`),
  KEY `fk_tb_utilities_has_tb_room_tb_utilities1_idx` (`utility_id`),
  CONSTRAINT `fk_tb_utilities_has_tb_room_tb_room1` FOREIGN KEY (`room_id`) REFERENCES `tb_room` (`room_id`),
  CONSTRAINT `fk_tb_utilities_has_tb_room_tb_utilities1` FOREIGN KEY (`utility_id`) REFERENCES `tb_utilities` (`utility_id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
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
 SET character_set_client = utf8mb4 ;
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
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tb_status` (
  `status_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
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
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tb_type` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
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
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tb_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) CHARACTER SET utf8 COLLATE utf8_icelandic_ci unique NOT NULL,
  `password` varchar(60) CHARACTER SET utf8 COLLATE utf8_icelandic_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_icelandic_ci NOT NULL,
  `fullname` varchar(100) CHARACTER SET utf8 COLLATE utf8_icelandic_ci DEFAULT NULL,
  `image_profile` varchar(255) CHARACTER SET utf8 COLLATE utf8_icelandic_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `phone` varchar(15) CHARACTER SET utf8 COLLATE utf8_icelandic_ci DEFAULT NULL,
  `gender` tinyint(4) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `fk_tb_user_tb_role1_idx` (`role_id`),
  CONSTRAINT `fk_tb_user_tb_role1` FOREIGN KEY (`role_id`) REFERENCES `tb_role` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
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
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tb_utilities` (
  `utility_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_icelandic_ci DEFAULT NULL,
  PRIMARY KEY (`utility_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
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
 SET character_set_client = utf8mb4 ;
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

-- Dump completed on 2018-10-09  0:09:56
