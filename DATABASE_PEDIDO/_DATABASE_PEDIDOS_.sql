-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Tempo de geração: 02/04/2024 às 22:36
-- Versão do servidor: 8.2.0
-- Versão do PHP: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `pedidos`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `cliente`
--

DROP TABLE IF EXISTS `cliente`;
CREATE TABLE IF NOT EXISTS `cliente` (
  `idCliente` int NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `cpfCnpj` varchar(14) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `cliente`
--

INSERT INTO `cliente` (`idCliente`, `nome`, `cpfCnpj`, `email`) VALUES
(1, 'João', '111.111.111-11', 'joao@hotmail.com'),
(2, 'Maria', '222.222.222-22', 'maria@uol.com.br'),
(3, 'José', '333.333.333-33', 'jose@bol.com.br'),
(4, 'Joana', '444.444.444-44', 'joana@outlook.com');

-- --------------------------------------------------------

--
-- Estrutura para tabela `itemestoque`
--

DROP TABLE IF EXISTS `itemestoque`;
CREATE TABLE IF NOT EXISTS `itemestoque` (
  `idItemEstoque` int NOT NULL,
  `descricao` varchar(45) DEFAULT NULL,
  `unidadeMedida` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`idItemEstoque`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `itemestoque`
--

INSERT INTO `itemestoque` (`idItemEstoque`, `descricao`, `unidadeMedida`) VALUES
(1, 'Lápis', 'UN'),
(2, 'Caneta', 'UN'),
(3, 'Caderno', 'UN'),
(4, 'Borracha', 'UN'),
(5, 'Apontador', 'UN');

-- --------------------------------------------------------

--
-- Estrutura para tabela `itempedido`
--

DROP TABLE IF EXISTS `itempedido`;
CREATE TABLE IF NOT EXISTS `itempedido` (
  `idItemPedido` int NOT NULL,
  `idPedido` int NOT NULL,
  `numItem` int DEFAULT NULL,
  `idItemEstoque` int NOT NULL,
  `qtd` int DEFAULT NULL,
  `valorUnitario` double DEFAULT NULL,
  `valorTotalItem` double DEFAULT NULL,
  PRIMARY KEY (`idItemPedido`),
  KEY `fk_ItemPedido_ItemEstoque1_idx` (`idItemEstoque`),
  KEY `idPedido_UNIQUE` (`idPedido`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `itempedido`
--

INSERT INTO `itempedido` (`idItemPedido`, `idPedido`, `numItem`, `idItemEstoque`, `qtd`, `valorUnitario`, `valorTotalItem`) VALUES
(1, 1, 1, 1, 100, 0, 10),
(2, 1, 2, 2, 10, 1, 10),
(3, 2, 1, 3, 4, 10, 40),
(4, 3, 1, 4, 40, 0, 10),
(5, 3, 2, 1, 40, 0, 6);

-- --------------------------------------------------------

--
-- Estrutura para tabela `pedido`
--

DROP TABLE IF EXISTS `pedido`;
CREATE TABLE IF NOT EXISTS `pedido` (
  `idPedido` int NOT NULL,
  `codigoFilial` int DEFAULT NULL,
  `tipo` varchar(45) DEFAULT NULL,
  `numero` int DEFAULT NULL,
  `data` date DEFAULT NULL,
  `idCliente` int NOT NULL,
  `valorTotal` double DEFAULT NULL,
  PRIMARY KEY (`idPedido`,`idCliente`),
  KEY `fk_Pedido_Cliente1_idx` (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `pedido`
--

INSERT INTO `pedido` (`idPedido`, `codigoFilial`, `tipo`, `numero`, `data`, `idCliente`, `valorTotal`) VALUES
(1, 1, 'VENDA', 100, '2013-04-02', 1, 20),
(2, 1, 'VENDA', 101, '2013-04-03', 2, 40),
(3, 2, 'VENDA', 100, '2013-04-10', 3, 16);

-- --------------------------------------------------------

--
-- Estrutura para tabela `preco`
--

DROP TABLE IF EXISTS `preco`;
CREATE TABLE IF NOT EXISTS `preco` (
  `idPreco` int NOT NULL,
  `idItemEstoque` int NOT NULL,
  `dataPreco` date DEFAULT NULL,
  `valor` double DEFAULT NULL,
  PRIMARY KEY (`idPreco`),
  KEY `idItemEstoque_UNIQUE` (`idItemEstoque`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `preco`
--

INSERT INTO `preco` (`idPreco`, `idItemEstoque`, `dataPreco`, `valor`) VALUES
(1, 1, '2013-04-02', 0),
(2, 1, '2013-04-10', 0),
(3, 2, '2013-04-02', 1),
(4, 3, '2013-04-02', 10),
(5, 4, '2013-04-02', 0),
(6, 4, '2013-04-10', 0),
(7, 5, '2013-04-02', 0);

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `itempedido`
--
ALTER TABLE `itempedido`
  ADD CONSTRAINT `fk_ItemPedido_ItemEstoque1` FOREIGN KEY (`idItemEstoque`) REFERENCES `itemestoque` (`idItemEstoque`),
  ADD CONSTRAINT `idPedido` FOREIGN KEY (`idPedido`) REFERENCES `pedido` (`idPedido`);

--
-- Restrições para tabelas `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `fk_Pedido_Cliente1` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`);

--
-- Restrições para tabelas `preco`
--
ALTER TABLE `preco`
  ADD CONSTRAINT `idItemEstoque` FOREIGN KEY (`idItemEstoque`) REFERENCES `itemestoque` (`idItemEstoque`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
