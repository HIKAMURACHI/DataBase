-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               10.1.31-MariaDB - mariadb.org binary distribution
-- Операционная система:         Win32
-- HeidiSQL Версия:              9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Дамп структуры базы данных movie
CREATE DATABASE IF NOT EXISTS `movie` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `movie`;

-- Дамп структуры для таблица movie.directorr
CREATE TABLE IF NOT EXISTS `directorr` (
  `directors` char(255) NOT NULL DEFAULT 'No Name',
  `DateBirth` date NOT NULL,
  PRIMARY KEY (`directors`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы movie.directorr: ~2 rows (приблизительно)
/*!40000 ALTER TABLE `directorr` DISABLE KEYS */;
INSERT INTO `directorr` (`directors`, `DateBirth`) VALUES
	('George Lucas', '1944-05-14'),
	('Lana Wachowski', '1965-06-21');
/*!40000 ALTER TABLE `directorr` ENABLE KEYS */;

-- Дамп структуры для таблица movie.genress
CREATE TABLE IF NOT EXISTS `genress` (
  `genres` char(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`genres`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы movie.genress: ~4 rows (приблизительно)
/*!40000 ALTER TABLE `genress` DISABLE KEYS */;
INSERT INTO `genress` (`genres`) VALUES
	('Action'),
	('Adventure'),
	('Cartoon'),
	('SpaceOpera');
/*!40000 ALTER TABLE `genress` ENABLE KEYS */;

-- Дамп структуры для таблица movie.movies
CREATE TABLE IF NOT EXISTS `movies` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` char(255) NOT NULL DEFAULT '0',
  `Studio` char(255) NOT NULL DEFAULT '0',
  `Genre` char(255) NOT NULL DEFAULT '0',
  `Year` int(4) NOT NULL DEFAULT '0',
  `Director` char(255) NOT NULL DEFAULT '0',
  `Main_Role` char(255) NOT NULL,
  `ShortStroy` char(255) NOT NULL,
  `Result` int(11) NOT NULL,
  `Avaliable` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`),
  KEY `FK_movies_directorr` (`Director`),
  KEY `FK_movies_resultt` (`Result`),
  KEY `FK_movies_genress` (`Genre`),
  KEY `FK_movies_studioo` (`Studio`),
  CONSTRAINT `FK_movies_directorr` FOREIGN KEY (`Director`) REFERENCES `directorr` (`directors`) ON UPDATE CASCADE,
  CONSTRAINT `FK_movies_genress` FOREIGN KEY (`Genre`) REFERENCES `genress` (`genres`) ON UPDATE CASCADE,
  CONSTRAINT `FK_movies_resultt` FOREIGN KEY (`Result`) REFERENCES `resultt` (`ID`) ON UPDATE CASCADE,
  CONSTRAINT `FK_movies_studioo` FOREIGN KEY (`Studio`) REFERENCES `studioo` (`studios`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы movie.movies: ~6 rows (приблизительно)
/*!40000 ALTER TABLE `movies` DISABLE KEYS */;
INSERT INTO `movies` (`ID`, `Name`, `Studio`, `Genre`, `Year`, `Director`, `Main_Role`, `ShortStroy`, `Result`, `Avaliable`) VALUES
	(1, 'Star Wars I The Phantom menace', '20th Century Fox', 'SpaceOpera', 1999, 'George Lucas', 'Frank OZ', 'Begin long story ...', 1, 1),
	(2, 'Star Wars Episode VI Return of the Jedi', '20th Century Fox', 'SpaceOpera', 1983, 'George Lucas', 'Harison Ford', 'Jedi return home ...', 2, 1),
	(3, 'Star Wars Episode V The Empire Strikes Back', '20th Century Fox', 'SpaceOpera', 1980, 'George Lucas', 'Carrie Fisher', 'Empire Strikes again ...', 3, 0),
	(4, 'Indiana Jones and the Last Crusade', '20th Century Fox', 'Adventure', 1989, 'George Lucas', 'Harison Ford', 'Indiana guy ...', 4, 1),
	(5, 'Phineas and Ferb', 'Wallt Disney', 'Cartoon', 2007, 'George Lucas', 'Vinsent Martella', 'Duck with nose 007 ...', 5, 1),
	(6, 'The Matrix', 'Warner Bros', 'Action', 1998, 'Lana Wachowski', 'Keanu Reeves', 'Real world ?', 6, 0);
/*!40000 ALTER TABLE `movies` ENABLE KEYS */;

-- Дамп структуры для таблица movie.resultt
CREATE TABLE IF NOT EXISTS `resultt` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Res` float DEFAULT '0',
  `MovieSer` int(11) DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы movie.resultt: ~6 rows (приблизительно)
/*!40000 ALTER TABLE `resultt` DISABLE KEYS */;
INSERT INTO `resultt` (`ID`, `Res`, `MovieSer`) VALUES
	(1, 7.9, 6695),
	(2, 8.2, 447),
	(3, 8.2, 338),
	(4, 8, 472),
	(5, 7.8, 449993),
	(6, 8.6, 301);
/*!40000 ALTER TABLE `resultt` ENABLE KEYS */;

-- Дамп структуры для таблица movie.studioo
CREATE TABLE IF NOT EXISTS `studioo` (
  `studios` char(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`studios`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы movie.studioo: ~4 rows (приблизительно)
/*!40000 ALTER TABLE `studioo` DISABLE KEYS */;
INSERT INTO `studioo` (`studios`) VALUES
	('20th Century Fox'),
	('Lucas Film'),
	('Wallt Disney'),
	('Warner Bros');
/*!40000 ALTER TABLE `studioo` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
