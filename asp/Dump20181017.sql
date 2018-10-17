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
INSERT INTO `tb_district` VALUES (1,'Lào Cai',1),(2,'Bát Xát',1),(3,'Mường Khương',1),(4,'Si Ma Cai',1),(5,'Bắc Hà',1),(6,'Bảo Thắng',1),(7,'Bảo Yên',1),(8,'Sa Pa',1),(9,'Văn Bàn',1),(10,'Sơn La',4),(11,'Quỳnh Nhai',4),(12,'Thuận Châu',4),(13,'Mường La',4),(14,'Bắc Yên',4),(15,'Phù Yên',4),(16,'Mộc Châu',4),(17,'Yên Châu',4),(18,'Mai Sơn',4),(19,'Sông Mã',4),(20,'Sốp Cộp',4),(21,'Vân Hồ',4),(22,'Yên Bái',5),(23,'Nghĩa Lộ',5),(24,'Lục Yên',5),(25,'Văn Yên',5),(26,'Mù Căng Chải',5),(27,'Trấn Yên',5),(28,'Trạm Tấu',5),(29,'Văn Chấn',5),(30,'Yên Bình',5),(31,'Lai Châu',2),(32,'Tam Đường',2),(33,'Mường Tè',2),(34,'Sìn Hồ',2),(35,'Phong Thổ',2),(36,'Than Uyên',2),(37,'Tân Uyên',2),(38,'Nậm Nhùn',2),(39,'Điện Biên',3),(40,'Điện Biên Đông',3),(41,'Mường Ảng',3),(42,'Nậm Pồ',3),(43,'Điện Biên Phủ',3),(44,'Mường Lay',3),(45,'Mường Nhé',3),(46,'Mường Chà',3),(47,'Tủa Chùa',3),(48,'Tuần Giáo',3),(49,'Hòa Bình',6),(50,'Đà Bắc',6),(51,'Kỳ Sơn',6),(52,'Lương Sơn',6),(53,'Kim Bôi',6),(54,'Cao Phong',6),(55,'Tân Lạc',6),(56,'Mai Châu',6),(57,'Lạc Sơn',6),(58,'Yên Thủy',6),(59,'Lạc Thủy',6),(60,'Hạ Long',9),(61,'Móng Cái',9),(62,'Cẩm Phả',9),(63,'Uông Bí',9),(64,'Bình Liêu',9),(65,'Tiên Yên',9),(66,'Đầm Hà',9),(67,'Hải Hà',9),(68,'Ba Chẽ',9),(69,'Vân Đồn',9),(70,'Hoành Bồ',9),(71,'Đông Triều',9),(72,'Quảng Yên',9),(73,'Cô Tô',9),(74,'Lạng Sơn',8),(75,'Tràng Định',8),(76,'Bình Gia',8),(77,'Văn Lãng',8),(78,'Cao Lộc',8),(79,'Văn Quan',8),(80,'Bắc Sơn',8),(81,'Hữu Lũng',8),(82,'Chi Lăng',8),(83,'Lộc Bình',8),(84,'Đình Lập',8),(85,'Bắc Giang',10),(86,'Yên Thế',10),(87,'Tân Yên',10),(88,'Lạng Giang',10),(89,'Lục Nam',10),(90,'Lục Ngạn',10),(91,'Sơn Động',10),(92,'Yên Dũng',10),(93,'Việt Yên',10),(94,'Hiệp Hòa',10),(95,'Thái Nguyên',7),(96,'Sông Công',7),(97,'Định Hóa',7),(98,'Phú Lương',7),(99,'Đồng Hỷ',7),(100,'Võ Nhai',7),(101,'Đại Từ',7),(102,'Phổ Yên',7),(103,'Phú Bình',7),(104,'Việt Trì',11),(105,'Phú Thọ',11),(106,'Đoan Hùng',11),(107,'Hạ Hoà',11),(108,'Thanh Ba',11),(109,'Phù Ninh',11),(110,'Yên Lập',11),(111,'Cẩm Khê',11),(112,'Tam Nông',11),(113,'Lâm Thao',11),(114,'Thanh Sơn',11),(115,'Thanh Thuỷ',11),(116,'Tân Sơn',11),(117,'Bắc Ninh',13),(118,'Yên Phong',13),(119,'Quế Võ',13),(120,'Tiên Du',13),(121,'Từ Sơn',13),(122,'Thuận Thành',13),(123,'Gia Bình',13),(124,'Lương Tài',13),(125,'Hải Dương',14),(126,'Chí Linh',14),(127,'Nam Sách',14),(128,'Kinh Môn',14),(129,'Kim Thành',14),(130,'Thanh Hà',14),(131,'Cẩm Giàng',14),(132,'Bình Giang',14),(133,'Gia Lộc',14),(134,'Tứ Kỳ',14),(135,'Ninh Giang',14),(136,'Thanh Miện',14),(137,'Vĩnh Yên',12),(138,'Phúc Yên',12),(139,'Lập Thạch',12),(140,'Tam Dương',12),(141,'Tam Đảo',12),(142,'Bình Xuyên',12),(143,'Yên Lạc',12),(144,'Vĩnh Tường',12),(145,'Sông Lô',12),(146,'Hồng Bàng',15),(147,'Ngô Quyền',15),(148,'Lê Chân',15),(149,'Hải An',15),(150,'Kiến An',15),(151,'Đồ Sơn',15),(152,'Dương Kinh',15),(153,'Thuỷ Nguyên',15),(154,'An Dương',15),(155,'An Lão',15),(156,'Kiến Thuỵ',15),(157,'Tiên Lãng',15),(158,'Vĩnh Bảo',15),(159,'Cát Hải',15),(160,'Hưng Yên',16),(161,'Văn Lâm',16),(162,'Văn Giang',16),(163,'Yên Mỹ',16),(164,'Mỹ Hào',16),(165,'Ân Thi',16),(166,'Khoái Châu',16),(167,'Kim Động',16),(168,'Tiên Lữ',16),(169,'Phù Cừ',16),(170,'Phủ Lý',18),(171,'Duy Tiên',18),(172,'Kim Bảng',18),(173,'Thanh Liêm',18),(174,'Bình Lục',18),(175,'Lý Nhân',18),(176,'Nam Định',19),(177,'Mỹ Lộc',19),(178,'Vụ Bản',19),(179,'Ý Yên',19),(180,'Nghĩa Hưng',19),(181,'Nam Trực',19),(182,'Trực Ninh',19),(183,'Xuân Trường',19),(184,'Giao Thủy',19),(185,'Hải Hậu',19),(186,'Thái Bình',17),(187,'Quỳnh Phụ',17),(188,'Hưng Hà',17),(189,'Đông Hưng',17),(190,'Thái Thụy',17),(191,'Tiền Hải',17),(192,'Kiến Xương',17),(193,'Vũ Thư',17),(194,'Ninh Bình',20),(195,'Tam Điệp',20),(196,'Nho Quan',20),(197,'Gia Viễn',20),(198,'Hoa Lư',20),(199,'Yên Khánh',20),(200,'Kim Sơn',20),(201,'Yên Mô',20),(202,'Vinh',22),(203,'Cửa Lò',22),(204,'Thái Hoà',22),(205,'Quế Phong',22),(206,'Quỳ Châu',22),(207,'Kỳ Sơn',22),(208,'Tương Dương',22),(209,'Nghĩa Đàn',22),(210,'Quỳ Hợp',22),(211,'Quỳnh Lưu',22),(212,'Con Cuông',22),(213,'Tân Kỳ',22),(214,'Anh Sơn',22),(215,'Diễn Châu',22),(216,'Yên Thành',22),(217,'Đô Lương',22),(218,'Thanh Chương',22),(219,'Nghi Lộc',22),(220,'Nam Đàn',22),(221,'Hưng Nguyên',22),(222,'Hoàng Mai',22),(223,'Đồng Hới',24),(224,'Minh Hóa',24),(225,'Tuyên Hóa',24),(226,'Quảng Trạch',24),(227,'Bố Trạch',24),(228,'Quảng Ninh',24),(229,'Lệ Thủy',24),(230,'Ba Đồn',24),(231,'Thanh Hóa',21),(232,'Bỉm Sơn',21),(233,'Sầm Sơn',21),(234,'Mường Lát',21),(235,'Quan Hóa',21),(236,'Bá Thước',21),(237,'Quan Sơn',21),(238,'Lang Chánh',21),(239,'Ngọc Lặc',21),(240,'Cẩm Thủy',21),(241,'Thạch Thành',21),(242,'Hà Trung',21),(243,'Vĩnh Lộc',21),(244,'Yên Định',21),(245,'Thọ Xuân',21),(246,'Thường Xuân',21),(247,'Triệu Sơn',21),(248,'Thiệu Hóa',21),(249,'Hoằng Hóa',21),(250,'Hậu Lộc',21),(251,'Nga Sơn',21),(252,'Như Xuân',21),(253,'Như Thanh',21),(254,'Nông Cống',21),(255,'Đông Sơn',21),(256,'Quảng Xương',21),(257,'Tĩnh Gia',21),(258,'Đông Hà',25),(259,'Quảng Trị',25),(260,'Vĩnh Linh',25),(261,'Hướng Hóa',25),(262,'Gio Linh',25),(263,'Đa Krông',25),(264,'Cam Lộ',25),(265,'Triệu Phong',25),(266,'Hải Lăng',25),(267,'Hà Tĩnh',23),(268,'Hồng Lĩnh',23),(269,'Hương Sơn',23),(270,'Đức Thọ',23),(271,'Vũ Quang',23),(272,'Nghi Xuân',23),(273,'Can Lộc',23),(274,'Hương Khê',23),(275,'Thạch Hà',23),(276,'Cẩm Xuyên',23),(277,'Kỳ Anh',23),(278,'Lộc Hà',23),(279,'Kỳ Anh',23),(280,'Huế',26),(281,'Phong Điền',26),(282,'Quảng Điền',26),(283,'Phú Vang',26),(284,'Hương Thủy',26),(285,'Hương Trà',26),(286,'A Lưới',26),(287,'Phú Lộc',26),(288,'Nam Đông',26),(289,'Liên Chiểu',27),(290,'Thanh Khê',27),(291,'Hải Châu',27),(292,'Sơn Trà',27),(293,'Ngũ Hành Sơn',27),(294,'Cẩm Lệ',27),(295,'Hòa Vang',27),(296,'Tam Kỳ',28),(297,'Hội An',28),(298,'Tây Giang',28),(299,'Đông Giang',28),(300,'Đại Lộc',28),(301,'Điện Bàn',28),(302,'Duy Xuyên',28),(303,'Quế Sơn',28),(304,'Nam Giang',28),(305,'Phước Sơn',28),(306,'Hiệp Đức',28),(307,'Thăng Bình',28),(308,'Tiên Phước',28),(309,'Bắc Trà My',28),(310,'Nam Trà My',28),(311,'Núi Thành',28),(312,'Phú Ninh',28),(313,'Nông Sơn',28),(314,'Qui Nhơn',30),(315,'An Lão',30),(316,'Hoài Nhơn',30),(317,'Hoài Ân',30),(318,'Phù Mỹ',30),(319,'Vĩnh Thạnh',30),(320,'Tây Sơn',30),(321,'Phù Cát',30),(322,'An Nhơn',30),(323,'Tuy Phước',30),(324,'Vân Canh',30),(325,'Quảng Ngãi',29),(326,'Bình Sơn',29),(327,'Trà Bồng',29),(328,'Tây Trà',29),(329,'Sơn Tịnh',29),(330,'Tư Nghĩa',29),(331,'Sơn Hà',29),(332,'Sơn Tây',29),(333,'Minh Long',29),(334,'Nghĩa Hành',29),(335,'Mộ Đức',29),(336,'Đức Phổ',29),(337,'Ba Tơ',29),(338,'Lý Sơn',29),(339,'Tuy Hoà',31),(340,'Sông Cầu',31),(341,'Đồng Xuân',31),(342,'Tuy An',31),(343,'Sơn Hòa',31),(344,'Sông Hinh',31),(345,'Tây Hoà',31),(346,'Phú Hoà',31),(347,'Đông Hòa',31),(348,'Kon Tum',35),(349,'Đắk Glei',35),(350,'Ngọc Hồi',35),(351,'Đắk Tô',35),(352,'Kon Plông',35),(353,'Kon Rẫy',35),(354,'Đắk Hà',35),(355,'Sa Thầy',35),(356,'Tu Mơ Rông',35),(357,'Ia H\' Drai',35),(358,'Phan Rang-Tháp Chàm',33),(359,'Bác Ái',33),(360,'Ninh Sơn',33),(361,'Ninh Hải',33),(362,'Ninh Phước',33),(363,'Thuận Bắc',33),(364,'Thuận Nam',33),(365,'Nha Trang',32),(366,'Cam Ranh',32),(367,'Cam Lâm',32),(368,'Vạn Ninh',32),(369,'Ninh Hòa',32),(370,'Khánh Vĩnh',32),(371,'Diên Khánh',32),(372,'Khánh Sơn',32),(373,'Trường Sa',32),(374,'Phan Thiết',34),(375,'La Gi',34),(376,'Tuy Phong',34),(377,'Bắc Bình',34),(378,'Hàm Thuận Bắc',34),(379,'Hàm Thuận Nam',34),(380,'Tánh Linh',34),(381,'Đức Linh',34),(382,'Hàm Tân',34),(383,'Phú Quí',34),(384,'Pleiku',36),(385,'An Khê',36),(386,'Ayun Pa',36),(387,'KBang',36),(388,'Đăk Đoa',36),(389,'Chư Păh',36),(390,'Ia Grai',36),(391,'Mang Yang',36),(392,'Kông Chro',36),(393,'Đức Cơ',36),(394,'Chư Prông',36),(395,'Chư Sê',36),(396,'Đăk Pơ',36),(397,'Ia Pa',36),(398,'Krông Pa',36),(399,'Phú Thiện',36),(400,'Chư Pưh',36),(401,'Đà Lạt',39),(402,'Bảo Lộc',39),(403,'Đam Rông',39),(404,'Lạc Dương',39),(405,'Lâm Hà',39),(406,'Đơn Dương',39),(407,'Đức Trọng',39),(408,'Di Linh',39),(409,'Bảo Lâm',39),(410,'Đạ Huoai',39),(411,'Đạ Tẻh',39),(412,'Cát Tiên',39),(413,'Buôn Ma Thuột',37),(414,'Buôn Hồ',37),(415,'Ea H\'leo',37),(416,'Ea Súp',37),(417,'Buôn Đôn',37),(418,'Cư M\'gar',37),(419,'Krông Búk',37),(420,'Krông Năng',37),(421,'Ea Kar',37),(422,'M\'Đrắk',37),(423,'Krông Bông',37),(424,'Krông Pắc',37),(425,'Krông A Na',37),(426,'Lắk',37),(427,'Cư Kuin',37),(428,'Phước Long',40),(429,'Đồng Xoài',40),(430,'Bình Long',40),(431,'Bù Gia Mập',40),(432,'Lộc Ninh',40),(433,'Bù Đốp',40),(434,'Hớn Quản',40),(435,'Đồng Phú',40),(436,'Bù Đăng',40),(437,'Chơn Thành',40),(438,'Phú Riềng',40),(439,'Gia Nghĩa',38),(440,'Đăk Glong',38),(441,'Cư Jút',38),(442,'Đắk Mil',38),(443,'Krông Nô',38),(444,'Đắk Song',38),(445,'Đắk R\'Lấp',38),(446,'Tuy Đức',38),(447,'Tây Ninh',41),(448,'Tân Biên',41),(449,'Tân Châu',41),(450,'Dương Minh Châu',41),(451,'Châu Thành',41),(452,'Hòa Thành',41),(453,'Gò Dầu',41),(454,'Bến Cầu',41),(455,'Trảng Bàng',41),(456,'Thủ Dầu Một',42),(457,'Bàu Bàng',42),(458,'Dầu Tiếng',42),(459,'Bến Cát',42),(460,'Phú Giáo',42),(461,'Tân Uyên',42),(462,'Dĩ An',42),(463,'Thuận An',42),(464,'Bắc Tân Uyên',42),(465,'1',45),(466,'12',45),(467,'Thủ Đức',45),(468,'9',45),(469,'Gò Vấp',45),(470,'Bình Thạnh',45),(471,'Tân Bình',45),(472,'Tân Phú',45),(473,'Phú Nhuận',45),(474,'2',45),(475,'3',45),(476,'10',45),(477,'11',45),(478,'4',45),(479,'5',45),(480,'6',45),(481,'8',45),(482,'Bình Tân',45),(483,'7',45),(484,'Củ Chi',45),(485,'Hóc Môn',45),(486,'Bình Chánh',45),(487,'Nhà Bè',45),(488,'Cần Giờ',45),(489,'Biên Hòa',43),(490,'Long Khánh',43),(491,'Tân Phú',43),(492,'Vĩnh Cửu',43),(493,'Định Quán',43),(494,'Trảng Bom',43),(495,'Thống Nhất',43),(496,'Cẩm Mỹ',43),(497,'Long Thành',43),(498,'Xuân Lộc',43),(499,'Nhơn Trạch',43),(500,'Vũng Tàu',44),(501,'Bà Rịa',44),(502,'Châu Đức',44),(503,'Xuyên Mộc',44),(504,'Long Điền',44),(505,'Đất Đỏ',44),(506,'Tân Thành',44),(507,'Tân An',46),(508,'Kiến Tường',46),(509,'Tân Hưng',46),(510,'Vĩnh Hưng',46),(511,'Mộc Hóa',46),(512,'Tân Thạnh',46),(513,'Thạnh Hóa',46),(514,'Đức Huệ',46),(515,'Đức Hòa',46),(516,'Bến Lức',46),(517,'Thủ Thừa',46),(518,'Tân Trụ',46),(519,'Cần Đước',46),(520,'Cần Giuộc',46),(521,'Châu Thành',46),(522,'Mỹ Tho',47),(523,'Gò Công',47),(524,'Cai Lậy',47),(525,'Tân Phước',47),(526,'Cái Bè',47),(527,'Cai Lậy',47),(528,'Châu Thành',47),(529,'Chợ Gạo',47),(530,'Gò Công Tây',47),(531,'Gò Công Đông',47),(532,'Tân Phú Đông',47),(533,'Vĩnh Long',50),(534,'Long Hồ',50),(535,'Mang Thít',50),(536,'Vũng Liêm',50),(537,'Tam Bình',50),(538,'Bình Minh',50),(539,'Trà Ôn',50),(540,'Bình Tân',50),(541,'Bến Tre',48),(542,'Châu Thành',48),(543,'Chợ Lách',48),(544,'Mỏ Cày Nam',48),(545,'Giồng Trôm',48),(546,'Bình Đại',48),(547,'Ba Tri',48),(548,'Thạnh Phú',48),(549,'Mỏ Cày Bắc',48),(550,'Trà Vinh',49),(551,'Càng Long',49),(552,'Cầu Kè',49),(553,'Tiểu Cần',49),(554,'Châu Thành',49),(555,'Cầu Ngang',49),(556,'Trà Cú',49),(557,'Duyên Hải',49),(558,'Duyên Hải',49),(559,'Cao Lãnh',51),(560,'Sa Đéc',51),(561,'Hồng Ngự',51),(562,'Tân Hồng',51),(563,'Hồng Ngự',51),(564,'Tam Nông',51),(565,'Tháp Mười',51),(566,'Cao Lãnh',51),(567,'Thanh Bình',51),(568,'Lấp Vò',51),(569,'Lai Vung',51),(570,'Châu Thành',51),(571,'Long Xuyên',52),(572,'Châu Đốc',52),(573,'An Phú',52),(574,'Tân Châu',52),(575,'Phú Tân',52),(576,'Châu Phú',52),(577,'Tịnh Biên',52),(578,'Tri Tôn',52),(579,'Châu Thành',52),(580,'Chợ Mới',52),(581,'Thoại Sơn',52),(582,'Vị Thanh',55),(583,'Ngã Bảy',55),(584,'Châu Thành A',55),(585,'Châu Thành',55),(586,'Phụng Hiệp',55),(587,'Vị Thuỷ',55),(588,'Long Mỹ',55),(589,'Long Mỹ',55),(590,'Ninh Kiều',54),(591,'Ô Môn',54),(592,'Bình Thuỷ',54),(593,'Cái Răng',54),(594,'Thốt Nốt',54),(595,'Vĩnh Thạnh',54),(596,'Cờ Đỏ',54),(597,'Phong Điền',54),(598,'Thới Lai',54),(599,'Rạch Giá',53),(600,'Hà Tiên',53),(601,'Kiên Lương',53),(602,'Hòn Đất',53),(603,'Tân Hiệp',53),(604,'Châu Thành',53),(605,'Giồng Riềng',53),(606,'Gò Quao',53),(607,'An Biên',53),(608,'An Minh',53),(609,'Vĩnh Thuận',53),(610,'Phú Quốc',53),(611,'Kiên Hải',53),(612,'U Minh Thượng',53),(613,'Giang Thành',53),(614,'Sóc Trăng',56),(615,'Châu Thành',56),(616,'Kế Sách',56),(617,'Mỹ Tú',56),(618,'Cù Lao Dung',56),(619,'Long Phú',56),(620,'Mỹ Xuyên',56),(621,'Ngã Năm',56),(622,'Thạnh Trị',56),(623,'Vĩnh Châu',56),(624,'Trần Đề',56),(625,'Bạc Liêu',57),(626,'Hồng Dân',57),(627,'Phước Long',57),(628,'Vĩnh Lợi',57),(629,'Giá Rai',57),(630,'Đông Hải',57),(631,'Hoà Bình',57),(632,'Cà Mau',58),(633,'U Minh',58),(634,'Thới Bình',58),(635,'Trần Văn Thời',58),(636,'Cái Nước',58),(637,'Đầm Dơi',58),(638,'Năm Căn',58),(639,'Phú Tân',58),(640,'Ngọc Hiển',58),(641,'Tuyên Quang',59),(642,'Lâm Bình',59),(643,'Nà Hang',59),(644,'Chiêm Hóa',59),(645,'Hàm Yên',59),(646,'Yên Sơn',59),(647,'Sơn Dương',59),(648,'Mê Linh',60),(649,'Hà Đông',60),(650,'Sơn Tây',60),(651,'Ba Vì',60),(652,'Phúc Thọ',60),(653,'Đan Phượng',60),(654,'Hoài Đức',60),(655,'Quốc Oai',60),(656,'Thạch Thất',60),(657,'Chương Mỹ',60),(658,'Thanh Oai',60),(659,'Thường Tín',60),(660,'Phú Xuyên',60),(661,'Ứng Hòa',60),(662,'Mỹ Đức',60),(663,'Ba Đình',60),(664,'Hoàn Kiếm',60),(665,'Tây Hồ',60),(666,'Long Biên',60),(667,'Cầu Giấy',60),(668,'Đống Đa',60),(669,'Hai Bà Trưng',60),(670,'Hoàng Mai',60),(671,'Thanh Xuân',60),(672,'Sóc Sơn',60),(673,'Đông Anh',60),(674,'Gia Lâm',60),(675,'Nam Từ Liêm',60),(676,'Thanh Trì',60),(677,'Bắc Từ Liêm',60),(678,'Cao Bằng',62),(679,'Bảo Lâm',62),(680,'Bảo Lạc',62),(681,'Thông Nông',62),(682,'Hà Quảng',62),(683,'Trà Lĩnh',62),(684,'Trùng Khánh',62),(685,'Hạ Lang',62),(686,'Quảng Uyên',62),(687,'Phục Hoà',62),(688,'Hoà An',62),(689,'Nguyên Bình',62),(690,'Thạch An',62),(691,'Hà Giang',61),(692,'Đồng Văn',61),(693,'Mèo Vạc',61),(694,'Yên Minh',61),(695,'Quản Bạ',61),(696,'Vị Xuyên',61),(697,'Bắc Mê',61),(698,'Hoàng Su Phì',61),(699,'Xín Mần',61),(700,'Bắc Quang',61),(701,'Quang Bình',61),(702,'Bắc Kạn',63),(703,'Pác Nặm',63),(704,'Ba Bể',63),(705,'Ngân Sơn',63),(706,'Bạch Thông',63),(707,'Chợ Đồn',63),(708,'Chợ Mới',63),(709,'Na Rì',63);
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
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
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
  `name` varchar(50) COLLATE utf8_icelandic_ci DEFAULT NULL,
  PRIMARY KEY (`utility_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_icelandic_ci;
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

-- Dump completed on 2018-10-17 19:46:40
