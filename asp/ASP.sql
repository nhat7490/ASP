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
INSERT INTO `tb_city` VALUES (1,'Điện Biên'),(2,'Lai Châu'),(3,'Sơn La'),(4,'Yên Bái'),(5,'Thái Nguyên'),(6,'Hoà Bình'),(7,'Lạng Sơn'),(8,'Lào Cai'),(9,'Bắc Giang'),(10,'Phú Thọ'),(11,'Vĩnh Phúc'),(12,'Bắc Ninh'),(13,'Quảng Ninh'),(14,'Hải Dương'),(15,'Hải Phòng'),(16,'Hưng Yên'),(17,'Thái Bình'),(18,'Hà Nam'),(19,'Nam Định'),(20,'Ninh Bình'),(21,'Thanh Hóa'),(22,'Nghệ An'),(23,'Hà Tĩnh'),(24,'Quảng Bình'),(25,'Quảng Trị'),(26,'Thừa Thiên Huế'),(27,'Đà Nẵng'),(28,'Quảng Nam'),(29,'Quảng Ngãi'),(30,'Bình Định'),(31,'Phú Yên'),(32,'Khánh Hòa'),(33,'Ninh Thuận'),(34,'Bình Thuận'),(35,'Kon Tum'),(36,'Gia Lai'),(37,'Đắk Lắk'),(38,'Đắk Nông'),(39,'Lâm Đồng'),(40,'Bình Phước'),(41,'Tây Ninh'),(42,'Bình Dương'),(43,'Đồng Nai'),(44,'Bà Rịa - Vũng Tàu'),(45,'Hồ Chí Minh'),(46,'Long An'),(47,'Tiền Giang'),(48,'Bến Tre'),(49,'Trà Vinh'),(50,'Vĩnh Long'),(51,'Đồng Tháp'),(52,'An Giang'),(53,'Kiên Giang'),(54,'Cần Thơ'),(55,'Hậu Giang'),(56,'Sóc Trăng'),(57,'Bạc Liêu'),(58,'Cà Mau'),(59,'Tuyên Quang'),(60,'Hà Nội'),(61,'Hà Giang'),(62,'Cao Bằng'),(63,'Bắc Kạn');
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
  PRIMARY KEY (`district_id`,`city_id`),
  KEY `fk_tb_district_tb_city1_idx` (`city_id`),
  CONSTRAINT `fk_tb_district_tb_city1` FOREIGN KEY (`city_id`) REFERENCES `tb_city` (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=710 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_district`
--

LOCK TABLES `tb_district` WRITE;
/*!40000 ALTER TABLE `tb_district` DISABLE KEYS */;
INSERT INTO `tb_district` VALUES (1,'Điện Biên',1),(2,'Điện Biên Đông',1),(3,'Mường Ảng',1),(4,'Nậm Pồ',1),(5,'Điện Biên Phủ',1),(6,'Mường Lay',1),(7,'Mường Nhé',1),(8,'Mường Chà',1),(9,'Tủa Chùa',1),(10,'Tuần Giáo',1),(11,'Yên Bái',4),(12,'Nghĩa Lộ',4),(13,'Lục Yên',4),(14,'Văn Yên',4),(15,'Mù Căng Chải',4),(16,'Trấn Yên',4),(17,'Trạm Tấu',4),(18,'Văn Chấn',4),(19,'Yên Bình',4),(20,'Lai Châu',2),(21,'Tam Đường',2),(22,'Mường Tè',2),(23,'Sìn Hồ',2),(24,'Phong Thổ',2),(25,'Than Uyên',2),(26,'Tân Uyên',2),(27,'Nậm Nhùn',2),(28,'Sơn La',3),(29,'Quỳnh Nhai',3),(30,'Thuận Châu',3),(31,'Mường La',3),(32,'Bắc Yên',3),(33,'Phù Yên',3),(34,'Mộc Châu',3),(35,'Yên Châu',3),(36,'Mai Sơn',3),(37,'Sông Mã',3),(38,'Sốp Cộp',3),(39,'Vân Hồ',3),(40,'Thái Nguyên',5),(41,'Sông Công',5),(42,'Định Hóa',5),(43,'Phú Lương',5),(44,'Đồng Hỷ',5),(45,'Võ Nhai',5),(46,'Đại Từ',5),(47,'Phổ Yên',5),(48,'Phú Bình',5),(49,'Hòa Bình',6),(50,'Đà Bắc',6),(51,'Kỳ Sơn',6),(52,'Lương Sơn',6),(53,'Kim Bôi',6),(54,'Cao Phong',6),(55,'Tân Lạc',6),(56,'Mai Châu',6),(57,'Lạc Sơn',6),(58,'Yên Thủy',6),(59,'Lạc Thủy',6),(60,'Lạng Sơn',7),(61,'Tràng Định',7),(62,'Bình Gia',7),(63,'Văn Lãng',7),(64,'Cao Lộc',7),(65,'Văn Quan',7),(66,'Bắc Sơn',7),(67,'Hữu Lũng',7),(68,'Chi Lăng',7),(69,'Lộc Bình',7),(70,'Đình Lập',7),(71,'Việt Trì',10),(72,'Phú Thọ',10),(73,'Đoan Hùng',10),(74,'Hạ Hoà',10),(75,'Thanh Ba',10),(76,'Phù Ninh',10),(77,'Yên Lập',10),(78,'Cẩm Khê',10),(79,'Tam Nông',10),(80,'Lâm Thao',10),(81,'Thanh Sơn',10),(82,'Thanh Thuỷ',10),(83,'Tân Sơn',10),(84,'Bắc Giang',9),(85,'Yên Thế',9),(86,'Tân Yên',9),(87,'Lạng Giang',9),(88,'Lục Nam',9),(89,'Lục Ngạn',9),(90,'Sơn Động',9),(91,'Yên Dũng',9),(92,'Việt Yên',9),(93,'Hiệp Hòa',9),(94,'Lào Cai',8),(95,'Bát Xát',8),(96,'Mường Khương',8),(97,'Si Ma Cai',8),(98,'Bắc Hà',8),(99,'Bảo Thắng',8),(100,'Bảo Yên',8),(101,'Sa Pa',8),(102,'Văn Bàn',8),(103,'Vĩnh Yên',11),(104,'Phúc Yên',11),(105,'Lập Thạch',11),(106,'Tam Dương',11),(107,'Tam Đảo',11),(108,'Bình Xuyên',11),(109,'Yên Lạc',11),(110,'Vĩnh Tường',11),(111,'Sông Lô',11),(112,'Bắc Ninh',12),(113,'Yên Phong',12),(114,'Quế Võ',12),(115,'Tiên Du',12),(116,'Từ Sơn',12),(117,'Thuận Thành',12),(118,'Gia Bình',12),(119,'Lương Tài',12),(120,'Hải Dương',14),(121,'Chí Linh',14),(122,'Nam Sách',14),(123,'Kinh Môn',14),(124,'Kim Thành',14),(125,'Thanh Hà',14),(126,'Cẩm Giàng',14),(127,'Bình Giang',14),(128,'Gia Lộc',14),(129,'Tứ Kỳ',14),(130,'Ninh Giang',14),(131,'Thanh Miện',14),(132,'Hồng Bàng',15),(133,'Ngô Quyền',15),(134,'Lê Chân',15),(135,'Hải An',15),(136,'Kiến An',15),(137,'Đồ Sơn',15),(138,'Dương Kinh',15),(139,'Thuỷ Nguyên',15),(140,'An Dương',15),(141,'An Lão',15),(142,'Kiến Thuỵ',15),(143,'Tiên Lãng',15),(144,'Vĩnh Bảo',15),(145,'Cát Hải',15),(146,'Hạ Long',13),(147,'Móng Cái',13),(148,'Cẩm Phả',13),(149,'Uông Bí',13),(150,'Bình Liêu',13),(151,'Tiên Yên',13),(152,'Đầm Hà',13),(153,'Hải Hà',13),(154,'Ba Chẽ',13),(155,'Vân Đồn',13),(156,'Hoành Bồ',13),(157,'Đông Triều',13),(158,'Quảng Yên',13),(159,'Cô Tô',13),(160,'Hưng Yên',16),(161,'Văn Lâm',16),(162,'Văn Giang',16),(163,'Yên Mỹ',16),(164,'Mỹ Hào',16),(165,'Ân Thi',16),(166,'Khoái Châu',16),(167,'Kim Động',16),(168,'Tiên Lữ',16),(169,'Phù Cừ',16),(170,'Ninh Bình',20),(171,'Tam Điệp',20),(172,'Nho Quan',20),(173,'Gia Viễn',20),(174,'Hoa Lư',20),(175,'Yên Khánh',20),(176,'Kim Sơn',20),(177,'Yên Mô',20),(178,'Thái Bình',17),(179,'Quỳnh Phụ',17),(180,'Hưng Hà',17),(181,'Đông Hưng',17),(182,'Thái Thụy',17),(183,'Tiền Hải',17),(184,'Kiến Xương',17),(185,'Vũ Thư',17),(186,'Nam Định',19),(187,'Mỹ Lộc',19),(188,'Vụ Bản',19),(189,'Ý Yên',19),(190,'Nghĩa Hưng',19),(191,'Nam Trực',19),(192,'Trực Ninh',19),(193,'Xuân Trường',19),(194,'Giao Thủy',19),(195,'Hải Hậu',19),(196,'Phủ Lý',18),(197,'Duy Tiên',18),(198,'Kim Bảng',18),(199,'Thanh Liêm',18),(200,'Bình Lục',18),(201,'Lý Nhân',18),(202,'Thanh Hóa',21),(203,'Bỉm Sơn',21),(204,'Sầm Sơn',21),(205,'Mường Lát',21),(206,'Quan Hóa',21),(207,'Bá Thước',21),(208,'Quan Sơn',21),(209,'Lang Chánh',21),(210,'Ngọc Lặc',21),(211,'Cẩm Thủy',21),(212,'Thạch Thành',21),(213,'Hà Trung',21),(214,'Vĩnh Lộc',21),(215,'Yên Định',21),(216,'Thọ Xuân',21),(217,'Thường Xuân',21),(218,'Triệu Sơn',21),(219,'Thiệu Hóa',21),(220,'Hoằng Hóa',21),(221,'Hậu Lộc',21),(222,'Nga Sơn',21),(223,'Như Xuân',21),(224,'Như Thanh',21),(225,'Nông Cống',21),(226,'Đông Sơn',21),(227,'Quảng Xương',21),(228,'Tĩnh Gia',21),(229,'Vinh',22),(230,'Cửa Lò',22),(231,'Thái Hoà',22),(232,'Quế Phong',22),(233,'Quỳ Châu',22),(234,'Kỳ Sơn',22),(235,'Tương Dương',22),(236,'Nghĩa Đàn',22),(237,'Quỳ Hợp',22),(238,'Quỳnh Lưu',22),(239,'Con Cuông',22),(240,'Tân Kỳ',22),(241,'Anh Sơn',22),(242,'Diễn Châu',22),(243,'Yên Thành',22),(244,'Đô Lương',22),(245,'Thanh Chương',22),(246,'Nghi Lộc',22),(247,'Nam Đàn',22),(248,'Hưng Nguyên',22),(249,'Hoàng Mai',22),(250,'Hà Tĩnh',23),(251,'Hồng Lĩnh',23),(252,'Hương Sơn',23),(253,'Đức Thọ',23),(254,'Vũ Quang',23),(255,'Nghi Xuân',23),(256,'Can Lộc',23),(257,'Hương Khê',23),(258,'Thạch Hà',23),(259,'Cẩm Xuyên',23),(260,'Kỳ Anh',23),(261,'Lộc Hà',23),(262,'Kỳ Anh',23),(263,'Đồng Hới',24),(264,'Minh Hóa',24),(265,'Tuyên Hóa',24),(266,'Quảng Trạch',24),(267,'Bố Trạch',24),(268,'Quảng Ninh',24),(269,'Lệ Thủy',24),(270,'Ba Đồn',24),(271,'Đông Hà',25),(272,'Quảng Trị',25),(273,'Vĩnh Linh',25),(274,'Hướng Hóa',25),(275,'Gio Linh',25),(276,'Đa Krông',25),(277,'Cam Lộ',25),(278,'Triệu Phong',25),(279,'Hải Lăng',25),(280,'Huế',26),(281,'Phong Điền',26),(282,'Quảng Điền',26),(283,'Phú Vang',26),(284,'Hương Thủy',26),(285,'Hương Trà',26),(286,'A Lưới',26),(287,'Phú Lộc',26),(288,'Nam Đông',26),(289,'Liên Chiểu',27),(290,'Thanh Khê',27),(291,'Hải Châu',27),(292,'Sơn Trà',27),(293,'Ngũ Hành Sơn',27),(294,'Cẩm Lệ',27),(295,'Hòa Vang',27),(296,'Quảng Ngãi',29),(297,'Bình Sơn',29),(298,'Trà Bồng',29),(299,'Tây Trà',29),(300,'Sơn Tịnh',29),(301,'Tư Nghĩa',29),(302,'Sơn Hà',29),(303,'Sơn Tây',29),(304,'Minh Long',29),(305,'Nghĩa Hành',29),(306,'Mộ Đức',29),(307,'Đức Phổ',29),(308,'Ba Tơ',29),(309,'Lý Sơn',29),(310,'Tam Kỳ',28),(311,'Hội An',28),(312,'Tây Giang',28),(313,'Đông Giang',28),(314,'Đại Lộc',28),(315,'Điện Bàn',28),(316,'Duy Xuyên',28),(317,'Quế Sơn',28),(318,'Nam Giang',28),(319,'Phước Sơn',28),(320,'Hiệp Đức',28),(321,'Thăng Bình',28),(322,'Tiên Phước',28),(323,'Bắc Trà My',28),(324,'Nam Trà My',28),(325,'Núi Thành',28),(326,'Phú Ninh',28),(327,'Nông Sơn',28),(328,'Qui Nhơn',30),(329,'An Lão',30),(330,'Hoài Nhơn',30),(331,'Hoài Ân',30),(332,'Phù Mỹ',30),(333,'Vĩnh Thạnh',30),(334,'Tây Sơn',30),(335,'Phù Cát',30),(336,'An Nhơn',30),(337,'Tuy Phước',30),(338,'Vân Canh',30),(339,'Tuy Hoà',31),(340,'Sông Cầu',31),(341,'Đồng Xuân',31),(342,'Tuy An',31),(343,'Sơn Hòa',31),(344,'Sông Hinh',31),(345,'Tây Hoà',31),(346,'Phú Hoà',31),(347,'Đông Hòa',31),(348,'Nha Trang',32),(349,'Cam Ranh',32),(350,'Cam Lâm',32),(351,'Vạn Ninh',32),(352,'Ninh Hòa',32),(353,'Khánh Vĩnh',32),(354,'Diên Khánh',32),(355,'Khánh Sơn',32),(356,'Trường Sa',32),(357,'Phan Thiết',34),(358,'La Gi',34),(359,'Tuy Phong',34),(360,'Bắc Bình',34),(361,'Hàm Thuận Bắc',34),(362,'Hàm Thuận Nam',34),(363,'Tánh Linh',34),(364,'Đức Linh',34),(365,'Hàm Tân',34),(366,'Phú Quí',34),(367,'Phan Rang-Tháp Chàm',33),(368,'Bác Ái',33),(369,'Ninh Sơn',33),(370,'Ninh Hải',33),(371,'Ninh Phước',33),(372,'Thuận Bắc',33),(373,'Thuận Nam',33),(374,'Pleiku',36),(375,'An Khê',36),(376,'Ayun Pa',36),(377,'KBang',36),(378,'Đăk Đoa',36),(379,'Chư Păh',36),(380,'Ia Grai',36),(381,'Mang Yang',36),(382,'Kông Chro',36),(383,'Đức Cơ',36),(384,'Chư Prông',36),(385,'Chư Sê',36),(386,'Đăk Pơ',36),(387,'Ia Pa',36),(388,'Krông Pa',36),(389,'Phú Thiện',36),(390,'Chư Pưh',36),(391,'Kon Tum',35),(392,'Đắk Glei',35),(393,'Ngọc Hồi',35),(394,'Đắk Tô',35),(395,'Kon Plông',35),(396,'Kon Rẫy',35),(397,'Đắk Hà',35),(398,'Sa Thầy',35),(399,'Tu Mơ Rông',35),(400,'Ia H\' Drai',35),(401,'Buôn Ma Thuột',37),(402,'Buôn Hồ',37),(403,'Ea H\'leo',37),(404,'Ea Súp',37),(405,'Buôn Đôn',37),(406,'Cư M\'gar',37),(407,'Krông Búk',37),(408,'Krông Năng',37),(409,'Ea Kar',37),(410,'M\'Đrắk',37),(411,'Krông Bông',37),(412,'Krông Pắc',37),(413,'Krông A Na',37),(414,'Lắk',37),(415,'Cư Kuin',37),(416,'Đà Lạt',39),(417,'Bảo Lộc',39),(418,'Đam Rông',39),(419,'Lạc Dương',39),(420,'Lâm Hà',39),(421,'Đơn Dương',39),(422,'Đức Trọng',39),(423,'Di Linh',39),(424,'Bảo Lâm',39),(425,'Đạ Huoai',39),(426,'Đạ Tẻh',39),(427,'Cát Tiên',39),(428,'Gia Nghĩa',38),(429,'Đăk Glong',38),(430,'Cư Jút',38),(431,'Đắk Mil',38),(432,'Krông Nô',38),(433,'Đắk Song',38),(434,'Đắk R\'Lấp',38),(435,'Tuy Đức',38),(436,'Tây Ninh',41),(437,'Tân Biên',41),(438,'Tân Châu',41),(439,'Dương Minh Châu',41),(440,'Châu Thành',41),(441,'Hòa Thành',41),(442,'Gò Dầu',41),(443,'Bến Cầu',41),(444,'Trảng Bàng',41),(445,'Phước Long',40),(446,'Đồng Xoài',40),(447,'Bình Long',40),(448,'Bù Gia Mập',40),(449,'Lộc Ninh',40),(450,'Bù Đốp',40),(451,'Hớn Quản',40),(452,'Đồng Phú',40),(453,'Bù Đăng',40),(454,'Chơn Thành',40),(455,'Phú Riềng',40),(456,'Biên Hòa',43),(457,'Long Khánh',43),(458,'Tân Phú',43),(459,'Vĩnh Cửu',43),(460,'Định Quán',43),(461,'Trảng Bom',43),(462,'Thống Nhất',43),(463,'Cẩm Mỹ',43),(464,'Long Thành',43),(465,'Xuân Lộc',43),(466,'Nhơn Trạch',43),(467,'Thủ Dầu Một',42),(468,'Bàu Bàng',42),(469,'Dầu Tiếng',42),(470,'Bến Cát',42),(471,'Phú Giáo',42),(472,'Tân Uyên',42),(473,'Dĩ An',42),(474,'Thuận An',42),(475,'Bắc Tân Uyên',42),(476,'Vũng Tàu',44),(477,'Bà Rịa',44),(478,'Châu Đức',44),(479,'Xuyên Mộc',44),(480,'Long Điền',44),(481,'Đất Đỏ',44),(482,'Tân Thành',44),(483,'Mỹ Tho',47),(484,'Gò Công',47),(485,'Cai Lậy',47),(486,'Tân Phước',47),(487,'Cái Bè',47),(488,'Cai Lậy',47),(489,'Châu Thành',47),(490,'Chợ Gạo',47),(491,'Gò Công Tây',47),(492,'Gò Công Đông',47),(493,'Tân Phú Đông',47),(494,'1',45),(495,'12',45),(496,'Thủ Đức',45),(497,'9',45),(498,'Gò Vấp',45),(499,'Bình Thạnh',45),(500,'Tân Bình',45),(501,'Tân Phú',45),(502,'Phú Nhuận',45),(503,'2',45),(504,'3',45),(505,'10',45),(506,'11',45),(507,'4',45),(508,'5',45),(509,'6',45),(510,'8',45),(511,'Bình Tân',45),(512,'7',45),(513,'Củ Chi',45),(514,'Hóc Môn',45),(515,'Bình Chánh',45),(516,'Nhà Bè',45),(517,'Cần Giờ',45),(518,'Tân An',46),(519,'Kiến Tường',46),(520,'Tân Hưng',46),(521,'Vĩnh Hưng',46),(522,'Mộc Hóa',46),(523,'Tân Thạnh',46),(524,'Thạnh Hóa',46),(525,'Đức Huệ',46),(526,'Đức Hòa',46),(527,'Bến Lức',46),(528,'Thủ Thừa',46),(529,'Tân Trụ',46),(530,'Cần Đước',46),(531,'Cần Giuộc',46),(532,'Châu Thành',46),(533,'Bến Tre',48),(534,'Châu Thành',48),(535,'Chợ Lách',48),(536,'Mỏ Cày Nam',48),(537,'Giồng Trôm',48),(538,'Bình Đại',48),(539,'Ba Tri',48),(540,'Thạnh Phú',48),(541,'Mỏ Cày Bắc',48),(542,'Trà Vinh',49),(543,'Càng Long',49),(544,'Cầu Kè',49),(545,'Tiểu Cần',49),(546,'Châu Thành',49),(547,'Cầu Ngang',49),(548,'Trà Cú',49),(549,'Duyên Hải',49),(550,'Duyên Hải',49),(551,'Vĩnh Long',50),(552,'Long Hồ',50),(553,'Mang Thít',50),(554,'Vũng Liêm',50),(555,'Tam Bình',50),(556,'Bình Minh',50),(557,'Trà Ôn',50),(558,'Bình Tân',50),(559,'Rạch Giá',53),(560,'Hà Tiên',53),(561,'Kiên Lương',53),(562,'Hòn Đất',53),(563,'Tân Hiệp',53),(564,'Châu Thành',53),(565,'Giồng Riềng',53),(566,'Gò Quao',53),(567,'An Biên',53),(568,'An Minh',53),(569,'Vĩnh Thuận',53),(570,'Phú Quốc',53),(571,'Kiên Hải',53),(572,'U Minh Thượng',53),(573,'Giang Thành',53),(574,'Cao Lãnh',51),(575,'Sa Đéc',51),(576,'Hồng Ngự',51),(577,'Tân Hồng',51),(578,'Hồng Ngự',51),(579,'Tam Nông',51),(580,'Tháp Mười',51),(581,'Cao Lãnh',51),(582,'Thanh Bình',51),(583,'Lấp Vò',51),(584,'Lai Vung',51),(585,'Châu Thành',51),(586,'Ninh Kiều',54),(587,'Ô Môn',54),(588,'Bình Thuỷ',54),(589,'Cái Răng',54),(590,'Thốt Nốt',54),(591,'Vĩnh Thạnh',54),(592,'Cờ Đỏ',54),(593,'Phong Điền',54),(594,'Thới Lai',54),(595,'Long Xuyên',52),(596,'Châu Đốc',52),(597,'An Phú',52),(598,'Tân Châu',52),(599,'Phú Tân',52),(600,'Châu Phú',52),(601,'Tịnh Biên',52),(602,'Tri Tôn',52),(603,'Châu Thành',52),(604,'Chợ Mới',52),(605,'Thoại Sơn',52),(606,'Sóc Trăng',56),(607,'Châu Thành',56),(608,'Kế Sách',56),(609,'Mỹ Tú',56),(610,'Cù Lao Dung',56),(611,'Long Phú',56),(612,'Mỹ Xuyên',56),(613,'Ngã Năm',56),(614,'Thạnh Trị',56),(615,'Vĩnh Châu',56),(616,'Trần Đề',56),(617,'Vị Thanh',55),(618,'Ngã Bảy',55),(619,'Châu Thành A',55),(620,'Châu Thành',55),(621,'Phụng Hiệp',55),(622,'Vị Thuỷ',55),(623,'Long Mỹ',55),(624,'Long Mỹ',55),(625,'Bạc Liêu',57),(626,'Hồng Dân',57),(627,'Phước Long',57),(628,'Vĩnh Lợi',57),(629,'Giá Rai',57),(630,'Đông Hải',57),(631,'Hoà Bình',57),(632,'Tuyên Quang',59),(633,'Lâm Bình',59),(634,'Nà Hang',59),(635,'Chiêm Hóa',59),(636,'Hàm Yên',59),(637,'Yên Sơn',59),(638,'Sơn Dương',59),(639,'Mê Linh',60),(640,'Hà Đông',60),(641,'Sơn Tây',60),(642,'Ba Vì',60),(643,'Phúc Thọ',60),(644,'Đan Phượng',60),(645,'Hoài Đức',60),(646,'Quốc Oai',60),(647,'Thạch Thất',60),(648,'Chương Mỹ',60),(649,'Thanh Oai',60),(650,'Thường Tín',60),(651,'Phú Xuyên',60),(652,'Ứng Hòa',60),(653,'Mỹ Đức',60),(654,'Ba Đình',60),(655,'Hoàn Kiếm',60),(656,'Tây Hồ',60),(657,'Long Biên',60),(658,'Cầu Giấy',60),(659,'Đống Đa',60),(660,'Hai Bà Trưng',60),(661,'Hoàng Mai',60),(662,'Thanh Xuân',60),(663,'Sóc Sơn',60),(664,'Đông Anh',60),(665,'Gia Lâm',60),(666,'Nam Từ Liêm',60),(667,'Thanh Trì',60),(668,'Bắc Từ Liêm',60),(669,'Cà Mau',58),(670,'U Minh',58),(671,'Thới Bình',58),(672,'Trần Văn Thời',58),(673,'Cái Nước',58),(674,'Đầm Dơi',58),(675,'Năm Căn',58),(676,'Phú Tân',58),(677,'Ngọc Hiển',58),(678,'Hà Giang',61),(679,'Đồng Văn',61),(680,'Mèo Vạc',61),(681,'Yên Minh',61),(682,'Quản Bạ',61),(683,'Vị Xuyên',61),(684,'Bắc Mê',61),(685,'Hoàng Su Phì',61),(686,'Xín Mần',61),(687,'Bắc Quang',61),(688,'Quang Bình',61),(689,'Cao Bằng',62),(690,'Bảo Lâm',62),(691,'Bảo Lạc',62),(692,'Thông Nông',62),(693,'Hà Quảng',62),(694,'Trà Lĩnh',62),(695,'Trùng Khánh',62),(696,'Hạ Lang',62),(697,'Quảng Uyên',62),(698,'Phục Hoà',62),(699,'Hoà An',62),(700,'Nguyên Bình',62),(701,'Thạch An',62),(702,'Bắc Kạn',63),(703,'Pác Nặm',63),(704,'Ba Bể',63),(705,'Ngân Sơn',63),(706,'Bạch Thông',63),(707,'Chợ Đồn',63),(708,'Chợ Mới',63),(709,'Na Rì',63);
/*!40000 ALTER TABLE `tb_district` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_favourite`
--

DROP TABLE IF EXISTS `tb_favourite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_favourite` (
  `user_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`post_id`),
  KEY `fk_tb_user_has_tb_room_info_tb_room_info1_idx` (`post_id`),
  KEY `fk_tb_user_has_tb_room_info_tb_user1_idx` (`user_id`),
  CONSTRAINT `fk_tb_user_has_tb_room_info_tb_room_info1` FOREIGN KEY (`post_id`) REFERENCES `tb_post` (`post_id`),
  CONSTRAINT `fk_tb_user_has_tb_room_info_tb_user1` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_favourite`
--

LOCK TABLES `tb_favourite` WRITE;
/*!40000 ALTER TABLE `tb_favourite` DISABLE KEYS */;
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
  PRIMARY KEY (`image_id`,`room_id`),
  KEY `fk_tb_image_tb_room1_idx` (`room_id`),
  CONSTRAINT `fk_tb_image_tb_room1` FOREIGN KEY (`room_id`) REFERENCES `tb_room` (`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_image`
--

LOCK TABLES `tb_image` WRITE;
/*!40000 ALTER TABLE `tb_image` DISABLE KEYS */;
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
  `gender_partner` tinyint(4) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `type_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `longtitude` double DEFAULT NULL,
  `lattitude` double DEFAULT NULL,
  PRIMARY KEY (`post_id`,`user_id`,`room_id`,`type_id`),
  KEY `fk_tb_post_tb_type1_idx` (`type_id`),
  KEY `fk_tb_post_tb_user1_idx` (`user_id`),
  KEY `fk_tb_post_tb_room1_idx` (`room_id`),
  CONSTRAINT `fk_tb_post_tb_room1` FOREIGN KEY (`room_id`) REFERENCES `tb_room` (`room_id`),
  CONSTRAINT `fk_tb_post_tb_type1` FOREIGN KEY (`type_id`) REFERENCES `tb_type` (`type_id`),
  CONSTRAINT `fk_tb_post_tb_user1` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_post`
--

LOCK TABLES `tb_post` WRITE;
/*!40000 ALTER TABLE `tb_post` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_post_has_tb_district`
--

DROP TABLE IF EXISTS `tb_post_has_tb_district`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_post_has_tb_district` (
  `post_id` int(11) NOT NULL,
  `district_id` int(11) NOT NULL,
  PRIMARY KEY (`post_id`,`district_id`),
  KEY `fk_tb_post_has_tb_district_tb_district1_idx` (`district_id`),
  KEY `fk_tb_post_has_tb_district_tb_post1_idx` (`post_id`),
  CONSTRAINT `fk_tb_post_has_tb_district_tb_district1` FOREIGN KEY (`district_id`) REFERENCES `tb_district` (`district_id`),
  CONSTRAINT `fk_tb_post_has_tb_district_tb_post1` FOREIGN KEY (`post_id`) REFERENCES `tb_post` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_post_has_tb_district`
--

LOCK TABLES `tb_post_has_tb_district` WRITE;
/*!40000 ALTER TABLE `tb_post_has_tb_district` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_post_has_tb_district` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_rate`
--

DROP TABLE IF EXISTS `tb_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_rate` (
  `tb_user_user_id` int(11) NOT NULL,
  `tb_room_room_id` int(11) NOT NULL,
  `security_rating` double DEFAULT NULL,
  `location_rating` double DEFAULT NULL,
  `utility_rating` double DEFAULT NULL,
  PRIMARY KEY (`tb_user_user_id`,`tb_room_room_id`),
  KEY `fk_tb_user_has_tb_room_tb_room1_idx` (`tb_room_room_id`),
  KEY `fk_tb_user_has_tb_room_tb_user1_idx` (`tb_user_user_id`),
  CONSTRAINT `fk_tb_user_has_tb_room_tb_room1` FOREIGN KEY (`tb_room_room_id`) REFERENCES `tb_room` (`room_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_user_has_tb_room_tb_user1` FOREIGN KEY (`tb_user_user_id`) REFERENCES `tb_user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_role`
--

LOCK TABLES `tb_role` WRITE;
/*!40000 ALTER TABLE `tb_role` DISABLE KEYS */;
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
  `name` varchar(45) DEFAULT NULL,
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
  `tb_status_status_id` int(11) NOT NULL,
  `longtitude` double DEFAULT NULL,
  `lattitude` double DEFAULT NULL,
  PRIMARY KEY (`room_id`,`user_id`,`city_id`,`district_id`,`tb_status_status_id`),
  KEY `fk_tb_room_tb_user1_idx` (`user_id`),
  KEY `fk_tb_room_tb_city1_idx` (`city_id`),
  KEY `fk_tb_room_tb_district1_idx` (`district_id`),
  KEY `fk_tb_room_tb_status1_idx` (`tb_status_status_id`),
  CONSTRAINT `fk_tb_room_tb_city1` FOREIGN KEY (`city_id`) REFERENCES `tb_city` (`city_id`),
  CONSTRAINT `fk_tb_room_tb_district1` FOREIGN KEY (`district_id`) REFERENCES `tb_district` (`district_id`),
  CONSTRAINT `fk_tb_room_tb_status1` FOREIGN KEY (`tb_status_status_id`) REFERENCES `tb_status` (`status_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_room_tb_user1` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_room`
--

LOCK TABLES `tb_room` WRITE;
/*!40000 ALTER TABLE `tb_room` DISABLE KEYS */;
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
  `status` tinyint(4) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  PRIMARY KEY (`room_has_user_id`,`user_id`,`room_id`),
  KEY `fk_tb_room_has_user_tb_user1_idx` (`user_id`),
  KEY `fk_tb_room_has_user_tb_room1_idx` (`room_id`),
  CONSTRAINT `fk_tb_room_has_user_tb_room1` FOREIGN KEY (`room_id`) REFERENCES `tb_room` (`room_id`),
  CONSTRAINT `fk_tb_room_has_user_tb_user1` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_room_has_user`
--

LOCK TABLES `tb_room_has_user` WRITE;
/*!40000 ALTER TABLE `tb_room_has_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_room_has_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_room_has_utility`
--

DROP TABLE IF EXISTS `tb_room_has_utility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_room_has_utility` (
  `room_id` int(11) NOT NULL,
  `utility_id` int(11) NOT NULL,
  `brand` varchar(45) COLLATE utf8_icelandic_ci DEFAULT NULL,
  `description` varchar(45) COLLATE utf8_icelandic_ci DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  PRIMARY KEY (`room_id`,`utility_id`),
  KEY `fk_tb_utilities_has_tb_room_tb_room1_idx` (`room_id`),
  KEY `fk_tb_utilities_has_tb_room_tb_utilities1_idx` (`utility_id`),
  CONSTRAINT `fk_tb_utilities_has_tb_room_tb_room1` FOREIGN KEY (`room_id`) REFERENCES `tb_room` (`room_id`),
  CONSTRAINT `fk_tb_utilities_has_tb_room_tb_utilities1` FOREIGN KEY (`utility_id`) REFERENCES `tb_utilities` (`utility_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_room_has_utility`
--

LOCK TABLES `tb_room_has_utility` WRITE;
/*!40000 ALTER TABLE `tb_room_has_utility` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_room_has_utility` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_room_reference`
--

DROP TABLE IF EXISTS `tb_room_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_room_reference` (
  `room_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`room_id`,`user_id`),
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_status`
--

LOCK TABLES `tb_status` WRITE;
/*!40000 ALTER TABLE `tb_status` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_type`
--

LOCK TABLES `tb_type` WRITE;
/*!40000 ALTER TABLE `tb_type` DISABLE KEYS */;
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
  `password` varchar(45) COLLATE utf8_icelandic_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_icelandic_ci NOT NULL,
  `fullname` varchar(100) COLLATE utf8_icelandic_ci DEFAULT NULL,
  `image_profile` varchar(255) COLLATE utf8_icelandic_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `phone` varchar(15) COLLATE utf8_icelandic_ci DEFAULT NULL,
  `gender` tinyint(4) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `fk_tb_user_tb_role1_idx` (`role_id`),
  CONSTRAINT `fk_tb_user_tb_role1` FOREIGN KEY (`role_id`) REFERENCES `tb_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_user`
--

LOCK TABLES `tb_user` WRITE;
/*!40000 ALTER TABLE `tb_user` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_utilities`
--

LOCK TABLES `tb_utilities` WRITE;
/*!40000 ALTER TABLE `tb_utilities` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_utilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_utilities_reference`
--

DROP TABLE IF EXISTS `tb_utilities_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_utilities_reference` (
  `utility_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`utility_id`,`user_id`),
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

-- Dump completed on 2018-10-07 14:58:30
