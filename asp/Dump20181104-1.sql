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
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_city`
--

LOCK TABLES `tb_city` WRITE;
/*!40000 ALTER TABLE `tb_city` DISABLE KEYS */;
INSERT INTO `tb_city` VALUES (1,'Lào Cai'),(2,'Lai Châu'),(3,'Điện Biên'),(4,'Sơn La'),(5,'Yên Bái'),(6,'Hoà Bình'),(7,'Thái Nguyên'),(8,'Lạng Sơn'),(9,'Quảng Ninh'),(10,'Bắc Giang'),(11,'Phú Thọ'),(12,'Vĩnh Phúc'),(13,'Bắc Ninh'),(14,'Hải Dương'),(15,'Hải Phòng'),(16,'Hưng Yên'),(17,'Thái Bình'),(18,'Hà Nam'),(19,'Nam Định'),(20,'Ninh Bình'),(21,'Thanh Hóa'),(22,'Nghệ An'),(23,'Hà Tĩnh'),(24,'Quảng Bình'),(25,'Quảng Trị'),(26,'Thừa Thiên Huế'),(27,'Đà Nẵng'),(28,'Quảng Nam'),(29,'Quảng Ngãi'),(30,'Bình Định'),(31,'Phú Yên'),(32,'Khánh Hòa'),(33,'Ninh Thuận'),(34,'Bình Thuận'),(35,'Kon Tum'),(36,'Gia Lai'),(37,'Đắk Lắk'),(38,'Đắk Nông'),(39,'Lâm Đồng'),(40,'Bình Phước'),(41,'Tây Ninh'),(42,'Bình Dương'),(43,'Đồng Nai'),(44,'Bà Rịa - Vũng Tàu'),(45,'Hồ Chí Minh'),(46,'Long An'),(47,'Tiền Giang'),(48,'Bến Tre'),(49,'Trà Vinh'),(50,'Vĩnh Long'),(51,'Đồng Tháp'),(52,'An Giang'),(53,'Kiên Giang'),(54,'Cần Thơ'),(55,'Hậu Giang'),(56,'Sóc Trăng'),(57,'Bạc Liêu'),(58,'Cà Mau'),(59,'Tuyên Quang'),(60,'Hà Nội'),(61,'Hà Giang'),(62,'Cao Bằng'),(63,'Bắc Kạn');
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
) ENGINE=InnoDB AUTO_INCREMENT=710 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_district`
--

