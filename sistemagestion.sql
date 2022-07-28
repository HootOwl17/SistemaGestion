-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-07-2022 a las 04:17:07
-- Versión del servidor: 10.4.8-MariaDB
-- Versión de PHP: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sistemagestion`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddFactura` (IN `ID` INT, IN `EMP` INT, IN `SUR` INT, IN `CLI` INT, IN `EML` INT, IN `TRA` INT, IN `DAT` DATETIME, IN `ACT` BIT, IN `TPAGO` BIT, IN `ESPA` INT, IN `TOPA` DOUBLE, IN `TONE` INT, IN `TOIVA` DOUBLE, IN `TOPG` DOUBLE)  BEGIN
SELECT @NPG := COUNT(*)+1 FROM pago_bitacora WHERE ID_FACTURA = ID;

INSERT INTO `factura`(`ID_FACTURA`, `ID_EMPRESA`, `ID_SUCURSAL`, `ID_CLIENTE`, `ID_EMPLEADO`, `ID_PAGO`, `ID_TRABAJOREALIZADO`, `FECHA`, `ACTIVO`) 
VALUES (ID,EMP,SUR,CLI,EML,ID,TRA,DAT,ACT);

INSERT INTO `pago`(`ID_PAGO`, `TIPOPAGO`, `ESTADO_PAGO`, `ID_TRABAJOREALIZADO`, `FECHA`, `TOTAL_PAGADO`, `TOTAL_NETO`, `TOTAL_IVA`, `TOTAL_PAGAR`) 
VALUES (ID,TPAGO,ESPA,TRA,DAT,TOPA,TONE,TOIVA,TOPG);

