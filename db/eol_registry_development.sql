-- MySQL dump 10.13  Distrib 5.1.63, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: eol_registry_development
-- ------------------------------------------------------
-- Server version	5.1.63-0ubuntu0.11.04.1

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
-- Table structure for table `pull_events`
--

DROP TABLE IF EXISTS `pull_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pull_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `pull_at` timestamp NULL DEFAULT NULL,
  `success_at` datetime DEFAULT NULL,
  `state_uuid` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pull_events`
--

LOCK TABLES `pull_events` WRITE;
/*!40000 ALTER TABLE `pull_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `pull_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `push_requests`
--

DROP TABLE IF EXISTS `push_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `push_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `file_url` varchar(150) DEFAULT NULL,
  `file_md5_hash` varchar(150) DEFAULT NULL,
  `received_at` datetime DEFAULT NULL,
  `success_at` datetime DEFAULT NULL,
  `failed_at` datetime DEFAULT NULL,
  `failed_reason` varchar(300) DEFAULT NULL,
  `uuid` varchar(50) DEFAULT NULL,
  `success` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_requests`
--

LOCK TABLES `push_requests` WRITE;
/*!40000 ALTER TABLE `push_requests` DISABLE KEYS */;
INSERT INTO `push_requests` VALUES (19,1,'','','2012-11-29 12:59:12','2012-11-29 12:59:12',NULL,NULL,'cef6da60-3a13-11e2-a6b3-080027e646e9',1),(29,1,'http://10.0.2.2:3000/files/sync_logs/33.json','http://10.0.2.2:3000/files/sync_logs/33.md5','2012-12-06 11:28:16','2012-12-06 11:31:00',NULL,NULL,'43f1f318-3f87-11e2-a439-080027e646e9',1),(30,1,'http://10.0.2.2:3000/files/sync_logs/34.json','http://10.0.2.2:3000/files/sync_logs/34.md5','2012-12-06 13:01:43','2012-12-06 13:01:51',NULL,NULL,'51d4f180-3f94-11e2-a439-080027e646e9',1),(31,1,'http://10.0.2.2:3000/files/sync_logs/35.json','http://10.0.2.2:3000/files/sync_logs/35.md5','2012-12-06 13:05:50','2012-12-06 13:05:57',NULL,NULL,'e4c21068-3f94-11e2-a439-080027e646e9',1),(32,1,'http://10.0.2.2:3000/files/sync_logs/36.json','http://10.0.2.2:3000/files/sync_logs/36.md5','2012-12-06 14:29:55','2012-12-06 14:30:06',NULL,NULL,'a413e8d2-3fa0-11e2-a439-080027e646e9',1),(33,1,'http://10.0.2.2:3000/files/sync_logs/37.json','http://10.0.2.2:3000/files/sync_logs/37.md5','2012-12-06 14:34:24','2012-12-06 14:34:31',NULL,NULL,'44b1f798-3fa1-11e2-a439-080027e646e9',1);
/*!40000 ALTER TABLE `push_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `current_uuid` varchar(45) DEFAULT NULL,
  `url` varchar(150) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `auth_code` varchar(45) DEFAULT NULL,
  `response_url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
INSERT INTO `sites` VALUES (1,'Bibalex','44b1f798-3fa1-11e2-a439-080027e646e9','http://localhost:3000/','2012-11-28 10:15:29','Auth123','http://10.0.2.2:3000/sync_event_update');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sync_log_action_parameters`
--

DROP TABLE IF EXISTS `sync_log_action_parameters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sync_log_action_parameters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `peer_log_id` int(11) DEFAULT NULL,
  `param_object_type_id` int(11) DEFAULT NULL,
  `param_object_id` int(11) DEFAULT NULL,
  `param_object_site_id` int(11) DEFAULT NULL,
  `parameter` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync_log_action_parameters`
--

LOCK TABLES `sync_log_action_parameters` WRITE;
/*!40000 ALTER TABLE `sync_log_action_parameters` DISABLE KEYS */;
/*!40000 ALTER TABLE `sync_log_action_parameters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sync_object_actions`
--

DROP TABLE IF EXISTS `sync_object_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sync_object_actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_action` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync_object_actions`
--

LOCK TABLES `sync_object_actions` WRITE;
/*!40000 ALTER TABLE `sync_object_actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sync_object_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sync_object_types`
--

DROP TABLE IF EXISTS `sync_object_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sync_object_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_type` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync_object_types`
--

LOCK TABLES `sync_object_types` WRITE;
/*!40000 ALTER TABLE `sync_object_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `sync_object_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sync_peer_logs`
--

DROP TABLE IF EXISTS `sync_peer_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sync_peer_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_site_id` int(11) DEFAULT NULL,
  `user_site_object_id` int(11) DEFAULT NULL,
  `action_taken_at_time` datetime NOT NULL,
  `sync_object_action_id` int(11) NOT NULL,
  `sync_object_type_id` int(11) NOT NULL,
  `sync_object_id` int(11) NOT NULL,
  `sync_object_site_id` int(11) NOT NULL,
  `push_request_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync_peer_logs`
--

LOCK TABLES `sync_peer_logs` WRITE;
/*!40000 ALTER TABLE `sync_peer_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `sync_peer_logs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-12-06 14:37:13
