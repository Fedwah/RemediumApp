-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3308
-- Généré le :  mer. 26 fév. 2020 à 06:32
-- Version du serveur :  8.0.18
-- Version de PHP :  7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `remediumapp`
--

-- --------------------------------------------------------

--
-- Structure de la table `comporte`
--

DROP TABLE IF EXISTS `comporte`;
CREATE TABLE IF NOT EXISTS `comporte` (
  `id_comp` int(11) NOT NULL AUTO_INCREMENT,
  `id_trait` int(11) NOT NULL,
  `id_med` int(11) NOT NULL,
  `id_notif_med` int(11) NOT NULL,
  PRIMARY KEY (`id_comp`),
  KEY `id_trait` (`id_trait`),
  KEY `id_med` (`id_med`),
  KEY `id_notif_med` (`id_notif_med`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `finnotification`
--

DROP TABLE IF EXISTS `finnotification`;
CREATE TABLE IF NOT EXISTS `finnotification` (
  `id_fin` int(11) NOT NULL AUTO_INCREMENT,
  `daterappel` datetime(6) NOT NULL,
  `id_trait` int(11) NOT NULL,
  PRIMARY KEY (`id_fin`),
  KEY `id_trait` (`id_trait`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `medcin`
--

DROP TABLE IF EXISTS `medcin`;
CREATE TABLE IF NOT EXISTS `medcin` (
  `nssd` varchar(100) NOT NULL,
  `nomd` varchar(100) NOT NULL,
  `prenomd` varchar(100) NOT NULL,
  `adrd` varchar(100) NOT NULL,
  `teld` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `pwdd` varchar(100) NOT NULL,
  `openh` time(6) NOT NULL,
  `closeh` time(6) NOT NULL,
  `speciality` varchar(100) NOT NULL,
  `commune` varchar(100) NOT NULL,
  `gpslink` varchar(100) NOT NULL,
  PRIMARY KEY (`nssd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `medicament`
--

DROP TABLE IF EXISTS `medicament`;
CREATE TABLE IF NOT EXISTS `medicament` (
  `id_med` int(11) NOT NULL,
  `nom_med` varchar(100) NOT NULL,
  PRIMARY KEY (`id_med`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `notificationmed`
--

DROP TABLE IF EXISTS `notificationmed`;
CREATE TABLE IF NOT EXISTS `notificationmed` (
  `id_notif_med` int(11) NOT NULL AUTO_INCREMENT,
  `datenotif` datetime(6) NOT NULL,
  PRIMARY KEY (`id_notif_med`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `patient`
--

DROP TABLE IF EXISTS `patient`;
CREATE TABLE IF NOT EXISTS `patient` (
  `nssp` varchar(100) NOT NULL,
  `nomp` varchar(100) NOT NULL,
  `prenomp` varchar(100) NOT NULL,
  `adrp` varchar(100) NOT NULL,
  `telp` varchar(100) NOT NULL,
  `pwdp` varchar(100) NOT NULL,
  PRIMARY KEY (`nssp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `patient`
--

INSERT INTO `patient` (`nssp`, `nomp`, `prenomp`, `adrp`, `telp`, `pwdp`) VALUES
('45669', 'fedwa', 'bzn', 'jijel', '0541510384', '000');

-- --------------------------------------------------------

--
-- Structure de la table `prendrerendezvous`
--

DROP TABLE IF EXISTS `prendrerendezvous`;
CREATE TABLE IF NOT EXISTS `prendrerendezvous` (
  `id_prend` int(11) NOT NULL AUTO_INCREMENT,
  `nssp` varchar(100) NOT NULL,
  `nssd` varchar(100) NOT NULL,
  `id_rend` int(11) NOT NULL,
  PRIMARY KEY (`id_prend`),
  KEY `prendrerendezvous_ibfk_1` (`nssd`),
  KEY `prendrerendezvous_ibfk_2` (`nssp`),
  KEY `prendrerendezvous_ibfk_3` (`id_rend`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `rendezvous`
--

DROP TABLE IF EXISTS `rendezvous`;
CREATE TABLE IF NOT EXISTS `rendezvous` (
  `id_rend` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `hour` time(6) NOT NULL,
  PRIMARY KEY (`id_rend`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `traitement`
--

DROP TABLE IF EXISTS `traitement`;
CREATE TABLE IF NOT EXISTS `traitement` (
  `id_trait` int(100) NOT NULL AUTO_INCREMENT,
  `datedebut` date NOT NULL,
  `dateFin` date NOT NULL,
  `id_rend` int(11) NOT NULL,
  PRIMARY KEY (`id_trait`),
  KEY `id_rend` (`id_rend`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `comporte`
--
ALTER TABLE `comporte`
  ADD CONSTRAINT `comporte_ibfk_1` FOREIGN KEY (`id_trait`) REFERENCES `traitement` (`id_trait`) ON DELETE CASCADE,
  ADD CONSTRAINT `comporte_ibfk_2` FOREIGN KEY (`id_med`) REFERENCES `medicament` (`id_med`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `comporte_ibfk_3` FOREIGN KEY (`id_notif_med`) REFERENCES `notificationmed` (`id_notif_med`);

--
-- Contraintes pour la table `finnotification`
--
ALTER TABLE `finnotification`
  ADD CONSTRAINT `finnotification_ibfk_1` FOREIGN KEY (`id_trait`) REFERENCES `traitement` (`id_trait`) ON DELETE CASCADE;

--
-- Contraintes pour la table `prendrerendezvous`
--
ALTER TABLE `prendrerendezvous`
  ADD CONSTRAINT `prendrerendezvous_ibfk_1` FOREIGN KEY (`nssd`) REFERENCES `medcin` (`nssd`) ON DELETE CASCADE,
  ADD CONSTRAINT `prendrerendezvous_ibfk_2` FOREIGN KEY (`nssp`) REFERENCES `patient` (`nssp`) ON DELETE CASCADE,
  ADD CONSTRAINT `prendrerendezvous_ibfk_3` FOREIGN KEY (`id_rend`) REFERENCES `rendezvous` (`id_rend`) ON DELETE CASCADE;

--
-- Contraintes pour la table `traitement`
--
ALTER TABLE `traitement`
  ADD CONSTRAINT `traitement_ibfk_1` FOREIGN KEY (`id_rend`) REFERENCES `rendezvous` (`id_rend`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