LOCK TABLES `tb_district` WRITE;
/*!40000 ALTER TABLE `tb_district` DISABLE KEYS */;
INSERT INTO `tb_district` VALUES (1,'Lào Cai',1),(2,'Bát Xát',1),(3,'Mường Khương',1),(4,'Si Ma Cai',1),(5,'Bắc Hà',1),(6,'Bảo Thắng',1),(7,'Bảo Yên',1),(8,'Sa Pa',1),(9,'Văn Bàn',1),(10,'Sơn La',4),(11,'Quỳnh Nhai',4),(12,'Thuận Châu',4),(13,'Mường La',4),(14,'Bắc Yên',4),(15,'Phù Yên',4),(16,'Mộc Châu',4),(17,'Yên Châu',4),(18,'Mai Sơn',4),(19,'Sông Mã',4),(20,'Sốp Cộp',4),(21,'Vân Hồ',4),(22,'Yên Bái',5),(23,'Nghĩa Lộ',5),(24,'Lục Yên',5),(25,'Văn Yên',5),(26,'Mù Căng Chải',5),(27,'Trấn Yên',5),(28,'Trạm Tấu',5),(29,'Văn Chấn',5),(30,'Yên Bình',5),(31,'Lai Châu',2),(32,'Tam Đường',2),(33,'Mường Tè',2),(34,'Sìn Hồ',2),(35,'Phong Thổ',2),(36,'Than Uyên',2),(37,'Tân Uyên',2),(38,'Nậm Nhùn',2),(39,'Điện Biên',3),(40,'Điện Biên Đông',3),(41,'Mường Ảng',3),(42,'Nậm Pồ',3),(43,'Điện Biên Phủ',3),(44,'Mường Lay',3),(45,'Mường Nhé',3),(46,'Mường Chà',3),(47,'Tủa Chùa',3),(48,'Tuần Giáo',3),(49,'Hòa Bình',6),(50,'Đà Bắc',6),(51,'Kỳ Sơn',6),(52,'Lương Sơn',6),(53,'Kim Bôi',6),(54,'Cao Phong',6),(55,'Tân Lạc',6),(56,'Mai Châu',6),(57,'Lạc Sơn',6),(58,'Yên Thủy',6),(59,'Lạc Thủy',6),(60,'Hạ Long',9),(61,'Móng Cái',9),(62,'Cẩm Phả',9),(63,'Uông Bí',9),(64,'Bình Liêu',9),(65,'Tiên Yên',9),(66,'Đầm Hà',9),(67,'Hải Hà',9),(68,'Ba Chẽ',9),(69,'Vân Đồn',9),(70,'Hoành Bồ',9),(71,'Đông Triều',9),(72,'Quảng Yên',9),(73,'Cô Tô',9),(74,'Lạng Sơn',8),(75,'Tràng Định',8),(76,'Bình Gia',8),(77,'Văn Lãng',8),(78,'Cao Lộc',8),(79,'Văn Quan',8),(80,'Bắc Sơn',8),(81,'Hữu Lũng',8),(82,'Chi Lăng',8),(83,'Lộc Bình',8),(84,'Đình Lập',8),(85,'Bắc Giang',10),(86,'Yên Thế',10),(87,'Tân Yên',10),(88,'Lạng Giang',10),(89,'Lục Nam',10),(90,'Lục Ngạn',10),(91,'Sơn Động',10),(92,'Yên Dũng',10),(93,'Việt Yên',10),(94,'Hiệp Hòa',10),(95,'Thái Nguyên',7),(96,'Sông Công',7),(97,'Định Hóa',7),(98,'Phú Lương',7),(99,'Đồng Hỷ',7),(100,'Võ Nhai',7),(101,'Đại Từ',7),(102,'Phổ Yên',7),(103,'Phú Bình',7),(104,'Việt Trì',11),(105,'Phú Thọ',11),(106,'Đoan Hùng',11),(107,'Hạ Hoà',11),(108,'Thanh Ba',11),(109,'Phù Ninh',11),(110,'Yên Lập',11),(111,'Cẩm Khê',11),(112,'Tam Nông',11),(113,'Lâm Thao',11),(114,'Thanh Sơn',11),(115,'Thanh Thuỷ',11),(116,'Tân Sơn',11),(117,'Bắc Ninh',13),(118,'Yên Phong',13),(119,'Quế Võ',13),(120,'Tiên Du',13),(121,'Từ Sơn',13),(122,'Thuận Thành',13),(123,'Gia Bình',13),(124,'Lương Tài',13),(125,'Hải Dương',14),(126,'Chí Linh',14),(127,'Nam Sách',14),(128,'Kinh Môn',14),(129,'Kim Thành',14),(130,'Thanh Hà',14),(131,'Cẩm Giàng',14),(132,'Bình Giang',14),(133,'Gia Lộc',14),(134,'Tứ Kỳ',14),(135,'Ninh Giang',14),(136,'Thanh Miện',14),(137,'Vĩnh Yên',12),(138,'Phúc Yên',12),(139,'Lập Thạch',12),(140,'Tam Dương',12),(141,'Tam Đảo',12),(142,'Bình Xuyên',12),(143,'Yên Lạc',12),(144,'Vĩnh Tường',12),(145,'Sông Lô',12),(146,'Hồng Bàng',15),(147,'Ngô Quyền',15),(148,'Lê Chân',15),(149,'Hải An',15),(150,'Kiến An',15),(151,'Đồ Sơn',15),(152,'Dương Kinh',15),(153,'Thuỷ Nguyên',15),(154,'An Dương',15),(155,'An Lão',15),(156,'Kiến Thuỵ',15),(157,'Tiên Lãng',15),(158,'Vĩnh Bảo',15),(159,'Cát Hải',15),(160,'Hưng Yên',16),(161,'Văn Lâm',16),(162,'Văn Giang',16),(163,'Yên Mỹ',16),(164,'Mỹ Hào',16),(165,'Ân Thi',16),(166,'Khoái Châu',16),(167,'Kim Động',16),(168,'Tiên Lữ',16),(169,'Phù Cừ',16),(170,'Phủ Lý',18),(171,'Duy Tiên',18),(172,'Kim Bảng',18),(173,'Thanh Liêm',18),(174,'Bình Lục',18),(175,'Lý Nhân',18),(176,'Nam Định',19),(177,'Mỹ Lộc',19),(178,'Vụ Bản',19),(179,'Ý Yên',19),(180,'Nghĩa Hưng',19),(181,'Nam Trực',19),(182,'Trực Ninh',19),(183,'Xuân Trường',19),(184,'Giao Thủy',19),(185,'Hải Hậu',19),(186,'Thái Bình',17),(187,'Quỳnh Phụ',17),(188,'Hưng Hà',17),(189,'Đông Hưng',17),(190,'Thái Thụy',17),(191,'Tiền Hải',17),(192,'Kiến Xương',17),(193,'Vũ Thư',17),(194,'Ninh Bình',20),(195,'Tam Điệp',20),(196,'Nho Quan',20),(197,'Gia Viễn',20),(198,'Hoa Lư',20),(199,'Yên Khánh',20),(200,'Kim Sơn',20),(201,'Yên Mô',20),(202,'Vinh',22),(203,'Cửa Lò',22),(204,'Thái Hoà',22),(205,'Quế Phong',22),(206,'Quỳ Châu',22),(207,'Kỳ Sơn',22),(208,'Tương Dương',22),(209,'Nghĩa Đàn',22),(210,'Quỳ Hợp',22),(211,'Quỳnh Lưu',22),(212,'Con Cuông',22),(213,'Tân Kỳ',22),(214,'Anh Sơn',22),(215,'Diễn Châu',22),(216,'Yên Thành',22),(217,'Đô Lương',22),(218,'Thanh Chương',22),(219,'Nghi Lộc',22),(220,'Nam Đàn',22),(221,'Hưng Nguyên',22),(222,'Hoàng Mai',22),(223,'Đồng Hới',24),(224,'Minh Hóa',24),(225,'Tuyên Hóa',24),(226,'Quảng Trạch',24),(227,'Bố Trạch',24),(228,'Quảng Ninh',24),(229,'Lệ Thủy',24),(230,'Ba Đồn',24),(231,'Thanh Hóa',21),(232,'Bỉm Sơn',21),(233,'Sầm Sơn',21),(234,'Mường Lát',21),(235,'Quan Hóa',21),(236,'Bá Thước',21),(237,'Quan Sơn',21),(238,'Lang Chánh',21),(239,'Ngọc Lặc',21),(240,'Cẩm Thủy',21),(241,'Thạch Thành',21),(242,'Hà Trung',21),(243,'Vĩnh Lộc',21),(244,'Yên Định',21),(245,'Thọ Xuân',21),(246,'Thường Xuân',21),(247,'Triệu Sơn',21),(248,'Thiệu Hóa',21),(249,'Hoằng Hóa',21),(250,'Hậu Lộc',21),(251,'Nga Sơn',21),(252,'Như Xuân',21),(253,'Như Thanh',21),(254,'Nông Cống',21),(255,'Đông Sơn',21),(256,'Quảng Xương',21),(257,'Tĩnh Gia',21),(258,'Đông Hà',25),(259,'Quảng Trị',25),(260,'Vĩnh Linh',25),(261,'Hướng Hóa',25),(262,'Gio Linh',25),(263,'Đa Krông',25),(264,'Cam Lộ',25),(265,'Triệu Phong',25),(266,'Hải Lăng',25),(267,'Hà Tĩnh',23),(268,'Hồng Lĩnh',23),(269,'Hương Sơn',23),(270,'Đức Thọ',23),(271,'Vũ Quang',23),(272,'Nghi Xuân',23),(273,'Can Lộc',23),(274,'Hương Khê',23),(275,'Thạch Hà',23),(276,'Cẩm Xuyên',23),(277,'Kỳ Anh',23),(278,'Lộc Hà',23),(279,'Kỳ Anh',23),(280,'Huế',26),(281,'Phong Điền',26),(282,'Quảng Điền',26),(283,'Phú Vang',26),(284,'Hương Thủy',26),(285,'Hương Trà',26),(286,'A Lưới',26),(287,'Phú Lộc',26),(288,'Nam Đông',26),(289,'Liên Chiểu',27),(290,'Thanh Khê',27),(291,'Hải Châu',27),(292,'Sơn Trà',27),(293,'Ngũ Hành Sơn',27),(294,'Cẩm Lệ',27),(295,'Hòa Vang',27),(296,'Tam Kỳ',28),(297,'Hội An',28),(298,'Tây Giang',28),(299,'Đông Giang',28),(300,'Đại Lộc',28),(301,'Điện Bàn',28),(302,'Duy Xuyên',28),(303,'Quế Sơn',28),(304,'Nam Giang',28),(305,'Phước Sơn',28),(306,'Hiệp Đức',28),(307,'Thăng Bình',28),(308,'Tiên Phước',28),(309,'Bắc Trà My',28),(310,'Nam Trà My',28),(311,'Núi Thành',28),(312,'Phú Ninh',28),(313,'Nông Sơn',28),(314,'Qui Nhơn',30),(315,'An Lão',30),(316,'Hoài Nhơn',30),(317,'Hoài Ân',30),(318,'Phù Mỹ',30),(319,'Vĩnh Thạnh',30),(320,'Tây Sơn',30),(321,'Phù Cát',30),(322,'An Nhơn',30),(323,'Tuy Phước',30),(324,'Vân Canh',30),(325,'Quảng Ngãi',29),(326,'Bình Sơn',29),(327,'Trà Bồng',29),(328,'Tây Trà',29),(329,'Sơn Tịnh',29),(330,'Tư Nghĩa',29),(331,'Sơn Hà',29),(332,'Sơn Tây',29),(333,'Minh Long',29),(334,'Nghĩa Hành',29),(335,'Mộ Đức',29),(336,'Đức Phổ',29),(337,'Ba Tơ',29),(338,'Lý Sơn',29),(339,'Tuy Hoà',31),(340,'Sông Cầu',31),(341,'Đồng Xuân',31),(342,'Tuy An',31),(343,'Sơn Hòa',31),(344,'Sông Hinh',31),(345,'Tây Hoà',31),(346,'Phú Hoà',31),(347,'Đông Hòa',31),(348,'Kon Tum',35),(349,'Đắk Glei',35),(350,'Ngọc Hồi',35),(351,'Đắk Tô',35),(352,'Kon Plông',35),(353,'Kon Rẫy',35),(354,'Đắk Hà',35),(355,'Sa Thầy',35),(356,'Tu Mơ Rông',35),(357,'Ia H\' Drai',35),(358,'Phan Rang-Tháp Chàm',33),(359,'Bác Ái',33),(360,'Ninh Sơn',33),(361,'Ninh Hải',33),(362,'Ninh Phước',33),(363,'Thuận Bắc',33),(364,'Thuận Nam',33),(365,'Nha Trang',32),(366,'Cam Ranh',32),(367,'Cam Lâm',32),(368,'Vạn Ninh',32),(369,'Ninh Hòa',32),(370,'Khánh Vĩnh',32),(371,'Diên Khánh',32),(372,'Khánh Sơn',32),(373,'Trường Sa',32),(374,'Phan Thiết',34),(375,'La Gi',34),(376,'Tuy Phong',34),(377,'Bắc Bình',34),(378,'Hàm Thuận Bắc',34),(379,'Hàm Thuận Nam',34),(380,'Tánh Linh',34),(381,'Đức Linh',34),(382,'Hàm Tân',34),(383,'Phú Quí',34),(384,'Pleiku',36),(385,'An Khê',36),(386,'Ayun Pa',36),(387,'KBang',36),(388,'Đăk Đoa',36),(389,'Chư Păh',36),(390,'Ia Grai',36),(391,'Mang Yang',36),(392,'Kông Chro',36),(393,'Đức Cơ',36),(394,'Chư Prông',36),(395,'Chư Sê',36),(396,'Đăk Pơ',36),(397,'Ia Pa',36),(398,'Krông Pa',36),(399,'Phú Thiện',36),(400,'Chư Pưh',36),(401,'Đà Lạt',39),(402,'Bảo Lộc',39),(403,'Đam Rông',39),(404,'Lạc Dương',39),(405,'Lâm Hà',39),(406,'Đơn Dương',39),(407,'Đức Trọng',39),(408,'Di Linh',39),(409,'Bảo Lâm',39),(410,'Đạ Huoai',39),(411,'Đạ Tẻh',39),(412,'Cát Tiên',39),(413,'Buôn Ma Thuột',37),(414,'Buôn Hồ',37),(415,'Ea H\'leo',37),(416,'Ea Súp',37),(417,'Buôn Đôn',37),(418,'Cư M\'gar',37),(419,'Krông Búk',37),(420,'Krông Năng',37),(421,'Ea Kar',37),(422,'M\'Đrắk',37),(423,'Krông Bông',37),(424,'Krông Pắc',37),(425,'Krông A Na',37),(426,'Lắk',37),(427,'Cư Kuin',37),(428,'Phước Long',40),(429,'Đồng Xoài',40),(430,'Bình Long',40),(431,'Bù Gia Mập',40),(432,'Lộc Ninh',40),(433,'Bù Đốp',40),(434,'Hớn Quản',40),(435,'Đồng Phú',40),(436,'Bù Đăng',40),(437,'Chơn Thành',40),(438,'Phú Riềng',40),(439,'Gia Nghĩa',38),(440,'Đăk Glong',38),(441,'Cư Jút',38),(442,'Đắk Mil',38),(443,'Krông Nô',38),(444,'Đắk Song',38),(445,'Đắk R\'Lấp',38),(446,'Tuy Đức',38),(447,'Tây Ninh',41),(448,'Tân Biên',41),(449,'Tân Châu',41),(450,'Dương Minh Châu',41),(451,'Châu Thành',41),(452,'Hòa Thành',41),(453,'Gò Dầu',41),(454,'Bến Cầu',41),(455,'Trảng Bàng',41),(456,'Thủ Dầu Một',42),(457,'Bàu Bàng',42),(458,'Dầu Tiếng',42),(459,'Bến Cát',42),(460,'Phú Giáo',42),(461,'Tân Uyên',42),(462,'Dĩ An',42),(463,'Thuận An',42),(464,'Bắc Tân Uyên',42),(465,'Quận 1',45),(466,'Quận 12',45),(467,'Thủ Đức',45),(468,'Quận 9',45),(469,'Gò Vấp',45),(470,'Bình Thạnh',45),(471,'Tân Bình',45),(472,'Tân Phú',45),(473,'Phú Nhuận',45),(474,'Quận 2',45),(475,'Quận 3',45),(476,'Quận 10',45),(477,'Quận 11',45),(478,'Quận 4',45),(479,'Quận 5',45),(480,'Quận 6',45),(481,'Quận 8',45),(482,'Bình Tân',45),(483,'Quận 7',45),(484,'Củ Chi',45),(485,'Hóc Môn',45),(486,'Bình Chánh',45),(487,'Nhà Bè',45),(488,'Cần Giờ',45),(489,'Biên Hòa',43),(490,'Long Khánh',43),(491,'Tân Phú',43),(492,'Vĩnh Cửu',43),(493,'Định Quán',43),(494,'Trảng Bom',43),(495,'Thống Nhất',43),(496,'Cẩm Mỹ',43),(497,'Long Thành',43),(498,'Xuân Lộc',43),(499,'Nhơn Trạch',43),(500,'Vũng Tàu',44),(501,'Bà Rịa',44),(502,'Châu Đức',44),(503,'Xuyên Mộc',44),(504,'Long Điền',44),(505,'Đất Đỏ',44),(506,'Tân Thành',44),(507,'Tân An',46),(508,'Kiến Tường',46),(509,'Tân Hưng',46),(510,'Vĩnh Hưng',46),(511,'Mộc Hóa',46),(512,'Tân Thạnh',46),(513,'Thạnh Hóa',46),(514,'Đức Huệ',46),(515,'Đức Hòa',46),(516,'Bến Lức',46),(517,'Thủ Thừa',46),(518,'Tân Trụ',46),(519,'Cần Đước',46),(520,'Cần Giuộc',46),(521,'Châu Thành',46),(522,'Mỹ Tho',47),(523,'Gò Công',47),(524,'Cai Lậy',47),(525,'Tân Phước',47),(526,'Cái Bè',47),(527,'Cai Lậy',47),(528,'Châu Thành',47),(529,'Chợ Gạo',47),(530,'Gò Công Tây',47),(531,'Gò Công Đông',47),(532,'Tân Phú Đông',47),(533,'Vĩnh Long',50),(534,'Long Hồ',50),(535,'Mang Thít',50),(536,'Vũng Liêm',50),(537,'Tam Bình',50),(538,'Bình Minh',50),(539,'Trà Ôn',50),(540,'Bình Tân',50),(541,'Bến Tre',48),(542,'Châu Thành',48),(543,'Chợ Lách',48),(544,'Mỏ Cày Nam',48),(545,'Giồng Trôm',48),(546,'Bình Đại',48),(547,'Ba Tri',48),(548,'Thạnh Phú',48),(549,'Mỏ Cày Bắc',48),(550,'Trà Vinh',49),(551,'Càng Long',49),(552,'Cầu Kè',49),(553,'Tiểu Cần',49),(554,'Châu Thành',49),(555,'Cầu Ngang',49),(556,'Trà Cú',49),(557,'Duyên Hải',49),(558,'Duyên Hải',49),(559,'Cao Lãnh',51),(560,'Sa Đéc',51),(561,'Hồng Ngự',51),(562,'Tân Hồng',51),(563,'Hồng Ngự',51),(564,'Tam Nông',51),(565,'Tháp Mười',51),(566,'Cao Lãnh',51),(567,'Thanh Bình',51),(568,'Lấp Vò',51),(569,'Lai Vung',51),(570,'Châu Thành',51),(571,'Long Xuyên',52),(572,'Châu Đốc',52),(573,'An Phú',52),(574,'Tân Châu',52),(575,'Phú Tân',52),(576,'Châu Phú',52),(577,'Tịnh Biên',52),(578,'Tri Tôn',52),(579,'Châu Thành',52),(580,'Chợ Mới',52),(581,'Thoại Sơn',52),(582,'Vị Thanh',55),(583,'Ngã Bảy',55),(584,'Châu Thành A',55),(585,'Châu Thành',55),(586,'Phụng Hiệp',55),(587,'Vị Thuỷ',55),(588,'Long Mỹ',55),(589,'Long Mỹ',55),(590,'Ninh Kiều',54),(591,'Ô Môn',54),(592,'Bình Thuỷ',54),(593,'Cái Răng',54),(594,'Thốt Nốt',54),(595,'Vĩnh Thạnh',54),(596,'Cờ Đỏ',54),(597,'Phong Điền',54),(598,'Thới Lai',54),(599,'Rạch Giá',53),(600,'Hà Tiên',53),(601,'Kiên Lương',53),(602,'Hòn Đất',53),(603,'Tân Hiệp',53),(604,'Châu Thành',53),(605,'Giồng Riềng',53),(606,'Gò Quao',53),(607,'An Biên',53),(608,'An Minh',53),(609,'Vĩnh Thuận',53),(610,'Phú Quốc',53),(611,'Kiên Hải',53),(612,'U Minh Thượng',53),(613,'Giang Thành',53),(614,'Sóc Trăng',56),(615,'Châu Thành',56),(616,'Kế Sách',56),(617,'Mỹ Tú',56),(618,'Cù Lao Dung',56),(619,'Long Phú',56),(620,'Mỹ Xuyên',56),(621,'Ngã Năm',56),(622,'Thạnh Trị',56),(623,'Vĩnh Châu',56),(624,'Trần Đề',56),(625,'Bạc Liêu',57),(626,'Hồng Dân',57),(627,'Phước Long',57),(628,'Vĩnh Lợi',57),(629,'Giá Rai',57),(630,'Đông Hải',57),(631,'Hoà Bình',57),(632,'Cà Mau',58),(633,'U Minh',58),(634,'Thới Bình',58),(635,'Trần Văn Thời',58),(636,'Cái Nước',58),(637,'Đầm Dơi',58),(638,'Năm Căn',58),(639,'Phú Tân',58),(640,'Ngọc Hiển',58),(641,'Tuyên Quang',59),(642,'Lâm Bình',59),(643,'Nà Hang',59),(644,'Chiêm Hóa',59),(645,'Hàm Yên',59),(646,'Yên Sơn',59),(647,'Sơn Dương',59),(648,'Mê Linh',60),(649,'Hà Đông',60),(650,'Sơn Tây',60),(651,'Ba Vì',60),(652,'Phúc Thọ',60),(653,'Đan Phượng',60),(654,'Hoài Đức',60),(655,'Quốc Oai',60),(656,'Thạch Thất',60),(657,'Chương Mỹ',60),(658,'Thanh Oai',60),(659,'Thường Tín',60),(660,'Phú Xuyên',60),(661,'Ứng Hòa',60),(662,'Mỹ Đức',60),(663,'Ba Đình',60),(664,'Hoàn Kiếm',60),(665,'Tây Hồ',60),(666,'Long Biên',60),(667,'Cầu Giấy',60),(668,'Đống Đa',60),(669,'Hai Bà Trưng',60),(670,'Hoàng Mai',60),(671,'Thanh Xuân',60),(672,'Sóc Sơn',60),(673,'Đông Anh',60),(674,'Gia Lâm',60),(675,'Nam Từ Liêm',60),(676,'Thanh Trì',60),(677,'Bắc Từ Liêm',60),(678,'Cao Bằng',62),(679,'Bảo Lâm',62),(680,'Bảo Lạc',62),(681,'Thông Nông',62),(682,'Hà Quảng',62),(683,'Trà Lĩnh',62),(684,'Trùng Khánh',62),(685,'Hạ Lang',62),(686,'Quảng Uyên',62),(687,'Phục Hoà',62),(688,'Hoà An',62),(689,'Nguyên Bình',62),(690,'Thạch An',62),(691,'Hà Giang',61),(692,'Đồng Văn',61),(693,'Mèo Vạc',61),(694,'Yên Minh',61),(695,'Quản Bạ',61),(696,'Vị Xuyên',61),(697,'Bắc Mê',61),(698,'Hoàng Su Phì',61),(699,'Xín Mần',61),(700,'Bắc Quang',61),(701,'Quang Bình',61),(702,'Bắc Kạn',63),(703,'Pác Nặm',63),(704,'Ba Bể',63),(705,'Ngân Sơn',63),(706,'Bạch Thông',63),(707,'Chợ Đồn',63),(708,'Chợ Mới',63),(709,'Na Rì',63);
/*!40000 ALTER TABLE `tb_district` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_district_reference`
--

DROP TABLE IF EXISTS `tb_district_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_district_reference` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `district_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tb_district_reference_tb_district1_idx` (`district_id`),
  KEY `fk_tb_district_reference_tb_reference1_idx` (`user_id`),
  CONSTRAINT `fk_tb_district_reference_tb_district1` FOREIGN KEY (`district_id`) REFERENCES `tb_district` (`district_id`),
  CONSTRAINT `fk_tb_district_reference_tb_reference1` FOREIGN KEY (`user_id`) REFERENCES `tb_reference` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_district_reference`
--

LOCK TABLES `tb_district_reference` WRITE;
/*!40000 ALTER TABLE `tb_district_reference` DISABLE KEYS */;
INSERT INTO `tb_district_reference` VALUES (1,465,5),(2,474,5),(3,475,5),(4,465,6),(5,474,6),(6,475,6),(7,465,7),(8,474,7),(9,475,7),(10,465,8),(11,474,8),(12,475,8),(13,465,9),(14,474,9),(15,475,9),(16,465,10),(17,474,10),(18,475,10),(19,465,11),(20,474,11),(21,475,11),(22,465,12),(23,474,12),(24,475,12),(25,465,13),(26,474,13),(27,475,13),(28,465,14),(29,474,14),(30,475,14),(31,465,15),(32,474,16),(33,475,17),(34,465,18),(35,474,18),(36,475,19),(37,465,19),(38,474,20),(39,475,20),(40,465,21),(41,468,22),(42,469,23),(43,465,24),(44,464,25),(45,474,25),(46,475,537),(47,465,537),(48,474,537),(49,468,537),(50,469,537),(51,465,3919),(52,474,3920),(53,475,3921),(54,468,3922),(55,468,3923),(56,469,3924),(57,465,3925),(58,474,3926),(59,475,3927),(60,465,3928),(61,469,3929),(62,475,3919),(63,468,3920);
/*!40000 ALTER TABLE `tb_district_reference` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=1331 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_favourite`
--

LOCK TABLES `tb_favourite` WRITE;
/*!40000 ALTER TABLE `tb_favourite` DISABLE KEYS */;
INSERT INTO `tb_favourite` VALUES (1,5,2),(2,5,3),(3,5,4),(4,6,5),(5,6,6),(6,6,7),(7,7,8),(8,7,9),(9,7,10),(10,8,11),(11,8,12),(12,8,13),(13,9,14),(14,9,1),(15,9,2),(16,10,3),(17,10,4),(18,10,5),(19,11,6),(20,11,7),(21,11,8),(22,12,9),(23,12,10),(24,12,11),(25,13,12),(26,13,13),(27,13,14),(28,14,1),(29,14,2),(30,14,3),(31,15,4),(32,16,5),(33,17,6),(34,18,7),(35,18,8),(36,19,9),(37,19,10),(38,20,11),(39,20,12),(40,21,13),(41,21,14),(43,3920,29),(44,3921,30),(45,3922,31),(46,3923,32),(47,3924,33),(48,3925,34),(49,3926,35),(50,3927,36),(51,3928,37),(52,3929,1),(1316,537,22),(1317,537,25),(1318,537,21),(1319,537,15),(1320,537,16),(1321,537,1),(1322,537,2),(1323,537,3),(1324,537,4),(1325,537,5),(1326,537,26),(1327,537,27),(1328,537,37),(1329,537,36),(1330,537,34);
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
) ENGINE=InnoDB AUTO_INCREMENT=2098 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_image`
--

LOCK TABLES `tb_image` WRITE;
/*!40000 ALTER TABLE `tb_image` DISABLE KEYS */;
INSERT INTO `tb_image` VALUES (1,'http://www.cokhicongnghiep.com/assets/upload/cokhicongnghiep.com/res/data_old/products/635689421929453125_1__1_.jpg',1),(2,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/2.jpg',1),(3,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/5.jpg',1),(4,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/6.jpg',1),(5,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/6.jpg',1),(6,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/7.jpg',2),(7,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/8.jpg',2),(8,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/9.jpg',2),(9,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',2),(10,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',2),(11,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/12.jpg',3),(12,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/19.jpg',3),(13,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/20.jpg',3),(14,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/19.jpg',3),(15,'http://www.cokhicongnghiep.com/assets/upload/cokhicongnghiep.com/res/data_old/products/635689421929453125_1__1_.jpg',3),(16,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/2.jpg',4),(17,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/5.jpg',4),(18,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/6.jpg',4),(19,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/6.jpg',4),(20,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/7.jpg',4),(21,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/8.jpg',5),(22,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/9.jpg',5),(23,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',5),(24,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',5),(25,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/12.jpg',5),(26,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/19.jpg',6),(27,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/20.jpg',6),(28,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/19.jpg',6),(29,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/8.jpg',6),(30,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/9.jpg',6),(31,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',7),(32,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',7),(33,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/12.jpg',7),(34,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/19.jpg',7),(35,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/20.jpg',7),(36,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/19.jpg',8),(37,'http://www.cokhicongnghiep.com/assets/upload/cokhicongnghiep.com/res/data_old/products/635689421929453125_1__1_.jpg',8),(38,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/2.jpg',8),(39,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/5.jpg',8),(40,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/6.jpg',8),(41,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/6.jpg',9),(42,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/7.jpg',9),(43,'http://www.cokhicongnghiep.com/assets/upload/cokhicongnghiep.com/res/data_old/products/635689421929453125_1__1_.jpg',9),(44,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/2.jpg',9),(45,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/5.jpg',9),(46,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/6.jpg',10),(47,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/6.jpg',10),(48,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/7.jpg',10),(49,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/8.jpg',10),(50,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/9.jpg',10),(51,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',11),(52,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',11),(53,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/12.jpg',11),(54,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/19.jpg',11),(55,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/20.jpg',11),(56,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/19.jpg',12),(57,'http://www.cokhicongnghiep.com/assets/upload/cokhicongnghiep.com/res/data_old/products/635689421929453125_1__1_.jpg',12),(58,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/2.jpg',12),(59,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/5.jpg',12),(60,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/6.jpg',12),(61,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/6.jpg',13),(62,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/7.jpg',13),(63,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/8.jpg',13),(64,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/9.jpg',13),(65,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',13),(66,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',14),(67,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/12.jpg',14),(68,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/19.jpg',14),(69,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/20.jpg',14),(70,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/19.jpg',14),(71,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/8.jpg',15),(72,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/9.jpg',15),(73,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/9.jpg',15),(74,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',15),(75,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',15),(2051,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',16),(2052,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',16),(2053,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',16),(2054,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',16),(2055,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',16),(2056,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',17),(2057,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',18),(2058,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',19),(2059,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',20),(2060,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',21),(2061,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',22),(2062,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',23),(2063,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',24),(2064,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',25),(2065,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',26),(2066,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',27),(2067,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',28),(2068,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',29),(2069,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',30),(2070,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',31),(2071,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',32),(2072,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',33),(2073,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',34),(2074,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',35),(2075,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',36),(2076,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',37),(2077,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',17),(2078,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',18),(2079,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',19),(2080,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',20),(2081,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',21),(2082,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',22),(2083,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',23),(2084,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',24),(2085,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',25),(2086,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',26),(2087,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',27),(2088,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',28),(2089,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',29),(2090,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',30),(2091,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',31),(2092,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',32),(2093,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',33),(2094,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',34),(2095,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',35),(2096,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',36),(2097,'http://thietkekhonggiansong.com/FCKeditor/Image/Thietkenoithat/Noithat_chungcu/a_trung_timescity/11.jpg',37);
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
  `name` varchar(50) COLLATE utf8_icelandic_ci DEFAULT NULL,
  `phone_contact` varchar(15) COLLATE utf8_icelandic_ci DEFAULT NULL,
  `number_partner` int(11) DEFAULT NULL,
  `gender_partner` int(11) DEFAULT NULL,
  `date_post` date DEFAULT NULL,
  `type_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `room_id` int(11) DEFAULT NULL,
  `longtitude` double DEFAULT NULL,
  `lattitude` double DEFAULT NULL,
  `min_price` float DEFAULT NULL,
  `max_price` float DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_icelandic_ci DEFAULT NULL,
  PRIMARY KEY (`post_id`),
  KEY `fk_tb_post_tb_type1_idx` (`type_id`),
  KEY `fk_tb_post_tb_user1_idx` (`user_id`),
  KEY `fk_tb_post_tb_room1_idx` (`room_id`),
  CONSTRAINT `fk_tb_post_tb_type1` FOREIGN KEY (`type_id`) REFERENCES `tb_type` (`type_id`),
  CONSTRAINT `fk_tb_post_tb_user1` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_post`
--

LOCK TABLES `tb_post` WRITE;
/*!40000 ALTER TABLE `tb_post` DISABLE KEYS */;
INSERT INTO `tb_post` VALUES (1,'phòng trọ sinh viên','0904234809',2,2,'2016-03-23',1,5,1,106.6917893,10.7723159,1000000,NULL,'a'),(2,'căn hộ mini','0904234820',2,2,'2016-03-24',1,6,2,106.7020418,10.7780263,2000000,NULL,'b'),(3,'Tìm người ở ghép','0904234831',2,2,'2016-03-25',1,5,3,106.7006886,10.7880698,3000000,NULL,'a'),(4,'Tìm nam ở ghép','0904234842',2,1,'2016-03-26',1,8,4,106.687783,10.76994,1500000,NULL,'a'),(5,'Tìm nữ ở ghép','0904234853',2,2,'2016-03-27',1,9,5,106.704748,10.7718259,1200000,NULL,'b'),(6,'phòng trọ sinh viên','0904234864',2,2,'2016-03-28',1,10,6,106.7073924,10.7793826,3000000,NULL,'a'),(7,'căn hộ mini','0904234875',2,1,'2016-03-29',1,11,7,106.7515503,10.7984131,5000000,NULL,'b'),(8,'căn hộ mini','0904234886',2,1,'2016-03-30',1,12,8,106.7456171,10.7930606,4500000,NULL,'a'),(9,'Tìm người ở ghép','0904234897',2,2,'2016-03-31',1,13,9,106.7251562,10.768701,6000000,NULL,'a'),(10,'Tìm nam ở ghép','0904234908',2,1,'2016-04-01',1,14,10,106.7378454,10.7954934,2500000,NULL,'b'),(11,'Tìm nữ ở ghép','0904234919',2,1,'2016-04-02',1,15,11,106.7656088,10.7704951,3000000,NULL,'a'),(12,'phòng trọ sinh viên','0904234930',2,1,'2016-04-03',1,16,12,106.7301725,10.8064941,1000000,NULL,'b'),(13,'căn hộ mini','0904234941',2,2,'2016-04-04',1,17,13,106.7290004,10.8170699,2000000,NULL,'a'),(14,'Tìm người ở ghép','0904234952',2,2,'2016-04-05',1,18,14,106.7433457,10.8060578,2800000,NULL,'a'),(15,'Tìm phòng gác lửng','0904250968',NULL,1,'2018-10-20',2,19,NULL,NULL,NULL,210000,6000000,NULL),(16,'Tìm phòng giá rẻ','0904250979',NULL,2,'2018-10-21',2,19,NULL,NULL,NULL,222222,8000000,NULL),(17,'Tìm phòng sinh viên','0904250990',NULL,2,'2018-10-22',2,19,NULL,NULL,NULL,200000,9000000,NULL),(18,'Tìm phòng gác lửng','0904251001',NULL,1,'2018-10-23',2,20,NULL,NULL,NULL,250000,20000000,NULL),(19,'Tìm phòng giá rẻ','0904251012',NULL,2,'2018-10-24',2,20,NULL,NULL,NULL,231000,1542560,NULL),(20,'Tìm phòng sinh viên','0904251023',NULL,1,'2018-10-25',2,21,NULL,NULL,NULL,1251240,22222200,NULL),(21,'Tìm phòng gác lửng','0904251034',NULL,2,'2018-10-26',2,21,NULL,NULL,NULL,1354210,50000000,NULL),(22,'Tìm phòng giá rẻ','0904251045',NULL,1,'2018-10-27',2,22,NULL,NULL,NULL,2115470,10000000,NULL),(23,'Tìm phòng sinh viên','0904251023',NULL,2,'2018-10-25',2,5,NULL,NULL,NULL,500000,22222200,NULL),(24,'Tìm phòng gác lửng','0904251034',NULL,2,'2018-10-26',2,5,NULL,NULL,NULL,600000,50000000,NULL),(25,'Tìm phòng giá rẻ','0904251045',NULL,2,'2018-10-27',2,5,NULL,NULL,NULL,700000,10000000,NULL),(26,'Tìm phòng giá rẻ','0904251045',NULL,2,'2018-10-27',2,537,NULL,NULL,NULL,500000,10000000,NULL),(27,'Tìm nam ở ghép','0904251045',2,1,'2018-10-28',1,3919,15,106.72574,10.8517489,10000000,NULL,'a'),(29,'căn hộ mini','0904251045',2,2,'2018-10-30',1,3921,17,106.682041,10.7882696,5000000,NULL,'v'),(30,'Tìm nam ở ghép','0904251045',2,1,'2018-11-01',1,3922,18,106.680658,10.7722307,6000000,NULL,'as'),(31,'tìm nữ ở ghép','0904251045',2,2,'2018-11-02',1,537,21,106.675056,10.782029,3000000,NULL,'d'),(32,'Tìm nam ở ghép','0904251045',2,1,'2018-11-03',1,3924,20,106.695201,10.7801688,2000000,NULL,'w'),(33,'Tìm nam ở ghép','0904251045',2,1,'2018-11-04',1,3925,21,106.6764377,10.7684748,1000000,NULL,'gasdf'),(34,'nhà 2 tầng','0904251045',2,2,'2018-11-05',1,3926,22,106.7194982,10.7990011,4000000,NULL,'awef'),(35,'Tìm nam ở ghép','0904251045',2,2,'2018-11-06',1,3927,23,106.6854271,10.770763,1500000,NULL,'h'),(36,'căn hộ 2 gác lửng','0904251045',2,2,'2018-11-07',1,3928,24,106.6878933,10.7797591,2500000,NULL,'ef'),(37,'Tìm nam ở ghép','0904251045',2,1,'2018-11-08',1,3929,25,106.6881762,10.7747488,600000,NULL,'e');
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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_post_has_tb_district`
--