INSERT INTO `pago_bitacora`(`ID_PAGO`, `ID_FACTURA`, `N_PAGO`, `TIPOPAGO`, `ESTADO_PAGO`, `ID_TRABAJOREALIZADO`, `FECHA`, `TOTALPAGADO`, `TOTALNETO`, `TOTALIVA`, `TOTALPAGAR`) 
VALUES (ID,ID,@NPG,TPAGO,ESPA,TRA,DAT,TOPA,TONE,TOIVA,TOPG);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CallFacturas` (IN `BUSCAR` VARCHAR(140), IN `ACT` BIT)  SELECT factura.*, 
empresa.ID_EMPRESA as 'EMP_ID', empresa.NOMBRE as 'EMPRESA', 
sucursal.ID_SUCURSAL as 'SUC_ID', sucursal.NOMBRE as 'SUCURSAL', 
cliente.ID_CLIENTE as 'CLI_ID', CONCAT(cliente.NOMBRE,' ',cliente.APELLIDO) as 'CLIENTE', 
empleado.ID_EMPLEADO as 'EMP_ID', CONCAT(empleado.NOMBRE,' ',empleado.APELLIDO) as 'EMPLEADO', 
pago.ID_PAGO as 'PG_ID', pago.TIPOPAGO as 'PG_TP', pago.ESTADO_PAGO AS 'PG_ES',pago.TOTAL_IVA AS 'PG_IVA', pago.TOTAL_PAGADO AS 'PG_TP', pago.TOTAL_NETO AS 'PG_TN', pago.TOTAL_PAGAR AS 'PG_TA',
estadopago.ID_ESTADO AS 'EST_ID', estadopago.ESTADO AS 'EST',
tipotrabajo.ID_TIPOTRABAJO AS 'IDT_TRABAJO', tipotrabajo.NOMBRE AS 'T_TRABAJO' 
FROM factura
INNER JOIN empresa ON empresa.ID_EMPRESA = factura.ID_EMPRESA
INNER JOIN sucursal ON sucursal.ID_SUCURSAL = factura.ID_SUCURSAL
INNER JOIN cliente ON cliente.ID_CLIENTE = factura.ID_CLIENTE
INNER JOIN empleado ON empleado.ID_EMPLEADO = factura.ID_EMPLEADO
INNER JOIN pago ON pago.ID_PAGO = factura.ID_PAGO
INNER JOIN trabajorealizado ON trabajorealizado.ID_TRABAJOREALIZADO = factura.ID_TRABAJOREALIZADO
INNER JOIN tipotrabajo on tipotrabajo.ID_TIPOTRABAJO = trabajorealizado.TIPOTRABAJO
INNER JOIN estadopago ON estadopago.ID_ESTADO= pago.ESTADO_PAGO
WHERE trabajorealizado.DESCRIPCION LIKE CONCAT('%',BUSCAR,'%')
OR empresa.NOMBRE LIKE CONCAT('%',BUSCAR,'%')
OR sucursal.NOMBRE LIKE CONCAT('%',BUSCAR,'%')
OR cliente.NOMBRE LIKE CONCAT('%',BUSCAR,'%')
OR cliente.APELLIDO LIKE CONCAT('%',BUSCAR,'%')
OR empleado.NOMBRE LIKE CONCAT('%',BUSCAR,'%')
OR empleado.APELLIDO LIKE CONCAT('%',BUSCAR,'%') AND trabajorealizado.ACTIVO = ACT$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CallTrabajos` (IN `BUSCAR` VARCHAR(140), IN `FINAL` BIT(1), IN `ACT` BIT(1))  SELECT trabajorealizado.*, empresa.ID_EMPRESA as 'EMP_ID', empresa.NOMBRE as 'EMPRESA', sucursal.ID_SUCURSAL as 'SUC_ID', sucursal.NOMBRE as 'SUCURSAL', cliente.ID_CLIENTE as 'CLI_ID', CONCAT(cliente.NOMBRE,' ',cliente.APELLIDO) as 'CLIENTE', empleado.ID_EMPLEADO as 'EMP_ID', CONCAT(empleado.NOMBRE,' ',empleado.APELLIDO) as 'EMPLEADO', usuario.ID_USUARIO as 'USR_ID', CONCAT(usuario.NOMBRE,' ',usuario.APELLIDO) as 'USUARIO', tipotrabajo.ID_TIPOTRABAJO AS 'IDT_TRABAJO', tipotrabajo.NOMBRE AS 'T_TRABAJO' FROM trabajorealizado
INNER JOIN empresa ON empresa.ID_EMPRESA = trabajorealizado.ID_EMPRESA
INNER JOIN sucursal ON sucursal.ID_SUCURSAL = trabajorealizado.ID_SUCURSAL
INNER JOIN cliente ON cliente.ID_CLIENTE = trabajorealizado.ID_CLIENTE
INNER JOIN empleado ON empleado.ID_EMPLEADO = trabajorealizado.ID_EMPLEADO
INNER JOIN usuario ON usuario.ID_USUARIO = trabajorealizado.ID_USUARIO
INNER JOIN tipotrabajo on tipotrabajo.ID_TIPOTRABAJO = trabajorealizado.TIPOTRABAJO
WHERE trabajorealizado.DESCRIPCION LIKE CONCAT('%',BUSCAR,'%')
OR empresa.NOMBRE LIKE CONCAT('%',BUSCAR,'%')
OR sucursal.NOMBRE LIKE CONCAT('%',BUSCAR,'%')
OR cliente.NOMBRE LIKE CONCAT('%',BUSCAR,'%')
OR cliente.APELLIDO LIKE CONCAT('%',BUSCAR,'%')
OR empleado.NOMBRE LIKE CONCAT('%',BUSCAR,'%')
OR empleado.APELLIDO LIKE CONCAT('%',BUSCAR,'%')
AND trabajorealizado.FINALIZADO = FINAL AND trabajorealizado.ACTIVO = ACT$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `FacturaByID` (IN `ID` INT, IN `ACT` BIT)  SELECT factura.*, 
empresa.ID_EMPRESA as 'EMP_ID', empresa.NOMBRE as 'EMPRESA', 
sucursal.ID_SUCURSAL as 'SUC_ID', sucursal.NOMBRE as 'SUCURSAL', 
cliente.ID_CLIENTE as 'CLI_ID', CONCAT(cliente.NOMBRE,' ',cliente.APELLIDO) as 'CLIENTE', 
empleado.ID_EMPLEADO as 'EMP_ID', CONCAT(empleado.NOMBRE,' ',empleado.APELLIDO) as 'EMPLEADO', 
pago.ID_PAGO as 'PG_ID', pago.TIPOPAGO as 'PG_TP', pago.ESTADO_PAGO AS 'PG_ES', pago.TOTAL_PAGADO AS 'PG_TP', pago.TOTAL_NETO AS 'PG_TN',pago.TOTAL_IVA AS 'PG_IVA', pago.TOTAL_PAGAR AS 'PG_TA',
tipotrabajo.ID_TIPOTRABAJO AS 'IDT_TRABAJO', tipotrabajo.NOMBRE AS 'T_TRABAJO' 
FROM factura
INNER JOIN empresa ON empresa.ID_EMPRESA = factura.ID_EMPRESA
INNER JOIN sucursal ON sucursal.ID_SUCURSAL = factura.ID_SUCURSAL
INNER JOIN cliente ON cliente.ID_CLIENTE = factura.ID_CLIENTE
INNER JOIN empleado ON empleado.ID_EMPLEADO = factura.ID_EMPLEADO
INNER JOIN pago ON pago.ID_PAGO = factura.ID_PAGO
INNER JOIN trabajorealizado ON trabajorealizado.ID_TRABAJOREALIZADO = factura.ID_TRABAJOREALIZADO
INNER JOIN tipotrabajo on tipotrabajo.ID_TIPOTRABAJO = trabajorealizado.TIPOTRABAJO
WHERE factura.ID_FACTURA = ID AND factura.ACTIVO = ACT$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `TrabajoByID` (IN `ID` INT, `FINAL` BIT, `ACT` BIT)  SELECT trabajorealizado.*, empresa.ID_EMPRESA as 'EMP_ID', empresa.NOMBRE as 'EMPRESA', sucursal.ID_SUCURSAL as 'SUC_ID', sucursal.NOMBRE as 'SUCURSAL', cliente.ID_CLIENTE as 'CLI_ID', CONCAT(cliente.NOMBRE,' ',cliente.APELLIDO) as 'CLIENTE', empleado.ID_EMPLEADO as 'EMP_ID', CONCAT(empleado.NOMBRE,' ',empleado.APELLIDO) as 'EMPLEADO', usuario.ID_USUARIO as 'USR_ID', CONCAT(usuario.NOMBRE,' ',usuario.APELLIDO) as 'USUARIO', tipotrabajo.ID_TIPOTRABAJO AS 'IDT_TRABAJO', tipotrabajo.NOMBRE AS 'T_TRABAJO' FROM trabajorealizado
INNER JOIN empresa ON empresa.ID_EMPRESA = trabajorealizado.ID_EMPRESA
INNER JOIN sucursal ON sucursal.ID_SUCURSAL = trabajorealizado.ID_SUCURSAL
INNER JOIN cliente ON cliente.ID_CLIENTE = trabajorealizado.ID_CLIENTE
INNER JOIN empleado ON empleado.ID_EMPLEADO = trabajorealizado.ID_EMPLEADO
INNER JOIN usuario ON usuario.ID_USUARIO = trabajorealizado.ID_USUARIO
INNER JOIN tipotrabajo on tipotrabajo.ID_TIPOTRABAJO = trabajorealizado.TIPOTRABAJO
WHERE trabajorealizado.ID_TRABAJOREALIZADO = ID AND trabajorealizado.FINALIZADO = FINAL AND trabajorealizado.ACTIVO = ACT$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateFactura` (IN `ID` INT, IN `EMP` INT, IN `SUR` INT, IN `CLI` INT, IN `EML` INT, IN `TRA` INT, IN `DAT` DATETIME, IN `ACT` BIT, IN `TPAGO` BIT, IN `ESPA` INT, IN `TOPA` DOUBLE, IN `TONE` INT, IN `TOIVA` DOUBLE, IN `TOPG` DOUBLE)  BEGIN
SELECT @NPG := COUNT(*)+1 FROM pago_bitacora WHERE ID_FACTURA = ID;

UPDATE factura SET ID_EMPRESA= EMP,ID_SUCURSAL= SUR,ID_CLIENTE= CLI,ID_EMPLEADO= EML,ID_PAGO= ID ,
ID_TRABAJOREALIZADO= TRA,FECHA= DAT,ACTIVO= ACT WHERE ID_FACTURA= ID;

UPDATE pago SET TIPOPAGO= TPAGO,ESTADO_PAGO= ESPA,ID_TRABAJOREALIZADO= TRA,FECHA= CURRENT_TIMESTAMP,TOTAL_PAGADO= TOPA,
TOTAL_NETO= TONE,TOTAL_IVA= TOIVA,TOTAL_PAGAR= TOPG WHERE ID_PAGO= ID;

INSERT INTO pago_bitacora(ID_PAGO, ID_FACTURA, N_PAGO, TIPOPAGO, ESTADO_PAGO, ID_TRABAJOREALIZADO, FECHA, TOTALPAGADO, TOTALNETO, TOTALIVA, TOTALPAGAR) VALUES (ID,ID,@NPG,TPAGO,ESPA,TRA,CURRENT_TIMESTAMP,TOPA,TONE,TOIVA,TOPG);

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `ID_CLIENTE` int(11) NOT NULL,
  `ID_EMPRESA` int(11) NOT NULL,
  `ID_SUCURSAL` int(11) NOT NULL,
  `NOMBRE` varchar(30) NOT NULL,
  `APELLIDO` varchar(30) NOT NULL,
  `TELEFONO` varchar(15) NOT NULL,
  `CORREO` varchar(30) NOT NULL,
  `ACTIVO` bit(1) NOT NULL DEFAULT b'1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`ID_CLIENTE`, `ID_EMPRESA`, `ID_SUCURSAL`, `NOMBRE`, `APELLIDO`, `TELEFONO`, `CORREO`, `ACTIVO`) VALUES
(1, 2, 1, 'Pepe', 'Pecas', '23458919', 'ppepas@gmail.com', b'1'),
(2, 2, 1, 'Galilea', 'Holland', '78451256', 'hollandteadoro@gmail.com', b'1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `ID_EMPLEADO` int(11) NOT NULL,
  `NOMBRE` varchar(30) NOT NULL,
  `APELLIDO` varchar(30) NOT NULL,
  `TELEFONO` varchar(15) NOT NULL,
  `CORREO` varchar(30) NOT NULL,
  `ID_EMPRESA` int(11) NOT NULL,
  `ID_SUCURSAL` int(11) NOT NULL,
  `ACTIVO` bit(1) NOT NULL DEFAULT b'1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`ID_EMPLEADO`, `NOMBRE`, `APELLIDO`, `TELEFONO`, `CORREO`, `ID_EMPRESA`, `ID_SUCURSAL`, `ACTIVO`) VALUES
(1, 'Andrés', 'Iniesta', '45781256', 'iniesta@gmail.com', 2, 5, b'1'),
(2, 'David Ricardo', 'Morales Arriaga', '74806592', 'david@selpro.com', 1, 2, b'1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

CREATE TABLE `empresa` (
  `ID_EMPRESA` int(11) NOT NULL,
  `NOMBRE` varchar(30) NOT NULL,
  `TELEFONO` varchar(15) NOT NULL,
  `DIRECCION` varchar(50) NOT NULL,
  `ACTIVO` bit(1) NOT NULL DEFAULT b'1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `empresa`
--

INSERT INTO `empresa` (`ID_EMPRESA`, `NOMBRE`, `TELEFONO`, `DIRECCION`, `ACTIVO`) VALUES
(1, 'SELPRO', '77777777', 'POR ALLÍ', b'1'),
(2, 'WAL-MART', '87654321', 'San Salvador', b'1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estadopago`
--

