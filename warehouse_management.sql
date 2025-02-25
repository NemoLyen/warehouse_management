-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Фев 25 2025 г., 19:22
-- Версия сервера: 10.4.28-MariaDB
-- Версия PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `warehouse_management`
--

-- --------------------------------------------------------

--
-- Структура таблицы `Categories`
--

CREATE TABLE `Categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `Categories`
--

INSERT INTO `Categories` (`id`, `name`) VALUES
(1, 'Электроника'),
(2, 'Одежда'),
(3, 'Продукты питания');

-- --------------------------------------------------------

--
-- Структура таблицы `Customers`
--

CREATE TABLE `Customers` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `contact_info` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `Customers`
--

INSERT INTO `Customers` (`id`, `name`, `contact_info`) VALUES
(1, 'Иван Петров', 'ivan.petrov@example.com, +7 911 123 4567'),
(2, 'Анна Смирнова', 'anna.smirnova@example.com, +7 922 234 5678');

-- --------------------------------------------------------

--
-- Структура таблицы `Products`
--

CREATE TABLE `Products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `unit` varchar(50) DEFAULT NULL,
  `barcode` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `Products`
--

INSERT INTO `Products` (`id`, `name`, `description`, `category_id`, `price`, `unit`, `barcode`) VALUES
(1, 'Смартфон', 'Мощный смартфон с OLED экраном', 1, 599.99, 'шт', '1234567890123'),
(2, 'Футболка', 'Хлопковая футболка', 2, 19.99, 'шт', '1234567890456'),
(3, 'Молоко', 'Литр пастеризованного молока', 3, 1.49, 'л', '1234567890789');

-- --------------------------------------------------------

--
-- Структура таблицы `SalesOrderDetails`
--

