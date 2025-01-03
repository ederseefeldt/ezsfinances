-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 23/09/2024 às 17:50
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `controlmoney`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `account`
--

CREATE TABLE `account` (
  `account_id` int(11) NOT NULL,
  `account_name` varchar(30) NOT NULL,
  `account_value` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `account`
--

INSERT INTO `account` (`account_id`, `account_name`, `account_value`) VALUES
(9, 'Mercado Pago', 1019.49),
(10, 'Caixa', 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `category`
--

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(30) NOT NULL,
  `category_target` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `category`
--

INSERT INTO `category` (`category_id`, `category_name`, `category_target`) VALUES
(7, 'Mercado', 350),
(8, 'Depósito', 0),
(9, 'O.B', 0),
(11, 'Apostas', 0),
(12, 'Veículos', 0),
(13, 'Telefone', 30),
(15, 'Lazer', 50),
(16, 'Saques', 0),
(17, 'Salário', 2500),
(18, 'Moradia', 700),
(19, 'Pix Recebidos', 0),
(20, 'Pix Enviados', 0),
(21, 'Outros', 0),
(22, 'Lanche', 150),
(23, 'Almoço', 150),
(24, 'Investimento', 0),
(25, 'Juros', 0),
(26, 'Streamings', 20),
(27, 'Combustível', 150),
(28, 'Roupas e Acessórios', 0),
(29, 'Farmacia', 100),
(30, 'Cartão de Crédito', 200),
(31, 'Pessoal', 100),
(32, 'Renda Extra', 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `transaction`
--

CREATE TABLE `transaction` (
  `transaction_id` int(11) NOT NULL,
  `transaction_value` double NOT NULL,
  `transaction_description` varchar(1000) DEFAULT NULL,
  `transaction_method` varchar(30) DEFAULT NULL,
  `transaction_date` date DEFAULT NULL,
  `transaction_type` varchar(30) DEFAULT NULL,
  `transaction_category` int(11) DEFAULT NULL,
  `transaction_account` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `transaction`
--

INSERT INTO `transaction` (`transaction_id`, `transaction_value`, `transaction_description`, `transaction_method`, `transaction_date`, `transaction_type`, `transaction_category`, `transaction_account`) VALUES
(35, 430.03, 'Pix recebido da conta caixa', 'Pix', '2023-01-05', '1', 19, 9),
(36, 20, 'Cópia de chave', 'Debito', '2023-01-09', '0', 21, 9),
(37, 1007, 'Pix recebido da conta caixa', 'Pix', '2023-01-09', '1', 19, 9),
(38, 37, 'Sem informação', 'Debito', '2023-01-10', '0', 21, 9),
(39, 18.8, '...', 'Debito', '2023-01-10', '0', 7, 9),
(40, 189, 'Oficina: Troca da bateria e mão de obra', 'Debito', '2023-01-10', '0', 12, 9),
(41, 23, '...', 'Debito', '2023-01-11', '0', 22, 9),
(42, 15.96, '...', 'Debito', '2023-01-12', '0', 7, 9),
(43, 88, 'Regulador retificador para a moto', 'Debito', '2023-01-12', '0', 12, 9),
(44, 31, 'Oficina', 'Debito', '2023-01-12', '0', 12, 9),
(45, 25, 'Pix para a Dé', 'Debito', '2023-01-12', '0', 20, 9),
(46, 36.29, 'Compra de bitcoin', 'Debito', '2023-01-14', '0', 24, 9),
(47, 20, 'Pix para a Dé', 'Debito', '2023-01-17', '0', 20, 9),
(48, 18, 'Pix para a Dé', 'Debito', '2023-01-19', '0', 20, 9),
(49, 20, 'Recarga', 'Debito', '2023-01-20', '0', 13, 9),
(50, 3, '...', 'Debito', '2023-01-20', '0', 21, 9),
(51, 141, '...', 'Debito', '2023-01-21', '0', 9, 9),
(52, 32.76, '...', 'Pix', '2023-01-22', '0', 20, 9),
(53, 3.5, '...', 'Debito', '2023-01-22', '0', 7, 9),
(54, 50, 'Pix para a Dé', 'Pix', '2023-01-22', '0', 20, 9),
(55, 21.9, 'Padaria', 'Debito', '2023-01-26', '0', 7, 9),
(56, 197.69, '...', 'Debito', '2023-01-29', '0', 7, 9),
(57, 16.9, 'Spotify', 'Debito', '2023-01-29', '0', 26, 9),
(58, 8.1, 'Valorização do dinheiro na conta', 'Debito', '2023-01-29', '1', 25, 9),
(59, 300, 'Pix recebido da caixa', 'Pix', '2023-02-01', '1', 19, 9),
(60, 178, 'Pix recebido da conta caixa', 'Pix', '2023-02-02', '1', 19, 9),
(61, 85.25, '...', 'Pix', '2023-02-02', '1', 19, 9),
(62, 13.25, 'Padaria', 'Debito', '2023-02-10', '0', 7, 9),
(63, 25, '...', 'Debito', '2023-02-11', '0', 21, 9),
(64, 49, '...', 'Debito', '2023-02-11', '0', 7, 9),
(65, 38.57, 'Abastecimento', 'Debito', '2023-02-11', '0', 27, 9),
(66, 139.9, 'Pagamento da OiTV', 'Debito', '2023-02-14', '0', 21, 9),
(67, 47.7, 'Telefone', 'Debito', '2023-02-15', '0', 13, 9),
(68, 149.9, 'Compra na pompeia', 'Debito', '2023-02-18', '0', 7, 9),
(69, 19.5, '...', 'Debito', '2023-02-19', '0', 7, 9),
(70, 15, 'Recarga', 'Debito', '2023-02-19', '0', 13, 9),
(71, 15.5, 'Padaria', 'Debito', '2023-02-21', '0', 7, 9),
(72, 86, '...', 'Debito', '2023-02-26', '0', 21, 9),
(73, 24.9, '...', 'Debito', '2023-02-27', '0', 29, 9),
(74, 16.9, 'Spotify', 'Debito', '2023-02-27', '0', 26, 9),
(75, 7.22, 'Valorização do dinheiro em conta', 'Debito', '2023-02-28', '1', 25, 9),
(76, 27.85, '...', 'Debito', '2023-03-01', '0', 29, 9),
(77, 98.5, 'Venda de Bitcoin', 'Debito', '2023-03-02', '1', 24, 9),
(78, 600, 'Aluguel de Março', 'Pix', '2023-03-02', '0', 18, 9),
(79, 615, 'Pix recebido da conta caixa', 'Pix', '2023-03-02', '1', 19, 9),
(80, 67, 'Brito Lanches', 'Debito', '2023-03-02', '0', 22, 9),
(81, 39.9, '...', 'Debito', '2023-03-04', '0', 21, 9),
(82, 70.09, '...', 'Debito', '2023-03-04', '0', 29, 9),
(83, 48.63, '...', 'Debito', '2023-03-04', '0', 21, 9),
(84, 21.48, '...', 'Debito', '2023-03-04', '0', 21, 9),
(85, 141.97, 'Compra na Shopee', 'Debito', '2023-03-04', '0', 28, 9),
(86, 145.2, 'Compra de SSD', 'Debito', '2023-03-09', '0', 21, 9),
(87, 38, 'Alguma coisa para a moto', 'Debito', '2023-03-10', '0', 12, 9),
(88, 14.03, '...', 'Debito', '2023-03-10', '0', 21, 9),
(89, 18, '...', 'Debito', '2023-03-10', '0', 7, 9),
(90, 6.3, '...', 'Debito', '2023-03-10', '0', 7, 9),
(91, 150, 'Pix recebido da conta caixa', 'Pix', '2023-03-10', '1', 19, 9),
(92, 50, 'Pix para o Anderson', 'Pix', '2023-03-10', '0', 20, 9),
(93, 4, '...', 'Pix', '2023-03-14', '0', 21, 9),
(94, 15, '...', 'Pix', '2023-03-14', '0', 23, 9),
(95, 15, '...', 'Pix', '2023-03-14', '0', 13, 9),
(96, 23, '...', 'Debito', '2023-03-15', '0', 7, 9),
(97, 20, '...', 'Debito', '2023-03-15', '0', 27, 9),
(98, 6, 'Pix para o Anderson', 'Pix', '2023-03-15', '0', 20, 9),
(99, 75, 'Pix para o Jader', 'Pix', '2023-03-15', '0', 20, 9),
(100, 12, 'Ferragem', 'Debito', '2023-03-15', '0', 21, 9),
(101, 15, 'Recarga', 'Debito', '2023-03-15', '0', 13, 9),
(102, 800.22, 'Pix recebido da conta Caixa', 'Pix', '2023-03-23', '1', 19, 9),
(103, 55.3, '...', 'Debito', '2023-03-23', '0', 7, 9),
(104, 66.91, '...', 'Debito', '2023-03-24', '0', 27, 9),
(105, 4.75, '...', 'Debito', '2023-03-28', '0', 21, 9),
(106, 4, 'Pão de Queijo', 'Debito', '2023-03-28', '0', 22, 9),
(107, 15, 'Recarga', 'Debito', '2023-03-28', '0', 13, 9),
(108, 180, '...', 'Pix', '2023-03-29', '0', 20, 9),
(109, 25.5, '...', 'Debito', '2023-03-29', '0', 7, 9),
(110, 35.19, '...', 'Debito', '2023-03-29', '0', 7, 9),
(111, 35.9, '...', 'Debito', '2023-03-31', '0', 7, 9),
(112, 4, 'Pão de Queijo', 'Debito', '2023-03-30', '0', 7, 9),
(113, 3.27, 'Valorização de dinheiro na conta', 'Debito', '2023-03-30', '1', 25, 9),
(114, 33.4, '...', 'Debito', '2023-04-01', '0', 29, 9),
(115, 70, '...', 'Pix', '2023-04-01', '0', 20, 9),
(116, 22.48, 'Ifood', 'Pix', '2023-04-02', '0', 22, 9),
(117, 15.41, '...', 'Debito', '2023-04-02', '0', 7, 9),
(118, 13.5, '...', 'Debito', '2023-04-03', '0', 21, 9),
(119, 10, '...', 'Debito', '2023-04-03', '0', 27, 9),
(120, 9.23, '...', 'Debito', '2023-04-03', '0', 7, 9),
(121, 15, '...', 'Debito', '2023-04-05', '0', 23, 9),
(122, 500, 'Pix recebido da conta caixa', 'Pix', '2023-04-05', '1', 19, 9),
(123, 26.2, 'Algo para a moto', 'Debito', '2023-04-06', '0', 12, 9),
(124, 32.25, '...', 'Debito', '2023-04-06', '0', 7, 9),
(125, 61.66, '...', 'Debito', '2023-04-06', '0', 7, 9),
(126, 10, '...', 'Debito', '2023-04-09', '0', 15, 9),
(127, 5, '...', 'Debito', '2023-04-09', '0', 21, 9),
(128, 39.67, '...', 'Debito', '2023-04-09', '0', 7, 9),
(129, 113.44, '...', 'Debito', '2023-04-11', '0', 9, 9),
(130, 164, 'Peças para a moto', 'Debito', '2023-04-11', '0', 12, 9),
(131, 17.7, '...', 'Debito', '2023-04-11', '0', 7, 9),
(132, 30, '...', 'Debito', '2023-04-11', '0', 21, 9),
(133, 21.99, '...', 'Pix', '2023-04-11', '0', 22, 9),
(134, 2.5, '...', 'Debito', '2023-04-13', '0', 21, 9),
(135, 20, '...', 'Debito', '2023-04-13', '0', 23, 9),
(136, 63.35, 'Venda de Bitcoin', 'Debito', '2023-04-13', '1', 24, 9),
(137, 25, '...', 'Debito', '2023-04-13', '0', 27, 9),
(138, 100.45, '...', 'Debito', '2023-04-13', '0', 7, 9),
(139, 4, 'Pão de queijo', 'Debito', '2023-04-14', '0', 22, 9),
(140, 70, 'Algo para a moto', 'Debito', '2023-04-15', '0', 12, 9),
(141, 3, '...', 'Debito', '2023-04-17', '0', 22, 9),
(142, 3.5, '...', 'Debito', '2023-04-17', '0', 22, 9),
(143, 550, 'Pix recebido da conta caixa', 'Pix', '2023-04-20', '1', 19, 9),
(144, 22, '...', 'Debito', '2023-04-24', '0', 21, 9),
(145, 85, '...', 'Debito', '2023-04-24', '0', 28, 9),
(146, 160, '...', 'Debito', '2023-04-25', '0', 21, 9),
(147, 44.48, '...', 'Debito', '2023-04-25', '0', 22, 9),
(148, 21.99, '...', 'Debito', '2023-04-25', '0', 22, 9),
(149, 48.76, '...', 'Debito', '2023-04-27', '0', 27, 9),
(150, 66.35, '...', 'Debito', '2023-04-28', '0', 21, 9),
(151, 47.22, '...', 'Debito', '2023-04-28', '0', 7, 9),
(152, 9.5, '...', 'Debito', '2023-04-30', '0', 22, 9),
(153, 1.91, 'Valorização do dinheiro em conta', 'Debito', '2023-04-30', '1', 25, 9),
(154, 15, '...', 'Debito', '2023-05-02', '0', 13, 9),
(155, 19, '...', 'Debito', '2023-05-02', '0', 21, 9),
(156, 10, '...', 'Debito', '2023-05-02', '0', 27, 9),
(157, 750, 'Pix recebido da conta caixa', 'Pix', '2023-05-08', '1', 19, 9),
(158, 86.72, '...', 'Debito', '2023-05-10', '0', 7, 9),
(159, 15, '...', 'Debito', '2023-05-10', '0', 23, 9),
(160, 8, '...', 'Debito', '2023-05-10', '0', 21, 9),
(161, 166.35, '...', 'Debito', '2023-05-10', '0', 29, 9),
(162, 62.79, '...', 'Debito', '2023-05-19', '0', 27, 9),
(163, 230, 'Pix pelo acidente com a Van', 'Debito', '2023-05-20', '0', 12, 9),
(164, 33, 'Pix para a Dé', 'Pix', '2023-05-20', '0', 20, 9),
(165, 29.55, '...', 'Debito', '2023-05-23', '0', 7, 9),
(166, 21.99, '...', 'Debito', '2023-05-26', '0', 22, 9),
(167, 29.15, '...', 'Debito', '2023-05-26', '0', 7, 9),
(168, 35, 'Pix sem info', 'Pix', '2023-05-30', '0', 20, 9),
(169, 10, 'Pix para o Jean', 'Pix', '2023-05-30', '0', 20, 9),
(170, 20.58, '...', 'Debito', '2023-05-30', '0', 7, 9),
(171, 6, '...', 'Debito', '2023-05-31', '0', 22, 9),
(172, 940, 'Salário P/2 de Maio', 'Pix', '2023-05-25', '1', 17, 9),
(173, 3.62, 'Valorização do dinheiro em conta', 'Debito', '2023-05-30', '1', 25, 9),
(174, 2, '...', 'Debito', '2023-06-01', '0', 22, 9),
(175, 53.67, '...', 'Debito', '2023-06-01', '0', 27, 9),
(176, 100, 'Saque para ir pra fora', 'Debito', '2023-06-01', '0', 16, 9),
(177, 56.28, '...', 'Debito', '2023-06-02', '0', 7, 9),
(178, 9.32, '...', 'Debito', '2023-06-02', '0', 7, 9),
(179, 75.32, 'Livro pro Gui', 'Debito', '2023-06-04', '0', 7, 9),
(180, 1173, 'Salário P/1 de Junho', 'Pix', '2023-06-05', '1', 17, 9),
(181, 600, 'Aluguel de Junho', 'Pix', '2023-06-05', '0', 18, 9),
(182, 155, 'Parcela do Celular', 'Pix', '2023-06-05', '0', 13, 9),
(183, 150, '...', 'Pix', '2023-06-05', '0', 9, 9),
(184, 23.57, '...', 'Debito', '2023-06-05', '0', 29, 9),
(185, 20, 'Curriculo do Thierry', 'Pix', '2023-06-05', '1', 19, 9),
(186, 944, 'Salário P/2 de junho', 'Pix', '2023-06-20', '1', 17, 9),
(187, 8, '...', 'Debito', '2023-06-20', '0', 22, 9),
(188, 59.99, '...', 'Debito', '2023-06-23', '0', 27, 9),
(189, 20.09, '...', 'Debito', '2023-06-26', '0', 7, 9),
(190, 21.99, '...', 'Debito', '2023-06-26', '0', 22, 9),
(191, 63.35, '...', 'Debito', '2023-06-26', '0', 7, 9),
(193, 4.5, 'Valorização do dinheiro em conta', 'Debito', '2023-06-26', '1', 25, 9),
(194, 883.92, 'Cartão de crédito de Maio', 'Debito', '2023-06-05', '0', 30, 9),
(202, 323.18, 'Cartão de crédito de Junho', 'Debito', '2023-07-01', '0', 30, 9),
(203, 155, 'Parcela do celular pro Jader', 'Pix', '2023-07-01', '0', 13, 9),
(204, 30, 'Lanche com o Jader', 'Pix', '2023-07-01', '0', 22, 9),
(205, 15, '...', 'Debito', '2023-07-01', '0', 21, 9),
(206, 33.68, '...', 'Debito', '2023-07-01', '0', 7, 9),
(207, 1165, 'Salário P1 de Julho', 'Pix', '2023-07-05', '1', 17, 9),
(208, 63.46, '...', 'Debito', '2023-07-05', '0', 29, 9),
(209, 600, 'Aluguel de Julho', 'Debito', '2023-07-05', '0', 18, 9),
(210, 21.99, '', 'Debito', '2023-07-06', '0', 22, 9),
(211, 126.25, 'Depósito O.B', 'Debito', '2023-07-11', '0', 9, 9),
(212, 21.99, '', 'Debito', '2023-07-11', '0', 22, 9),
(213, 44.53, 'Pix pro Jader', 'Debito', '2023-07-11', '0', 20, 9),
(214, 32.99, '', 'Debito', '2023-07-16', '0', 22, 9),
(215, 15, '', 'Debito', '2023-07-16', '0', 13, 9),
(216, 30, 'Corte de cabelo', 'Debito', '2023-07-18', '0', 31, 9),
(217, 90.79, 'Chuveiro', 'Debito', '2023-07-18', '0', 21, 9),
(219, 944, 'Salário P2 de Julho', 'Debito', '2023-07-20', '1', 17, 9),
(220, 25, 'Pix pro Jean', 'Pix', '2023-07-20', '0', 20, 9),
(221, 900, 'Pix Recebido da conta caixa', 'Pix', '2023-07-20', '1', 19, 9),
(222, 63.17, '', 'Debito', '2023-07-21', '0', 27, 9),
(223, 14, '', 'Debito', '2023-07-21', '0', 21, 9),
(224, 12, '', 'Debito', '2023-07-21', '0', 21, 9),
(225, 15.83, '', 'Debito', '2023-07-24', '0', 7, 9),
(226, 20.5, '', 'Debito', '2023-07-26', '0', 7, 9),
(227, 58.95, '', 'Debito', '2023-07-26', '0', 7, 9),
(228, 27.14, '', 'Debito', '2023-07-27', '0', 27, 9),
(229, 32.17, '', 'Debito', '2023-07-28', '0', 7, 9),
(230, 126.54, '', 'Debito', '2023-07-28', '0', 7, 9),
(231, 80, 'Pix para a Dé', 'Pix', '2023-07-28', '0', 20, 9),
(232, 80.33, '', 'Pix', '2023-07-28', '0', 21, 9),
(233, 15.51, '', 'Debito', '2023-07-31', '0', 7, 9),
(234, 8.33, 'Valorização do dinheiro em conta', 'Debito', '2023-07-31', '1', 25, 9),
(235, 492, 'Adiantamento 13° salário P1', 'Debito', '2023-08-01', '1', 17, 9),
(236, 21.99, '', 'Debito', '2023-08-01', '0', 22, 9),
(237, 483.91, 'Cartão de crédito de Julho', 'Debito', '2023-08-02', '0', 30, 9),
(238, 231.88, 'Depósito O.B', 'Debito', '2023-08-02', '0', 9, 9),
(239, 29.9, 'Spotify', 'Debito', '2023-08-03', '0', 26, 9),
(240, 370.7, 'Aplicação em Fundo de investimento', 'Debito', '2023-08-03', '0', 24, 9),
(241, 1165, 'Salário P1 de Agosto', 'Pix', '2023-08-04', '1', 17, 9),
(242, 430, 'Aplicação em Fundo de Investimento', 'Debito', '2023-08-04', '0', 24, 9),
(243, 600, 'Aluguel de Agosto', 'Pix', '2023-08-04', '0', 18, 9),
(244, 155, 'Parcela do Celular', 'Pix', '2023-08-04', '0', 13, 9),
(245, 258.65, 'Moto na Oficina', 'Debito', '2023-08-10', '0', 12, 9),
(246, 34.9, '', 'Debito', '2023-08-10', '0', 21, 9),
(247, 21.99, '', 'Debito', '2023-08-11', '0', 22, 9),
(248, 64.32, '...', 'Debito', '2023-08-11', '0', 13, 9),
(249, 32.99, '', 'Debito', '2023-08-16', '0', 22, 9),
(250, 36.99, '', 'Debito', '2023-08-17', '0', 22, 9),
(251, 944, 'Salário P2 de Agosto', 'Pix', '2023-08-18', '1', 17, 9),
(252, 57.25, '', 'Debito', '2023-08-18', '0', 27, 9),
(253, 420, 'Aplicação de fundo de Investimento', 'Debito', '2023-08-18', '0', 24, 9),
(254, 44.9, 'Compra no AliExpress', 'Pix', '2023-08-18', '0', 21, 9),
(255, 29.98, 'Almoço no Tio Beto', 'Debito', '2023-08-23', '0', 23, 9),
(256, 49.9, 'Compra na Shopee', 'Debito', '2023-08-30', '0', 28, 9),
(257, 8.42, 'Valorização de Dinheiro em conta', 'Debito', '2023-08-30', '1', 25, 9),
(258, 29.9, 'Spotify', 'Debito', '2023-09-01', '0', 26, 9),
(259, 249.08, '', 'Debito', '2023-09-03', '0', 9, 9),
(260, 1165, 'Salário P1 de Setembro', 'Pix', '2023-09-05', '1', 17, 9),
(261, 792.41, 'Cartão de crédito de Agosto', 'Debito', '2023-09-05', '0', 30, 9),
(262, 600, 'Aluguel de Setembro', 'Debito', '2023-09-05', '0', 18, 9),
(263, 155, 'Parcela do celular', 'Debito', '2023-09-05', '0', 13, 9),
(264, 218.15, 'Aplicação em fundo de investimento', 'Debito', '2023-09-05', '0', 24, 9),
(266, 1200, 'Pix recebido da conta Caixa', 'Pix', '2023-09-09', '1', 19, 9),
(267, 17, 'Pix para a Dé', 'Pix', '2023-09-09', '0', 20, 9),
(268, 944, 'Salário P2 de Setembro', 'Debito', '2023-09-19', '1', 17, 9),
(269, 1129.83, 'Aplicação em fundo de investimento', 'Debito', '2023-09-19', '0', 24, 9),
(270, 130.81, 'Compra na Shopee', 'Debito', '2023-09-27', '0', 28, 9),
(271, 2600, 'Pix Recebido da conta Caixa', 'Pix', '2023-09-28', '1', 19, 9),
(272, 1471.73, 'Aplicação em fundo de investimento', 'Debito', '2023-09-28', '0', 24, 9),
(273, 35, 'Pix para a Dé', 'Pix', '2023-09-28', '0', 20, 9),
(274, 6.99, 'Valorização do dinheiro em conta', 'Debito', '2023-09-28', '1', 25, 9),
(275, 29.9, 'Spotify', 'Debito', '2023-10-02', '0', 26, 9),
(276, 134.56, '', 'Debito', '2023-10-02', '0', 9, 9),
(277, 301.39, '', 'Debito', '2023-10-02', '0', 9, 9),
(278, 1165, 'Salário P1 de Outubro', 'Debito', '2023-10-02', '1', 17, 9),
(279, 600, 'Aluguel de Outubro', 'Debito', '2023-10-05', '0', 18, 9),
(280, 155, 'Parcela do celular', 'Debito', '2023-10-05', '0', 13, 9),
(281, 28, 'Pix para a Dé', 'Pix', '2023-10-05', '0', 20, 9),
(282, 1553.21, 'Cartão de crédito de setembro', 'Pix', '2023-10-06', '0', 20, 9),
(283, 200, '', 'Pix', '2023-10-06', '0', 9, 9),
(284, 944, 'Salário P2 de Outubro', 'Pix', '2023-10-20', '1', 17, 9),
(286, 70, '', 'Debito', '2023-10-20', '0', 21, 9),
(287, 15, 'Recarga', 'Debito', '2023-10-20', '0', 13, 9),
(288, 290.15, '', 'Debito', '2023-10-23', '0', 9, 9),
(289, 4.53, 'Valorização do dinheiro em conta', 'Debito', '2023-10-23', '1', 25, 9),
(290, 1165, 'Salário P1 de Novembro', 'Pix', '2023-11-03', '1', 17, 9),
(291, 614.34, 'Sem info', 'Pix', '2023-11-03', '1', 21, 9),
(292, 600, 'Aluguel de Novembro', 'Debito', '2023-11-05', '0', 18, 9),
(293, 155, 'Parcela do celular', 'Debito', '2023-11-05', '0', 13, 9),
(294, 1385.24, 'Cartão de crédito de Outubro', 'Debito', '2023-11-05', '0', 13, 9),
(295, 25, 'Recarga', 'Debito', '2023-11-08', '0', 13, 9),
(296, 17.79, 'Pix para a Dé', 'Pix', '2023-11-08', '0', 20, 9),
(297, 20, '', 'Pix', '2023-11-08', '1', 19, 9),
(298, 100, '', 'Pix', '2023-11-15', '0', 9, 9),
(299, 220, '', 'Pix', '2023-11-15', '0', 9, 9),
(300, 944, 'Salário P2 de Novembro', 'Pix', '2023-11-20', '1', 17, 9),
(301, 500, 'Aplicação em fundo de investimento', 'Debito', '2023-11-22', '0', 24, 9),
(302, 42.31, '', 'Pix', '2023-11-22', '0', 21, 9),
(303, 11.8, 'Algo para a moto', 'Debito', '2023-11-22', '0', 12, 9),
(304, 390.87, '', 'Pix', '2023-11-22', '0', 20, 9),
(305, 122.56, 'Sem info', 'Pix', '2023-11-22', '1', 21, 9),
(306, 100, 'Sem info', 'Pix', '2023-11-22', '0', 20, 9),
(307, 20, 'Sem info', 'Pix', '2023-11-22', '0', 20, 9),
(308, 2.76, 'Valorização do dinheiro em conta', 'Debito', '2023-11-30', '1', 25, 9),
(309, 1164, 'Salário P1 de Dezembro', 'Pix', '2023-12-05', '1', 17, 9),
(310, 600, 'Aluguel de Dezembro', 'Pix', '2023-12-05', '0', 18, 9),
(311, 155, 'Parcela do celular', 'Pix', '2023-12-05', '0', 13, 9),
(312, 898.34, 'Sem info', 'Pix', '2023-12-05', '1', 21, 9),
(313, 498.85, 'Sem info', 'Pix', '2023-12-06', '1', 21, 9),
(314, 1325.73, 'Cartão de Crédito de Novembro', 'Debito', '2023-12-06', '0', 30, 9),
(315, 14.92, 'Pix recebido da conta caixa', 'Pix', '2023-12-06', '1', 19, 9),
(316, 98.73, '', 'Pix', '2023-12-10', '0', 9, 9),
(317, 1317, '2° Parcela do 13° Salário', 'Pix', '2023-12-15', '1', 17, 9),
(318, 944, 'Salário P2 de Dezembro', 'Pix', '2023-12-15', '1', 17, 9),
(319, 1163.49, 'Aplicação em fundo de investimento', 'Pix', '2023-12-15', '0', 17, 9),
(320, 213.56, 'Compra no AliExpress', 'Debito', '2023-12-20', '0', 21, 9),
(321, 5, '', 'Debito', '2023-12-22', '0', 22, 9),
(322, 199.84, 'Sem info', 'Debito', '2023-12-22', '0', 21, 9),
(323, 30, '', 'Debito', '2023-12-29', '0', 27, 9),
(324, 35, 'Pix pro Jean', 'Pix', '2023-12-29', '0', 20, 9),
(325, 6.03, 'Valorização do dinheiro em conta', 'Debito', '2023-12-29', '1', 25, 9),
(326, 50, 'Note da Renate', 'Pix', '2023-08-11', '1', 32, 10),
(327, 10, 'Curriculo pro Thierry', 'Pix', '2023-08-17', '1', 32, 10),
(328, 1500, '', 'Pix', '2023-08-25', '1', 9, 10),
(329, 160, 'Saque para viajar', 'Debito', '2023-08-31', '0', 16, 10),
(335, 20, 'Pix para o Jean', 'Pix', '2023-08-03', '0', 20, 10),
(336, 1200, 'Pix enviado para o Mercado Pago', 'Pix', '2023-09-11', '0', 20, 10),
(337, 70.96, 'Sem info', 'Pix', '2023-09-11', '0', 20, 10),
(338, 53, 'Sem info', 'Pix', '2023-09-11', '1', 19, 10),
(339, 183.63, 'Sem info', 'Pix', '2023-09-25', '0', 20, 10),
(340, 2800, 'Recebimento O.B', 'Pix', '2023-09-25', '1', 9, 10),
(341, 2600, 'Pix para o Mercado Pago', 'Pix', '2023-09-25', '0', 20, 10),
(342, 1.49, 'Valorização do dinheiro em conta', 'Debito', '2023-09-25', '1', 25, 10),
(343, 200, 'Saque para Viajar', 'Debito', '2023-10-09', '0', 16, 10),
(344, 100, 'Pix recebido do Mercado Pago', 'Pix', '2023-11-24', '1', 19, 10),
(345, 55.08, '', 'Pix', '2023-11-24', '0', 20, 10),
(347, 50, 'Saque para viajar', 'Debito', '2023-11-24', '0', 16, 10),
(348, 14.92, 'Pix enviado para o Mercado Pago', 'Pix', '2023-12-06', '0', 20, 9);

--
-- Acionadores `transaction`
--
DELIMITER $$
CREATE TRIGGER `update_account_value_after_transaction_delete` AFTER DELETE ON `transaction` FOR EACH ROW BEGIN
    -- Se a transação deletada for do tipo 'Pagar' (0), somar o valor à conta
    IF OLD.transaction_type = 0 THEN
        UPDATE account A
        SET A.account_value = A.account_value + OLD.transaction_value 
        WHERE A.account_id = OLD.transaction_account;
    
    -- Se a transação deletada for do tipo 'Receber' (1), subtrair o valor da conta
    ELSEIF OLD.transaction_type = 1 THEN
        UPDATE account A
        SET A.account_value = A.account_value - OLD.transaction_value 
        WHERE A.account_id = OLD.transaction_account;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_account_value_after_transaction_insert` AFTER INSERT ON `transaction` FOR EACH ROW BEGIN
    -- Se o tipo da transação for 0 (pagamento), subtrai o valor do saldo da conta
    IF NEW.transaction_type = 0 THEN
        UPDATE account A
        SET A.account_value = A.account_value - NEW.transaction_value
        WHERE A.account_id = NEW.transaction_account;
        
    -- Se o tipo da transação for 1 (recebimento), adiciona o valor ao saldo da conta
    ELSEIF NEW.transaction_type = 1 THEN
        UPDATE account A
        SET A.account_value = A.account_value + NEW.transaction_value
        WHERE A.account_id = NEW.transaction_account;
    END IF;
END
$$
DELIMITER ;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`account_id`);

--
-- Índices de tabela `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `category_name` (`category_name`);

--
-- Índices de tabela `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `transaction_category` (`transaction_category`),
  ADD KEY `transaction_account` (`transaction_account`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `account`
--
ALTER TABLE `account`
  MODIFY `account_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de tabela `transaction`
--
ALTER TABLE `transaction`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=351;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`transaction_category`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`transaction_account`) REFERENCES `account` (`account_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