CREATE TABLE `estadopago` (
  `ID_ESTADO` int(11) NOT NULL,
  `ESTADO` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `estadopago`
--

INSERT INTO `estadopago` (`ID_ESTADO`, `ESTADO`) VALUES
(1, 'NO PAGADO'),
(2, 'PAGADO PARCIALMENTE'),
(3, 'PAGADO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `ID_FACTURA` int(11) NOT NULL,
  `ID_EMPRESA` int(11) NOT NULL,
  `ID_SUCURSAL` int(11) NOT NULL,
  `ID_CLIENTE` int(11) NOT NULL,
  `ID_EMPLEADO` int(11) NOT NULL,
  `ID_PAGO` int(11) NOT NULL,
  `ID_TRABAJOREALIZADO` int(11) NOT NULL,
  `FECHA` datetime NOT NULL,
  `ACTIVO` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago`
--

CREATE TABLE `pago` (
  `ID_PAGO` int(11) NOT NULL,
  `TIPOPAGO` bit(1) NOT NULL,
  `ESTADO_PAGO` int(11) NOT NULL,
  `ID_TRABAJOREALIZADO` int(11) NOT NULL,
  `FECHA` datetime NOT NULL,
  `TOTAL_PAGADO` double NOT NULL,
  `TOTAL_NETO` double NOT NULL,
  `TOTAL_IVA` double NOT NULL,
  `TOTAL_PAGAR` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago_bitacora`
--

CREATE TABLE `pago_bitacora` (
  `ID_PAGO` int(11) NOT NULL,
  `ID_FACTURA` int(11) NOT NULL,
  `N_PAGO` int(11) NOT NULL,
  `TIPOPAGO` bit(1) NOT NULL,
  `ESTADO_PAGO` int(11) NOT NULL,
  `ID_TRABAJOREALIZADO` int(11) NOT NULL,
  `FECHA` datetime NOT NULL,
  `TOTALPAGADO` double NOT NULL,
  `TOTALNETO` double NOT NULL,
  `TOTALIVA` double NOT NULL,
  `TOTALPAGAR` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursal`
--

CREATE TABLE `sucursal` (
  `ID_SUCURSAL` int(11) NOT NULL,
  `ID_EMPRESA` int(11) DEFAULT NULL,
  `NOMBRE` varchar(30) NOT NULL,
  `DIRECCION` varchar(30) NOT NULL,
  `TELEFONO` varchar(15) NOT NULL,
  `ACTIVO` bit(1) NOT NULL DEFAULT b'1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `sucursal`
--

INSERT INTO `sucursal` (`ID_SUCURSAL`, `ID_EMPRESA`, `NOMBRE`, `DIRECCION`, `TELEFONO`, `ACTIVO`) VALUES
(1, 2, 'Sucursal Constitución', 'Constitucion', '77777777', b'1'),
(2, 1, 'Sucursal Central', 'San Salvador', '12345678', b'1'),
(5, 2, 'Sucursal Escalón', 'Escalón', '45781256', b'1'),
(6, 2, 'Sucursal Cascadas', 'Centro Comercial Cascadas', '12457832', b'1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipotrabajo`
--

CREATE TABLE `tipotrabajo` (
  `ID_TIPOTRABAJO` int(11) NOT NULL,
  `NOMBRE` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipotrabajo`
--

INSERT INTO `tipotrabajo` (`ID_TIPOTRABAJO`, `NOMBRE`) VALUES
(1, 'TRABAJO PREVENTIVO'),
(2, 'TRABAJO CORRECTIVO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trabajorealizado`
--

CREATE TABLE `trabajorealizado` (
  `ID_TRABAJOREALIZADO` int(11) NOT NULL,
  `ID_EMPRESA` int(11) NOT NULL,
  `ID_SUCURSAL` int(11) NOT NULL,
  `ID_CLIENTE` int(11) NOT NULL,
  `ID_EMPLEADO` int(11) NOT NULL,
  `ID_USUARIO` int(11) NOT NULL DEFAULT 1,
  `FECHA` datetime NOT NULL DEFAULT current_timestamp(),
  `DESCRIPCION` varchar(140) DEFAULT NULL,
  `TIPOTRABAJO` int(11) NOT NULL,
  `FINALIZADO` bit(1) NOT NULL,
  `ACTIVO` bit(1) NOT NULL DEFAULT b'1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `trabajorealizado`
--

INSERT INTO `trabajorealizado` (`ID_TRABAJOREALIZADO`, `ID_EMPRESA`, `ID_SUCURSAL`, `ID_CLIENTE`, `ID_EMPLEADO`, `ID_USUARIO`, `FECHA`, `DESCRIPCION`, `TIPOTRABAJO`, `FINALIZADO`, `ACTIVO`) VALUES
(1, 2, 1, 2, 1, 1, '2022-07-24 10:04:29', 'Mantenimiento de Escaleras', 1, b'0', b'1'),
(2, 2, 1, 1, 1, 1, '2022-07-24 21:14:55', 'Reparación de Cajero', 1, b'0', b'1'),
(5, 2, 1, 1, 2, 1, '2022-07-24 21:18:40', 'Mantenimiento de Rutina', 1, b'0', b'1'),
(6, 2, 1, 2, 1, 1, '2022-07-24 00:00:00', 'Falla total de Banda', 2, b'1', b'1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `ID_USUARIO` int(11) NOT NULL,
  `NOMBRE` varchar(50) NOT NULL,
  `APELLIDO` varchar(50) NOT NULL,
  `TELEFONO` varchar(15) NOT NULL,
  `CORREO` varchar(30) NOT NULL,
  `PASSWORD` varchar(50) NOT NULL,
  `ACTIVO` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`ID_USUARIO`, `NOMBRE`, `APELLIDO`, `TELEFONO`, `CORREO`, `PASSWORD`, `ACTIVO`) VALUES
(1, 'prueba', 'prueba', '77777777', 'prueba@gmail.com', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', b'1'),
(2, 'Angel David', 'Revilla', '02055', 'diariodedross@gmail.com', '3bd6d64dc94a1275222a479f27146bff7de7b575', b'1');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`ID_CLIENTE`),
  ADD KEY `FK_CLIENTE_EMPRESA` (`ID_EMPRESA`),
  ADD KEY `FK_CLIENTE_SUCURSAL` (`ID_SUCURSAL`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`ID_EMPLEADO`),
  ADD KEY `FK_EMPLEADO_EMPRESA` (`ID_EMPRESA`),
  ADD KEY `FK_EMPLEADO_SUCURSAL` (`ID_SUCURSAL`);

--
-- Indices de la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`ID_EMPRESA`);

--
-- Indices de la tabla `estadopago`
--
ALTER TABLE `estadopago`
  ADD PRIMARY KEY (`ID_ESTADO`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`ID_FACTURA`),
  ADD KEY `FK_FACTURA_CLIENTE` (`ID_CLIENTE`),
  ADD KEY `FK_FACTURA_TRABAJO` (`ID_TRABAJOREALIZADO`),
  ADD KEY `FK_FACTURA_PAGO` (`ID_PAGO`),
  ADD KEY `FK_FACTURA_EMPRESA` (`ID_EMPRESA`),
  ADD KEY `FK_FACTURA_SUCURSAL` (`ID_SUCURSAL`),
  ADD KEY `FK_FACTURA_EMPLEADO` (`ID_EMPLEADO`);

--
-- Indices de la tabla `pago`
--
ALTER TABLE `pago`
  ADD PRIMARY KEY (`ID_PAGO`),
  ADD KEY `FK_PAGO_TRABAJO` (`ID_TRABAJOREALIZADO`),
  ADD KEY `FK_PAGO_ESTADO` (`ESTADO_PAGO`);

--
-- Indices de la tabla `pago_bitacora`
--
ALTER TABLE `pago_bitacora`
  ADD PRIMARY KEY (`ID_PAGO`),
  ADD KEY `FK_PAGO_FACTURA` (`ID_FACTURA`);

--
-- Indices de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  ADD PRIMARY KEY (`ID_SUCURSAL`),
  ADD KEY `FK_SUCURSAL_EMPRESA` (`ID_EMPRESA`);

--
-- Indices de la tabla `tipotrabajo`
--
ALTER TABLE `tipotrabajo`
  ADD PRIMARY KEY (`ID_TIPOTRABAJO`);

--
-- Indices de la tabla `trabajorealizado`
--
ALTER TABLE `trabajorealizado`
  ADD PRIMARY KEY (`ID_TRABAJOREALIZADO`),
  ADD KEY `FK_TRABAJO_EMPRESA` (`ID_EMPRESA`),
  ADD KEY `FK_TRABAJO_SUCURSAL` (`ID_SUCURSAL`),
  ADD KEY `FK_TRABAJO_CLIENTE` (`ID_CLIENTE`),
  ADD KEY `FK_TRABAJO_EMPLEADO` (`ID_EMPLEADO`),
  ADD KEY `FK_USUARIO_TREALIZADO` (`ID_USUARIO`),
  ADD KEY `FK_TRABAJO_TIPOTRABAJO` (`TIPOTRABAJO`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`ID_USUARIO`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `ID_CLIENTE` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `ID_EMPLEADO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `empresa`
--
ALTER TABLE `empresa`
  MODIFY `ID_EMPRESA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `factura`
--
ALTER TABLE `factura`
  MODIFY `ID_FACTURA` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  MODIFY `ID_SUCURSAL` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `trabajorealizado`
--
ALTER TABLE `trabajorealizado`
  MODIFY `ID_TRABAJOREALIZADO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `ID_USUARIO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `FK_CLIENTE_EMPRESA` FOREIGN KEY (`ID_EMPRESA`) REFERENCES `empresa` (`ID_EMPRESA`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_CLIENTE_SUCURSAL` FOREIGN KEY (`ID_SUCURSAL`) REFERENCES `sucursal` (`ID_SUCURSAL`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `FK_EMPLEADO_EMPRESA` FOREIGN KEY (`ID_EMPRESA`) REFERENCES `empresa` (`ID_EMPRESA`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_EMPLEADO_SUCURSAL` FOREIGN KEY (`ID_SUCURSAL`) REFERENCES `sucursal` (`ID_SUCURSAL`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `FK_FACTURA_CLIENTE` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `cliente` (`ID_CLIENTE`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_FACTURA_EMPLEADO` FOREIGN KEY (`ID_EMPLEADO`) REFERENCES `empleado` (`ID_EMPLEADO`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_FACTURA_EMPRESA` FOREIGN KEY (`ID_EMPRESA`) REFERENCES `empresa` (`ID_EMPRESA`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_FACTURA_PAGO` FOREIGN KEY (`ID_PAGO`) REFERENCES `pago` (`ID_PAGO`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_FACTURA_SUCURSAL` FOREIGN KEY (`ID_SUCURSAL`) REFERENCES `sucursal` (`ID_SUCURSAL`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_FACTURA_TRABAJO` FOREIGN KEY (`ID_TRABAJOREALIZADO`) REFERENCES `trabajorealizado` (`ID_TRABAJOREALIZADO`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `pago`
--
ALTER TABLE `pago`
  ADD CONSTRAINT `FK_PAGO_ESTADO` FOREIGN KEY (`ESTADO_PAGO`) REFERENCES `estadopago` (`ID_ESTADO`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_PAGO_TRABAJO` FOREIGN KEY (`ID_TRABAJOREALIZADO`) REFERENCES `trabajorealizado` (`ID_TRABAJOREALIZADO`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `pago_bitacora`
--
ALTER TABLE `pago_bitacora`
  ADD CONSTRAINT `FK_PAGO_BITACORA` FOREIGN KEY (`ID_PAGO`) REFERENCES `pago` (`ID_PAGO`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_PAGO_FACTURA` FOREIGN KEY (`ID_FACTURA`) REFERENCES `factura` (`ID_FACTURA`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `sucursal`
--
ALTER TABLE `sucursal`
  ADD CONSTRAINT `FK_SUCURSAL_EMPRESA` FOREIGN KEY (`ID_EMPRESA`) REFERENCES `empresa` (`ID_EMPRESA`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `trabajorealizado`
--
ALTER TABLE `trabajorealizado`
  ADD CONSTRAINT `FK_TRABAJO_CLIENTE` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `cliente` (`ID_CLIENTE`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_TRABAJO_EMPLEADO` FOREIGN KEY (`ID_EMPLEADO`) REFERENCES `empleado` (`ID_EMPLEADO`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_TRABAJO_EMPRESA` FOREIGN KEY (`ID_EMPRESA`) REFERENCES `empresa` (`ID_EMPRESA`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_TRABAJO_SUCURSAL` FOREIGN KEY (`ID_SUCURSAL`) REFERENCES `sucursal` (`ID_SUCURSAL`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_TRABAJO_TIPOTRABAJO` FOREIGN KEY (`TIPOTRABAJO`) REFERENCES `tipotrabajo` (`ID_TIPOTRABAJO`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_USUARIO_TREALIZADO` FOREIGN KEY (`ID_USUARIO`) REFERENCES `usuario` (`ID_USUARIO`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;