CREATE TABLE `SalesOrderDetails` (
  `id` int(11) NOT NULL,
  `sales_order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `SalesOrderDetails`
--

INSERT INTO `SalesOrderDetails` (`id`, `sales_order_id`, `product_id`, `quantity`, `price`) VALUES
(1, 1, 1, 1, 599.99),
(2, 2, 3, 2, 2.98);

-- --------------------------------------------------------

--
-- Структура таблицы `SalesOrders`
--

CREATE TABLE `SalesOrders` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `order_date` datetime DEFAULT current_timestamp(),
  `status` enum('pending','shipped','delivered','cancelled') NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `SalesOrders`
--

INSERT INTO `SalesOrders` (`id`, `customer_id`, `order_date`, `status`) VALUES
(1, 1, '2025-02-25 22:44:49', 'pending'),
(2, 2, '2025-02-25 22:44:49', 'shipped');

-- --------------------------------------------------------

--
-- Структура таблицы `Stock`
--

CREATE TABLE `Stock` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `Stock`
--

INSERT INTO `Stock` (`id`, `product_id`, `warehouse_id`, `quantity`) VALUES
(2, 1, 1, 11000),
(3, 2, 1, 195),
(4, 3, 2, 500);

-- --------------------------------------------------------

--
-- Структура таблицы `Suppliers`
--

CREATE TABLE `Suppliers` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `contact_info` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `Suppliers`
--

INSERT INTO `Suppliers` (`id`, `name`, `contact_info`) VALUES
(1, 'ООО \"ТехноМир\"', 'techno@example.com, +7 900 123 4567'),
(2, 'АО \"ТекстильПром\"', 'textile@example.com, +7 900 987 6543');

-- --------------------------------------------------------

--
-- Структура таблицы `SupplyOrderDetails`
--

CREATE TABLE `SupplyOrderDetails` (
  `id` int(11) NOT NULL,
  `supply_order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `SupplyOrderDetails`
--

INSERT INTO `SupplyOrderDetails` (`id`, `supply_order_id`, `product_id`, `quantity`, `price`) VALUES
(1, 1, 1, 20, 580.00),
(2, 2, 2, 100, 18.00);

-- --------------------------------------------------------

--
-- Структура таблицы `SupplyOrders`
--

CREATE TABLE `SupplyOrders` (
  `id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `order_date` datetime DEFAULT current_timestamp(),
  `status` enum('pending','completed','cancelled') NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `SupplyOrders`
--

INSERT INTO `SupplyOrders` (`id`, `supplier_id`, `warehouse_id`, `order_date`, `status`) VALUES
(1, 1, 1, '2025-02-25 22:44:49', 'pending'),
(2, 2, 2, '2025-02-25 22:44:49', 'completed');

-- --------------------------------------------------------

--
-- Структура таблицы `Warehouses`
--

CREATE TABLE `Warehouses` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `Warehouses`
--

INSERT INTO `Warehouses` (`id`, `name`, `location`) VALUES
(1, 'Главный склад', 'Москва'),
(2, 'Запасной склад', 'Санкт-Петербург');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `Categories`
--
ALTER TABLE `Categories`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `Customers`
--
ALTER TABLE `Customers`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `Products`
--
ALTER TABLE `Products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `barcode` (`barcode`),
  ADD KEY `category_id` (`category_id`);

--
-- Индексы таблицы `SalesOrderDetails`
--
ALTER TABLE `SalesOrderDetails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sales_order_id` (`sales_order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Индексы таблицы `SalesOrders`
--
ALTER TABLE `SalesOrders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Индексы таблицы `Stock`
--
ALTER TABLE `Stock`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `warehouse_id` (`warehouse_id`);

--
-- Индексы таблицы `Suppliers`
--
ALTER TABLE `Suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `SupplyOrderDetails`
--
ALTER TABLE `SupplyOrderDetails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `supply_order_id` (`supply_order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Индексы таблицы `SupplyOrders`
--
ALTER TABLE `SupplyOrders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `supplier_id` (`supplier_id`),
  ADD KEY `warehouse_id` (`warehouse_id`);

--
-- Индексы таблицы `Warehouses`
--
ALTER TABLE `Warehouses`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `Categories`
--
ALTER TABLE `Categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `Customers`
--
ALTER TABLE `Customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `Products`
--
ALTER TABLE `Products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `SalesOrderDetails`
--
ALTER TABLE `SalesOrderDetails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `SalesOrders`
--
ALTER TABLE `SalesOrders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `Stock`
--
ALTER TABLE `Stock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `Suppliers`
--
ALTER TABLE `Suppliers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `SupplyOrderDetails`
--
ALTER TABLE `SupplyOrderDetails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `SupplyOrders`
--
ALTER TABLE `SupplyOrders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `Warehouses`
--
ALTER TABLE `Warehouses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `Products`
--
ALTER TABLE `Products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `Categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`id`) REFERENCES `Stock` (`product_id`);

--
-- Ограничения внешнего ключа таблицы `SalesOrderDetails`
--
ALTER TABLE `SalesOrderDetails`
  ADD CONSTRAINT `salesorderdetails_ibfk_1` FOREIGN KEY (`sales_order_id`) REFERENCES `SalesOrders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `salesorderdetails_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `Products` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `SalesOrders`
--
ALTER TABLE `SalesOrders`
  ADD CONSTRAINT `salesorders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `Customers` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `Stock`
--
ALTER TABLE `Stock`
  ADD CONSTRAINT `stock_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `Products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stock_ibfk_2` FOREIGN KEY (`warehouse_id`) REFERENCES `Warehouses` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `SupplyOrderDetails`
--
ALTER TABLE `SupplyOrderDetails`
  ADD CONSTRAINT `supplyorderdetails_ibfk_1` FOREIGN KEY (`supply_order_id`) REFERENCES `SupplyOrders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `supplyorderdetails_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `Products` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `SupplyOrders`
--
ALTER TABLE `SupplyOrders`
  ADD CONSTRAINT `supplyorders_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `Suppliers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `supplyorders_ibfk_2` FOREIGN KEY (`warehouse_id`) REFERENCES `Warehouses` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
