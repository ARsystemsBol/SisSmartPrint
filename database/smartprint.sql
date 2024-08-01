-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 28-07-2024 a las 18:36:13
-- Versión del servidor: 8.0.31
-- Versión de PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `smartprint`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_ciudad`
--

DROP TABLE IF EXISTS `t_ciudad`;
CREATE TABLE IF NOT EXISTS `t_ciudad` (
  `id_ciudad` int NOT NULL AUTO_INCREMENT,
  `ciudad` varchar(20) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_ciudad`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `t_ciudad`
--

INSERT INTO `t_ciudad` (`id_ciudad`, `ciudad`) VALUES
(1, 'La Paz'),
(2, 'Cochabamba'),
(3, 'Santa Cruz'),
(4, 'Oruro');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_cliente`
--

DROP TABLE IF EXISTS `t_cliente`;
CREATE TABLE IF NOT EXISTS `t_cliente` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `cliente` varchar(45) COLLATE utf8mb4_spanish_ci NOT NULL,
  `direccion` varchar(100) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `contacto` varchar(45) COLLATE utf8mb4_spanish_ci NOT NULL,
  `cargo` varchar(40) COLLATE utf8mb4_spanish_ci NOT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_spanish_ci NOT NULL,
  `id_rubro` int DEFAULT NULL,
  `referencia` varchar(50) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `id_ciudad` int NOT NULL,
  `id_estado_cli` int NOT NULL,
  `id_usuario` int NOT NULL DEFAULT '1',
  `f_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `cliente` (`cliente`),
  KEY `id_rubro` (`id_rubro`,`id_ciudad`,`id_usuario`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_ciudad` (`id_ciudad`),
  KEY `id_estado_cli` (`id_estado_cli`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_contactos`
--

DROP TABLE IF EXISTS `t_contactos`;
CREATE TABLE IF NOT EXISTS `t_contactos` (
  `id_contactos` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `contacto` varchar(45) COLLATE utf8mb4_spanish_ci NOT NULL,
  `cargo` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `whatsapp` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `telefono` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `interno` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `id_ciudad` int NOT NULL,
  PRIMARY KEY (`id_contactos`),
  KEY `id_cliente` (`id_cliente`,`id_ciudad`),
  KEY `id_ciudad` (`id_ciudad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_cotizacion`
--

DROP TABLE IF EXISTS `t_cotizacion`;
CREATE TABLE IF NOT EXISTS `t_cotizacion` (
  `id_cotizacion` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `id_contacto` int NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `total` float NOT NULL,
  `validez` int NOT NULL DEFAULT '30',
  `id_transaccion` int NOT NULL,
  `id_f_pago` int NOT NULL,
  `id_facturacion` int NOT NULL,
  `id_entrega` int NOT NULL,
  `id_usuario` int NOT NULL,
  `id_estado_cot` int NOT NULL,
  PRIMARY KEY (`id_cotizacion`),
  KEY `id_cliente` (`id_cliente`,`id_contacto`,`id_f_pago`,`id_facturacion`,`id_entrega`,`id_usuario`,`id_estado_cot`),
  KEY `id_transaccion` (`id_transaccion`),
  KEY `id_contacto` (`id_contacto`),
  KEY `id_f_pago` (`id_f_pago`),
  KEY `id_facturacion` (`id_facturacion`),
  KEY `id_entrega` (`id_entrega`),
  KEY `id_estado_cot` (`id_estado_cot`),
  KEY `id_usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_entrega`
--

DROP TABLE IF EXISTS `t_entrega`;
CREATE TABLE IF NOT EXISTS `t_entrega` (
  `id_entrega` int NOT NULL AUTO_INCREMENT,
  `entrega` varchar(45) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_entrega`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_estado_cliente`
--

DROP TABLE IF EXISTS `t_estado_cliente`;
CREATE TABLE IF NOT EXISTS `t_estado_cliente` (
  `id_estado_cli` int NOT NULL AUTO_INCREMENT,
  `estado` varchar(45) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_estado_cli`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `t_estado_cliente`
--

INSERT INTO `t_estado_cliente` (`id_estado_cli`, `estado`) VALUES
(1, 'Registrado'),
(2, 'Contactado'),
(3, 'Inicial'),
(4, 'Regular'),
(5, 'Recurrente'),
(6, 'VIP');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_estado_cotizacion`
--

DROP TABLE IF EXISTS `t_estado_cotizacion`;
CREATE TABLE IF NOT EXISTS `t_estado_cotizacion` (
  `id_estado_cot` int NOT NULL AUTO_INCREMENT,
  `estado` varchar(45) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_estado_cot`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `t_estado_cotizacion`
--

INSERT INTO `t_estado_cotizacion` (`id_estado_cot`, `estado`) VALUES
(1, 'Pendiente'),
(2, 'Enviado'),
(3, 'Aprobada'),
(4, 'Cancelada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_facturacion`
--

DROP TABLE IF EXISTS `t_facturacion`;
CREATE TABLE IF NOT EXISTS `t_facturacion` (
  `id_facturacion` int NOT NULL AUTO_INCREMENT,
  `facturacion` varchar(45) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_facturacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_fact_cliente`
--

DROP TABLE IF EXISTS `t_fact_cliente`;
CREATE TABLE IF NOT EXISTS `t_fact_cliente` (
  `correlativo` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `nit` varchar(30) COLLATE utf8mb4_spanish_ci NOT NULL,
  `razon social` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`correlativo`),
  KEY `id_cliente` (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_forma_pago`
--

DROP TABLE IF EXISTS `t_forma_pago`;
CREATE TABLE IF NOT EXISTS `t_forma_pago` (
  `id_forma_pago` int NOT NULL AUTO_INCREMENT,
  `pago` varchar(45) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_forma_pago`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `t_forma_pago`
--

INSERT INTO `t_forma_pago` (`id_forma_pago`, `pago`) VALUES
(1, 'Efectivo, Cheque o transferencia'),
(2, 'Efectivo'),
(3, 'Cheque'),
(4, 'Transferencia'),
(5, 'Mediante SIGEP'),
(6, 'Intercabio'),
(7, 'Interno');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_rubros`
--

DROP TABLE IF EXISTS `t_rubros`;
CREATE TABLE IF NOT EXISTS `t_rubros` (
  `id_rubro` int NOT NULL AUTO_INCREMENT,
  `rubro` varchar(40) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_rubro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_transaccion`
--

DROP TABLE IF EXISTS `t_transaccion`;
CREATE TABLE IF NOT EXISTS `t_transaccion` (
  `id_transaccion` int NOT NULL AUTO_INCREMENT,
  `transaccion` varchar(45) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_transaccion`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `t_transaccion`
--

INSERT INTO `t_transaccion` (`id_transaccion`, `transaccion`) VALUES
(1, 'adelanto'),
(2, 'contraentrega'),
(3, 'contado'),
(4, 'sin costo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_usuario`
--

DROP TABLE IF EXISTS `t_usuario`;
CREATE TABLE IF NOT EXISTS `t_usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `usuario` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `t_usuario`
--

INSERT INTO `t_usuario` (`id_usuario`, `usuario`) VALUES
(1, 'Sistemas'),
(2, 'Admin');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `t_cliente`
--
ALTER TABLE `t_cliente`
  ADD CONSTRAINT `t_cliente_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `t_usuario` (`id_usuario`) ON DELETE RESTRICT,
  ADD CONSTRAINT `t_cliente_ibfk_2` FOREIGN KEY (`id_ciudad`) REFERENCES `t_ciudad` (`id_ciudad`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `t_cliente_ibfk_3` FOREIGN KEY (`id_rubro`) REFERENCES `t_rubros` (`id_rubro`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `t_cliente_ibfk_4` FOREIGN KEY (`id_estado_cli`) REFERENCES `t_estado_cliente` (`id_estado_cli`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Filtros para la tabla `t_contactos`
--
ALTER TABLE `t_contactos`
  ADD CONSTRAINT `t_contactos_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `t_cliente` (`id_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `t_contactos_ibfk_2` FOREIGN KEY (`id_ciudad`) REFERENCES `t_ciudad` (`id_ciudad`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Filtros para la tabla `t_cotizacion`
--
ALTER TABLE `t_cotizacion`
  ADD CONSTRAINT `t_cotizacion_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `t_cliente` (`id_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `t_cotizacion_ibfk_2` FOREIGN KEY (`id_contacto`) REFERENCES `t_contactos` (`id_contactos`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `t_cotizacion_ibfk_3` FOREIGN KEY (`id_transaccion`) REFERENCES `t_transaccion` (`id_transaccion`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `t_cotizacion_ibfk_4` FOREIGN KEY (`id_f_pago`) REFERENCES `t_forma_pago` (`id_forma_pago`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `t_cotizacion_ibfk_5` FOREIGN KEY (`id_facturacion`) REFERENCES `t_facturacion` (`id_facturacion`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `t_cotizacion_ibfk_6` FOREIGN KEY (`id_entrega`) REFERENCES `t_entrega` (`id_entrega`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `t_cotizacion_ibfk_7` FOREIGN KEY (`id_estado_cot`) REFERENCES `t_estado_cotizacion` (`id_estado_cot`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `t_cotizacion_ibfk_8` FOREIGN KEY (`id_usuario`) REFERENCES `t_usuario` (`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Filtros para la tabla `t_fact_cliente`
--
ALTER TABLE `t_fact_cliente`
  ADD CONSTRAINT `t_fact_cliente_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `t_cliente` (`id_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