LOCK TABLES `tb_post_has_tb_district` WRITE;
/*!40000 ALTER TABLE `tb_post_has_tb_district` DISABLE KEYS */;
INSERT INTO `tb_post_has_tb_district` VALUES (1,1,465),(2,2,465),(3,3,465),(4,4,465),(5,5,465),(6,6,465),(7,7,465),(8,8,465),(9,9,465),(10,10,465),(11,11,465),(12,12,465),(13,13,465),(14,14,465),(15,15,465),(16,16,465),(17,17,465),(18,18,465),(19,19,465),(20,20,465),(21,21,465),(22,22,465),(23,23,465),(24,24,465),(25,25,465),(26,26,465),(27,26,474),(28,27,475),(30,29,475),(31,30,475),(32,31,475),(33,32,475),(34,33,475),(35,34,475),(36,35,475),(37,36,475),(38,37,475);
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
) ENGINE=InnoDB AUTO_INCREMENT=231 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_rate`
--

LOCK TABLES `tb_rate` WRITE;
/*!40000 ALTER TABLE `tb_rate` DISABLE KEYS */;
INSERT INTO `tb_rate` VALUES (1,15,1,1.5,1.5,1.5),(2,16,2,2,2.5,2),(3,17,3,2.5,5,2.5),(4,18,4,3,5,3),(5,19,5,3.5,5,3.5),(6,20,6,4,4,4),(7,21,7,4.5,4,4.5),(8,22,8,5,3,5),(9,23,9,5,2,5),(10,24,10,5,1,5),(11,25,11,4,1,4),(12,26,12,1.5,1.5,1.5),(13,27,13,2.5,2,2.5),(14,28,14,1.5,2.5,1.5),(15,29,15,2,3,2),(16,30,16,2,3.5,2),(17,31,17,3,4,3),(18,32,18,4,4.5,4),(19,33,19,5,5,5),(20,34,20,5,5,5),(21,35,21,5,5,5),(22,36,22,2.5,4,2.5),(23,37,23,3.5,1.5,3.5),(24,38,24,2,2.5,2),(25,39,25,0.5,1.5,0.5),(26,40,26,1,2,1),(27,41,27,1.5,2,1.5),(28,42,28,1,3,1),(29,43,29,1,4,1),(30,44,30,1,5,1),(31,45,31,1,5,1),(32,46,32,1.5,5,1.5),(33,47,33,2,2.5,2),(34,48,34,2.5,3.5,2.5),(35,49,35,3,2,3),(36,50,36,3.5,0.5,3.5),(37,51,37,4,1,4),(38,52,38,4.5,1.5,4.5),(39,53,39,5,1,5),(40,54,40,5,1,5),(41,55,41,5,1,5),(42,56,42,4,1,4),(43,57,43,1.5,1.5,1.5),(44,58,44,2.5,2,2.5),(45,59,45,1.5,2.5,1.5),(46,60,46,2,3,2),(47,61,47,2,3.5,2),(48,62,48,3,4,3),(49,63,49,4,4.5,4),(50,64,50,5,5,5),(51,65,51,5,5,5),(52,66,52,5,5,5),(53,67,53,2.5,4,2.5),(54,68,54,3.5,1.5,3.5),(55,69,55,2,2.5,2),(56,70,56,0.5,1.5,0.5),(57,71,57,1,2,1),(58,72,58,1.5,2,1.5),(59,73,59,1,3,1),(60,74,60,1,4,1),(61,75,61,1,5,1),(62,76,62,1,5,1),(63,77,63,1.5,5,1.5),(64,78,64,2,2.5,2),(65,79,65,2.5,3.5,2.5),(66,80,66,3,2,3),(67,81,67,3.5,0.5,3.5),(68,82,68,4,1,4),(69,83,69,4.5,1.5,4.5),(70,84,70,5,1,5),(71,85,71,5,1,5),(72,86,72,5,1,5),(73,87,73,4,1,4),(74,88,74,1.5,1.5,1.5),(75,89,75,2.5,2,2.5),(76,90,76,1.5,2.5,1.5),(77,91,77,2,3,2),(78,92,78,2,3.5,2),(79,93,79,3,4,3),(80,94,80,4,4.5,4),(81,95,81,5,5,5),(82,96,82,5,5,5),(83,97,83,5,5,5),(84,98,84,2.5,4,2.5),(85,99,85,3.5,1.5,3.5),(86,100,86,2,2.5,2),(87,101,87,0.5,1.5,0.5),(88,102,88,1,2,1),(89,103,89,1.5,2,1.5),(90,104,90,1,3,1),(91,105,91,1,4,1),(92,106,92,1,5,1),(93,107,93,1,5,1),(94,108,94,1.5,5,1.5),(95,109,95,2,2.5,2),(96,110,96,2.5,3.5,2.5),(97,111,97,3,2,3),(98,112,98,3.5,0.5,3.5),(99,113,99,4,1,4),(100,114,100,4.5,1.5,4.5),(101,115,101,5,1,5),(102,116,102,5,1,5),(103,117,103,5,1,5),(104,118,104,4,1,4),(105,119,105,1.5,1.5,1.5),(106,120,106,2.5,2,2.5),(107,121,107,1.5,2.5,1.5),(108,122,108,2,3,2),(109,123,109,2,3.5,2),(110,124,110,3,4,3),(111,125,111,4,4.5,4),(112,126,112,5,5,5),(113,127,113,5,5,5),(114,128,114,5,5,5),(115,129,115,2.5,4,2.5),(116,130,116,3.5,1.5,3.5),(117,131,117,2,2.5,2),(118,132,118,1.5,1.5,1.5),(119,133,119,2,2,2),(120,134,120,2.5,2,2.5),(121,135,121,3,3,3),(122,136,122,3.5,4,3.5),(123,137,123,4,5,4),(124,138,124,4.5,5,4.5),(125,139,125,5,5,5),(126,140,126,5,2.5,5),(127,141,127,5,3.5,5),(128,142,128,4,2,4),(129,143,129,1.5,1.5,1.5),(130,144,130,2.5,2,2.5),(131,145,131,1.5,2.5,1.5),(132,146,132,2,3,2),(133,147,133,2,3.5,2),(134,148,134,3,4,3),(135,149,135,4,4.5,4),(136,150,136,5,5,5),(137,151,137,5,5,5),(138,152,138,5,5,5),(139,153,139,2.5,4,2.5),(140,154,140,3.5,1.5,3.5),(141,155,141,2,2.5,2),(142,156,142,0.5,1.5,0.5),(143,157,143,1,2,1),(144,158,144,1.5,2,1.5),(145,159,145,1,3,1),(146,160,146,1,4,1),(147,161,147,1,5,1),(148,162,148,1,5,1),(149,163,149,1.5,5,1.5),(150,164,150,2,2.5,2),(151,165,151,2.5,3.5,2.5),(152,166,152,3,2,3),(153,167,153,3.5,0.5,3.5),(154,168,154,4,1,4),(155,169,155,4.5,1.5,1.5),(156,170,156,5,1,2),(157,171,157,5,1,2.5),(158,172,158,5,1,3),(159,173,159,4,1,3.5),(160,174,160,1.5,1.5,4),(161,175,161,2.5,2,4.5),(162,176,162,1.5,2.5,5),(163,177,163,2,3,5),(164,178,164,2,3.5,5),(165,179,165,3,4,4),(166,180,166,4,1.5,1.5),(167,181,167,5,2,2.5),(168,182,168,5,2.5,1.5),(169,183,169,1.5,3,2),(170,184,170,2,3.5,2),(171,185,171,2.5,4,3),(172,186,172,3,4.5,4),(173,187,173,3.5,5,5),(174,188,174,4,5,5),(175,189,175,4.5,5,5),(176,190,176,5,4,2.5),(177,191,177,5,1.5,3.5),(178,192,178,5,2.5,2),(179,193,179,4,1.5,0.5),(180,194,180,1.5,2,1),(181,195,181,2.5,2,1.5),(182,196,182,1.5,3,1),(183,197,183,2,4,1),(184,198,184,2,5,1),(185,199,185,3,5,1),(186,200,186,4,5,1.5),(187,201,187,5,2.5,2),(188,202,188,5,3.5,2.5),(189,203,189,5,2,3),(190,204,190,2.5,0.5,3.5),(191,205,191,3.5,1,4),(192,206,192,2,1.5,4.5),(193,207,193,0.5,1,5),(194,208,194,1,1,5),(195,209,195,1.5,1,5),(196,210,196,1,1,4),(197,211,197,1,1.5,1.5),(198,212,198,1,2,2.5),(199,213,199,1,2.5,1.5),(200,214,200,1.5,3,2),(201,215,201,2,3.5,2),(202,216,202,2.5,4,3),(203,217,203,3,4.5,4),(204,218,204,3.5,5,5),(205,219,205,4,5,5),(206,220,206,4.5,5,5),(207,221,207,5,4,2.5),(208,222,208,5,1.5,3.5),(209,223,209,5,2.5,2),(210,224,210,4,1.5,0.5),(211,225,211,1.5,2,1),(212,226,212,2.5,2,1.5),(213,227,213,1.5,3,1),(214,228,214,2,4,1),(215,229,215,2,5,1),(216,230,216,3,5,1),(217,231,217,4,5,1.5),(218,232,218,5,2.5,2),(219,233,219,5,3.5,2.5),(220,234,220,5,2,3),(221,235,221,2.5,0.5,3.5),(222,236,222,3.5,1,4),(223,237,223,2,1.5,4.5),(224,238,224,0.5,1,5),(225,239,225,1,1,5),(226,240,226,1.5,1,5),(227,241,227,1,1,4),(228,242,228,1,1.5,1.5),(229,243,229,1,2,2.5),(230,244,230,1,2.5,1.5);
/*!40000 ALTER TABLE `tb_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_reference`
--

DROP TABLE IF EXISTS `tb_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_reference` (
  `user_id` int(11) NOT NULL,
  `min_price` float DEFAULT NULL,
  `max_price` float DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `fk_tb_reference_tb_user1_idx` (`user_id`),
  CONSTRAINT `fk_tb_reference_tb_user1` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_reference`
