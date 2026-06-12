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

-- Table structure for table `item_sparse`
--

DROP TABLE IF EXISTS `item_sparse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_sparse` (
  `ID` int(10) unsigned NOT NULL DEFAULT '0',
  `AllowableRace` bigint(20) NOT NULL DEFAULT '0',
  `Name` text,
  `Name2` text,
  `Name3` text,
  `Name4` text,
  `Description` text,
  `Flags1` int(10) unsigned NOT NULL DEFAULT '0',
  `Flags2` int(10) unsigned NOT NULL DEFAULT '0',
  `Flags3` int(10) unsigned NOT NULL DEFAULT '0',
  `Flags4` int(10) unsigned NOT NULL DEFAULT '0',
  `Unk1` float NOT NULL DEFAULT '0',
  `Unk2` float NOT NULL DEFAULT '0',
  `BuyCount` int(10) unsigned NOT NULL DEFAULT '0',
  `BuyPrice` int(10) unsigned NOT NULL DEFAULT '0',
  `SellPrice` int(10) unsigned NOT NULL DEFAULT '0',
  `RequiredSpell` int(10) unsigned NOT NULL DEFAULT '0',
  `MaxCount` int(10) unsigned NOT NULL DEFAULT '0',
  `Stackable` int(10) unsigned NOT NULL DEFAULT '0',
  `ItemStatAllocation1` int(11) NOT NULL DEFAULT '0',
  `ItemStatAllocation2` int(11) NOT NULL DEFAULT '0',
  `ItemStatAllocation3` int(11) NOT NULL DEFAULT '0',
  `ItemStatAllocation4` int(11) NOT NULL DEFAULT '0',
  `ItemStatAllocation5` int(11) NOT NULL DEFAULT '0',
  `ItemStatAllocation6` int(11) NOT NULL DEFAULT '0',
  `ItemStatAllocation7` int(11) NOT NULL DEFAULT '0',
  `ItemStatAllocation8` int(11) NOT NULL DEFAULT '0',
  `ItemStatAllocation9` int(11) NOT NULL DEFAULT '0',
  `ItemStatAllocation10` int(11) NOT NULL DEFAULT '0',
  `ItemStatSocketCostMultiplier1` float NOT NULL DEFAULT '0',
  `ItemStatSocketCostMultiplier2` float NOT NULL DEFAULT '0',
  `ItemStatSocketCostMultiplier3` float NOT NULL DEFAULT '0',
  `ItemStatSocketCostMultiplier4` float NOT NULL DEFAULT '0',
  `ItemStatSocketCostMultiplier5` float NOT NULL DEFAULT '0',
  `ItemStatSocketCostMultiplier6` float NOT NULL DEFAULT '0',
  `ItemStatSocketCostMultiplier7` float NOT NULL DEFAULT '0',
  `ItemStatSocketCostMultiplier8` float NOT NULL DEFAULT '0',
  `ItemStatSocketCostMultiplier9` float NOT NULL DEFAULT '0',
  `ItemStatSocketCostMultiplier10` float NOT NULL DEFAULT '0',
  `RangedModRange` float NOT NULL DEFAULT '0',
  `BagFamily` int(10) unsigned NOT NULL DEFAULT '0',
  `ArmorDamageModifier` float NOT NULL DEFAULT '0',
  `Duration` int(10) unsigned NOT NULL DEFAULT '0',
  `StatScalingFactor` float NOT NULL DEFAULT '0',
  `AllowableClass` smallint(6) NOT NULL DEFAULT '0',
  `ItemLevel` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RequiredSkill` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RequiredSkillRank` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RequiredReputationFaction` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ItemStatValue1` smallint(6) NOT NULL DEFAULT '0',
  `ItemStatValue2` smallint(6) NOT NULL DEFAULT '0',
  `ItemStatValue3` smallint(6) NOT NULL DEFAULT '0',
  `ItemStatValue4` smallint(6) NOT NULL DEFAULT '0',
  `ItemStatValue5` smallint(6) NOT NULL DEFAULT '0',
  `ItemStatValue6` smallint(6) NOT NULL DEFAULT '0',
  `ItemStatValue7` smallint(6) NOT NULL DEFAULT '0',
  `ItemStatValue8` smallint(6) NOT NULL DEFAULT '0',
  `ItemStatValue9` smallint(6) NOT NULL DEFAULT '0',
  `ItemStatValue10` smallint(6) NOT NULL DEFAULT '0',
  `ScalingStatDistribution` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Delay` smallint(5) unsigned NOT NULL DEFAULT '0',
  `PageText` smallint(5) unsigned NOT NULL DEFAULT '0',
  `StartQuest` smallint(5) unsigned NOT NULL DEFAULT '0',
  `LockID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RandomProperty` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RandomSuffix` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ItemSet` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Area` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Map` smallint(5) unsigned NOT NULL DEFAULT '0',
  `TotemCategory` smallint(5) unsigned NOT NULL DEFAULT '0',
  `SocketBonus` smallint(5) unsigned NOT NULL DEFAULT '0',
  `GemProperties` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ItemLimitCategory` smallint(5) unsigned NOT NULL DEFAULT '0',
  `HolidayID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RequiredTransmogHolidayID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ItemNameDescriptionID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Quality` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `InventoryType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `RequiredLevel` tinyint(4) NOT NULL DEFAULT '0',
  `RequiredHonorRank` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `RequiredCityRank` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `RequiredReputationRank` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ContainerSlots` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ItemStatType1` tinyint(4) NOT NULL DEFAULT '0',
  `ItemStatType2` tinyint(4) NOT NULL DEFAULT '0',
  `ItemStatType3` tinyint(4) NOT NULL DEFAULT '0',
  `ItemStatType4` tinyint(4) NOT NULL DEFAULT '0',
  `ItemStatType5` tinyint(4) NOT NULL DEFAULT '0',
  `ItemStatType6` tinyint(4) NOT NULL DEFAULT '0',
  `ItemStatType7` tinyint(4) NOT NULL DEFAULT '0',
  `ItemStatType8` tinyint(4) NOT NULL DEFAULT '0',
  `ItemStatType9` tinyint(4) NOT NULL DEFAULT '0',
  `ItemStatType10` tinyint(4) NOT NULL DEFAULT '0',
  `DamageType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Bonding` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `LanguageID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `PageMaterial` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Material` tinyint(4) NOT NULL DEFAULT '0',
  `Sheath` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `SocketColor1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `SocketColor2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `SocketColor3` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `CurrencySubstitutionID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `CurrencySubstitutionCount` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ArtifactID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `RequiredExpansion` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_sparse`
--

LOCK TABLES `item_sparse` WRITE;
/*!40000 ALTER TABLE `item_sparse` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_sparse` ENABLE KEYS */;
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
