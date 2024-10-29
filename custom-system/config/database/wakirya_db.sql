-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 29, 2024 at 06:12 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wakirya_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `password` varchar(191) NOT NULL,
  `phone` varchar(191) DEFAULT NULL,
  `role` enum('admin','user') NOT NULL,
  `is_ban` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0=not_ban,1=ban',
  `created_at` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `password`, `phone`, `role`, `is_ban`, `created_at`) VALUES
(5, 'Administrator', 'admin@example.com', '$2y$10$eAF30FEqkFWw1WUsHZSOfubYw0m7y.Vhi6qMmFMAtqzT58498G5gW', '0712000555', 'admin', 0, '2024-09-02'),
(6, 'ibrah', 'ibrah@gmail.com', '$2y$10$9zbd8FHa0qicGdwmZTN54OBjVMYlMw4uuOnOy2enz.QxpyKeKiUjy', '0652700800', 'user', 0, '2024-09-02');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0 COMMENT '0=visible,1=hidden',
  `created_at` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `email`, `phone`, `status`, `created_at`) VALUES
(65, 'tariq', NULL, '0652999888', 0, '2024-10-07'),
(66, 'mzabanga', NULL, '0987654321', 0, '2024-10-07'),
(67, 'khan', NULL, '0652999888', 0, '2024-10-07'),
(68, 'mfano', NULL, '0652000000', 0, '2024-10-08'),
(69, 'ibrah mteja', NULL, '1234', 0, '2024-10-16'),
(70, 'hey', NULL, '', 0, '2024-10-16'),
(71, 'emtee', NULL, '0987654321', 0, '2024-10-19'),
(72, 'zuma', NULL, '', 0, '2024-10-19'),
(73, 'mteja', NULL, '', 0, '2024-10-21'),
(77, 'July', NULL, '', 0, '2024-10-26'),
(78, 'July', NULL, '', 0, '2024-10-26'),
(79, 'titt', NULL, '097', 0, '2024-10-26'),
(80, 'k', NULL, '0786653311', 0, '2024-10-26'),
(81, 'J', NULL, '', 0, '2024-10-26'),
(82, 'Jay', NULL, '', 0, '2024-10-27'),
(83, 'jk', NULL, '', 0, '2024-10-27'),
(84, 'muze', NULL, '0756241192', 0, '2024-10-27');

-- --------------------------------------------------------

--
-- Table structure for table `expenses_tracking`
--

CREATE TABLE `expenses_tracking` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `expense_type` varchar(50) NOT NULL,
  `expense_percentage` decimal(10,2) NOT NULL,
  `expense_amount` decimal(10,2) NOT NULL,
  `transaction_date` date NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loans`
--

CREATE TABLE `loans` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `tracking_no` varchar(100) NOT NULL,
  `invoice_no` varchar(100) NOT NULL,
  `destination` varchar(100) NOT NULL,
  `total_amount` varchar(100) NOT NULL,
  `paid_amount` varchar(100) NOT NULL,
  `due_amount` varchar(100) NOT NULL,
  `surplus_amount` varchar(100) NOT NULL,
  `order_date` date NOT NULL,
  `order_status` varchar(100) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `payment_mode` varchar(100) DEFAULT NULL,
  `order_placed_by_id` int(11) NOT NULL,
  `created_at` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loans`
--

INSERT INTO `loans` (`id`, `customer_id`, `tracking_no`, `invoice_no`, `destination`, `total_amount`, `paid_amount`, `due_amount`, `surplus_amount`, `order_date`, `order_status`, `comment`, `payment_mode`, `order_placed_by_id`, `created_at`) VALUES
(6, 65, '84515', 'INV-968945', '', '22500', '20000', '2500', '0', '2024-10-21', 'Anadaiwa', 'amepunguza deni', NULL, 6, '2024-10-21');

-- --------------------------------------------------------

--
-- Table structure for table `loan_items`
--

CREATE TABLE `loan_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `price` varchar(100) NOT NULL,
  `quantity` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan_items`
--

INSERT INTO `loan_items` (`id`, `order_id`, `product_id`, `price`, `quantity`) VALUES
(6, 6, 9, '22500', '1');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `tracking_no` varchar(100) NOT NULL,
  `invoice_no` varchar(100) NOT NULL,
  `destination` varchar(100) NOT NULL,
  `total_amount` varchar(100) NOT NULL,
  `paid_amount` varchar(100) DEFAULT NULL,
  `due_amount` varchar(100) DEFAULT NULL,
  `surplus_amount` varchar(100) NOT NULL,
  `loan_payment` varchar(100) NOT NULL,
  `order_date` date NOT NULL,
  `order_status` varchar(100) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `payment_mode` varchar(100) DEFAULT NULL COMMENT 'cash, online',
  `order_placed_by_id` int(11) NOT NULL,
  `created_at` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `customer_id`, `tracking_no`, `invoice_no`, `destination`, `total_amount`, `paid_amount`, `due_amount`, `surplus_amount`, `loan_payment`, `order_date`, `order_status`, `comment`, `payment_mode`, `order_placed_by_id`, `created_at`) VALUES
