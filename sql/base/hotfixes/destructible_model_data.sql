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

-- Table structure for table `destructible_model_data`
--

DROP TABLE IF EXISTS `destructible_model_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `destructible_model_data` (
  `ID` int(10) unsigned NOT NULL DEFAULT '0',
  `StateDamagedDisplayID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `StateDestroyedDisplayID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `StateRebuildingDisplayID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `StateSmokeDisplayID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `HealEffectSpeed` smallint(5) unsigned NOT NULL DEFAULT '0',
  `StateDamagedImpactEffectDoodadSet` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `StateDamagedAmbientDoodadSet` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `StateDamagedNameSet` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `StateDestroyedDestructionDoodadSet` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `StateDestroyedImpactEffectDoodadSet` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `StateDestroyedAmbientDoodadSet` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `StateDestroyedNameSet` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `StateRebuildingDestructionDoodadSet` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `StateRebuildingImpactEffectDoodadSet` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `StateRebuildingAmbientDoodadSet` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `StateRebuildingNameSet` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `StateSmokeInitDoodadSet` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `StateSmokeAmbientDoodadSet` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `StateSmokeNameSet` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `EjectDirection` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `DoNotHighlight` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `HealEffect` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `destructible_model_data`
--

LOCK TABLES `destructible_model_data` WRITE;
/*!40000 ALTER TABLE `destructible_model_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `destructible_model_data` ENABLE KEYS */;
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
