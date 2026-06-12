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

-- Table structure for table `garr_follower`
--

DROP TABLE IF EXISTS `garr_follower`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `garr_follower` (
  `HordeSourceText` text,
  `AllianceSourceText` text,
  `Name` text,
  `HordeCreatureID` int(10) unsigned NOT NULL DEFAULT '0',
  `AllianceCreatureID` int(10) unsigned NOT NULL DEFAULT '0',
  `HordePortraitIconID` int(10) unsigned NOT NULL DEFAULT '0',
  `AlliancePortraitIconID` int(10) unsigned NOT NULL DEFAULT '0',
  `HordeAddedBroadcastTextID` int(10) unsigned NOT NULL DEFAULT '0',
  `AllianceAddedBroadcastTextID` int(10) unsigned NOT NULL DEFAULT '0',
  `HordeGarrFollItemSetID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AllianceGarrFollItemSetID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ItemLevelWeapon` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ItemLevelArmor` smallint(5) unsigned NOT NULL DEFAULT '0',
  `HordeListPortraitTextureKitID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AllianceListPortraitTextureKitID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `FollowerTypeID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `HordeUiAnimRaceInfoID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `AllianceUiAnimRaceInfoID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Quality` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `HordeGarrClassSpecID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `AllianceGarrClassSpecID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Level` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Unknown1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Flags` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Unknown2` tinyint(4) NOT NULL DEFAULT '0',
  `Unknown3` tinyint(4) NOT NULL DEFAULT '0',
  `GarrTypeID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `MaxDurability` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Class` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `HordeFlavorTextGarrStringID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `AllianceFlavorTextGarrStringID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ID` int(10) unsigned NOT NULL DEFAULT '0',
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `garr_follower`
--

LOCK TABLES `garr_follower` WRITE;
/*!40000 ALTER TABLE `garr_follower` DISABLE KEYS */;
/*!40000 ALTER TABLE `garr_follower` ENABLE KEYS */;
UNLOCK TABLES;

--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