(1, 65, '36316', 'INV-426486', '', '3000', '3000', '0', '0', '300', '2024-10-19', 'Amelipa', '', NULL, 5, '2024-10-19'),
(2, 72, '93952', 'INV-411926', '', '3000', '3000', '0', '0', '300', '2024-10-19', 'Amelipa', '', NULL, 5, '2024-10-19'),
(3, 65, '44530', 'INV-484499', '', '20500', '20500', '0', '0', '2050', '2024-10-19', 'Amelipa', '', NULL, 5, '2024-10-19'),
(4, 65, '28832', 'INV-561969', '', '22500', '22500', '0', '0', '', '2024-10-21', 'Amelipa', '', NULL, 6, '2024-10-21'),
(5, 73, '47538', 'INV-775285', '', '22500', '22500', '0', '0', '', '2024-10-21', 'Amelipa', 'amelipa', NULL, 6, '2024-10-21');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `price` varchar(100) NOT NULL,
  `quantity` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `price`, `quantity`) VALUES
(2, 2, 11, '3000', '1'),
(3, 3, 11, '3000', '1'),
(4, 4, 11, '3000', '1'),
(5, 5, 11, '3000', '1'),
(6, 6, 11, '3000', '1'),
(7, 1, 11, '3000', '1'),
(8, 2, 11, '3000', '1'),
(9, 3, 10, '17500', '1'),
(10, 3, 11, '3000', '1'),
(11, 4, 9, '22500', '1'),
(12, 5, 9, '22500', '1');

-- --------------------------------------------------------

--
-- Table structure for table `preorders`
--

CREATE TABLE `preorders` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `tracking_no` varchar(100) NOT NULL,
  `invoice_no` varchar(100) NOT NULL,
  `destination` varchar(100) NOT NULL,
  `total_amount` varchar(100) NOT NULL,
  `paid_amount` varchar(100) NOT NULL,
  `due_amount` varchar(100) NOT NULL,
  `surplus_amount` varchar(100) NOT NULL,
  `order_date` date NOT NULL,
  `order_status` varchar(100) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `payment_mode` varchar(100) DEFAULT NULL,
  `order_placed_by_id` int(11) NOT NULL,
  `created_at` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `preorder_items`
--

CREATE TABLE `preorder_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `price` varchar(100) NOT NULL,
  `quantity` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `batch` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `measure` varchar(255) DEFAULT NULL,
  `buy_price` int(11) NOT NULL,
  `sell_price` int(11) NOT NULL,
  `expense` enum('mikopo','wafanyakazi','mengineyo') DEFAULT NULL,
  `expense_percentage` decimal(5,2) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0 COMMENT '0 = visible, 1 = hidden',
  `created_at` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `batch`, `quantity`, `measure`, `buy_price`, `sell_price`, `expense`, `expense_percentage`, `status`, `created_at`) VALUES
(20, 'sement twiga', 'TW100', 100, 'mifuko', 15000, 17000, 'mikopo', '13.00', 0, '2024-10-26'),
(21, 'misumari', 'Ms19', 50, 'kilo', 3600, 400, 'mikopo', '9.00', 0, '2024-10-26'),
(22, 'Cement', '34', 12, 'mifuko', 16000, 18000, 'mikopo', '16.00', 0, '2024-10-26'),
(23, 'Cement T', '10TW', 100, 'mifuko', 16000, 18000, 'mikopo', '13.00', 0, '2024-10-27'),
(24, 'Cement T', '10TW', 100, 'mifuko', 16000, 18000, 'mikopo', '13.00', 0, '2024-10-27'),
(25, 'Cement T', '10TW', 100, 'mifuko', 16000, 18000, 'mikopo', '13.00', 0, '2024-10-27'),
(28, 'cmt', 'cm12', 112, 'mifuko', 234, 345, 'mikopo', '12.00', 0, '2024-10-27'),
(32, 'CMT', 'tr', 34, 'mifuko', 248, 300, 'mengineyo', '45.00', 0, '2024-10-27'),
(33, 'MSMR', 'MS', 23, 'kilo', 3000, 4000, 'wafanyakazi', '24.00', 0, '2024-10-27'),
(34, 'ms', 'ms1', 10, 'kilo', 2600, 4500, 'wafanyakazi', '12.00', 0, '2024-10-27'),
(35, 'Leo', 'ee', 23, 'kilo', 2500, 3000, 'mengineyo', '32.00', 0, '2024-10-27'),
(36, 'CEMENT', 'CM100', 23, 'kilo', 3999, 4550, 'mikopo', '23.00', 0, '2024-10-27');

-- --------------------------------------------------------

--
-- Table structure for table `product_expenses`
--

CREATE TABLE `product_expenses` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `expense_type` varchar(50) DEFAULT NULL,
  `percentage` decimal(5,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expenses_tracking`
--
ALTER TABLE `expenses_tracking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `loans`
--
ALTER TABLE `loans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_items`
--
ALTER TABLE `loan_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `preorders`
--
ALTER TABLE `preorders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `preorder_items`
--
ALTER TABLE `preorder_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_expenses`
--
ALTER TABLE `product_expenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `expenses_tracking`
--
ALTER TABLE `expenses_tracking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loans`
--
ALTER TABLE `loans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `loan_items`
--
ALTER TABLE `loan_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `preorders`
--
ALTER TABLE `preorders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `preorder_items`
--
ALTER TABLE `preorder_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `product_expenses`
--
ALTER TABLE `product_expenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `product_expenses`
--
ALTER TABLE `product_expenses`
  ADD CONSTRAINT `product_expenses_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
