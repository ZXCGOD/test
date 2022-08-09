-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Авг 09 2022 г., 17:45
-- Версия сервера: 5.7.33-log
-- Версия PHP: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `test`
--

-- --------------------------------------------------------

--
-- Структура таблицы `company`
--

CREATE TABLE `company` (
  `id` int(11) NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `company`
--

INSERT INTO `company` (`id`, `name`) VALUES
(1, 'ООО Горгаз'),
(2, 'ООО Москва'),
(3, 'ООО Моя оборона'),
(4, 'ООО Зеленоглазое такси');

--
-- Триггеры `company`
--
DELIMITER $$
CREATE TRIGGER `check_contact` BEFORE DELETE ON `company` FOR EACH ROW begin
DECLARE amount_of_contacts int;
set amount_of_contacts := (SELECT count(*) from contact where company = old.id);
if amount_of_contacts  > 0 THEN
SIGNAL SQLSTATE '45000';
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `contact`
--

CREATE TABLE `contact` (
  `id` int(11) NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `contact`
--

INSERT INTO `contact` (`id`, `name`, `company`) VALUES
(1, 'Алексей', 1),
(2, 'Михаил', 2),
(3, 'Павел', 3),
(4, 'Юрий', 4);

-- --------------------------------------------------------

--
-- Структура таблицы `contactlines`
--

CREATE TABLE `contactlines` (
  `id` int(11) DEFAULT NULL,
  `value` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `contactlines`
--

INSERT INTO `contactlines` (`id`, `value`) VALUES
(1, '+7904069058'),
(1, 'yandex@yandex.ru'),
(2, '+79040689068'),
(NULL, 'mail@mail.ru'),
(2, 'mail@mail.ru'),
(3, '+79030408002'),
(3, 'gmail@gmail.com'),
(4, '+79875587638'),
(4, '+79535591301');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contact_ibfk_1` (`company`);

--
-- Индексы таблицы `contactlines`
--
ALTER TABLE `contactlines`
  ADD KEY `contactlines_ibfk_1` (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `company`
--
ALTER TABLE `company`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `contact`
--
ALTER TABLE `contact`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `contact`
--
ALTER TABLE `contact`
  ADD CONSTRAINT `contact_ibfk_1` FOREIGN KEY (`company`) REFERENCES `company` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `contactlines`
--
ALTER TABLE `contactlines`
  ADD CONSTRAINT `contactlines_ibfk_1` FOREIGN KEY (`id`) REFERENCES `contact` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
