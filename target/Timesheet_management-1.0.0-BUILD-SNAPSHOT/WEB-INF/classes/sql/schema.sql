-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Время создания: Май 15 2019 г., 14:45
-- Версия сервера: 5.6.17
-- Версия PHP: 7.1.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `timesheet`
--

-- --------------------------------------------------------

--
-- Структура таблицы `employee`
--

CREATE TABLE IF NOT EXISTS `employee` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `department` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Дамп данных таблицы `employee`
--

INSERT INTO `employee` (`id`, `department`, `name`) VALUES
(1, 'management', 'Steve Jobs'),
(2, 'management', 'Bill Gates'),
(3, 'engineering', 'Steve Wozniak'),
(4, 'engineering', 'Paul Allen'),
(8, 'Alex', 'Krav');

-- --------------------------------------------------------

--
-- Структура таблицы `manager`
--

CREATE TABLE IF NOT EXISTS `manager` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Дамп данных таблицы `manager`
--

INSERT INTO `manager` (`id`, `name`) VALUES
(1, 'Eric Schmidt'),
(2, 'Steve Ballmer'),
(3, 'Vladimir Zelaaa');

-- --------------------------------------------------------

--
-- Структура таблицы `task`
--

CREATE TABLE IF NOT EXISTS `task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `completed` tinyint(1) NOT NULL,  -- BOOLEAN
  `description` varchar(255) DEFAULT NULL,
  `manager_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK363585B7A879D6` (`manager_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `task`
--

INSERT INTO `task` (`id`, `completed`, `description`, `manager_id`) VALUES
(1, 0, 'task 1', 1),
(2, 0, 'task 2', 2),
(4, 0, 'task 3', 3);

-- --------------------------------------------------------

--
-- Структура таблицы `task_employee`
--

CREATE TABLE IF NOT EXISTS `task_employee` (
  `task_id` bigint(20) NOT NULL,
  `employee_id` bigint(20) NOT NULL,
  KEY `FK47A54828B1506F3E` (`employee_id`),
  KEY `FK47A54828F22C2DDE` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `task_employee`
--

INSERT INTO `task_employee` (`task_id`, `employee_id`) VALUES
(1, 1),
(1, 3),
(1, 4),
(2, 2),
(2, 1),
(4, 2),
(4, 8);

-- --------------------------------------------------------

--
-- Структура таблицы `timesheet`
--

CREATE TABLE IF NOT EXISTS `timesheet` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hours` int(11) DEFAULT NULL,
  `task_id` bigint(20) DEFAULT NULL,
  `employee_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK343C2B2B1506F3E` (`employee_id`),
  KEY `FK343C2B2F22C2DDE` (`task_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `timesheet`
--

INSERT INTO `timesheet` (`id`, `hours`, `task_id`, `employee_id`) VALUES
(1, 5, 1, 1),
(2, 8, 2, 3);

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `task`
--
ALTER TABLE `task`
  ADD CONSTRAINT `FK363585B7A879D6` FOREIGN KEY (`manager_id`) REFERENCES `manager` (`id`);

--
-- Ограничения внешнего ключа таблицы `task_employee`
--
ALTER TABLE `task_employee`
  ADD CONSTRAINT `FK47A54828B1506F3E` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`),
  ADD CONSTRAINT `FK47A54828F22C2DDE` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`);

--
-- Ограничения внешнего ключа таблицы `timesheet`
--
ALTER TABLE `timesheet`
  ADD CONSTRAINT `FK343C2B2B1506F3E` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`),
  ADD CONSTRAINT `FK343C2B2F22C2DDE` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- ================================== My Tables ================================

-- 
-- Table PROFILE --
--

CREATE TABLE IF NOT EXISTS `profile` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `datebirth` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `nationality` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `experience` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

