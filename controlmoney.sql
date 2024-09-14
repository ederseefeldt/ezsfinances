-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 13/09/2024 às 20:15
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
(1, 'Caixa', 966.3800000000001);

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
(1, 'Mercado', 350.5),
(2, 'Combustível', 100),
(3, 'Lanche', 100);

-- --------------------------------------------------------

--
-- Estrutura para tabela `transaction`
--

CREATE TABLE `transaction` (
  `transaction_id` int(11) NOT NULL,
  `transaction_value` double DEFAULT NULL,
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
(10, 21.31, 'asdas', 'Credito', '2024-09-19', '0', 1, 1),
(11, 12.31, 'asdas', 'Credito', '2024-09-11', '0', 1, 1);

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
  MODIFY `account_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `transaction`
--
ALTER TABLE `transaction`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

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
