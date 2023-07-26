-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: nacos_config
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `config_info`
--

DROP TABLE IF EXISTS `config_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) COLLATE utf8mb3_bin DEFAULT NULL,
  `content` longtext COLLATE utf8mb3_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text COLLATE utf8mb3_bin COMMENT 'source user',
  `src_ip` varchar(50) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'source ip',
  `app_name` varchar(128) COLLATE utf8mb3_bin DEFAULT NULL,
  `tenant_id` varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT '租户字段',
  `c_desc` varchar(256) COLLATE utf8mb3_bin DEFAULT NULL,
  `c_use` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `effect` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `type` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `c_schema` text COLLATE utf8mb3_bin,
  `encrypted_data_key` text COLLATE utf8mb3_bin NOT NULL COMMENT '秘钥',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfo_datagrouptenant` (`data_id`,`group_id`,`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='config_info';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info`
--

LOCK TABLES `config_info` WRITE;
/*!40000 ALTER TABLE `config_info` DISABLE KEYS */;
INSERT INTO `config_info` VALUES (5,'producer-service-dev.yml','DEFAULT_GROUP','spring:\r\n  application:\r\n    name: producer-service','3b458f8b94bf065ec5b47c59c419fa25','2023-07-15 11:10:16','2023-07-15 11:10:16','nacos','0:0:0:0:0:0:0:1','','b33e09e9-c40a-417c-b3fe-5972aea01979',NULL,NULL,NULL,'yaml',NULL,''),(8,'provider-service.yaml','DEFAULT_GROUP','testname: 222','a39f913f088e934fbd5f22626a278570','2023-07-16 09:31:05','2023-07-25 22:32:17','nacos','0:0:0:0:0:0:0:1','','dev','','','','yaml','',''),(10,'provider-service-rules','sentinel','[\n  {\n    \"resource\": \"/sentinel/testSentinelBlock\",\n    \"controlBehavior\": 0,\n    \"count\": 1,\n    \"grade\": 1,\n    \"limitApp\": \"default\",\n    \"strategy\": 0\n  },\n  {\n    \"resource\": \"testSentinelBlock\",\n    \"controlBehavior\": 0,\n    \"count\": 1,\n    \"grade\": 1,\n    \"limitApp\": \"default\",\n    \"strategy\": 0\n  }\n]','ff3c49e9505e7ff54aabb86cee8976aa','2023-07-24 23:20:17','2023-07-24 23:29:21','nacos','0:0:0:0:0:0:0:1','','dev','','','','json','',''),(28,'xxiaohei-gateway.yaml','DEFAULT_GROUP','spring:\n  cloud:\n    gateway:\n      routes:\n        - id: provider-service\n          uri: lb://provider-service\n          predicates:\n            - Path=/provider/**\n          filters:\n            - StripPrefix=1\n        - id: consumer-service\n          uri: lb://consumer-service\n          predicates:\n            - Path=/consumer/**\n          filters:\n            - StripPrefix=1','d964bfca18263d5fa5d84e0319f6374e','2023-07-25 23:08:55','2023-07-26 21:14:57','nacos','0:0:0:0:0:0:0:1','','dev','','','','yaml','','');
/*!40000 ALTER TABLE `config_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_info_aggr`
--

DROP TABLE IF EXISTS `config_info_aggr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_info_aggr` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
  `datum_id` varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'datum_id',
  `content` longtext COLLATE utf8mb3_bin NOT NULL COMMENT '内容',
  `gmt_modified` datetime NOT NULL COMMENT '修改时间',
  `app_name` varchar(128) COLLATE utf8mb3_bin DEFAULT NULL,
  `tenant_id` varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfoaggr_datagrouptenantdatum` (`data_id`,`group_id`,`tenant_id`,`datum_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='增加租户字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info_aggr`
--

LOCK TABLES `config_info_aggr` WRITE;
/*!40000 ALTER TABLE `config_info_aggr` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_info_aggr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_info_beta`
--

DROP TABLE IF EXISTS `config_info_beta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_info_beta` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext COLLATE utf8mb3_bin NOT NULL COMMENT 'content',
  `beta_ips` varchar(1024) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'betaIps',
  `md5` varchar(32) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text COLLATE utf8mb3_bin COMMENT 'source user',
  `src_ip` varchar(50) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'source ip',
  `tenant_id` varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT '租户字段',
  `encrypted_data_key` text COLLATE utf8mb3_bin NOT NULL COMMENT '秘钥',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfobeta_datagrouptenant` (`data_id`,`group_id`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='config_info_beta';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info_beta`
--

LOCK TABLES `config_info_beta` WRITE;
/*!40000 ALTER TABLE `config_info_beta` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_info_beta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_info_tag`
--

DROP TABLE IF EXISTS `config_info_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_info_tag` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT 'tenant_id',
  `tag_id` varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'tag_id',
  `app_name` varchar(128) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext COLLATE utf8mb3_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text COLLATE utf8mb3_bin COMMENT 'source user',
  `src_ip` varchar(50) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfotag_datagrouptenanttag` (`data_id`,`group_id`,`tenant_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='config_info_tag';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info_tag`
--

LOCK TABLES `config_info_tag` WRITE;
/*!40000 ALTER TABLE `config_info_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_info_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_tags_relation`
--

DROP TABLE IF EXISTS `config_tags_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_tags_relation` (
  `id` bigint NOT NULL COMMENT 'id',
  `tag_name` varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'tag_name',
  `tag_type` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'tag_type',
  `data_id` varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT 'tenant_id',
  `nid` bigint NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nid`),
  UNIQUE KEY `uk_configtagrelation_configidtag` (`id`,`tag_name`,`tag_type`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='config_tag_relation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_tags_relation`
--

LOCK TABLES `config_tags_relation` WRITE;
/*!40000 ALTER TABLE `config_tags_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_tags_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_capacity`
--

DROP TABLE IF EXISTS `group_capacity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_capacity` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` varchar(128) COLLATE utf8mb3_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
  `quota` int unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
  `usage` int unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
  `max_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数，，0表示使用默认值',
  `max_aggr_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='集群、各Group容量信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_capacity`
--

LOCK TABLES `group_capacity` WRITE;
/*!40000 ALTER TABLE `group_capacity` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_capacity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `his_config_info`
--

DROP TABLE IF EXISTS `his_config_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `his_config_info` (
  `id` bigint unsigned NOT NULL,
  `nid` bigint unsigned NOT NULL AUTO_INCREMENT,
  `data_id` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `group_id` varchar(128) COLLATE utf8mb3_bin NOT NULL,
  `app_name` varchar(128) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext COLLATE utf8mb3_bin NOT NULL,
  `md5` varchar(32) COLLATE utf8mb3_bin DEFAULT NULL,
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `src_user` text COLLATE utf8mb3_bin,
  `src_ip` varchar(50) COLLATE utf8mb3_bin DEFAULT NULL,
  `op_type` char(10) COLLATE utf8mb3_bin DEFAULT NULL,
  `tenant_id` varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT '租户字段',
  `encrypted_data_key` text COLLATE utf8mb3_bin NOT NULL COMMENT '秘钥',
  PRIMARY KEY (`nid`),
  KEY `idx_gmt_create` (`gmt_create`),
  KEY `idx_gmt_modified` (`gmt_modified`),
  KEY `idx_did` (`data_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='多租户改造';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `his_config_info`
--

LOCK TABLES `his_config_info` WRITE;
/*!40000 ALTER TABLE `his_config_info` DISABLE KEYS */;
INSERT INTO `his_config_info` VALUES (0,1,'xxiaohei-producer.yml','DEFAULT_GROUP','','a: 1','270f9e65a80226eccd82c99cdd0dd2fb','2023-07-13 21:42:21','2023-07-13 13:42:22','nacos','0:0:0:0:0:0:0:1','I','',''),(1,2,'xxiaohei-producer.yml','DEFAULT_GROUP','','a: 1','270f9e65a80226eccd82c99cdd0dd2fb','2023-07-13 21:44:51','2023-07-13 13:44:51','nacos','0:0:0:0:0:0:0:1','D','',''),(0,3,'xxiaohei-producer.properties','DEFAULT_GROUP','','a=1','3872c9ae3f427af0be0ead09d07ae2cf','2023-07-13 21:46:01','2023-07-13 13:46:02','nacos','0:0:0:0:0:0:0:1','I','',''),(2,4,'xxiaohei-producer.properties','DEFAULT_GROUP','','a=1','3872c9ae3f427af0be0ead09d07ae2cf','2023-07-13 21:53:50','2023-07-13 13:53:51','nacos','0:0:0:0:0:0:0:1','U','',''),(0,5,'xxiaohei-producer','DEFAULT_GROUP','','a=1','3872c9ae3f427af0be0ead09d07ae2cf','2023-07-13 21:54:20','2023-07-13 13:54:21','nacos','0:0:0:0:0:0:0:1','I','',''),(2,6,'xxiaohei-producer.properties','DEFAULT_GROUP','','a=1','3872c9ae3f427af0be0ead09d07ae2cf','2023-07-13 22:06:25','2023-07-13 14:06:26','nacos','0:0:0:0:0:0:0:1','D','',''),(4,7,'xxiaohei-producer','DEFAULT_GROUP','','a=1','3872c9ae3f427af0be0ead09d07ae2cf','2023-07-13 22:06:28','2023-07-13 14:06:28','nacos','0:0:0:0:0:0:0:1','D','',''),(0,8,'producer-service-dev.yml','DEFAULT_GROUP','','spring:\r\n  application:\r\n    name: producer-service','3b458f8b94bf065ec5b47c59c419fa25','2023-07-15 11:10:16','2023-07-15 11:10:16','nacos','0:0:0:0:0:0:0:1','I','b33e09e9-c40a-417c-b3fe-5972aea01979',''),(0,9,'provider-service-dev.yml','DEFAULT_GROUP','','testname: provider-service','39192cad0cf1107d8c397b91620c6b16','2023-07-15 18:29:42','2023-07-15 18:29:42','nacos','0:0:0:0:0:0:0:1','I','dev',''),(6,10,'provider-service-dev.yml','DEFAULT_GROUP','','testname: provider-service','39192cad0cf1107d8c397b91620c6b16','2023-07-15 18:34:15','2023-07-15 18:34:16','nacos','0:0:0:0:0:0:0:1','U','dev',''),(6,11,'provider-service-dev.yml','DEFAULT_GROUP','','testname: provider-service-modify','497368c7fbe6897992a514872fad8cfc','2023-07-16 09:30:37','2023-07-16 09:30:38','nacos','0:0:0:0:0:0:0:1','D','dev',''),(0,12,'provider-service.yaml','DEFAULT_GROUP','','testname: xxx','3074ea430f879c28ab55678634041bdc','2023-07-16 09:31:04','2023-07-16 09:31:05','nacos','0:0:0:0:0:0:0:1','I','dev',''),(0,13,'sentinel-test-rules','sentinel','','[\r\n    {\r\n        \"resource\":\"/sentinel/testSentinelFallback\",\r\n        \"limitApp\":\"default\",\r\n        \"grade\":1,\r\n        \"count\":1,\r\n        \"strategy\":0,\r\n        \"controlBehavior\":0,\r\n        \"clusterMode\":false\r\n    }\r\n]','a304c5b48b6d93b91d4f4cb7ff6f2062','2023-07-24 23:02:52','2023-07-24 23:02:52','nacos','0:0:0:0:0:0:0:1','I','dev',''),(9,14,'sentinel-test-rules','sentinel','','[\r\n    {\r\n        \"resource\":\"/sentinel/testSentinelFallback\",\r\n        \"limitApp\":\"default\",\r\n        \"grade\":1,\r\n        \"count\":1,\r\n        \"strategy\":0,\r\n        \"controlBehavior\":0,\r\n        \"clusterMode\":false\r\n    }\r\n]','a304c5b48b6d93b91d4f4cb7ff6f2062','2023-07-24 23:19:52','2023-07-24 23:19:52','nacos','0:0:0:0:0:0:0:1','D','dev',''),(0,15,'provider-service-rules','sentinel','','[\r\n    {\r\n        \"resource\":\"/sentinel/testSentinelFallback\",\r\n        \"limitApp\":\"default\",\r\n        \"grade\":1,\r\n        \"count\":1,\r\n        \"strategy\":0,\r\n        \"controlBehavior\":0,\r\n        \"clusterMode\":false\r\n    }\r\n]','a304c5b48b6d93b91d4f4cb7ff6f2062','2023-07-24 23:20:17','2023-07-24 23:20:17','nacos','0:0:0:0:0:0:0:1','I','dev',''),(10,16,'provider-service-rules','sentinel','','[\r\n    {\r\n        \"resource\":\"/sentinel/testSentinelFallback\",\r\n        \"limitApp\":\"default\",\r\n        \"grade\":1,\r\n        \"count\":1,\r\n        \"strategy\":0,\r\n        \"controlBehavior\":0,\r\n        \"clusterMode\":false\r\n    }\r\n]','a304c5b48b6d93b91d4f4cb7ff6f2062','2023-07-24 23:26:16','2023-07-24 23:26:16','nacos','0:0:0:0:0:0:0:1','U','dev',''),(10,17,'provider-service-rules','sentinel','','[\n    {\n        \"resource\":\"testSentinelBlock\",\n        \"limitApp\":\"default\",\n        \"grade\":1,\n        \"count\":1,\n        \"strategy\":0,\n        \"controlBehavior\":0,\n        \"clusterMode\":false\n    }\n]','bb018c5d90cd32a47c580753081a1d42','2023-07-24 23:29:04','2023-07-24 23:29:04','nacos','0:0:0:0:0:0:0:1','U','dev',''),(10,18,'provider-service-rules','sentinel','','[\n  {\n    \"resource\": \"/sentinel/testSentinelBlock\",\n    \"controlBehavior\": 0,\n    \"count\": 1,\n    \"grade\": 1,\n    \"limitApp\": \"default\",\n    \"strategy\": 0\n  }\n]','989d270d048bb05b165c446c1e145dd0','2023-07-24 23:29:20','2023-07-24 23:29:21','nacos','0:0:0:0:0:0:0:1','U','dev',''),(0,19,'xxiaohei-gateway.yml','DEFAULT_GROUP','','spring:\r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          enabled: true','7874db86bbc84f1dd705bf244bed97a0','2023-07-25 22:14:32','2023-07-25 22:14:33','nacos','0:0:0:0:0:0:0:1','I','dev',''),(14,20,'xxiaohei-gateway.yml','DEFAULT_GROUP','','spring:\r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          enabled: true','7874db86bbc84f1dd705bf244bed97a0','2023-07-25 22:14:42','2023-07-25 22:14:42','nacos','0:0:0:0:0:0:0:1','D','dev',''),(0,21,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          enabled: true','7874db86bbc84f1dd705bf244bed97a0','2023-07-25 22:15:06','2023-07-25 22:15:07','nacos','0:0:0:0:0:0:0:1','I','dev',''),(15,22,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          enabled: true','7874db86bbc84f1dd705bf244bed97a0','2023-07-25 22:16:21','2023-07-25 22:16:21','nacos','0:0:0:0:0:0:0:1','U','dev',''),(15,23,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      discovery:\n        locator:\n          enabled: false','e4a3e98f02d334bc233a9e39e1f01afc','2023-07-25 22:19:10','2023-07-25 22:19:10','nacos','0:0:0:0:0:0:0:1','U','dev',''),(15,24,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      discovery:\n        locator:\n          enabled: true','6ceb211f302a085089ce73a8f9f290fa','2023-07-25 22:25:47','2023-07-25 22:25:47','nacos','0:0:0:0:0:0:0:1','U','dev',''),(15,25,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      routes:\n        - id: consumer-service\n          uri: lb://consumer-service\n          predicates:\n            - Path=/consumer/**','e8efd1811390bc62d50603940217326b','2023-07-25 22:27:27','2023-07-25 22:27:27','nacos','0:0:0:0:0:0:0:1','U','dev',''),(15,26,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          enabled: true','7874db86bbc84f1dd705bf244bed97a0','2023-07-25 22:27:47','2023-07-25 22:27:47','nacos','0:0:0:0:0:0:0:1','U','dev',''),(15,27,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      discovery:\n        locator:\n          enabled: true','6ceb211f302a085089ce73a8f9f290fa','2023-07-25 22:27:56','2023-07-25 22:27:57','nacos','0:0:0:0:0:0:0:1','U','dev',''),(15,28,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      discovery:\n        locator:\n          enabled: false','e4a3e98f02d334bc233a9e39e1f01afc','2023-07-25 22:28:46','2023-07-25 22:28:46','nacos','0:0:0:0:0:0:0:1','U','dev',''),(8,29,'provider-service.yaml','DEFAULT_GROUP','','testname: xxx','3074ea430f879c28ab55678634041bdc','2023-07-25 22:32:16','2023-07-25 22:32:17','nacos','0:0:0:0:0:0:0:1','U','dev',''),(15,30,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      discovery:\n        locator:\n          enabled: true','6ceb211f302a085089ce73a8f9f290fa','2023-07-25 22:38:03','2023-07-25 22:38:03','nacos','0:0:0:0:0:0:0:1','U','dev',''),(15,31,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      discovery:\n        locator:\n          enabled: true\n      httpclient:\n        connect-timeout: 45000','e6ab3e7b1c2fb63e0036a44dc41a70c1','2023-07-25 22:39:10','2023-07-25 22:39:11','nacos','0:0:0:0:0:0:0:1','U','dev',''),(15,32,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      discovery:\n        locator:\n          enabled: false','e4a3e98f02d334bc233a9e39e1f01afc','2023-07-25 22:53:15','2023-07-25 22:53:15','nacos','0:0:0:0:0:0:0:1','U','dev',''),(15,33,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      routes:\n        - id: provider-service\n          uri: lb://provider-service\n          predicates:\n            - Path=/provider/**\n        - id: consumer-service\n          uri: lb://consumer-service\n          predicates:\n            - Path=/consumer/**','c506aa528ba6e6bfc6d2990ed5ea4943','2023-07-25 22:57:15','2023-07-25 22:57:15','nacos','0:0:0:0:0:0:0:1','U','dev',''),(15,34,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      routes:\n        - id: provider-service\n          uri: lb://provider-service\n          predicates:\n           - Path=/provider/**\n        - id: consumer-service\n          uri: lb://consumer-service\n          predicates:\n           - Path=/consumer/**','711ef569ac83a0d606387cd11f3ab4ca','2023-07-25 22:59:05','2023-07-25 22:59:05','nacos','0:0:0:0:0:0:0:1','D','dev',''),(0,35,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\r\n  cloud:\r\n    gateway:\r\n      routes:\r\n        - id: provider-service # 确定路由唯一性的id\r\n          uri: lb://provider-service # lb允许才nacos中通过该名称查找到指定服务,并实现负载均衡\r\n          predicates:\r\n            - Path=/provider/** # 路由断言\r\n          filters:\r\n            - StripPrefix=1\r\n        - id: consumer-service\r\n          uri: lb://consumer-service\r\n          predicates:\r\n            - Path=/consumer/**\r\n          filters:\r\n            - StripPrefix=1','e1271dd76467a14251e9cc9751ea8d75','2023-07-25 23:08:55','2023-07-25 23:08:55','nacos','0:0:0:0:0:0:0:1','I','dev',''),(28,36,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\r\n  cloud:\r\n    gateway:\r\n      routes:\r\n        - id: provider-service # 确定路由唯一性的id\r\n          uri: lb://provider-service # lb允许才nacos中通过该名称查找到指定服务,并实现负载均衡\r\n          predicates:\r\n            - Path=/provider/** # 路由断言\r\n          filters:\r\n            - StripPrefix=1\r\n        - id: consumer-service\r\n          uri: lb://consumer-service\r\n          predicates:\r\n            - Path=/consumer/**\r\n          filters:\r\n            - StripPrefix=1','e1271dd76467a14251e9cc9751ea8d75','2023-07-25 23:10:12','2023-07-25 23:10:13','nacos','0:0:0:0:0:0:0:1','U','dev',''),(0,37,'xxiaohei-gateway','DEFAULT_GROUP','','spring:\r\n  cloud:\r\n    gateway:\r\n      routes:\r\n        - id: provider-service\r\n          uri: lb://provider-service\r\n          predicates:\r\n            - Path=/provider/**\r\n          filters:\r\n            - StripPrefix=1\r\n        - id: consumer-service\r\n          uri: lb://consumer-service\r\n          predicates:\r\n            - Path=/consumer/**\r\n          filters:\r\n            - StripPrefix=1','c25a8af3263bc3fb995dbd61b1597536','2023-07-25 23:12:50','2023-07-25 23:12:50','nacos','0:0:0:0:0:0:0:1','I','dev',''),(30,38,'xxiaohei-gateway','DEFAULT_GROUP','','spring:\r\n  cloud:\r\n    gateway:\r\n      routes:\r\n        - id: provider-service\r\n          uri: lb://provider-service\r\n          predicates:\r\n            - Path=/provider/**\r\n          filters:\r\n            - StripPrefix=1\r\n        - id: consumer-service\r\n          uri: lb://consumer-service\r\n          predicates:\r\n            - Path=/consumer/**\r\n          filters:\r\n            - StripPrefix=1','c25a8af3263bc3fb995dbd61b1597536','2023-07-25 23:16:07','2023-07-25 23:16:07','nacos','0:0:0:0:0:0:0:1','D','dev',''),(28,39,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      routes:\n        - id: provider-service\n          uri: lb://provider-service\n          predicates:\n            - Path=/provider/**\n          filters:\n            - StripPrefix=1\n        - id: consumer-service\n          uri: lb://consumer-service\n          predicates:\n            - Path=/consumer/**\n          filters:\n            - StripPrefix=1','d964bfca18263d5fa5d84e0319f6374e','2023-07-25 23:19:33','2023-07-25 23:19:34','nacos','0:0:0:0:0:0:0:1','U','dev',''),(28,40,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      routes:\n        - id: provider-service\n          uri: lb://provider-service\n          predicates:\n            - Path=/provider/**\n          filters:\n            - StripPrefix=1\n        - id: consumer-service\n          uri: lb://consumer-service\n          predicates:\n            - Path=/consumer/**\n          filters:\n            - StripPrefix=1\n\na: 1','dca62ec09db861fed19029c49c66157a','2023-07-25 23:19:51','2023-07-25 23:19:51','nacos','0:0:0:0:0:0:0:1','U','dev',''),(28,41,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      routes:\n        - id: provider-service\n          uri: lb://provider-service\n          predicates:\n            - Path=/provider/**\n          filters:\n            - StripPrefix=1\n        - id: consumer-service\n          uri: lb://consumer-service\n          predicates:\n            - Path=/consumer/**\n          filters:\n            - StripPrefix=1','d964bfca18263d5fa5d84e0319f6374e','2023-07-25 23:50:05','2023-07-25 23:50:06','nacos','0:0:0:0:0:0:0:1','U','dev',''),(28,42,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      routes:\n        - id: provider-service\n          uri: lb://provider-service\n          predicates:\n            - Path=/provider/**\n          filters:\n            - StripPrefix=1\n        - id: consumer-service\n          uri: lb://consumer-service\n          predicates:\n            - Path=/consumer1/**\n          filters:\n            - StripPrefix=1','24314e96ccd68aed641b65a5057322e0','2023-07-26 20:08:13','2023-07-26 20:08:13','nacos','0:0:0:0:0:0:0:1','U','dev',''),(28,43,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      routes:\n        - id: provider-service\n          uri: lb://provider-service\n          predicates:\n            - Path=/provider/**\n          filters:\n            - StripPrefix=1\n        - id: consumer-service\n          uri: lb://consumer-service\n          predicates:\n            - Path=/consumer/**\n          filters:\n            - StripPrefix=1','d964bfca18263d5fa5d84e0319f6374e','2023-07-26 20:09:56','2023-07-26 20:09:57','nacos','0:0:0:0:0:0:0:1','U','dev',''),(28,44,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      routes:\n        - id: provider-service\n          uri: lb://provider-service\n          predicates:\n            - Path=/provider/**\n          filters:\n            - StripPrefix=1\n        - id: consumer-service\n          uri: lb://consumer-service\n          predicates:\n            - Path=/consumer/**\n          filters:\n            - StripPrefix=1','d964bfca18263d5fa5d84e0319f6374e','2023-07-26 20:10:02','2023-07-26 20:10:03','nacos','0:0:0:0:0:0:0:1','U','dev',''),(28,45,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      routes:\n        - id: provider-service\n          uri: lb://provider-service\n          predicates:\n            - Path=/provider/**\n          filters:\n            - StripPrefix=1\n        - id: consumer-service\n          uri: lb://consumer-service\n          predicates:\n            - Path=/consumer1/**\n          filters:\n            - StripPrefix=1','24314e96ccd68aed641b65a5057322e0','2023-07-26 20:35:06','2023-07-26 20:35:06','nacos','0:0:0:0:0:0:0:1','U','dev',''),(28,46,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      routes:\n        - id: provider-service\n          uri: lb://provider-service\n          predicates:\n            - Path=/provider/**\n          filters:\n            - StripPrefix=1\n        - id: consumer-service\n          uri: lb://consumer-service\n          predicates:\n            - Path=/consumer/**\n          filters:\n            - StripPrefix=1','d964bfca18263d5fa5d84e0319f6374e','2023-07-26 20:39:05','2023-07-26 20:39:05','nacos','0:0:0:0:0:0:0:1','U','dev',''),(28,47,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      routes:\n        - id: provider-service\n          uri: lb://provider-service\n          predicates:\n            - Path=/provider/**\n          filters:\n            - StripPrefix=1\n        - id: consumer-service\n          uri: lb://consumer-service\n          predicates:\n            - Path=/consumer1/**\n          filters:\n            - StripPrefix=1','24314e96ccd68aed641b65a5057322e0','2023-07-26 20:41:13','2023-07-26 20:41:13','nacos','0:0:0:0:0:0:0:1','U','dev',''),(28,48,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      routes:\n        - id: provider-service\n          uri: lb://provider-service\n          predicates:\n            - Path=/provider/**\n          filters:\n            - StripPrefix=1\n        - id: consumer-service\n          uri: lb://consumer-service\n          predicates:\n            - Path=/consumer/**\n          filters:\n            - StripPrefix=1','d964bfca18263d5fa5d84e0319f6374e','2023-07-26 20:50:33','2023-07-26 20:50:33','nacos','0:0:0:0:0:0:0:1','U','dev',''),(28,49,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      routes:\n        - id: provider-service\n          uri: lb://provider-service\n          predicates:\n            - Path=/provider/**\n          filters:\n            - StripPrefix=1\n        - id: consumer-service\n          uri: lb://consumer-service\n          predicates:\n            - Path=/consumer1/**\n          filters:\n            - StripPrefix=1','24314e96ccd68aed641b65a5057322e0','2023-07-26 20:53:26','2023-07-26 20:53:27','nacos','0:0:0:0:0:0:0:1','U','dev',''),(28,50,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      routes:\n        - id: provider-service\n          uri: lb://provider-service\n          predicates:\n            - Path=/provider/**\n          filters:\n            - StripPrefix=1\n        - id: consumer-service\n          uri: lb://consumer-service\n          predicates:\n            - Path=/consumer/**\n          filters:\n            - StripPrefix=1','d964bfca18263d5fa5d84e0319f6374e','2023-07-26 21:04:51','2023-07-26 21:04:51','nacos','0:0:0:0:0:0:0:1','U','dev',''),(28,51,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      routes:\n        - id: provider-service\n          uri: lb://provider-service\n          predicates:\n            - Path=/provider/**\n          filters:\n            - StripPrefix=1\n        - id: consumer-service\n          uri: lb://consumer-service\n          predicates:\n            - Path=/consumer1/**\n          filters:\n            - StripPrefix=1','24314e96ccd68aed641b65a5057322e0','2023-07-26 21:05:37','2023-07-26 21:05:37','nacos','0:0:0:0:0:0:0:1','U','dev',''),(28,52,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      routes:\n        - id: provider-service\n          uri: lb://provider-service\n          predicates:\n            - Path=/provider1/**\n          filters:\n            - StripPrefix=1\n        - id: consumer-service\n          uri: lb://consumer-service\n          predicates:\n            - Path=/consumer/**\n          filters:\n            - StripPrefix=1','78613dec9af34a6b8a276d7712b3b3b7','2023-07-26 21:06:02','2023-07-26 21:06:02','nacos','0:0:0:0:0:0:0:1','U','dev',''),(28,53,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      routes:\n        - id: provider-service\n          uri: lb://provider-service\n          predicates:\n            - Path=/provider/**\n          filters:\n            - StripPrefix=1\n        - id: consumer-service\n          uri: lb://consumer-service\n          predicates:\n            - Path=/consumer/**\n          filters:\n            - StripPrefix=1','d964bfca18263d5fa5d84e0319f6374e','2023-07-26 21:07:03','2023-07-26 21:07:04','nacos','0:0:0:0:0:0:0:1','U','dev',''),(28,54,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      routes:\n        - id: provider-service\n          uri: lb://provider-service\n          predicates:\n            - Path=/provider1/**\n          filters:\n            - StripPrefix=1\n        - id: consumer-service\n          uri: lb://consumer-service\n          predicates:\n            - Path=/consumer/**\n          filters:\n            - StripPrefix=1','78613dec9af34a6b8a276d7712b3b3b7','2023-07-26 21:12:07','2023-07-26 21:12:07','nacos','0:0:0:0:0:0:0:1','U','dev',''),(28,55,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      routes:\n        - id: provider-service\n          uri: lb://provider-service\n          predicates:\n            - Path=/provider/**\n          filters:\n            - StripPrefix=1\n        - id: consumer-service\n          uri: lb://consumer-service\n          predicates:\n            - Path=/consumer/**\n          filters:\n            - StripPrefix=1','d964bfca18263d5fa5d84e0319f6374e','2023-07-26 21:14:42','2023-07-26 21:14:43','nacos','0:0:0:0:0:0:0:1','U','dev',''),(28,56,'xxiaohei-gateway.yaml','DEFAULT_GROUP','','spring:\n  cloud:\n    gateway:\n      routes:\n        - id: provider-service\n          uri: lb://provider-service\n          predicates:\n            - Path=/provider1/**\n          filters:\n            - StripPrefix=1\n        - id: consumer-service\n          uri: lb://consumer-service\n          predicates:\n            - Path=/consumer/**\n          filters:\n            - StripPrefix=1','78613dec9af34a6b8a276d7712b3b3b7','2023-07-26 21:14:57','2023-07-26 21:14:57','nacos','0:0:0:0:0:0:0:1','U','dev','');
/*!40000 ALTER TABLE `his_config_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `role` varchar(50) NOT NULL,
  `resource` varchar(255) NOT NULL,
  `action` varchar(8) NOT NULL,
  UNIQUE KEY `uk_role_permission` (`role`,`resource`,`action`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `username` varchar(50) NOT NULL,
  `role` varchar(50) NOT NULL,
  UNIQUE KEY `idx_user_role` (`username`,`role`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES ('nacos','ROLE_ADMIN');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tenant_capacity`
--

DROP TABLE IF EXISTS `tenant_capacity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenant_capacity` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) COLLATE utf8mb3_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
  `quota` int unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
  `usage` int unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
  `max_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数',
  `max_aggr_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='租户容量信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_capacity`
--

LOCK TABLES `tenant_capacity` WRITE;
/*!40000 ALTER TABLE `tenant_capacity` DISABLE KEYS */;
/*!40000 ALTER TABLE `tenant_capacity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tenant_info`
--

DROP TABLE IF EXISTS `tenant_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenant_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `kp` varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'kp',
  `tenant_id` varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT 'tenant_id',
  `tenant_name` varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT 'tenant_name',
  `tenant_desc` varchar(256) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'tenant_desc',
  `create_source` varchar(32) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'create_source',
  `gmt_create` bigint NOT NULL COMMENT '创建时间',
  `gmt_modified` bigint NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tenant_info_kptenantid` (`kp`,`tenant_id`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='tenant_info';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_info`
--

LOCK TABLES `tenant_info` WRITE;
/*!40000 ALTER TABLE `tenant_info` DISABLE KEYS */;
INSERT INTO `tenant_info` VALUES (2,'1','dev','dev','开发环境','nacos',1689391689097,1689391689097);
/*!40000 ALTER TABLE `tenant_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` varchar(50) NOT NULL,
  `password` varchar(500) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('nacos','$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-26 22:35:04