--

LOCK TABLES `tb_reference` WRITE;
/*!40000 ALTER TABLE `tb_reference` DISABLE KEYS */;
INSERT INTO `tb_reference` VALUES (5,1000000,31000000),(6,3000000,8000000),(7,4000000,40000000),(8,2000000,33000000),(9,2000000,45000000),(10,4000000,22000000),(11,2000000,12000000),(12,4000000,26000000),(13,4000000,16000000),(14,4000000,4000000),(15,2000000,23000000),(16,3000000,43000000),(17,1000000,49000000),(18,2000000,34000000),(19,2000000,28000000),(20,2000000,26000000),(21,1000000,15000000),(22,200000,2500000),(23,300000,30000000),(24,5000000,40000000),(25,600000,45000000),(537,1000000,10000000),(3919,500000,20000000),(3920,600000,6000000),(3921,700000,45000000),(3922,800000,25000000),(3923,900000,30000000),(3924,540000,12000000),(3925,560000,22000000),(3926,580000,2520000),(3927,650000,33000000),(3928,630000,36000000),(3929,520000,10000000);
/*!40000 ALTER TABLE `tb_reference` ENABLE KEYS */;
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
  `name` varchar(50) NOT NULL,
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
  KEY `fk_tb_room_tb_user1_idx` (`user_id`),
  KEY `fk_tb_room_tb_city1_idx` (`city_id`),
  KEY `fk_tb_room_tb_district1_idx` (`district_id`),
  KEY `fk_tb_room_tb_status1_idx` (`status_id`),
  CONSTRAINT `fk_tb_room_tb_city1` FOREIGN KEY (`city_id`) REFERENCES `tb_city` (`city_id`),
  CONSTRAINT `fk_tb_room_tb_district1` FOREIGN KEY (`district_id`) REFERENCES `tb_district` (`district_id`),
  CONSTRAINT `fk_tb_room_tb_status1` FOREIGN KEY (`status_id`) REFERENCES `tb_status` (`status_id`),
  CONSTRAINT `fk_tb_room_tb_user1` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_room`
--

LOCK TABLES `tb_room` WRITE;
/*!40000 ALTER TABLE `tb_room` DISABLE KEYS */;
INSERT INTO `tb_room` VALUES (1,'Phòng có gác',2000000,21,'81 Cách Mạng Tháng Tám, Phường Bến Thành, Quận 1, TP Hồ Chí Minh',3,1,'Phòng mặt tiền',2,45,465,'2016-01-23',1,106.6917893,10.7723159),(2,'Căn hộ mini',3000000,21,'187/7 Điện Biên Phủ, Phường Đa Kao, Quận 1, TP Hồ Chí Minh',3,1,'Phòng giá rẻ',2,45,465,'2016-01-24',1,106.7020418,10.7780263),(3,'Căn hộ mặt tiền',4000000,22,'81 Cách Mạng Tháng Tám, Phường Bến Thành, Quận 1, TP Hồ Chí Minh',3,1,'Phòng mặt tiền',2,45,465,'2016-01-25',1,106.7006886,10.7880698),(4,'Phòng giá rẻ',13973800,22,'8/46 Đinh Tiên Hoàng, Phường Đa Kao, Quận 1, TP Hồ Chí Minh',3,1,'Phòng giá rẻ',2,45,465,'2016-01-26',1,106.687783,10.76994),(5,'Phòng mặt tiền',41112800,23,'3 Tôn Đức Thắng, Phường Bến Nghé, Quận 1, TP Hồ Chí Minh',3,1,'Phòng mặt tiền',2,45,465,'2016-01-27',1,106.704748,10.7718259),(6,'Phòng có gác',39202600,23,'72 Lê Thánh T, Phường Bến Nghé, Quận 1, TP Hồ Chí Minh',3,1,'Phòng giá rẻ',2,45,465,'2016-01-28',1,106.7073924,10.7793826),(7,'Căn hộ mini',37684900,24,'8 Bùi Thi Xuân, Phường Bến Thành, Quận 1, TP Hồ Chí Minh',3,1,'Phòng mặt tiền',2,45,465,'2016-01-29',1,106.7515503,10.7984131),(8,'Căn hộ mặt tiền',11987300,24,'02 Hải Triều, Phường Bến Nghé, Quận 1, TP Hồ Chí Minh',3,1,'Phòng giá rẻ',2,45,465,'2016-01-30',1,106.7456171,10.7930606),(9,'Phòng giá rẻ',38068900,25,'67 Đường Mai Chí Thọ, Phường An Phú, Quận 2, TP Hồ Chí Minh',3,1,'Phòng mặt tiền',2,45,474,'2016-01-31',1,106.7251562,10.768701),(10,'Phòng mặt tiền',17115500,25,'216 Nguyễn Hoàng, Khu phố 5, Phường An Phú, Quận 2, TP Hồ Chí Minh',3,1,'Phòng giá rẻ',3,45,474,'2016-02-01',1,106.7378454,10.7954934),(11,'Phòng có gác',47157900,26,'83 Nguyễn Khoa Đăng, Phường Thạnh Mỹ Lợi, Quận 2, TP Hồ Chí Minh',3,1,'Phòng mặt tiền',3,45,474,'2016-02-02',1,106.7656088,10.7704951),(12,'Căn hộ mini',12927300,26,'95 Nguyễn Cơ Thạch, Phường An Lợi Đông, Quận 2, TP Hồ Chí Minh',3,1,'Phòng giá rẻ',3,45,474,'2016-02-03',1,106.7301725,10.8064941),(13,'Căn hộ mặt tiền',46057500,27,'50 đường 5, Phường Thảo Điền, Quận 2, TP Hồ Chí Minh',3,1,'Phòng mặt tiền',3,45,474,'2016-02-04',1,106.7290004,10.8170699),(14,'Phòng giá rẻ',37009200,27,'18A1 Đường 43, Phường Thảo Điền, Quận 2, TP Hồ Chí Minh',3,1,'Phòng giá rẻ',3,45,474,'2016-02-05',1,106.7433457,10.8060578),(15,'Phòng mặt tiền',19143100,28,'189C3 Nguyễn Văn Hưởng, Phường Thảo Điền, Quận 2, TP Hồ Chí Minh',3,1,'Phòng mặt tiền',3,45,474,'2016-02-06',1,106.72574,10.8517489),(16,'Phòng giá rẻ',39768900,40,'100 Nguyễn Thị Minh Khai, Phường 06, Quận 3, TP Hồ Chí Minh',3,1,'Phòng mặt tiền',3,45,475,'2016-03-01',1,106.676969,10.785639),(17,'Phòng mặt tiền',35169600,40,'378/29 Cách Mạng Tháng 8, Phường 10, Quận 3, TP Hồ Chí Minh',3,1,'Phòng giá rẻ',3,45,475,'2016-03-02',1,106.682041,10.7882696),(18,'Phòng có gác',42148500,41,'42-44 Nguyễn Hiền, Cư xá Đô Thành, Phường 04, Quận 3, TP Hồ Chí Minh',3,1,'Phòng mặt tiền',3,45,475,'2016-03-03',1,106.680658,10.7722307),(19,'Căn hộ mini',36713100,41,'633/14D, Điện Biên Phủ, Phường 01, Quận 3, TP Hồ Chí Minh',3,1,'Phòng giá rẻ',3,45,475,'2016-03-04',1,106.675056,10.782029),(20,'Căn hộ mặt tiền',39006300,42,'339/52 Lê Văn Sỹ, Phường 13, Quận 3, TP Hồ Chí Minh',3,1,'Phòng mặt tiền',3,45,475,'2016-03-05',1,106.695201,10.7801688),(21,'Phòng giá rẻ',34860700,42,'792 Trường Sa, Phường 14, Quận 3, TP Hồ Chí Minh',3,1,'Phòng giá rẻ',3,45,475,'2016-03-06',1,106.6764377,10.7684748),(22,'Phòng mặt tiền',26029600,43,'23 Nguyễn Sơn Hà, Phuờng 05, Quận 3, TP Hồ Chí Minh',3,1,'Phòng mặt tiền',3,45,475,'2016-03-07',1,106.7194982,10.7990011),(23,'Phòng có gác',49321100,43,'591 Điện Biên Phủ, Phường 01, Quận 3, TP Hồ Chí Minh',3,1,'Phòng giá rẻ',3,45,475,'2016-03-08',1,106.6854271,10.770763),(24,'Căn hộ mini',22366400,44,'590 Cách Mạng Tháng Tám, Phường 11, Quận 3, TP Hồ Chí Minh',3,1,'Phòng mặt tiền',3,45,475,'2016-03-09',1,106.6878933,10.7797591),(25,'Căn hộ mặt tiền',10299200,44,'32A Trương Định, Phường 07, Quận 3, TP Hồ Chí Minh',3,1,'Phòng giá rẻ',4,45,475,'2016-03-10',1,106.6881762,10.7747488),(26,'Phòng giá rẻ',38606800,45,'62A cách mạng tháng tám, Phường 06, Quận 3, TP Hồ Chí Minh',3,1,'Phòng mặt tiền',4,45,475,'2016-03-11',1,106.666297,10.786377),(27,'Phòng giá rẻ',31000000,80,'100 Nguyễn Thị Minh Khai, Phường 06, Quận 3, TP Hồ Chí Minh',3,1,'Phòng mặt tiền',4,45,475,'2016-03-01',1,106.676969,10.785639),(28,'Phòng mặt tiền',6000000,267,'378/29 Cách Mạng Tháng 8, Phường 10, Quận 3, TP Hồ Chí Minh',3,1,'Phòng giá rẻ',4,45,475,'2016-03-02',1,106.682041,10.7882696),(29,'Phòng có gác',6000000,71,'42-44 Nguyễn Hiền, Cư xá Đô Thành, Phường 04, Quận 3, TP Hồ Chí Minh',3,1,'Phòng mặt tiền',4,45,475,'2016-03-03',1,106.680658,10.7722307),(30,'Căn hộ mini',27000000,242,'633/14D, Điện Biên Phủ, Phường 01, Quận 3, TP Hồ Chí Minh',3,1,'Phòng giá rẻ',4,45,475,'2016-03-04',1,106.675056,10.782029),(31,'Căn hộ mặt tiền',14000000,235,'339/52 Lê Văn Sỹ, Phường 13, Quận 3, TP Hồ Chí Minh',3,1,'Phòng mặt tiền',4,45,475,'2016-03-05',1,106.695201,10.7801688),(32,'Phòng giá rẻ',32000000,299,'792 Trường Sa, Phường 14, Quận 3, TP Hồ Chí Minh',3,1,'Phòng giá rẻ',4,45,475,'2016-03-06',1,106.6764377,10.7684748),(33,'Phòng mặt tiền',42000000,250,'23 Nguyễn Sơn Hà, Phuờng 05, Quận 3, TP Hồ Chí Minh',3,1,'Phòng mặt tiền',4,45,475,'2016-03-07',1,106.7194982,10.7990011),(34,'Phòng có gác',15000000,237,'591 Điện Biên Phủ, Phường 01, Quận 3, TP Hồ Chí Minh',3,1,'Phòng giá rẻ',4,45,475,'2016-03-08',1,106.6854271,10.770763),(35,'Căn hộ mini',29000000,129,'590 Cách Mạng Tháng Tám, Phường 11, Quận 3, TP Hồ Chí Minh',3,1,'Phòng mặt tiền',4,45,475,'2016-03-09',1,106.6878933,10.7797591),(36,'Căn hộ mặt tiền',29000000,265,'32A Trương Định, Phường 07, Quận 3, TP Hồ Chí Minh',3,1,'Phòng giá rẻ',4,45,475,'2016-03-10',1,106.6881762,10.7747488),(37,'Phòng giá rẻ',8000000,225,'62A cách mạng tháng tám, Phường 06, Quận 3, TP Hồ Chí Minh',3,1,'Phòng mặt tiền',4,45,475,'2016-03-11',1,106.666297,10.786377);
/*!40000 ALTER TABLE `tb_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_room_has_user`
--

DROP TABLE IF EXISTS `tb_room_has_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_room_has_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `date_in` date NOT NULL,
  `date_out` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_room_has_user`
--

LOCK TABLES `tb_room_has_user` WRITE;
/*!40000 ALTER TABLE `tb_room_has_user` DISABLE KEYS */;
INSERT INTO `tb_room_has_user` VALUES (1,5,1,'2018-02-01','2018-09-01'),(2,6,2,'2018-02-02','2018-08-01'),(3,7,3,'2018-02-03','2018-05-01'),(4,8,4,'2018-02-04','2018-12-01'),(5,9,5,'2018-02-05','2018-08-01'),(6,15,6,'2018-02-06','2018-08-01'),(7,15,7,'2018-02-07','2018-08-01'),(8,15,8,'2018-02-08','2018-08-01'),(9,15,9,'2018-02-09','2018-08-01'),(10,15,10,'2018-02-10','2018-08-01'),(11,15,11,'2018-02-11',NULL),(12,16,12,'2018-02-12',NULL),(13,17,13,'2018-02-13',NULL),(14,19,14,'2018-02-16',NULL),(15,20,14,'2018-02-17',NULL),(16,21,14,'2018-02-18',NULL),(17,22,13,'2018-02-19',NULL),(18,3919,15,'2018-02-18',NULL),(19,3920,16,'2018-02-18',NULL),(20,3921,17,'2018-02-18',NULL),(21,3922,18,'2018-02-18',NULL),(22,3923,19,'2018-02-18',NULL),(23,3924,20,'2018-02-18',NULL),(24,3925,21,'2018-02-18',NULL),(25,3926,22,'2018-02-18',NULL),(26,3927,23,'2018-02-18',NULL),(27,3928,24,'2018-02-18',NULL),(28,3929,25,'2018-02-18',NULL);
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
  `brand` varchar(50) COLLATE utf8_icelandic_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_icelandic_ci DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tb_utilities_has_tb_room_tb_room1_idx` (`room_id`),
  KEY `fk_tb_utilities_has_tb_room_tb_utilities1_idx` (`utility_id`),
  CONSTRAINT `fk_tb_utilities_has_tb_room_tb_room1` FOREIGN KEY (`room_id`) REFERENCES `tb_room` (`room_id`),
  CONSTRAINT `fk_tb_utilities_has_tb_room_tb_utilities1` FOREIGN KEY (`utility_id`) REFERENCES `tb_utilities` (`utility_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1976 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_room_has_utility`
--

LOCK TABLES `tb_room_has_utility` WRITE;
/*!40000 ALTER TABLE `tb_room_has_utility` DISABLE KEYS */;
INSERT INTO `tb_room_has_utility` VALUES (1,1,1,'Panasonic',NULL,1),(2,1,2,'Electrolux',NULL,1),(3,1,3,'Sony',NULL,1),(4,1,4,'LG',NULL,1),(5,1,5,'B-Come',NULL,1),(6,2,6,'Panasonic',NULL,1),(7,2,7,'Electrolux',NULL,1),(8,2,8,'Sony',NULL,1),(9,2,9,'LG',NULL,1),(10,2,10,'B-Come',NULL,1),(11,3,11,'Panasonic',NULL,1),(12,3,12,'Electrolux',NULL,1),(13,3,13,'Sony',NULL,1),(14,3,14,'LG',NULL,1),(15,3,15,'B-Come',NULL,1),(16,4,1,'Panasonic',NULL,1),(17,4,2,'Electrolux',NULL,1),(18,4,3,'Sony',NULL,1),(19,4,4,'LG',NULL,1),(20,4,5,'B-Come',NULL,1),(21,5,6,'Panasonic',NULL,1),(22,5,7,'Electrolux',NULL,1),(23,5,8,'Sony',NULL,1),(24,5,9,'LG',NULL,1),(25,5,10,'B-Come',NULL,1),(26,6,11,'Panasonic',NULL,1),(27,6,12,'Electrolux',NULL,1),(28,6,13,'Sony',NULL,1),(29,6,14,'LG',NULL,1),(30,6,15,'B-Come',NULL,1),(31,7,1,'Panasonic',NULL,1),(32,7,2,'Electrolux',NULL,1),(33,7,3,'Sony',NULL,1),(34,7,4,'LG',NULL,1),(35,7,5,'B-Come',NULL,1),(36,8,6,'Panasonic',NULL,1),(37,8,7,'Electrolux',NULL,1),(38,8,8,'Sony',NULL,1),(39,8,9,'LG',NULL,1),(40,8,10,'B-Come',NULL,1),(41,9,11,'Panasonic',NULL,1),(42,9,12,'Electrolux',NULL,1),(43,9,13,'Sony',NULL,1),(44,9,14,'LG',NULL,1),(45,9,15,'B-Come',NULL,1),(46,10,1,'Panasonic',NULL,1),(47,10,2,'Electrolux',NULL,1),(48,10,3,'Sony',NULL,1),(49,10,4,'LG',NULL,1),(50,10,5,'Panasonic',NULL,1),(51,11,6,'Electrolux',NULL,1),(52,11,7,'Sony',NULL,1),(53,11,8,'LG',NULL,1),(54,11,9,'B-Come',NULL,1),(55,11,10,'Panasonic',NULL,1),(56,12,11,'Electrolux',NULL,1),(57,12,12,'Sony',NULL,1),(58,12,13,'LG',NULL,1),(59,12,14,'B-Come',NULL,1),(60,12,15,'Panasonic',NULL,1),(61,13,1,'Electrolux',NULL,1),(62,13,2,'Sony',NULL,1),(63,13,3,'LG',NULL,1),(64,13,4,'B-Come',NULL,1),(65,13,5,'Panasonic',NULL,1),(66,14,6,'Electrolux',NULL,1),(67,14,7,'Sony',NULL,1),(68,14,8,'LG',NULL,1),(69,14,9,'B-Come',NULL,1),(70,14,10,'Panasonic',NULL,1),(71,15,11,'Electrolux',NULL,1),(72,15,12,'Sony',NULL,1),(73,15,13,'LG',NULL,1),(74,15,14,'B-Come',NULL,1),(75,15,15,'Panasonic',NULL,1),(1952,17,2,'Sony',NULL,1),(1953,18,3,'Panasonic',NULL,1),(1954,19,4,'Panasonic',NULL,1),(1955,20,5,'Panasonic',NULL,1),(1956,21,6,'Panasonic',NULL,1),(1957,22,7,'Panasonic',NULL,1),(1958,23,8,'Panasonic',NULL,1),(1959,24,9,'Panasonic',NULL,1),(1960,25,10,'Panasonic',NULL,1),(1961,26,11,'Panasonic',NULL,1),(1962,27,12,'Panasonic',NULL,1),(1963,28,13,'Panasonic',NULL,1),(1964,29,14,'Panasonic',NULL,1),(1965,30,15,'Panasonic',NULL,1),(1966,31,1,'Panasonic',NULL,1),(1967,32,2,'Panasonic',NULL,1),(1968,33,3,'Panasonic',NULL,1),(1969,34,4,'Panasonic',NULL,1),(1970,35,5,'Panasonic',NULL,1),(1971,36,6,'Panasonic',NULL,1),(1972,37,7,'Panasonic',NULL,1),(1973,37,8,'sony',NULL,1),(1974,37,9,'samsung',NULL,1),(1975,37,10,'lg',NULL,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=321 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_room_reference`
--

LOCK TABLES `tb_room_reference` WRITE;
/*!40000 ALTER TABLE `tb_room_reference` DISABLE KEYS */;
INSERT INTO `tb_room_reference` VALUES (1,1,15),(2,2,16),(3,3,17),(4,4,18),(5,5,19),(6,6,20),(7,7,21),(8,8,22),(9,9,23),(10,10,24),(11,11,25),(12,12,26),(13,13,27),(14,14,28),(15,15,29),(16,16,30),(17,17,31),(18,18,32),(19,19,33),(20,20,34),(21,21,35),(22,22,36),(23,23,37),(24,24,38),(25,25,39),(26,26,40),(27,27,41),(28,28,42),(29,29,43),(30,30,44),(31,31,45),(32,32,46),(33,33,47),(34,34,48),(35,35,49),(36,36,50),(37,37,51),(38,38,52),(39,39,53),(40,40,54),(41,41,55),(42,42,56),(43,43,57),(44,44,58),(45,45,59),(46,46,60),(47,47,61),(48,48,62),(49,49,63),(50,50,64),(51,51,65),(52,52,66),(53,53,67),(54,54,68),(55,55,69),(56,56,70),(57,57,71),(58,58,72),(59,59,73),(60,60,74),(61,61,75),(62,62,76),(63,63,77),(64,64,78),(65,65,79),(66,66,80),(67,67,81),(68,68,82),(69,69,83),(70,70,84),(71,71,85),(72,72,86),(73,73,87),(74,74,88),(75,75,89),(76,76,90),(77,77,91),(78,78,92),(79,79,93),(80,80,94),(81,81,95),(82,82,96),(83,83,97),(84,84,98),(85,85,99),(86,86,100),(87,87,101),(88,88,102),(89,89,103),(90,90,104),(91,91,105),(92,92,106),(93,93,107),(94,94,108),(95,95,109),(96,96,110),(97,97,111),(98,98,112),(99,99,113),(100,100,114),(101,101,115),(102,102,116),(103,103,117),(104,104,118),(105,105,119),(106,106,120),(107,107,121),(108,108,122),(109,109,123),(110,110,124),(111,111,125),(112,112,126),(113,113,127),(114,114,128),(115,115,129),(116,116,130),(117,117,131),(118,118,132),(119,119,133),(120,120,134),(121,121,135),(122,122,136),(123,123,137),(124,124,138),(125,125,139),(126,126,140),(127,127,141),(128,128,142),(129,129,143),(130,130,144),(131,131,145),(132,132,146),(133,133,147),(134,134,148),(135,135,149),(136,136,150),(137,137,151),(138,138,152),(139,139,153),(140,140,154),(141,141,155),(142,142,156),(143,143,157),(144,144,158),(145,145,159),(146,146,160),(147,147,161),(148,148,162),(149,149,163),(150,150,164),(151,151,165),(152,152,166),(153,153,167),(154,154,168),(155,155,169),(156,156,170),(157,157,171),(158,158,172),(159,159,173),(160,160,174),(161,161,175),(162,162,176),(163,163,177),(164,164,178),(165,165,179),(166,166,180),(167,167,181),(168,168,182),(169,169,183),(170,170,184),(171,171,185),(172,172,186),(173,173,187),(174,174,188),(175,175,189),(176,176,190),(177,177,191),(178,178,192),(179,179,193),(180,180,194),(181,181,195),(182,182,196),(183,183,197),(184,184,198),(185,185,199),(186,186,200),(187,187,201),(188,188,202),(189,189,203),(190,190,204),(191,191,205),(192,192,206),(193,193,207),(194,194,208),(195,195,209),(196,196,210),(197,197,211),(198,198,212),(199,199,213),(200,200,214),(201,201,215),(202,202,216),(203,203,217),(204,204,218),(205,205,219),(206,206,220),(207,207,221),(208,208,222),(209,209,223),(210,210,224),(211,211,225),(212,212,226),(213,213,227),(214,214,228),(215,215,229),(216,216,230),(217,217,231),(218,218,232),(219,219,233),(220,220,234),(221,221,235),(222,222,236),(223,223,237),(224,224,238),(225,225,239),(226,226,240),(227,227,241),(228,228,242),(229,229,243),(230,230,244),(231,231,245),(232,232,246),(233,233,247),(234,234,248),(235,235,249),(236,236,250),(237,237,251),(238,238,252),(239,239,253),(240,240,254),(241,241,255),(242,242,256),(243,243,257),(244,244,258),(245,245,259),(246,246,260),(247,247,261),(248,248,262),(249,249,263),(250,250,264),(251,251,265),(252,252,266),(253,253,267),(254,254,268),(255,255,269),(256,256,270),(257,257,271),(258,258,272),(259,259,273),(260,260,274),(261,261,275),(262,262,276),(263,263,277),(264,264,278),(265,265,279),(266,266,280),(267,267,281),(268,268,282),(269,269,283),(270,270,284),(271,271,285),(272,272,286),(273,273,287),(274,274,288),(275,275,289),(276,276,290),(277,277,291),(278,278,292),(279,279,293),(280,280,294),(281,281,295),(282,282,296),(283,283,297),(284,284,298),(285,285,299),(286,286,300),(287,287,301),(288,288,302),(289,289,303),(290,290,304),(291,291,305),(292,292,306),(293,293,307),(294,294,308),(295,295,309),(296,296,310),(297,297,311),(298,298,312),(299,299,313),(300,300,314),(301,301,315),(302,302,316),(303,303,317),(304,304,318),(305,305,319),(306,306,320),(307,307,321),(308,308,322),(309,309,323),(310,310,324),(311,311,325),(312,312,326),(313,313,327),(314,314,328),(315,315,329),(316,316,330),(317,317,331),(318,318,332),(319,319,333),(320,320,334);
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
  `gender` int(11) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  KEY `fk_tb_user_tb_role1_idx` (`role_id`),
  CONSTRAINT `fk_tb_user_tb_role1` FOREIGN KEY (`role_id`) REFERENCES `tb_role` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3930 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_user`
--

LOCK TABLES `tb_user` WRITE;
/*!40000 ALTER TABLE `tb_user` DISABLE KEYS */;
INSERT INTO `tb_user` VALUES (1,'admin','admin','admin@gmail.com','admin','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1985-02-01','0902485478',1,1),(2,'aaren','1234','angelicap.padilla8@gmail.com','An Cơ','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1985-02-02','0902486479',1,2),(3,'aarika','1234','angelicap@herbalife.com','An Khang','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1985-02-03','0902487480',1,2),(4,'aaron','1234','angelicaperez714@gmail.com','Ân Lai','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1985-02-04','0902488481',2,2),(5,'aartjan','1234','angelicasanz@hotmail.com','An Nam','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1985-02-05','0902489482',1,3),(6,'aarushi','1234','angelicataylor@gmail.com','An Nguyên','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1985-02-06','0902490483',1,3),(7,'abagael','1234','angelicavallejo83@gmail.com','An Ninh','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1985-02-07','0902491484',1,3),(8,'abagail','1234','angelichm1@gmail.com','An Tâm','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1985-02-08','0902492485',1,3),(9,'abahri','1234','angelicsanchez30@gmail.com','Ân Thiện','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1985-02-09','0902493486',1,3),(10,'abbas','1234','angelicwun@gmail.com','An Tường','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1985-02-10','0902494487',1,3),(11,'abbe','1234','angelika58@gmail.com','Anh Ðức','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1985-02-11','0902495488',1,3),(12,'abbey','1234','angelina.ruiz7@yahoo.com','Anh Dũng','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1985-02-12','0902496489',1,3),(13,'abbi','1234','angelina.silvers@gmail.com','Anh Duy','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1985-02-13','0902497490',1,3),(14,'abbie','1234','angelina24.love@gmail.com','Anh Hoàng','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1985-02-14','0902498491',2,3),(15,'abby','1234','angelinababy77@gmail.com','Anh Khải','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1985-02-15','0902499492',1,3),(16,'ailsun','1234','angier336@gmail.com','Ðại Dương','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1985-07-05','0902639632',1,3),(17,'ailyn','1234','angierd14@gmail.com','Ðại Hành','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1985-07-06','0902640633',1,3),(18,'aime','1234','angiersimmons@gmail.com','Ðại Ngọc','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1985-07-07','0902641634',2,3),(19,'aimee','1234','angieruiz1967@gmail.com','Ðại Thống','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1985-07-08','0902642635',1,4),(20,'aimil','1234','angieryan90@gmail.com','Dân Hiệp','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1985-07-09','0902643636',1,4),(21,'aindrea','1234','angiesadler@gmail.com','Dân Khánh','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1985-07-10','0902644637',2,4),(22,'aindrea1','1234','angiesadler@gmail.com','Dân Khánh','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1985-07-10','0902644637',2,4),(23,'aimil1','1234','angieryan90@gmail.com','Dân Hiệp','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1985-07-09','0902643636',1,4),(24,'aindrea13','1234','angiesadler@gmail.com','Dân Khánh','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1985-07-10','0902644637',2,4),(25,'aindrea12','1234','angiesadler@gmail.com','Dân Khánh','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1985-07-10','0902644637',2,4),(537,'strongpwd','$2a$10$v9UGWLepAVizfol71.4NGeOZHqpikqSyMrxBndUynLyjnTs3vz79S','strongpwd@gmail.com','Strongpwd','https://petrotimes.vn/stores/photo_data/vuongthanhtam/012016/27/12/41_1.jpg','2012-10-10','0909909090',2,4),(3919,'gwynn','$2a$10$v9UGWLepAVizfol71.4NGeOZHqpikqSyMrxBndUynLyjnTs3vz79S','capcote@gmail.com','Giáng Tiên','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1995-10-25','0906407396',2,3),(3920,'gwynne','$2a$10$v9UGWLepAVizfol71.4NGeOZHqpikqSyMrxBndUynLyjnTs3vz79S','capickren@gmail.com','Giáng Uyên','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1995-10-26','0906408397',2,4),(3921,'gypsy','$2a$10$v9UGWLepAVizfol71.4NGeOZHqpikqSyMrxBndUynLyjnTs3vz79S','capnstinaa@gmail.com','Giao Kiều','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1995-10-27','0906409398',2,4),(3922,'gyula','$2a$10$v9UGWLepAVizfol71.4NGeOZHqpikqSyMrxBndUynLyjnTs3vz79S','cappycapp1212@gmail.com','Giao Linh','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1995-10-28','0906410399',1,4),(3923,'gzl','$2a$10$v9UGWLepAVizfol71.4NGeOZHqpikqSyMrxBndUynLyjnTs3vz79S','capqueen@gmail.com','Hà Giang','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1995-10-29','0906411400',1,4),(3924,'ha','$2a$10$v9UGWLepAVizfol71.4NGeOZHqpikqSyMrxBndUynLyjnTs3vz79S','capricorn0916@gmail.com','Hà Liên','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1995-10-30','0906412401',2,3),(3925,'habeeb','$2a$10$v9UGWLepAVizfol71.4NGeOZHqpikqSyMrxBndUynLyjnTs3vz79S','carashumaker@gmail.com','Hà Mi','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1995-10-31','0906413402',2,3),(3926,'habib','$2a$10$v9UGWLepAVizfol71.4NGeOZHqpikqSyMrxBndUynLyjnTs3vz79S','caraveocarol@gmail.com','Hà My','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1995-11-01','0906414403',2,3),(3927,'habiba','$2a$10$v9UGWLepAVizfol71.4NGeOZHqpikqSyMrxBndUynLyjnTs3vz79S','carbajal3361@gmail.com','Hà Nhi','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1995-11-02','0906415404',2,3),(3928,'hack6hoo','$2a$10$v9UGWLepAVizfol71.4NGeOZHqpikqSyMrxBndUynLyjnTs3vz79S','carceneaux37@gmail.com','Hà Phương','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1995-11-03','0906416405',1,3),(3929,'haden','$2a$10$v9UGWLepAVizfol71.4NGeOZHqpikqSyMrxBndUynLyjnTs3vz79S','cardiacmom1@gmail.com','Hạ Phương','https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg','1995-11-04','0906417406',1,3);
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
  `name` varchar(50) COLLATE utf8_icelandic_ci DEFAULT NULL,
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
  KEY `fk_tb_utilities_has_tb_user_tb_utilities1_idx` (`utility_id`),
  KEY `fk_tb_utilities_reference_tb_reference1_idx` (`user_id`),
  CONSTRAINT `fk_tb_utilities_has_tb_user_tb_utilities1` FOREIGN KEY (`utility_id`) REFERENCES `tb_utilities` (`utility_id`),
  CONSTRAINT `fk_tb_utilities_reference_tb_reference1` FOREIGN KEY (`user_id`) REFERENCES `tb_reference` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_utilities_reference`
--

LOCK TABLES `tb_utilities_reference` WRITE;
/*!40000 ALTER TABLE `tb_utilities_reference` DISABLE KEYS */;
INSERT INTO `tb_utilities_reference` VALUES (1,1,5),(2,2,5),(3,3,5),(4,4,6),(5,5,6),(6,6,6),(7,7,7),(8,8,7),(9,9,7),(10,10,8),(11,11,8),(12,12,8),(13,13,9),(14,14,9),(15,15,9),(16,1,10),(17,2,10),(18,3,10),(19,4,11),(20,5,11),(21,6,11),(22,7,12),(23,8,12),(24,9,12),(25,10,13),(26,11,13),(27,12,13),(28,13,14),(29,14,14),(30,15,14),(31,1,15),(32,2,15),(33,3,16),(34,4,16),(35,5,17),(36,6,17),(37,7,18),(38,8,18),(39,9,18),(40,10,18),(41,11,19),(42,14,19),(43,15,19),(44,1,19),(45,2,20),(46,3,20),(47,4,20),(48,5,20),(49,6,21),(50,7,21),(51,1,22),(52,2,23),(53,3,24),(54,4,25),(55,5,537),(56,6,537),(57,7,537),(58,8,537),(59,9,537),(60,11,537),(61,12,537),(62,15,537),(63,1,3919),(64,2,3920),(65,3,3921),(66,4,3921),(67,5,3922),(68,6,3923),(69,7,3923),(70,8,3924),(71,9,3925),(72,10,3925),(73,11,3926),(74,12,3927),(75,13,3927),(76,14,3928),(77,15,3929);
/*!40000 ALTER TABLE `tb_utilities_reference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'asp'
--

--
-- Dumping routines for database 'asp'
--
/*!50003 DROP PROCEDURE IF EXISTS `CalculateDistance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CalculateDistance`(IN userId INT, IN pageOf INT, IN size INT)
BEGIN

DECLARE theta			DOUBLE;
DECLARE dist 			DOUBLE;
DECLARE lon1 			DOUBLE;
DECLARE lat1 			DOUBLE;
DECLARE lon2 			DOUBLE;
DECLARE lat2 			DOUBLE;
DECLARE startIndex		INT;
DECLARE post_id_temp	INT;
DECLARE done 			INT DEFAULT FALSE;
DECLARE cur1 			CURSOR FOR SELECT longtitude, lattitude FROM CalDis;
DECLARE cur2 			CURSOR FOR SELECT post_id FROM CalDis;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

DROP TABLE IF EXISTS CalDis;
DROP TABLE IF EXISTS PostTemp;

SET lon1 = 
	(	SELECT	longtitude
		FROM 	tb_post AS p
		WHERE 	p.user_id = userId
			AND p.type_id = 1);

SET lat1 = 
	(	SELECT 	lattitude
		FROM 	tb_post AS p
		WHERE 	p.user_id = userId
			AND p.type_id = 1);    

CREATE TEMPORARY TABLE CalDis
SELECT	* 
FROM 	tb_post 
WHERE 	tb_post.room_id 
	IN
    (	SELECT	room_id
		FROM 	tb_room AS r
		WHERE 	r.district_id = 
			(	SELECT	district_id
				FROM 	tb_room AS r
				WHERE 	r.room_id = 
					(	SELECT	room_id
						FROM 	tb_post AS p
						WHERE 	p.user_id = userId
							AND p.type_id = 1)))
	AND	tb_post.user_id <> userId;
    
ALTER TABLE CalDis
ADD PRIMARY KEY (post_id),
ADD COLUMN distance FLOAT;

OPEN cur1;  
OPEN cur2;
read_loop: LOOP
	FETCH cur1 INTO lon2, lat2;    
	FETCH cur2 INTO post_id_temp;
	IF done THEN
		LEAVE read_loop;    
	ELSE
		SET theta = lon1 - lon2;
		SET dist = sin(lat1 * PI() / 180.0) * sin(lat2 * PI() / 180.0) + cos(lat1 * PI() / 180.0) * cos(lat2 * PI() / 180.0) * cos(theta * PI() / 180.0);
		SET dist = acos(dist);
		SET dist = dist * 180 / PI();
		SET dist = dist * 60 * 1.1515 * 1.609344;		
		UPDATE	CalDis
		SET		distance = dist
		WHERE	post_id = post_id_temp;
	END IF;
END LOOP;
CLOSE cur1; 
CLOSE cur2; 

CREATE TEMPORARY TABLE PostTemp
SELECT		* 
FROM 		CalDis
ORDER BY	distance;

ALTER TABLE PostTemp
DROP COLUMN distance;
        
SET startIndex = (pageOf - 1) * size;

SELECT	*
FROM	PostTemp
LIMIT	startIndex, size;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-04 20:55:48
