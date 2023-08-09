PRAGMA synchronous = OFF;
PRAGMA journal_mode = MEMORY;
BEGIN TRANSACTION;

CREATE TABLE `MELOS` (
  `kod_melous` integer NOT NULL PRIMARY KEY AUTOINCREMENT
,  `adt_melous` varchar(8) NOT NULL
,  `onoma` varchar(30) NOT NULL
,  `odos` varchar(50) DEFAULT NULL
,  `arithmos` integer NOT NULL
,  `tax_kodikas` integer DEFAULT NULL
,  `topos` varchar(255) NOT NULL
,  `blacklisted` integer NOT NULL DEFAULT '0'
);
INSERT INTO `MELOS` VALUES (1,'AA123410','Ευρυπίδης Μάριος','Μακεδονίας',2,NULL,'Πάτρα',0),(2,'AA123411','Σωτηρίου Λευτέρης','Αγ. Ιωάννη',65,NULL,'Βύρωνας',0),(3,'AA123412','Λεμονίδης Στέφανος','Χρυσάφη',45,NULL,'Γέρακας',0),(4,'AA123413','Νίκας Σωκράτης','Μεσολογγίου',46,NULL,'Άραξος',0),(5,'AA123414','Σκαρτσή Λένα','Αγ. Δημητρίου',4,NULL,'Άγ. Δημήτριος',0),(6,'AA123415','Οθώνος Ανθή','Κατσαντώνη',19,NULL,'Λεωνίδιο',0),(7,'AA123416','Τσιγγούνης Κώστας','Κρήτης',25,NULL,'Χίος',0),(8,'AA123417','Μήλας Θόδωρος','Αιγίνης',73,NULL,'Γιαννιτσά',0),(9,'AA123418','Καπερώνης Γιάννης','Καρκαβίτσα',12,NULL,'Χολαργός',0),(10,'AA123419','Μήλας Κώστας','Δερβενακίων',76,NULL,'Θεσπρωτικό',0),(11,'AA12342','Νίκα Ελένη','Λομβάρδου',7,NULL,'Πάτρα',0),(12,'AA123420','Ζαφειρίου Νίκος','Αισχύλου',89,NULL,'Δροσιά',0),(13,'AA123421','Συμεωνίδης Στέργιος','Κολοκοτρώνη',58,NULL,'Τανάγρα',0),(14,'AA123422','Νίκα Μάρθα','Κρέσνας',48,NULL,'Νέα Σμύρνη',0),(15,'AA123423','Ζυγουράκης Θωμάς','Ανθείας',43,NULL,'Πάτρα',0),(16,'AA123424','Ευθυμίου Κώστας','Ασπασίας',11,NULL,'Αγ. Παρασκευή',0),(17,'AA123425','Μαύρος Ανδρέας','Μενελάου',1,NULL,'Ιωάννινα',0),(18,'AA123426','Φτωχούλης Μηνάς','Βάρναλη',76,NULL,'Πρέβεζα',0),(19,'AA123427','Κατωπόδης Μηνάς','Πλάτωνος',7,NULL,'Άρτα',0),(20,'AA123428','Ετσιμία Δήμητρα','Λοκρίδος',35,NULL,'Γλυφάδα',0),(21,'AA123429','Καραμαύρος Μένιος','Δανοπούλου',89,NULL,'Ηράκλειο',0),(22,'AA12343','Νίκας Νίκος','Πετρόμπεη',78,NULL,'Βόλος',0),(23,'AA123430','Κούτρας Τάκης','Αγ. Νεκταρίου',10,NULL,'Ρέθυμνο',0),(24,'AA12344','Μαρίνη Δήμητρα','Ταξιαρχών',25,NULL,'Ιωάννινα',0),(25,'AA12345','Σωτηρίου Ιωάννα','Ιωνίας',22,NULL,'Πάτρα',0),(26,'AA12346','Καλαπόδης Νικόλαος','Ρέας',33,NULL,'Κάλυμνος',0),(27,'AA12347','Καραγκούνη Δήμητρα','Ρήγα Φεραίου',56,NULL,'Ιωάννινα',0),(28,'AA12348','Ανδριανός Ανδρέας','Μιλτιάδου',67,NULL,'Αθήνα',0),(29,'AA12349','Μετζίνης Θωμάς','Ωρωπού',18,NULL,'Ιθάκη',0);

