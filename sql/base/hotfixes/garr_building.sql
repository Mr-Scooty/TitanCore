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

-- Table structure for table `garr_building`
--

DROP TABLE IF EXISTS `garr_building`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `garr_building` (
  `ID` int(10) unsigned NOT NULL DEFAULT '0',
  `NameAlliance` text,
  `NameHorde` text,
  `Description` text,
  `Tooltip` text,
  `HordeGameObjectID` int(10) unsigned NOT NULL DEFAULT '0',
  `AllianceGameObjectID` int(10) unsigned NOT NULL DEFAULT '0',
  `IconFileDataID` int(10) unsigned NOT NULL DEFAULT '0',
  `CostCurrencyID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `HordeTexPrefixKitID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AllianceTexPrefixKitID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AllianceActivationScenePackageID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `HordeActivationScenePackageID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `FollowerRequiredGarrAbilityID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `FollowerGarrAbilityEffectID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `CostMoney` smallint(6) NOT NULL DEFAULT '0',
  `Unknown` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Level` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Flags` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `MaxShipments` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `GarrTypeID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `BuildDuration` int(11) NOT NULL DEFAULT '0',
  `CostCurrencyAmount` int(11) NOT NULL DEFAULT '0',
  `BonusAmount` int(11) NOT NULL DEFAULT '0',
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `garr_building`
--

LOCK TABLES `garr_building` WRITE;
/*!40000 ALTER TABLE `garr_building` DISABLE KEYS */;
/*!40000 ALTER TABLE `garr_building` ENABLE KEYS */;
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
