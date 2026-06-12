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

-- Table structure for table `chr_races`
--

DROP TABLE IF EXISTS `chr_races`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chr_races` (
  `ClientPrefix` text,
  `ClientFileString` text,
  `Name` text,
  `NameFemale` text,
  `LowercaseName` text,
  `LowercaseNameFemale` text,
  `Flags` int(10) unsigned NOT NULL DEFAULT '0',
  `MaleDisplayID` int(10) unsigned NOT NULL DEFAULT '0',
  `FemaleDisplayID` int(10) unsigned NOT NULL DEFAULT '0',
  `CreateScreenFileDataID` int(10) unsigned NOT NULL DEFAULT '0',
  `SelectScreenFileDataID` int(10) unsigned NOT NULL DEFAULT '0',
  `MaleCustomizeOffset1` float NOT NULL DEFAULT '0',
  `MaleCustomizeOffset2` float NOT NULL DEFAULT '0',
  `MaleCustomizeOffset3` float NOT NULL DEFAULT '0',
  `FemaleCustomizeOffset1` float NOT NULL DEFAULT '0',
  `FemaleCustomizeOffset2` float NOT NULL DEFAULT '0',
  `FemaleCustomizeOffset3` float NOT NULL DEFAULT '0',
  `LowResScreenFileDataID` int(10) unsigned NOT NULL DEFAULT '0',
  `StartingLevel` int(10) unsigned NOT NULL DEFAULT '0',
  `UIDisplayOrder` int(10) unsigned NOT NULL DEFAULT '0',
  `FactionID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ResSicknessSpellID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `SplashSoundID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `CinematicSequenceID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `BaseLanguage` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `CreatureType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `TeamID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `RaceRelated` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `UnalteredVisualRaceID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `CharComponentTextureLayoutID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `DefaultClassID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `NeutralRaceID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ItemAppearanceFrameRaceID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `CharComponentTexLayoutHiResID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ID` int(10) unsigned NOT NULL DEFAULT '0',
  `HighResMaleDisplayID` int(10) unsigned NOT NULL DEFAULT '0',
  `HighResFemaleDisplayID` int(10) unsigned NOT NULL DEFAULT '0',
  `HeritageArmorAchievementID` int(10) unsigned NOT NULL DEFAULT '0',
  `MaleCorpseBonesModelFileDataID` int(10) unsigned NOT NULL DEFAULT '0',
  `FemaleCorpseBonesModelFileDataID` int(10) unsigned NOT NULL DEFAULT '0',
  `AlteredFormTransitionSpellVisualID1` int(10) unsigned NOT NULL DEFAULT '0',
  `AlteredFormTransitionSpellVisualID2` int(10) unsigned NOT NULL DEFAULT '0',
  `AlteredFormTransitionSpellVisualID3` int(10) unsigned NOT NULL DEFAULT '0',
  `AlteredFormTransitionSpellVisualKitID1` int(10) unsigned NOT NULL DEFAULT '0',
  `AlteredFormTransitionSpellVisualKitID2` int(10) unsigned NOT NULL DEFAULT '0',
  `AlteredFormTransitionSpellVisualKitID3` int(10) unsigned NOT NULL DEFAULT '0',
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chr_races`
--

LOCK TABLES `chr_races` WRITE;
/*!40000 ALTER TABLE `chr_races` DISABLE KEYS */;
/*!40000 ALTER TABLE `chr_races` ENABLE KEYS */;
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