CREATE TABLE `ERGASTIRIO` (
  `kod_ergastirou` integer NOT NULL
,  `onoma` varchar(60) DEFAULT NULL
,  PRIMARY KEY (`kod_ergastirou`)
);
INSERT INTO `ERGASTIRIO` VALUES (11,'Φυσικής'),(12,'Διαδραστικού Προγραμματισμού'),(13,'Βάσεων Δεδομένων'),(14,'Ηλεκτρονικών Κυκλωμάτων');

CREATE TABLE `KATHIGITIS` (
  `kod_melous` integer NOT NULL
,  PRIMARY KEY (`kod_melous`)
,  CONSTRAINT `KATHIGITIS_fk0` FOREIGN KEY (`kod_melous`) REFERENCES `MELOS` (`kod_melous`) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO `KATHIGITIS` VALUES (2),(3),(4),(5),(11),(12),(14),(15);

CREATE TABLE `FITITIS` (
  `kod_epivleponta` integer NOT NULL
,  `kod_melous` integer NOT NULL
,  PRIMARY KEY (`kod_melous`)
,  CONSTRAINT `FITITIS_fk0` FOREIGN KEY (`kod_epivleponta`) REFERENCES `KATHIGITIS` (`kod_melous`) ON DELETE CASCADE ON UPDATE CASCADE
,  CONSTRAINT `FITITIS_fk1` FOREIGN KEY (`kod_melous`) REFERENCES `MELOS` (`kod_melous`) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO `FITITIS` VALUES (2,7),(2,8),(3,6),(3,10),(3,17),(3,19),(4,20),(4,26),(4,27),(5,9),(11,16),(12,18),(14,13),(14,29),(15,28);


CREATE TABLE `TILEFONO` (
  `kod_melous` integer NOT NULL
,  `ar_tilefonou` varchar(14) NOT NULL
,  PRIMARY KEY (`kod_melous`,`ar_tilefonou`)
,  CONSTRAINT `TILEFONO_fk0` FOREIGN KEY (`kod_melous`) REFERENCES `MELOS` (`kod_melous`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `ANHKEI` (
  `kod_melous` integer NOT NULL
,  `kod_ergastirou` integer NOT NULL
,  PRIMARY KEY (`kod_melous`)
,  CONSTRAINT `ANHKEI_fk0` FOREIGN KEY (`kod_melous`) REFERENCES `KATHIGITIS` (`kod_melous`) ON DELETE CASCADE ON UPDATE CASCADE
,  CONSTRAINT `ANHKEI_fk1` FOREIGN KEY (`kod_ergastirou`) REFERENCES `ERGASTIRIO` (`kod_ergastirou`) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO `ANHKEI` VALUES (2,11),(11,11),(3,12),(15,12),(4,13),(5,13),(12,14),(14,14);

CREATE TABLE `ENTYPO` (
  `kod_entypou` integer NOT NULL
,  `titlos` varchar(100) NOT NULL
,  `ekdotis` integer NOT NULL
,  `syggrafeas` varchar(100) DEFAULT NULL
,  `ekdosi` varchar(20) DEFAULT NULL
,  `im_ekdosis` datetime DEFAULT NULL
,  PRIMARY KEY (`kod_entypou`)
);
INSERT INTO `ENTYPO` VALUES (10,'Database system concepts',1,'Douglas','1','1985-02-10 00:00:00'),(11,'Database design',1,'Michael','3','1989-02-10 00:00:00'),(12,'Using SQL',5,'Groff','1','1985-02-10 00:00:00'),(13,'Visual Basic for Windows inside & out',5,'Stevens','3','1989-02-10 00:00:00'),(14,'Conceptual schema and relational database design : a fact oriented',5,'Nijssen','1','1985-02-10 00:00:00'),(15,'Fundamental concepts of information modeling',7,'Flavin','3','1989-02-10 00:00:00'),(16,'Visual basic [programming]',7,'Holzner','1','1985-02-10 00:00:00'),(17,'Practical data design',7,'Brackett','3','1989-02-10 00:00:00'),(18,'A practical guide to data base design',8,'Hogan','1','1985-02-10 00:00:00'),(19,'Relational database design with microcomputer applications',8,'Jackson','3','1989-02-10 00:00:00'),(20,'Strategic information planning methodologies',8,'Martin','1','1985-02-10 00:00:00'),(21,'Fundamentals of data normalization',8,'Dutka','3','1989-02-10 00:00:00'),(22,'Database: a primer',1,'Date','1','1985-02-10 00:00:00'),(23,'Handbook of relational database design',1,'Fleming','3','1989-02-10 00:00:00'),(24,'Object-oriented concepts,  databases and applications',1,'Kim','1','1985-02-10 00:00:00'),(25,'Introduction to SQL',5,'van der Lans','3','1989-02-10 00:00:00'),(26,'A guide to the SQL standard : a user''s guide to the standard relational language SQL',5,'Date','1','1985-02-10 00:00:00'),(27,'An introduction to database systems',5,'Date','3','1989-02-10 00:00:00'),(28,'The practical SQL handbook : using structured query language',7,'Emerson','1','1985-02-10 00:00:00'),(29,'Using Visual Basic : writing Windows applications',7,'Murray','3','1989-02-10 00:00:00'),(30,'Data structures,  files and databases',2,'Bamford','1','1985-02-10 00:00:00'),(31,'A visual introduction to SQL',8,'Trimble','3','1989-02-10 00:00:00'),(32,'Database : structured techniques for design,  performance,  and management',2,'Benford','1','1985-02-10 00:00:00'),(33,'Visual Basic programming : with Windows applications',8,'Hergert','3','1989-02-10 00:00:00'),(34,'Database processing : fundamentals,  design,  implementation',2,'Hubert','1','1985-02-10 00:00:00'),(35,'Database analysis and design',1,'Hawryszkiewycz','3','1989-02-10 00:00:00'),(36,'Principles of database systems',1,'Ullman','1','1985-02-10 00:00:00'),(37,'Programmer''s introduction to Visual Basic',1,'Brown','3','1989-02-10 00:00:00'),(38,'Fundamentals of database systems',5,'Elmasri','1','1985-02-10 00:00:00'),(39,'Object-oriented databases',9,'Petry','1','1985-02-10 00:00:00'),(40,'Visual Basic : easy Windows programming',9,'Shammas','3','1989-02-10 00:00:00'),(41,'SQL,  structured query language',2,'Hursch','1','1985-02-10 00:00:00'),(42,'Visual Basic by example',2,'Scott','2','1989-02-10 00:00:00'),(43,'Principles of database and knowledgebase systems',2,'Ullman','1','1985-02-10 00:00:00'),(44,'Logical data base design',8,'Curtice','3','1989-02-10 00:00:00'),(45,'Understanding SQL',8,'Gruber','1','1985-02-10 00:00:00'),(46,'SQL and relational databases',8,'Vang','3','1989-02-10 00:00:00'),(47,'Managing your information : how to design and create a textual database',8,'Tenopir','1','1985-02-10 00:00:00'),(48,'Quick reference guide to SQL',1,'Viescas','3','1989-02-10 00:00:00'),(49,'The Microsoft Visual Basic workshop',1,'Craig','1','1985-02-10 00:00:00'),(50,'Running Visual Basic For Windows (Version 2)',1,'Nelson','1','1992-03-20 00:00:00'),(51,'The Microsoft Visual Basic for MS-DOS workshop',9,'Craig','3','1989-02-10 00:00:00'),(52,'Running Microsoft Access',9,'Viescas','1','2015-06-20 00:00:00'),(53,'SQL and relational basics',9,'Pascal','1','2008-09-13 00:00:00'),(54,'Database modeling and design : the entity-relationship approach',3,'Teorey','2','1989-02-10 00:00:00'),(55,'A guide to developing client/server SQL applications',1,'Khoshafian','2','1985-02-10 00:00:00'),(56,'The Waite Group''s Visual Basic How-To',8,'Arnson','1','1985-02-10 00:00:00'),(57,'Visual BASIC superbible',8,'Maxwell','1','1985-02-10 00:00:00'),(58,'VB = mc2 : the art of Visual Basic programming',8,'Evans','1','1985-02-10 00:00:00');

CREATE TABLE `ANTITYPO` (
  `kod_entypou` integer NOT NULL
,  `ar_entypou` integer NOT NULL
,  PRIMARY KEY (`kod_entypou`,`ar_entypou`)
,  CONSTRAINT `ANTITYPO_fk0` FOREIGN KEY (`kod_entypou`) REFERENCES `ENTYPO` (`kod_entypou`) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO `ANTITYPO` VALUES (10,1),(10,2),(10,3),(11,1),(11,2),(11,3),(12,1),(12,2),(12,3),(13,1),(13,2),(13,3),(14,1),(14,2),(14,3),(15,1),(15,2),(15,3),(16,1),(16,2),(16,3),(17,1),(17,2),(17,3),(18,1),(18,2),(18,3),(19,1),(19,2),(19,3),(20,1),(20,2),(20,3),(21,1),(21,2),(21,3),(22,1),(22,2),(22,3),(23,1),(23,2),(23,3),(24,1),(24,2),(24,3),(25,1),(25,2),(25,3),(26,1),(26,2),(26,3),(27,1),(27,2),(27,3),(28,1),(28,2),(28,3),(29,1),(29,2),(29,3),(30,1),(30,2),(30,3),(31,1),(31,2),(31,3),(32,1),(32,2),(32,3),(33,1),(33,2),(33,3),(34,1),(34,2),(34,3),(35,1),(35,2),(35,3),(36,1),(36,2),(36,3),(37,1),(37,2),(37,3),(38,1),(38,2),(38,3),(39,1),(39,2),(39,3),(40,1),(40,2),(40,3),(41,1),(41,2),(41,3),(42,1),(42,2),(42,3),(43,1),(43,2),(43,3),(44,1),(44,2),(44,3),(45,1),(45,2),(45,3),(46,1),(46,2),(46,3),(47,1),(47,2),(47,3),(48,1),(48,2),(48,3),(49,1),(49,2),(49,3),(50,1),(50,2),(50,3),(51,1),(52,1),(53,1),(53,2),(53,3),(53,4),(54,1),(54,2),(54,3),(55,1),(55,2),(55,3),(56,1),(56,2),(56,3),(57,1),(57,2),(57,3);

CREATE TABLE `DANEIZETAI` (
  `kod_entypou` integer NOT NULL
,  `ar_entypou` integer NOT NULL
,  `kod_melous` integer NOT NULL
,  `im_daneismou` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
,  `im_epistrofis` datetime DEFAULT NULL
,  PRIMARY KEY (`kod_entypou`,`ar_entypou`,`kod_melous`,`im_daneismou`)
,  CONSTRAINT `DANEIZETAI_fk0` FOREIGN KEY (`kod_entypou`, `ar_entypou`) REFERENCES `ANTITYPO` (`kod_entypou`, `ar_entypou`) ON DELETE CASCADE ON UPDATE CASCADE
,  CONSTRAINT `DANEIZETAI_fk1` FOREIGN KEY (`kod_melous`) REFERENCES `MELOS` (`kod_melous`) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO `DANEIZETAI` VALUES (11,1,27,'2022-11-11 00:00:00','2022-11-21 00:00:00'),(11,1,29,'2022-07-28 00:00:00','2022-08-12 00:00:00'),(11,1,29,'2022-08-12 00:00:00','2022-08-26 00:00:00'),(13,1,24,'2022-09-30 00:00:00','2022-10-18 00:00:00'),(14,1,13,'2022-11-11 00:00:00','2022-11-28 00:00:00'),(14,1,24,'2021-12-09 00:00:00','2021-12-29 00:00:00'),(14,1,24,'2022-11-15 00:00:00','2022-12-15 00:00:00'),(14,2,22,'2022-10-07 00:00:00','2022-11-05 00:00:00'),(14,3,20,'2022-10-07 00:00:00','2022-10-31 00:00:00'),(16,1,11,'2022-10-06 00:00:00','2022-11-03 00:00:00'),(16,2,16,'2022-09-30 00:00:00','2022-10-21 00:00:00'),(19,1,29,'2022-11-05 00:00:00','2022-11-24 00:00:00'),(22,1,4,'2022-10-02 00:00:00','2022-10-26 00:00:00'),(22,3,26,'2022-10-08 00:00:00','2022-11-01 00:00:00'),(23,1,29,'2022-10-05 00:00:00','2022-11-02 00:00:00'),(23,3,7,'2022-10-05 00:00:00','2022-10-27 00:00:00'),(29,3,9,'2022-11-06 00:00:00','2022-11-25 00:00:00'),(31,3,14,'2022-10-13 00:00:00','2022-11-11 00:00:00'),(32,1,23,'2022-10-06 00:00:00','2022-10-30 00:00:00'),(32,2,13,'2022-10-12 00:00:00','2022-11-09 00:00:00'),(34,2,7,'2022-10-14 00:00:00','2022-11-11 00:00:00'),(34,2,14,'2022-09-03 00:00:00','2022-09-30 00:00:00'),(35,2,3,'2022-10-05 00:00:00','2022-10-26 00:00:00'),(35,3,6,'2022-11-03 00:00:00','2022-11-12 00:00:00'),(36,2,12,'2022-11-14 00:00:00','2022-12-01 00:00:00'),(36,2,27,'2022-10-05 00:00:00','2022-10-24 00:00:00'),(38,1,26,'2022-10-01 00:00:00','2022-10-27 00:00:00'),(39,3,16,'2022-09-30 00:00:00','2022-10-25 00:00:00'),(40,3,11,'2022-10-12 00:00:00','2022-11-10 00:00:00'),(44,3,19,'2022-08-12 00:00:00','2022-09-11 00:00:00'),(44,3,24,'2022-11-10 00:00:00','2022-11-26 00:00:00'),(45,3,7,'2022-11-13 00:00:00','2022-11-20 00:00:00'),(47,1,5,'2022-11-05 00:00:00','2022-11-14 00:00:00'),(49,1,13,'2022-10-09 00:00:00','2022-11-08 00:00:00'),(50,1,10,'2022-10-06 00:00:00','2022-11-01 00:00:00'),(50,1,25,'2022-03-28 00:00:00','2022-04-12 00:00:00'),(51,1,27,'2022-04-24 00:00:00','2022-05-24 00:00:00'),(52,1,27,'2022-05-08 00:00:00','2022-06-08 00:00:00');

CREATE TABLE `EPISTREFEI` (
  `kod_melous` integer NOT NULL
,  `kod_entypou` integer NOT NULL
,  `ar_entypou` integer NOT NULL
,  `im_daneismou` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
,  `im_pou_epistrafike` datetime NOT NULL
,  PRIMARY KEY (`kod_entypou`,`ar_entypou`,`kod_melous`,`im_daneismou`)
,  CONSTRAINT `EPISTREFEI_FK` FOREIGN KEY (`kod_entypou`, `ar_entypou`, `kod_melous`, `im_daneismou`) REFERENCES `DANEIZETAI` (`kod_entypou`, `ar_entypou`, `kod_melous`, `im_daneismou`) ON DELETE CASCADE ON UPDATE CASCADE
,  CONSTRAINT `EPISTREFEI_fk1` FOREIGN KEY (`kod_melous`) REFERENCES `MELOS` (`kod_melous`) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO `EPISTREFEI` VALUES (27,11,1,'2022-11-11 00:00:00','2022-11-21 00:00:00'),(29,11,1,'2022-07-28 00:00:00','2022-08-12 00:00:00'),(29,11,1,'2022-08-12 00:00:00','2022-08-26 00:00:00'),(24,13,1,'2022-09-30 00:00:00','2022-10-18 00:00:00'),(24,14,1,'2021-12-09 00:00:00','2022-01-30 00:00:00'),(22,14,2,'2022-10-07 00:00:00','2022-11-05 00:00:00'),(20,14,3,'2022-10-07 00:00:00','2022-10-31 00:00:00'),(11,16,1,'2022-10-06 00:00:00','2022-11-03 00:00:00'),(16,16,2,'2022-09-30 00:00:00','2022-10-21 00:00:00'),(4,22,1,'2022-10-02 00:00:00','2022-10-26 00:00:00'),(26,22,3,'2022-10-08 00:00:00','2022-11-01 00:00:00'),(29,23,1,'2022-10-05 00:00:00','2022-11-02 00:00:00'),(7,23,3,'2022-10-05 00:00:00','2022-10-27 00:00:00'),(14,31,3,'2022-10-13 00:00:00','2022-11-11 00:00:00'),(23,32,1,'2022-10-06 00:00:00','2022-10-30 00:00:00'),(13,32,2,'2022-10-12 00:00:00','2022-11-09 00:00:00'),(7,34,2,'2022-10-14 00:00:00','2022-11-11 00:00:00'),(14,34,2,'2022-09-03 00:00:00','2022-10-01 00:00:00'),(3,35,2,'2022-10-05 00:00:00','2022-10-26 00:00:00'),(27,36,2,'2022-10-05 00:00:00','2022-11-13 00:00:00'),(26,38,1,'2022-10-01 00:00:00','2022-10-27 00:00:00'),(16,39,3,'2022-09-30 00:00:00','2022-10-25 00:00:00'),(11,40,3,'2022-10-12 00:00:00','2022-11-10 00:00:00'),(19,44,3,'2022-08-12 00:00:00','2022-09-11 00:00:00'),(24,44,3,'2022-11-10 00:00:00','2022-11-22 00:00:00'),(13,49,1,'2022-10-09 00:00:00','2022-11-08 00:00:00'),(10,50,1,'2022-10-06 00:00:00','2022-11-01 00:00:00'),(25,50,1,'2022-03-28 00:00:00','2022-04-30 00:00:00'),(27,51,1,'2022-04-24 00:00:00','2022-05-25 00:00:00'),(27,52,1,'2022-05-08 00:00:00','2022-06-09 00:00:00');

CREATE TABLE `PROEGRAFETAI` (
  `kod_entypou` integer NOT NULL
,  `kod_melous` integer NOT NULL
,  `im_aitisis` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
,  PRIMARY KEY (`kod_entypou`,`kod_melous`,`im_aitisis`)
,  CONSTRAINT `PROEGRAFETAI_fk0` FOREIGN KEY (`kod_entypou`) REFERENCES `ENTYPO` (`kod_entypou`) ON DELETE CASCADE ON UPDATE CASCADE
,  CONSTRAINT `PROEGRAFETAI_fk1` FOREIGN KEY (`kod_melous`) REFERENCES `MELOS` (`kod_melous`) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO `PROEGRAFETAI` VALUES (10,2,'2022-11-15 00:00:00'),(10,10,'2022-11-16 00:00:00'),(18,12,'2022-11-20 00:00:00'),(15,19,'2022-11-19 00:00:00'),(17,23,'2022-11-15 00:00:00');

CREATE TABLE `THEMA` (
  `kod_thematos` integer NOT NULL
,  `perigrafi` varchar(255) NOT NULL
,  PRIMARY KEY (`kod_thematos`)
);
INSERT INTO `THEMA` VALUES (1,'Βάσεις Δεδομένων'),(2,'Λειτουργικά Συστήματα'),(3,'Γλώσσες Προγραμματισμού'),(4,'Λογιστικά Φύλλα'),(5,'Πακέτα Γραφείου'),(6,'Σχεδίαση Βάσεων Δεδομένων'),(7,'Σχεσιακές Βάσεις Δεδομένων'),(8,'Access'),(9,'Gupta'),(10,'Dos'),(11,'Windows 95'),(12,'Windows NT'),(13,'Unix'),(14,'Excel'),(15,'Lotus'),(16,'Word'),(17,'Ami Pro'),(18,'Word Pro'),(19,'SQL Server'),(20,'Visual C'),(21,'Visual Basic'),(22,'SQL Windows'),(23,'Cobol'),(24,'Pascal'),(25,'Power Point');

CREATE TABLE `PRAGMATEVETAI` (
  `kod_entypou` integer NOT NULL
,  `kod_thematos` integer NOT NULL
,  PRIMARY KEY (`kod_entypou`,`kod_thematos`)
,  CONSTRAINT `PRAGMATEVETAI_fk0` FOREIGN KEY (`kod_entypou`) REFERENCES `ENTYPO` (`kod_entypou`) ON DELETE CASCADE ON UPDATE CASCADE
,  CONSTRAINT `PRAGMATEVETAI_fk1` FOREIGN KEY (`kod_thematos`) REFERENCES `THEMA` (`kod_thematos`) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO `PRAGMATEVETAI` VALUES (10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(16,1),(10,6),(14,6),(11,7),(12,7),(14,7),(13,21),(16,21);

INSERT INTO `TILEFONO` VALUES (2,'2610993457'),(3,'2610993457'),(4,'2610993457'),(5,'2610993453'),(11,'2610993453'),(12,'2610993453'),(13,'2610993453'),(14,'2610993457'),(15,'2610993453'),(21,'2610993453'),(22,'2610993453'),(23,'2610993453'),(24,'2610993453'),(25,'2610993457'),(26,'2610993457'),(27,'2610993457'),(28,'2610993457'),(29,'2610993457');
CREATE INDEX "idx_PRAGMATEVETAI_PRAGMATEVETAI_fk1" ON "PRAGMATEVETAI" (`kod_thematos`);
CREATE INDEX "idx_PRAGMATEVETAI_PRAGMATEVETAI_fk0" ON "PRAGMATEVETAI" (`kod_entypou`);
CREATE INDEX "idx_FITITIS_FITITIS_fk0" ON "FITITIS" (`kod_epivleponta`);
CREATE INDEX "idx_EPISTREFEI_EPISTREFEI_fk1" ON "EPISTREFEI" (`kod_melous`);
CREATE INDEX "idx_DANEIZETAI_DANEIZETAI_fk1" ON "DANEIZETAI" (`kod_melous`);
CREATE INDEX "idx_PROEGRAFETAI_PROEGRAFETAI_fk1" ON "PROEGRAFETAI" (`kod_melous`);
CREATE INDEX "idx_ANHKEI_ANHKEI_fk1" ON "ANHKEI" (`kod_ergastirou`);
END TRANSACTION;
