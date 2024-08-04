-- MySQL dump 10.13  Distrib 8.0.39, for Linux (x86_64)
--
-- Host: localhost    Database: PROJECT_LIBRARY
-- ------------------------------------------------------
-- Server version	8.0.39-0ubuntu0.22.04.1

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add book',6,'add_book'),(22,'Can change book',6,'change_book'),(23,'Can delete book',6,'delete_book'),(24,'Can view book',6,'view_book'),(25,'Can add user',7,'add_customuser'),(26,'Can change user',7,'change_customuser'),(27,'Can delete user',7,'delete_customuser'),(28,'Can view user',7,'view_customuser'),(29,'Can add comment',8,'add_comment'),(30,'Can change comment',8,'change_comment'),(31,'Can delete comment',8,'delete_comment'),(32,'Can view comment',8,'view_comment'),(33,'Can add user interaction',9,'add_userinteraction'),(34,'Can change user interaction',9,'change_userinteraction'),(35,'Can delete user interaction',9,'delete_userinteraction'),(36,'Can view user interaction',9,'view_userinteraction');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books_book`
--

DROP TABLE IF EXISTS `books_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books_book` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `isbn` varchar(13) DEFAULT NULL,
  `book_name` varchar(255) NOT NULL,
  `book_author` varchar(1000) NOT NULL,
  `description` longtext NOT NULL,
  `thumbnail_url` varchar(200) DEFAULT NULL,
  `book_rating` double NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `isbn` (`isbn`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books_book`
--

LOCK TABLES `books_book` WRITE;
/*!40000 ALTER TABLE `books_book` DISABLE KEYS */;
INSERT INTO `books_book` VALUES (1,'9780393244809','The Book: A Cover-to-Cover Exploration of the Most Powerful Object of Our Time','Keith Houston','\"Everybody who has ever read a book will benefit from the way Keith Houston explores the most powerful object of our time. And everybody who has read it will agree that reports of the book’s death have been greatly exaggerated.\"— Erik Spiekermann, typographer We may love books, but do we know what lies behind them? In The Book, Keith Houston reveals that the paper, ink, thread, glue, and board from which a book is made tell as rich a story as the words on its pages—of civilizations, empires, human ingenuity, and madness. In an invitingly tactile history of this 2,000-year-old medium, Houston follows the development of writing, printing, the art of illustrations, and binding to show how we have moved from cuneiform tablets and papyrus scrolls to the hardcovers and paperbacks of today. Sure to delight book lovers of all stripes with its lush, full-color illustrations, The Book gives us the momentous and surprising history behind humanity’s most important—and universal—information technology.','http://books.google.com/books/content?id=uxiZCgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',0,'2024-08-04 10:36:52.573776','2024-08-04 10:36:52.592627'),(2,'9780008487027','The Book of Harry: A Celebration of Harry Styles','Charlotte McLaren','A celebration of Harry Styles – we Adore You!','http://books.google.com/books/content?id=Ed4sEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',0,'2024-08-04 10:38:18.664749','2024-08-04 10:38:18.680503'),(3,'9781529049503','Be Kind','Pat Zietlow Miller','Each act, big or small, can make a difference – or at least help a friend. What does it mean to be kind? When Tanisha spills grape juice all over her new dress, her classmate contemplates how to make her feel better and what it means to be kind. From asking the new girl to play to standing up for someone being bullied, this moving and thoughtful story explores what a child can do to be kind. With award-winning author Pat Zietlow Miller\'s gentle text and Jen Hill\'s irresistible art, Be Kind is an unforgettable story for young children, about how simple acts can change the world.','http://books.google.com/books/content?id=HaPMDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',3,'2024-08-04 10:38:35.220501','2024-08-04 10:38:35.240980'),(4,'9781452143712','Love Is','Diane Adams','Perfect for any fond gift or tender moment, this story of a girl and a duckling who share a touching year together will melt hearts old and young. In this tenderly funny book, girl and duckling grow in their understanding of what it is to care for each other, discovering that love is as much about letting go as it is about holding tight. Children and parents together will adore this fond exploration of growing up while learning about the joys of love offered and love returned.','http://books.google.com/books/content?id=83ZtDQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',0,'2024-08-04 10:40:28.788461','2024-08-04 10:41:45.031875'),(5,'9788184003895','55','Chetan Chhatwal','‘Tried to picture myself in a shady second-rate college and realized that even thinking about it was difficult.’ Arjun Singh is a typical South Delhi brat whose biggest worry is securing a much-coveted seat in one of the city’s top colleges. But his ambitious plans come to a screeching halt when he scores a paltry ‘55’ in English in the board exams. Unable to meet the cut-off, Arjun is forced to take admission in a neighbouring second-grade college. Between grappling with his identity as a Sikh and facing repeated misfortunes in love, Arjun’s only solace is his three best friends from school who have also ended up in the same dump. What will happen to his future now? Witty, naughty, and plain irreverent, 55 is a delightful, mad caper about growing up and surviving three tumultuous years in the hallowed corridors of Delhi University.','http://books.google.com/books/content?id=-TdqTrK6ZawC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',0,'2024-08-04 10:41:25.543913','2024-08-04 10:41:25.569757'),(6,'9780465098866','What Love Is','Carrie Jenkins','A rising star in philosophy examines the cultural, social, and scientific interpretations of love to answer one of our most enduring questions What is love? Aside from being the title of many a popular love song, this is one of life\'s perennial questions. In What Love Is, philosopher Carrie Jenkins offers a bold new theory on the nature of romantic love that reconciles its humanistic and scientific components. Love can be a social construct (the idea of a perfect fairy tale romance) and a physical manifestation (those anxiety- inducing heart palpitations); we must recognize its complexities and decide for ourselves how to love. Motivated by her own polyamorous relationships, she examines the ways in which our parameters of love have recently changed-to be more accepting of homosexual, interracial, and non-monogamous relationships-and how they will continue to evolve in the future. Full of anecdotal, cultural, and scientific reflections on love, What Love Is is essential reading for anyone seeking to understand what it means to say \"I love you.\" Whether young or old, gay or straight, male or female, polyamorous or monogamous, this book will help each of us decide for ourselves how we choose to love.','http://books.google.com/books/content?id=kCxWDgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',0,'2024-08-04 10:42:08.101315','2024-08-04 10:42:08.118131'),(7,'','LIFE','','LIFE Magazine is the treasured photographic magazine that chronicled the 20th Century. It now lives on at LIFE.com, the largest, most amazing collection of professional photography on the internet. Users can browse, search and view photos of today’s people and events. They have free access to share, print and post images for personal use.','http://books.google.com/books/content?id=cUoEAAAAMBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',0,'2024-08-04 10:51:36.696637','2024-08-04 10:51:36.696689'),(8,'9780785170761','Marvels','Kurt Busiek','Welcome to New York. Here, burning figures roam the streets, men in brightly colored costumes scale the glass and concrete walls, and creatures from space threaten to devour our world. This is the Marvel Universe, where the ordinary and fantastic interact daily. This is the world of MARVELS. Collecting Marvels (1994) #0-4.','http://books.google.com/books/content?id=03ZYRmOhwGsC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',4,'2024-08-04 10:53:31.456347','2024-08-04 10:53:31.456419'),(9,'9789389143874','Being Love','Sister Shivani , Suresh Oberoi','We can each radiate unconditional love. We don’t even need to create it – we are love. But the flow of love is blocked in moments of hurt, blame, anger, criticism, competition or insecurity. These emotions have dominated our emotional space, and hardly enable us to feel our own love. So today, we rely on someone else to love us. This book teaches us to think right, enable self-love, feel it and extend it to other people. The central message here is that love is not ‘out there’, but within us. A spectrum of emotions like attachment, expectations, hurt, worry, stress, fear or anger, which we use in the pretext of love, are analysed. The conversations also explore the fact that the parent-child relationship is not challenging – It does not need to be. As you free yourself from judgments and expectations, as you start thinking right for people, and as you accept people for who they are, you become a Radiator of unconditional love. You are one decision away from vibrating at a frequency of love … by not needing love or giving love – but just by being love.','http://books.google.com/books/content?id=w-rKDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',5,'2024-08-04 10:56:46.577344','2024-08-04 10:56:46.577393'),(10,'9781439170199','The Lessons of History','Will Durant , Ariel Durant','A concise survey of the culture and civilization of mankind, The Lessons of History is the result of a lifetime of research from Pulitzer Prize–winning historians Will and Ariel Durant. With their accessible compendium of philosophy and social progress, the Durants take us on a journey through history, exploring the possibilities and limitations of humanity over time. Juxtaposing the great lives, ideas, and accomplishments with cycles of war and conquest, the Durants reveal the towering themes of history and give meaning to our own.','http://books.google.com/books/content?id=LWNQ2_4wkocC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',0,'2024-08-04 10:58:50.483808','2024-08-04 11:05:37.623041');
/*!40000 ALTER TABLE `books_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books_customuser`
--

DROP TABLE IF EXISTS `books_customuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books_customuser` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `email` varchar(254) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books_customuser`
--

LOCK TABLES `books_customuser` WRITE;
/*!40000 ALTER TABLE `books_customuser` DISABLE KEYS */;
INSERT INTO `books_customuser` VALUES (1,'pbkdf2_sha256$720000$wuz3pjDwo664tRygaxHQzU$FDwl50BD504QKVITUxQijxIV5NCC5ZKJ4JnmbOP4+Fc=','2024-08-04 11:05:22.708457',1,'gourav541','','',1,1,'2024-08-03 17:13:22.100776','gourav4304@gmail.com'),(2,'pbkdf2_sha256$720000$QGlmwCJ4wXGCRmjDdJY4tN$V+qMeBSIa31V528Rd1gTOW3+wJ+0/E/cRrrEm8IUTAo=','2024-08-04 09:56:49.817528',0,'test','','',0,1,'2024-08-03 18:58:33.694482','haribhariho@gmail.com'),(3,'pbkdf2_sha256$720000$40zqKtBORtFkKZX29qDMVx$7o+Lk33hmxm6qjkk4/QHnEmigI9MVM7wY0kdTEHLe3Y=','2024-08-04 10:49:33.223036',0,'finaltest','','',0,1,'2024-08-04 10:46:56.068873','finaltest@123.com'),(4,'pbkdf2_sha256$720000$HzBkLF6Y1phAvXi9YOKtJO$e1vDcdszUrB+Kxh4e3MADQ9b2hvVwTxf+HBmbWQ5MtE=','2024-08-04 10:51:12.856392',0,'randomtester','','',0,1,'2024-08-04 10:51:12.138973','randomtester@12.com');
/*!40000 ALTER TABLE `books_customuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books_customuser_groups`
--

DROP TABLE IF EXISTS `books_customuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books_customuser_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `books_customuser_groups_customuser_id_group_id_cb470f44_uniq` (`customuser_id`,`group_id`),
  KEY `books_customuser_groups_group_id_34ec5ee8_fk_auth_group_id` (`group_id`),
  CONSTRAINT `books_customuser_gro_customuser_id_d9b3d1d8_fk_books_cus` FOREIGN KEY (`customuser_id`) REFERENCES `books_customuser` (`id`),
  CONSTRAINT `books_customuser_groups_group_id_34ec5ee8_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books_customuser_groups`
--

LOCK TABLES `books_customuser_groups` WRITE;
/*!40000 ALTER TABLE `books_customuser_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `books_customuser_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books_customuser_user_permissions`
--

DROP TABLE IF EXISTS `books_customuser_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books_customuser_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `books_customuser_user_pe_customuser_id_permission_f4b967de_uniq` (`customuser_id`,`permission_id`),
  KEY `books_customuser_use_permission_id_23a87421_fk_auth_perm` (`permission_id`),
  CONSTRAINT `books_customuser_use_customuser_id_968ef107_fk_books_cus` FOREIGN KEY (`customuser_id`) REFERENCES `books_customuser` (`id`),
  CONSTRAINT `books_customuser_use_permission_id_23a87421_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books_customuser_user_permissions`
--

LOCK TABLES `books_customuser_user_permissions` WRITE;
/*!40000 ALTER TABLE `books_customuser_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `books_customuser_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books_userinteraction`
--

DROP TABLE IF EXISTS `books_userinteraction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books_userinteraction` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `interaction_type` int NOT NULL,
  `book_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `books_userinteraction_book_id_c21d9ff9_fk_books_book_id` (`book_id`),
  KEY `books_userinteraction_user_id_06079500_fk_books_customuser_id` (`user_id`),
  CONSTRAINT `books_userinteraction_book_id_c21d9ff9_fk_books_book_id` FOREIGN KEY (`book_id`) REFERENCES `books_book` (`id`),
  CONSTRAINT `books_userinteraction_user_id_06079500_fk_books_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `books_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books_userinteraction`
--

LOCK TABLES `books_userinteraction` WRITE;
/*!40000 ALTER TABLE `books_userinteraction` DISABLE KEYS */;
INSERT INTO `books_userinteraction` VALUES (1,1,1,2),(2,1,2,2),(3,1,3,2),(4,1,4,2),(5,1,5,1),(6,1,4,1),(7,1,6,1),(8,1,7,4),(9,1,8,4),(10,1,9,4),(11,1,10,4),(12,1,10,1);
/*!40000 ALTER TABLE `books_userinteraction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_books_customuser_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_books_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `books_customuser` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(6,'books','book'),(8,'books','comment'),(7,'books','customuser'),(9,'books','userinteraction'),(4,'contenttypes','contenttype'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-08-03 17:08:42.483998'),(2,'contenttypes','0002_remove_content_type_name','2024-08-03 17:11:14.812549'),(3,'auth','0001_initial','2024-08-03 17:11:15.347037'),(4,'auth','0002_alter_permission_name_max_length','2024-08-03 17:11:15.440466'),(5,'auth','0003_alter_user_email_max_length','2024-08-03 17:11:15.451423'),(6,'auth','0004_alter_user_username_opts','2024-08-03 17:11:15.456564'),(7,'auth','0005_alter_user_last_login_null','2024-08-03 17:11:15.462201'),(8,'auth','0006_require_contenttypes_0002','2024-08-03 17:11:15.466608'),(9,'auth','0007_alter_validators_add_error_messages','2024-08-03 17:11:15.474003'),(10,'auth','0008_alter_user_username_max_length','2024-08-03 17:11:15.480364'),(11,'auth','0009_alter_user_last_name_max_length','2024-08-03 17:11:15.486918'),(12,'auth','0010_alter_group_name_max_length','2024-08-03 17:11:15.570824'),(13,'auth','0011_update_proxy_permissions','2024-08-03 17:11:15.578352'),(14,'auth','0012_alter_user_first_name_max_length','2024-08-03 17:11:15.584351'),(15,'books','0001_initial','2024-08-03 17:11:17.328287'),(16,'admin','0001_initial','2024-08-03 17:11:32.109173'),(17,'admin','0002_logentry_remove_auto_add','2024-08-03 17:11:32.126914'),(18,'admin','0003_logentry_add_action_flag_choices','2024-08-03 17:11:32.175434'),(19,'sessions','0001_initial','2024-08-03 17:11:32.751851'),(20,'books','0002_comment_created_at','2024-08-03 19:22:14.986029'),(21,'books','0003_book_currency_book_price_delete_comment','2024-08-04 10:25:00.556102'),(22,'books','0004_remove_book_currency_remove_book_price','2024-08-04 10:35:10.989729');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-04 17:23:13
