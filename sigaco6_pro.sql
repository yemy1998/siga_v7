/*
 Navicat Premium Data Transfer

 Source Server         : MYSQL_V7
 Source Server Type    : MySQL
 Source Server Version : 100427
 Source Host           : localhost:3306
 Source Schema         : sigaco6_pro

 Target Server Type    : MySQL
 Target Server Version : 100427
 File Encoding         : 65001

 Date: 28/02/2023 09:12:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ajuste
-- ----------------------------
DROP TABLE IF EXISTS `ajuste`;
CREATE TABLE `ajuste`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint NOT NULL,
  `local_id` bigint NOT NULL,
  `moneda_id` bigint NOT NULL,
  `fecha` datetime NOT NULL,
  `operacion` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `io` varchar(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `documento` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `serie` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `numero` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `estado` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `total_importe` decimal(18, 2) NULL DEFAULT 0.00,
  `tasa_cambio` float NULL DEFAULT 0,
  `operacion_otros` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ajuste
-- ----------------------------
INSERT INTO `ajuste` VALUES (1, 2, 1, 1029, '2023-02-14 14:05:07', '16', '1', '16', '1', '1', '1', 0.00, 0, NULL);

-- ----------------------------
-- Table structure for ajuste_detalle
-- ----------------------------
DROP TABLE IF EXISTS `ajuste_detalle`;
CREATE TABLE `ajuste_detalle`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `ajuste_id` bigint NOT NULL,
  `producto_id` bigint NOT NULL,
  `unidad_id` bigint NOT NULL,
  `cantidad` decimal(18, 2) NOT NULL,
  `cantidad_parcial` decimal(18, 2) NOT NULL,
  `costo_unitario` float NOT NULL DEFAULT 0,
  `detalle_importe` decimal(18, 2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ajuste_detalle
-- ----------------------------
INSERT INTO `ajuste_detalle` VALUES (1, 1, 1, 1, 100.00, 100.00, 0, 0.00);

-- ----------------------------
-- Table structure for ajusteinventario
-- ----------------------------
DROP TABLE IF EXISTS `ajusteinventario`;
CREATE TABLE `ajusteinventario`  (
  `id_ajusteinventario` bigint NOT NULL AUTO_INCREMENT,
  `fecha` datetime NULL DEFAULT NULL,
  `descripcion` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `local_id` bigint NULL DEFAULT NULL,
  `usuario_encargado` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id_ajusteinventario`) USING BTREE,
  INDEX `ajusteinventario_fk_1_idx`(`local_id` ASC) USING BTREE,
  INDEX `usuario_encargado`(`usuario_encargado` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ajusteinventario
-- ----------------------------

-- ----------------------------
-- Table structure for anticipos
-- ----------------------------
DROP TABLE IF EXISTS `anticipos`;
CREATE TABLE `anticipos`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `correlativo` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `idLocal` int NOT NULL COMMENT 'Id del local donde se registra el anticipo',
  `fechaEntregaAnticipo` datetime NOT NULL COMMENT 'Fecha en la que se entrego el anticipo',
  `naturalizaAnticipo` tinyint(1) NOT NULL COMMENT ' 1 = cliente / 2 = proveedor',
  `idActor` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Puede ser el id del cliente o el id del proveedor',
  `tipoMovimiento` tinyint(1) NOT NULL COMMENT '1 = entrada / 2 = salida ',
  `idMoneda` int NOT NULL COMMENT 'Id de la moneda',
  `metodoPago` int NOT NULL,
  `idCuentaAfectada` int NOT NULL,
  `idDocumento` int NOT NULL,
  `cuentaDestino` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Nombre del banco y numero de cuenta del origen o destino del dinero',
  `numeroOperacion` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Numero de operación de la transacción (valor alfanumero), en caso de efectivo puede dejarlo en blanco',
  `descripcionMotivoAnticipo` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `importeAnticipo` decimal(18, 2) NOT NULL COMMENT 'Importe del anticipo, este valor representaria el abono inicial realizado',
  `saldoAnticipo` decimal(18, 2) NOT NULL COMMENT 'Importe disponible del anticipo, cada vez q se hago uso del anticipo, este valor se ira reduciendo hasta quedar en cero.',
  `estadoTransaccion` tinyint(1) NOT NULL COMMENT '1 = pendiente / 2 = confirmado / 3 = rechazado ',
  `estadoAnticipo` tinyint(1) NOT NULL COMMENT '0 = pendiente de aprobación / 1 = disponible / 2 = utilizado / 3 = anulado',
  `enlaceComprobante` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ref_id` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Id de la venta ',
  `created_at` datetime NOT NULL COMMENT 'Fecha de creación',
  `usuario_at` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `delete_at` datetime NULL DEFAULT NULL COMMENT 'Fecha en la que se elimina',
  `usuario_delete` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Usuario que elimina el registro',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of anticipos
-- ----------------------------

-- ----------------------------
-- Table structure for banco
-- ----------------------------
DROP TABLE IF EXISTS `banco`;
CREATE TABLE `banco`  (
  `banco_id` bigint NOT NULL AUTO_INCREMENT,
  `banco_nombre` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `banco_numero_cuenta` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `banco_saldo` decimal(18, 2) NULL DEFAULT NULL,
  `banco_cuenta_contable` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `banco_titular` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `banco_status` tinyint(1) NULL DEFAULT 1,
  `cuenta_id` bigint NOT NULL,
  PRIMARY KEY (`banco_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of banco
-- ----------------------------
INSERT INTO `banco` VALUES (1, 'CTA BCP SOLES', '1321345', NULL, '564541', 'NOMBRE DEL USUARIO RESPONSABLE', 1, 3);

-- ----------------------------
-- Table structure for caja
-- ----------------------------
DROP TABLE IF EXISTS `caja`;
CREATE TABLE `caja`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `local_id` bigint NOT NULL,
  `moneda_id` bigint NOT NULL,
  `responsable_id` bigint NOT NULL,
  `estado` tinyint NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of caja
-- ----------------------------
INSERT INTO `caja` VALUES (1, 1, 1029, 1, 1);
INSERT INTO `caja` VALUES (2, 1, 1030, 1, 0);

-- ----------------------------
-- Table structure for caja_desglose
-- ----------------------------
DROP TABLE IF EXISTS `caja_desglose`;
CREATE TABLE `caja_desglose`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `caja_id` int NOT NULL,
  `responsable_id` bigint NOT NULL,
  `descripcion` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `saldo` decimal(18, 2) NOT NULL DEFAULT 0.00,
  `principal` tinyint NOT NULL DEFAULT 0,
  `retencion` tinyint NOT NULL DEFAULT 0,
  `estado` tinyint NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of caja_desglose
-- ----------------------------
INSERT INTO `caja_desglose` VALUES (1, 1, 2, 'CTA PRINCIPAL SOLES', 6785.00, 1, 0, 1);
INSERT INTO `caja_desglose` VALUES (2, 2, 2, 'PRINCIPAL DOLARES', 0.00, 1, 0, 1);
INSERT INTO `caja_desglose` VALUES (3, 1, 2, 'CTA BCP', 0.00, 0, 0, 1);

-- ----------------------------
-- Table structure for caja_movimiento
-- ----------------------------
DROP TABLE IF EXISTS `caja_movimiento`;
CREATE TABLE `caja_movimiento`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `caja_desglose_id` bigint NOT NULL,
  `usuario_id` bigint NOT NULL,
  `fecha_mov` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `movimiento` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `operacion` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `medio_pago` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `saldo` decimal(18, 2) NOT NULL,
  `saldo_old` decimal(18, 2) NOT NULL,
  `ref_id` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ref_val` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of caja_movimiento
-- ----------------------------
INSERT INTO `caja_movimiento` VALUES (1, 1, 2, '2023-02-14 14:06:56', '2023-02-14 14:06:56', 'INGRESO', 'VENTA', '3', 1.00, 0.00, '1', '');
INSERT INTO `caja_movimiento` VALUES (2, 1, 1, '2023-02-14 14:34:58', '2023-02-14 14:34:58', 'INGRESO', 'VENTA', '3', 1.00, 1.00, '2', '');
INSERT INTO `caja_movimiento` VALUES (3, 1, 1, '2023-02-14 16:33:59', '2023-02-14 16:33:59', 'INGRESO', 'VENTA', '3', 2.00, 2.00, '3', '');
INSERT INTO `caja_movimiento` VALUES (4, 1, 1, '2023-02-15 09:50:57', '2023-02-15 09:50:57', 'INGRESO', 'VENTA', '3', 3.00, 4.00, '4', '');
INSERT INTO `caja_movimiento` VALUES (5, 1, 1, '2023-02-15 10:22:00', '2023-02-15 10:22:00', 'INGRESO', 'VENTA', '3', 1.00, 7.00, '5', '');
INSERT INTO `caja_movimiento` VALUES (6, 1, 1, '2023-02-15 10:27:27', '2023-02-15 10:27:27', 'INGRESO', 'VENTA', '3', 4.00, 8.00, '6', '');
INSERT INTO `caja_movimiento` VALUES (7, 1, 1, '2023-02-15 15:46:18', '2023-02-15 15:46:18', 'INGRESO', 'VENTA', '3', 5.00, 12.00, '7', '');
INSERT INTO `caja_movimiento` VALUES (8, 1, 1, '2023-02-16 10:30:18', '2023-02-16 10:30:18', 'INGRESO', 'VENTA', '3', 1.00, 17.00, '8', '');
INSERT INTO `caja_movimiento` VALUES (9, 1, 1, '2023-02-16 11:00:24', '2023-02-16 11:00:24', 'INGRESO', 'VENTA', '3', 1.00, 18.00, '9', '');
INSERT INTO `caja_movimiento` VALUES (10, 1, 1, '2023-02-16 11:09:30', '2023-02-16 11:09:30', 'INGRESO', 'VENTA', '3', 3.00, 19.00, '10', '');
INSERT INTO `caja_movimiento` VALUES (11, 1, 1, '2023-02-16 14:42:56', '2023-02-16 14:42:56', 'INGRESO', 'VENTA', '3', 1700.00, 22.00, '11', '');
INSERT INTO `caja_movimiento` VALUES (12, 1, 1, '2023-02-17 09:43:39', '2023-02-17 09:43:39', 'INGRESO', 'VENTA', '3', 2.00, 1722.00, '12', '');
INSERT INTO `caja_movimiento` VALUES (13, 1, 1, '2023-02-20 12:10:06', '2023-02-20 12:10:06', 'INGRESO', 'VENTA', '3', 2.00, 1724.00, '13', '');
INSERT INTO `caja_movimiento` VALUES (14, 1, 1, '2023-02-21 14:39:22', '2023-02-21 14:39:22', 'INGRESO', 'VENTA', '3', 2.00, 1726.00, '14', '');
INSERT INTO `caja_movimiento` VALUES (15, 1, 1, '2023-02-21 16:20:15', '2023-02-21 16:20:15', 'INGRESO', 'VENTA', '3', 3.00, 1728.00, '15', '');
INSERT INTO `caja_movimiento` VALUES (16, 1, 1, '2023-02-21 16:22:43', '2023-02-21 16:22:43', 'INGRESO', 'VENTA', '3', 6.00, 1731.00, '16', '');
INSERT INTO `caja_movimiento` VALUES (17, 1, 1, '2023-02-22 12:44:22', '2023-02-22 12:44:22', 'INGRESO', 'VENTA', '3', 4.00, 1737.00, '17', '');
INSERT INTO `caja_movimiento` VALUES (18, 1, 1, '2023-02-23 09:19:47', '2023-02-23 09:19:47', 'INGRESO', 'VENTA', '3', 12.00, 1741.00, '18', '');
INSERT INTO `caja_movimiento` VALUES (19, 1, 1, '2023-02-23 15:22:19', '2023-02-23 15:22:19', 'INGRESO', 'VENTA', '3', 12.00, 1753.00, '19', '');
INSERT INTO `caja_movimiento` VALUES (20, 1, 1, '2023-02-23 17:23:23', '2023-02-23 17:23:23', 'INGRESO', 'VENTA', '3', 8.00, 1765.00, '20', '');
INSERT INTO `caja_movimiento` VALUES (21, 1, 1, '2023-02-24 11:39:26', '2023-02-24 11:39:26', 'INGRESO', 'VENTA', '3', 4.00, 1773.00, '21', '');
INSERT INTO `caja_movimiento` VALUES (22, 1, 1, '2023-02-24 14:06:34', '2023-02-24 14:06:34', 'INGRESO', 'VENTA', '3', 8.00, 1777.00, '23', '');
INSERT INTO `caja_movimiento` VALUES (23, 1, 1, '2023-02-27 11:17:15', '2023-02-27 11:17:15', 'INGRESO', 'VENTA', '3', 5000.00, 1785.00, '24', '');

-- ----------------------------
-- Table structure for caja_pendiente
-- ----------------------------
DROP TABLE IF EXISTS `caja_pendiente`;
CREATE TABLE `caja_pendiente`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `caja_desglose_id` bigint NOT NULL,
  `usuario_id` bigint NOT NULL,
  `tipo` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `IO` tinyint NOT NULL,
  `monto` decimal(18, 2) NOT NULL,
  `estado` tinyint NOT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp,
  `ref_id` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ref_val` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of caja_pendiente
-- ----------------------------
INSERT INTO `caja_pendiente` VALUES (1, 1, 1, 'VENTA_ANULADA', 2, 2.00, 0, '2023-02-14 17:29:23', '3', '3');
INSERT INTO `caja_pendiente` VALUES (2, 1, 1, 'VENTA_ANULADA', 2, 4.00, 0, '2023-02-15 10:31:32', '6', '3');
INSERT INTO `caja_pendiente` VALUES (3, 1, 1, 'VENTA_RECHAZADA', 2, 1700.00, 0, '2023-02-16 14:47:35', '11', '3');
INSERT INTO `caja_pendiente` VALUES (5, 1, 1, 'VENTA_ANULADA', 2, 2.00, 0, '2023-02-20 11:13:58', '12', '3');
INSERT INTO `caja_pendiente` VALUES (6, 1, 1, 'COMPRA', 2, 1.00, 0, '2023-02-22 11:50:43', '1', '');
INSERT INTO `caja_pendiente` VALUES (7, 1, 1, 'COMPRA', 2, 50.00, 0, '2023-02-23 09:18:37', '2', '');
INSERT INTO `caja_pendiente` VALUES (8, 1, 1, 'VENTA_ANULADA', 2, 12.00, 0, '2023-02-23 17:20:43', '19', '3');

-- ----------------------------
-- Table structure for camiones
-- ----------------------------
DROP TABLE IF EXISTS `camiones`;
CREATE TABLE `camiones`  (
  `placa` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `metros_cubicos` int NULL DEFAULT NULL,
  `peso` int NULL DEFAULT NULL,
  `estado` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`placa`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of camiones
-- ----------------------------

-- ----------------------------
-- Table structure for ci_sessions
-- ----------------------------
DROP TABLE IF EXISTS `ci_sessions`;
CREATE TABLE `ci_sessions`  (
  `id` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ip_address` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `timestamp` int UNSIGNED NOT NULL DEFAULT 0,
  `data` blob NOT NULL,
  INDEX `ci_sessions_timestamp`(`timestamp`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ci_sessions
-- ----------------------------
INSERT INTO `ci_sessions` VALUES ('leik02hc8j6rar064aiataq044sjsn2r', '::1', 1677593377, 0x5F5F63695F6C6173745F726567656E65726174657C693A313637373539333337363B6E557375436F6469676F7C733A313A2231223B757365726E616D657C733A31303A22737570657261646D696E223B7661725F7573756172696F5F636C6176657C733A33323A223035623465393138383063346639393830663136383034346636653037363433223B61637469766F7C733A313A2231223B6E6F6D6272657C733A31303A22537570657241646D696E223B677275706F7C733A313A2232223B69645F6C6F63616C7C733A313A2232223B64656C657465647C733A313A2230223B6964656E74696669636163696F6E7C733A313A2230223B657353757065727C733A313A2231223B706F7263656E74616A655F636F6D6973696F6E7C733A343A22302E3030223B696E745F6C6F63616C5F69647C4E3B6C6F63616C5F6E6F6D6272657C4E3B6C6F63616C5F7374617475737C4E3B7072696E636970616C7C4E3B646973747269746F5F69647C4E3B646972656363696F6E7C4E3B74656C65666F6E6F7C4E3B7469706F7C4E3B69645F677275706F735F7573756172696F737C733A313A2232223B6E6F6D6272655F677275706F735F7573756172696F737C733A31333A2241646D696E6973747261646F72223B7374617475735F677275706F735F7573756172696F737C733A313A2231223B70617373776F72647C733A33323A223035623465393138383063346639393830663136383034346636653037363433223B454D50524553415F4E4F4D4252457C733A31383A22414D4249454E544520454E20424C414E434F223B454D50524553415F444952454343494F4E7C733A303A22223B454D50524553415F54454C45464F4E4F7C733A303A22223B56454E54415F44454641554C547C733A363A224E4F4D425245223B494E494349414C5F504F5243454E54414A455F5654415F435245447C733A313A2230223B544153415F494E54455245537C733A313A2230223B44415441424153455F49507C4E3B44415441424153455F4E414D457C4E3B44415441424153455F555345524E414D457C4E3B4D4F444946494341444F525F50524543494F7C733A323A225349223B434F4449474F5F44454641554C547C733A373A22494E5445524E4F223B56414C4F525F554E49434F7C733A363A224E4F4D425245223B50524F445543544F5F53455249457C733A313A2230223B4D4158494D4F5F43554F5441535F4352454449544F7C733A323A223234223B47454E455241525F4641435455524143494F4E7C733A323A225349223B5041474F535F414E544943495041444F537C4E3B4144454C414E544F5F5041474F5F43554F54417C733A313A2230223B46414354555241525F494E475245534F7C733A323A224E4F223B56495354415F4352454449544F7C733A383A224156414E5A41444F223B50524543494F5F424153457C733A353A22434F53544F223B434F4E5441424C455F434F53544F7C733A323A224E4F223B56454E5441535F434F425241527C733A323A224E4F223B50524543494F5F44455F56454E54417C733A363A224D414E55414C223B4255534341525F50524F445543544F535F56454E54417C733A363A224E4F4D425245223B50524543494F5F494E475245534F7C733A353A22434F53544F223B414354495641525F4641435455524143494F4E5F56454E54417C733A313A2230223B414354495641525F4641435455524143494F4E5F494E475245534F7C733A313A2230223B414354495641525F534841444F577C733A313A2230223B494E475245534F5F434F53544F7C733A313A2230223B494E475245534F5F5554494C494441447C733A313A2230223B4352454449544F5F494E494349414C7C733A313A2230223B4352454449544F5F544153417C733A313A2230223B4352454449544F5F43554F5441537C733A323A223234223B434F53544F5F41554D454E544F7C4E3B494E434F52504F5241525F4947567C733A313A2230223B434F425241525F43414A417C733A313A2230223B434F54495A4143494F4E5F494E464F524D4143494F4E7C733A33373A2241C3B16F2064656C206469616C6F676F2079206C61207265636F6E63696C69616369C3B36E223B434F54495A4143494F4E5F434F4E444943494F4E7C733A3139373A224374652E20446F6C617265733A203139332D58585858585858202842616E636F206465204372C3A96469746F202D20424350293C62723E4374652E20536F6C65733A203139342D58582D58585858585858202842616E636F206465204372C3A96469746F202D20424350293C62723E204573746520646F63756D656E746F20636F6D70726F6D65746520616C20636C69656E74652061206D616E74656E657220656E20657374726963746120726573657276612076657262616C206F20657363726974612E223B434F54495A4143494F4E5F5049455F504147494E417C733A39343A223C61207461726765743D225F626C616E6B222072656C3D226E6F666F6C6C6F772220687265663D2268747470733A2F2F7777772E7475706167696E612E70652F223E68747470733A2F2F7777772E7475706167696E612E70652F3C2F613E223B434F4D50524F42414E54457C733A313A2230223B454D50524553415F4944454E54494649434143494F4E7C733A303A22223B4641435455524143494F4E7C733A313A2231223B454D50524553415F434F5252454F7C733A303A22223B454D50524553415F434F4E544143544F7C733A303A22223B484F53545F494D50524553494F4E7C4E3B454D50524553415F4C4F474F7C733A303A22223B444F43554D454E544F5F4445464543544F7C733A313A2236223B424F544F4E45535F56454E54417C733A31373A225B2231222C2230222C2231222C2230225D223B4E4F4D4252455F50524F445543544F7C733A32353A225B2230222C2230222C2230222C2230222C2230222C2230225D223B434F54495A4143494F4E5F434F4C4F525F464F524D41544F7C733A31383A225B2223663030222C2223303130393131225D223B454D42414C414A455F494D50524553494F4E7C733A313A2231223B4E554D45524F5F444543494D414C45537C733A313A2232223B56414C4F525F434F4D50524F42414E54457C733A363A224E4F4D425245223B5245444F4E44454F5F56454E5441537C733A313A2230223B504F5055505F43414D42494F537C733A323A225349223B5449504F5F494D50524543494F4E7C733A313A2254223B545241535041534F7C733A343A224155544F223B47525F41435449564143494F4E5F454C454354524F4E4943417C733A313A2231223B47525F41435449564143494F4E5F4D414E55414C7C733A313A2231223B47525F504F525F4445464543544F7C733A31313A22454C454354524F4E494341223B47525F554E4944414445535F4D494E494D41535F494D5052494D49527C733A313A2231223B4752455F464F524D41544F5F494D50524553494F4E5F4445464543544F7C733A323A224134223B47524D5F504C414E54494C4C415F52454D4953494F4E7C733A333A22504446223B50524F4345534F5F414E54494349504F537C733A313A2230223B5449504F5F50524543494F7C733A383A22554E49544152494F223B53554E41545F4449524543544F7C733A313A2231223B504C414E54494C4C415F52454D4953494F4E7C733A343A22574F5244223B524553554D454E5F4155544F7C733A313A2230223B);

-- ----------------------------
-- Table structure for ciudades
-- ----------------------------
DROP TABLE IF EXISTS `ciudades`;
CREATE TABLE `ciudades`  (
  `ciudad_id` bigint NOT NULL AUTO_INCREMENT,
  `subId_ubigeo` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ciudad_nombre` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `estado_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`ciudad_id`) USING BTREE,
  INDEX `ciudad_pk_1_idx`(`estado_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 198 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ciudades
-- ----------------------------
INSERT INTO `ciudades` VALUES (1, '01', 'Chachapoyas', 1);
INSERT INTO `ciudades` VALUES (2, '02', 'Bagua', 1);
INSERT INTO `ciudades` VALUES (3, '03', 'Bongará', 1);
INSERT INTO `ciudades` VALUES (4, '04', 'Condorcanqui', 1);
INSERT INTO `ciudades` VALUES (5, '05', 'Luya', 1);
INSERT INTO `ciudades` VALUES (6, '06', 'Rodríguez de Mendoza', 1);
INSERT INTO `ciudades` VALUES (7, '07', 'Utcubamba', 1);
INSERT INTO `ciudades` VALUES (8, '01', 'Huaraz', 2);
INSERT INTO `ciudades` VALUES (9, '02', 'Aija', 2);
INSERT INTO `ciudades` VALUES (10, '03', 'Antonio Raymondi', 2);
INSERT INTO `ciudades` VALUES (11, '04', 'Asunción', 2);
INSERT INTO `ciudades` VALUES (12, '05', 'Bolognesi', 2);
INSERT INTO `ciudades` VALUES (13, '06', 'Carhuaz', 2);
INSERT INTO `ciudades` VALUES (14, '07', 'Carlos Fermín Fitzcarrald', 2);
INSERT INTO `ciudades` VALUES (15, '08', 'Casma', 2);
INSERT INTO `ciudades` VALUES (16, '09', 'Corongo', 2);
INSERT INTO `ciudades` VALUES (17, '10', 'Huari', 2);
INSERT INTO `ciudades` VALUES (18, '11', 'Huarmey', 2);
INSERT INTO `ciudades` VALUES (19, '12', 'Huaylas', 2);
INSERT INTO `ciudades` VALUES (20, '13', 'Mariscal Luzuriaga', 2);
INSERT INTO `ciudades` VALUES (21, '14', 'Ocros', 2);
INSERT INTO `ciudades` VALUES (22, '15', 'Pallasca', 2);
INSERT INTO `ciudades` VALUES (23, '16', 'Pomabamba', 2);
INSERT INTO `ciudades` VALUES (24, '17', 'Recuay', 2);
INSERT INTO `ciudades` VALUES (25, '18', 'Santa', 2);
INSERT INTO `ciudades` VALUES (26, '19', 'Sihuas', 2);
INSERT INTO `ciudades` VALUES (27, '20', 'Yungay', 2);
INSERT INTO `ciudades` VALUES (28, '01', 'Abancay', 3);
INSERT INTO `ciudades` VALUES (29, '02', 'Andahuaylas', 3);
INSERT INTO `ciudades` VALUES (30, '03', 'Antabamba', 3);
INSERT INTO `ciudades` VALUES (31, '04', 'Aymaraes', 3);
INSERT INTO `ciudades` VALUES (32, '05', 'Cotabambas', 3);
INSERT INTO `ciudades` VALUES (33, '06', 'Chincheros', 3);
INSERT INTO `ciudades` VALUES (34, '07', 'Grau', 3);
INSERT INTO `ciudades` VALUES (35, '01', 'Arequipa', 4);
INSERT INTO `ciudades` VALUES (36, '02', 'Camaná', 4);
INSERT INTO `ciudades` VALUES (37, '03', 'Caravelí', 4);
INSERT INTO `ciudades` VALUES (38, '04', 'Castilla', 4);
INSERT INTO `ciudades` VALUES (39, '05', 'Caylloma', 4);
INSERT INTO `ciudades` VALUES (40, '06', 'Condesuyos', 4);
INSERT INTO `ciudades` VALUES (41, '07', 'Islay', 4);
INSERT INTO `ciudades` VALUES (42, '08', 'La Uniòn', 4);
INSERT INTO `ciudades` VALUES (43, '01', 'Huamanga', 5);
INSERT INTO `ciudades` VALUES (44, '02', 'Cangallo', 5);
INSERT INTO `ciudades` VALUES (45, '03', 'Huanca Sancos', 5);
INSERT INTO `ciudades` VALUES (46, '04', 'Huanta', 5);
INSERT INTO `ciudades` VALUES (47, '05', 'La Mar', 5);
INSERT INTO `ciudades` VALUES (48, '06', 'Lucanas', 5);
INSERT INTO `ciudades` VALUES (49, '07', 'Parinacochas', 5);
INSERT INTO `ciudades` VALUES (50, '08', 'Pàucar del Sara Sara ', 5);
INSERT INTO `ciudades` VALUES (51, '09', 'Sucre', 5);
INSERT INTO `ciudades` VALUES (52, '10', 'Víctor Fajardo', 5);
INSERT INTO `ciudades` VALUES (53, '11', 'Vilcas Huamán', 5);
INSERT INTO `ciudades` VALUES (54, '01', 'Cajamarca', 6);
INSERT INTO `ciudades` VALUES (55, '02', 'Cajabamba', 6);
INSERT INTO `ciudades` VALUES (56, '03', 'Celendín', 6);
INSERT INTO `ciudades` VALUES (57, '04', 'Chota', 6);
INSERT INTO `ciudades` VALUES (58, '05', 'Contumazá', 6);
INSERT INTO `ciudades` VALUES (59, '06', 'Cutervo', 6);
INSERT INTO `ciudades` VALUES (60, '07', 'Hualgayoc', 6);
INSERT INTO `ciudades` VALUES (61, '08', 'Jaén', 6);
INSERT INTO `ciudades` VALUES (62, '09', 'San Ignacio', 6);
INSERT INTO `ciudades` VALUES (63, '10', 'San Marcos', 6);
INSERT INTO `ciudades` VALUES (64, '11', 'San Miguel', 6);
INSERT INTO `ciudades` VALUES (65, '12', 'San Pablo', 6);
INSERT INTO `ciudades` VALUES (66, '13', 'Santa Cruz', 6);
INSERT INTO `ciudades` VALUES (67, '01', 'Prov. Const. del Callao', 7);
INSERT INTO `ciudades` VALUES (68, '01', 'Cusco', 8);
INSERT INTO `ciudades` VALUES (69, '02', 'Acomayo', 8);
INSERT INTO `ciudades` VALUES (70, '03', 'Anta', 8);
INSERT INTO `ciudades` VALUES (71, '04', 'Calca', 8);
INSERT INTO `ciudades` VALUES (72, '05', 'Canas', 8);
INSERT INTO `ciudades` VALUES (73, '06', 'Canchis', 8);
INSERT INTO `ciudades` VALUES (74, '07', 'Chumbivilcas', 8);
INSERT INTO `ciudades` VALUES (75, '08', 'Espinar', 8);
INSERT INTO `ciudades` VALUES (76, '09', 'La Convención', 8);
INSERT INTO `ciudades` VALUES (77, '10', 'Paruro', 8);
INSERT INTO `ciudades` VALUES (78, '11', 'Paucartambo', 8);
INSERT INTO `ciudades` VALUES (79, '12', 'Quispicanchi', 8);
INSERT INTO `ciudades` VALUES (80, '13', 'Urubamba', 8);
INSERT INTO `ciudades` VALUES (81, '01', 'Huancavelica', 9);
INSERT INTO `ciudades` VALUES (82, '02', 'Acobamba', 9);
INSERT INTO `ciudades` VALUES (83, '03', 'Angaraes', 9);
INSERT INTO `ciudades` VALUES (84, '04', 'Castrovirreyna', 9);
INSERT INTO `ciudades` VALUES (85, '05', 'Churcampa', 9);
INSERT INTO `ciudades` VALUES (86, '06', 'Huaytará', 9);
INSERT INTO `ciudades` VALUES (87, '07', 'Tayacaja', 9);
INSERT INTO `ciudades` VALUES (88, '01', 'Huánuco', 10);
INSERT INTO `ciudades` VALUES (89, '02', 'Ambo', 10);
INSERT INTO `ciudades` VALUES (90, '03', 'Dos de Mayo', 10);
INSERT INTO `ciudades` VALUES (91, '04', 'Huacaybamba', 10);
INSERT INTO `ciudades` VALUES (92, '05', 'Huamalíes', 10);
INSERT INTO `ciudades` VALUES (93, '06', 'Leoncio Prado', 10);
INSERT INTO `ciudades` VALUES (94, '07', 'Marañón', 10);
INSERT INTO `ciudades` VALUES (95, '08', 'Pachitea', 10);
INSERT INTO `ciudades` VALUES (96, '09', 'Puerto Inca', 10);
INSERT INTO `ciudades` VALUES (97, '10', 'Lauricocha', 10);
INSERT INTO `ciudades` VALUES (98, '11', 'Yarowilca', 10);
INSERT INTO `ciudades` VALUES (99, '01', 'Ica', 11);
INSERT INTO `ciudades` VALUES (100, '02', 'Chincha', 11);
INSERT INTO `ciudades` VALUES (101, '03', 'Nazca', 11);
INSERT INTO `ciudades` VALUES (102, '04', 'Palpa', 11);
INSERT INTO `ciudades` VALUES (103, '05', 'Pisco', 11);
INSERT INTO `ciudades` VALUES (104, '01', 'Huancayo', 12);
INSERT INTO `ciudades` VALUES (105, '02', 'Concepción', 12);
INSERT INTO `ciudades` VALUES (106, '03', 'Chanchamayo', 12);
INSERT INTO `ciudades` VALUES (107, '04', 'Jauja', 12);
INSERT INTO `ciudades` VALUES (108, '05', 'Junín', 12);
INSERT INTO `ciudades` VALUES (109, '06', 'Satipo', 12);
INSERT INTO `ciudades` VALUES (110, '07', 'Tarma', 12);
INSERT INTO `ciudades` VALUES (111, '08', 'Yauli', 12);
INSERT INTO `ciudades` VALUES (112, '09', 'Chupaca', 12);
INSERT INTO `ciudades` VALUES (113, '01', 'Trujillo', 13);
INSERT INTO `ciudades` VALUES (114, '02', 'Ascope', 13);
INSERT INTO `ciudades` VALUES (115, '03', 'Bolívar', 13);
INSERT INTO `ciudades` VALUES (116, '04', 'Chepén', 13);
INSERT INTO `ciudades` VALUES (117, '05', 'Julcán', 13);
INSERT INTO `ciudades` VALUES (118, '06', 'Otuzco', 13);
INSERT INTO `ciudades` VALUES (119, '07', 'Pacasmayo', 13);
INSERT INTO `ciudades` VALUES (120, '08', 'Pataz', 13);
INSERT INTO `ciudades` VALUES (121, '09', 'Sánchez Carrión', 13);
INSERT INTO `ciudades` VALUES (122, '10', 'Santiago de Chuco', 13);
INSERT INTO `ciudades` VALUES (123, '11', 'Gran Chimú', 13);
INSERT INTO `ciudades` VALUES (124, '12', 'Virú', 13);
INSERT INTO `ciudades` VALUES (125, '01', 'Chiclayo', 14);
INSERT INTO `ciudades` VALUES (126, '02', 'Ferreñafe', 14);
INSERT INTO `ciudades` VALUES (127, '03', 'Lambayeque', 14);
INSERT INTO `ciudades` VALUES (128, '01', 'Lima', 15);
INSERT INTO `ciudades` VALUES (129, '02', 'Barranca', 15);
INSERT INTO `ciudades` VALUES (130, '03', 'Cajatambo', 15);
INSERT INTO `ciudades` VALUES (131, '04', 'Canta', 15);
INSERT INTO `ciudades` VALUES (132, '05', 'Cañete', 15);
INSERT INTO `ciudades` VALUES (133, '06', 'Huaral', 15);
INSERT INTO `ciudades` VALUES (134, '07', 'Huarochirí', 15);
INSERT INTO `ciudades` VALUES (135, '08', 'Huaura', 15);
INSERT INTO `ciudades` VALUES (136, '09', 'Oyón', 15);
INSERT INTO `ciudades` VALUES (137, '10', 'Yauyos', 15);
INSERT INTO `ciudades` VALUES (138, '01', 'Maynas', 16);
INSERT INTO `ciudades` VALUES (139, '02', 'Alto Amazonas', 16);
INSERT INTO `ciudades` VALUES (140, '03', 'Loreto', 16);

-- ----------------------------
-- Table structure for cliente
-- ----------------------------
DROP TABLE IF EXISTS `cliente`;
CREATE TABLE `cliente`  (
  `id_cliente` bigint NOT NULL AUTO_INCREMENT,
  `id_alias` int NULL DEFAULT NULL,
  `tipo_cliente` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '0' COMMENT '0 = natural; 1 = juridica',
  `identificacion` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ruc` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `razon_social` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nombres` varchar(225) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `apellido_paterno` varchar(225) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `apellido_materno` varchar(225) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `direccion` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `email` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `grupo_id` bigint NULL DEFAULT NULL,
  `pagina_web` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `telefono1` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nota` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `cliente_status` tinyint(1) NULL DEFAULT 1,
  `status_sunat` tinyint(1) NULL DEFAULT 1 COMMENT '0 = baja segun sunat ; 1 = activo segun sunat ; 2= no validado por sunat ',
  `tipodocumento_represent` tinyint NOT NULL DEFAULT 0 COMMENT 'los datos se jalan de la tabla tipo_documento_persona',
  `genero` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `latitud` varchar(225) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `longitud` varchar(225) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `representante_apellido_pat` varchar(225) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `representante_apellido_mat` varchar(225) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `representante_nombre` varchar(225) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `representante_dni` varchar(225) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `agente_retension` tinyint(1) NULL DEFAULT NULL,
  `agente_retension_valor` decimal(18, 2) NULL DEFAULT NULL,
  `linea_credito` decimal(18, 2) NULL DEFAULT NULL,
  `ciudad_ubigeo` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tipo_id` bigint NOT NULL,
  `eliminado` tinyint NOT NULL DEFAULT 1,
  `created_at` datetime NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id_cliente`) USING BTREE,
  INDEX `cliente_fk_1_idx`(`grupo_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cliente
-- ----------------------------
INSERT INTO `cliente` VALUES (1, 0, '1', '11111111', '1', 'Cliente frecuente', 'Cliente frecuente', '', NULL, NULL, '', 1, NULL, '', NULL, 1, 2, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, 1, NULL);
INSERT INTO `cliente` VALUES (2, 0, '1', '70798865', '1', 'HUALLIPE MAMANI WILBER', 'HUALLIPE MAMANI WILBER', ' ', NULL, NULL, '', 1, NULL, '', NULL, 1, 2, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, 1, '2023-02-14 14:05:50');
INSERT INTO `cliente` VALUES (3, 0, '1', '77670689', '1', 'SOLIS GOMEZ PAOLO FRANCIS', 'SOLIS GOMEZ PAOLO FRANCIS', ' ', NULL, NULL, '', 1, NULL, '', NULL, 1, 2, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, 1, '2023-02-14 14:34:54');
INSERT INTO `cliente` VALUES (4, 0, '3', '20454713061', '2', 'CONSORCIO JM S.A.C.', NULL, NULL, NULL, 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', '', 1, NULL, '', NULL, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '', 0, 1, '2023-02-15 09:47:13');

-- ----------------------------
-- Table structure for cliente_alias
-- ----------------------------
DROP TABLE IF EXISTS `cliente_alias`;
CREATE TABLE `cliente_alias`  (
  `id_alias` int NOT NULL AUTO_INCREMENT,
  `codigointerno` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'codigo interno alternativo',
  `alias` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `id_tipodocumento` int NULL DEFAULT NULL COMMENT 'Este valor se extrae desde la tabla diccionario de terminos grupo 1',
  `numerodocumento` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `categoria_id` int NULL DEFAULT NULL,
  `telefono` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `correo` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `estado` bigint NULL DEFAULT 1 COMMENT '1 = activo; 0 = inactivo; 2=suspendido x pago',
  `eliminado` tinyint(1) NULL DEFAULT 1 COMMENT '1= vigente; 0 = eliminado',
  `create_at` datetime NULL DEFAULT NULL COMMENT 'fecha creacion',
  `auto` tinyint(1) NULL DEFAULT 0 COMMENT '1 = autogenerado; 0 = creado',
  PRIMARY KEY (`id_alias`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cliente_alias
-- ----------------------------

-- ----------------------------
-- Table structure for cliente_categoria
-- ----------------------------
DROP TABLE IF EXISTS `cliente_categoria`;
CREATE TABLE `cliente_categoria`  (
  `id_categoria` bigint NOT NULL,
  `nombre_categoria` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_categoria`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cliente_categoria
-- ----------------------------
INSERT INTO `cliente_categoria` VALUES (1, 'PROSPECTO');
INSERT INTO `cliente_categoria` VALUES (2, 'CLIENTE');

-- ----------------------------
-- Table structure for cliente_entrega
-- ----------------------------
DROP TABLE IF EXISTS `cliente_entrega`;
CREATE TABLE `cliente_entrega`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int NOT NULL,
  `direccion` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `estado` int NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cliente_entrega
-- ----------------------------

-- ----------------------------
-- Table structure for cliente_sucursal
-- ----------------------------
DROP TABLE IF EXISTS `cliente_sucursal`;
CREATE TABLE `cliente_sucursal`  (
  `id_sucursal` bigint NOT NULL AUTO_INCREMENT,
  `id_cliente` bigint NULL DEFAULT NULL,
  `id_zona` bigint NULL DEFAULT NULL,
  `tipo` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `referencia` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nombre_sucursal` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `direccion` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ubigeo` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT 'codigo de ubigeo de la sucursal',
  `latitud` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `longitud` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_sucursal`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cliente_sucursal
-- ----------------------------

-- ----------------------------
-- Table structure for cliente_tipo
-- ----------------------------
DROP TABLE IF EXISTS `cliente_tipo`;
CREATE TABLE `cliente_tipo`  (
  `id_tipo` bigint NOT NULL,
  `nombre_tipo` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status_tipo` smallint NULL DEFAULT NULL,
  `eliminado` tinyint NOT NULL DEFAULT 1,
  `fecha_eliminado` datetime NULL DEFAULT NULL,
  `fecha_created` datetime NOT NULL,
  PRIMARY KEY (`id_tipo`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cliente_tipo
-- ----------------------------
INSERT INTO `cliente_tipo` VALUES (1, 'GENERAL', 1, 1, NULL, '0000-00-00 00:00:00');
INSERT INTO `cliente_tipo` VALUES (2, 'MARKET', 1, 1, NULL, '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for columnas
-- ----------------------------
DROP TABLE IF EXISTS `columnas`;
CREATE TABLE `columnas`  (
  `nombre_columna` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nombre_join` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nombre_mostrar` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tabla` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `mostrar` tinyint(1) NULL DEFAULT 1,
  `activo` tinyint(1) NULL DEFAULT 1,
  `id_columna` bigint NOT NULL AUTO_INCREMENT,
  `orden` int NOT NULL,
  `excel_requerido` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `excel_descripcion` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `excel_color` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '31869B',
  PRIMARY KEY (`id_columna`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 70 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of columnas
-- ----------------------------
INSERT INTO `columnas` VALUES ('producto_id', 'producto_id', 'ID', 'producto', 0, 0, 35, 0, 'opcional', NULL, '31869B');
INSERT INTO `columnas` VALUES ('producto_codigo_barra', 'producto_codigo_barra', 'Código de barra', 'producto', 0, 0, 36, 2, 'opcional', 'De no asignar un código, el Sistema lo autogenerará', '31869B');
INSERT INTO `columnas` VALUES ('producto_nombre', 'producto_nombre', 'Nombre', 'producto', 1, 1, 37, 3, 'obligatorio', 'Nombre que irá en el comprobante electrónico', 'F79646');
INSERT INTO `columnas` VALUES ('producto_descripcion', 'producto_descripcion', 'Descripción', 'producto', 0, 0, 38, 4, 'opcional', 'Nombre opcional para reconocimiento interno', '31869B');
INSERT INTO `columnas` VALUES ('producto_marca', 'nombre_marca', 'Marca', 'producto', 0, 0, 39, 4, 'opcional', 'No aparece en el comprob. Electr.', '31869B');
INSERT INTO `columnas` VALUES ('produto_grupo', 'nombre_grupo', 'Grupo', 'producto', 0, 0, 40, 5, 'opcional', 'No aparece en el comprob. Electr.', '31869B');
INSERT INTO `columnas` VALUES ('producto_familia', 'nombre_familia', 'Familia', 'producto', 0, 0, 41, 6, 'opcional', 'No aparece en el comprob. Electr.', '31869B');
INSERT INTO `columnas` VALUES ('producto_linea', 'nombre_linea', 'Línea', 'producto', 0, 0, 42, 7, 'opcional', 'No aparece en el comprob. Electr.', '31869B');
INSERT INTO `columnas` VALUES ('producto_modelo', 'producto_modelo', 'Modelo', 'producto', 0, 0, 43, 8, 'opcional', 'No aparece en el comprob. Electr.', '31869B');
INSERT INTO `columnas` VALUES ('producto_proveedor', 'proveedor_nombre', 'Proveedor', 'producto', 0, 0, 53, 9, 'opcional', 'No aparece en el comprob. Electr.', '31869B');
INSERT INTO `columnas` VALUES ('producto_stockminimo', 'producto_stockminimo', 'Stock mínimo', 'producto', 0, 0, 54, 10, 'opcional', 'No aparece en el comprob. Electr.', '31869B');
INSERT INTO `columnas` VALUES ('producto_impuesto', 'nombre_impuesto', 'Impuesto', 'producto', 1, 1, 55, 12, 'obligatorio', '¿Qué impuesto?  Precisar : IGV?', '31869B');
INSERT INTO `columnas` VALUES ('producto_largo', 'producto_largo', 'Largo', 'producto', 0, 0, 56, 14, 'opcional', NULL, '31869B');
INSERT INTO `columnas` VALUES ('producto_ancho', 'producto_ancho', 'Ancho', 'producto', 0, 0, 57, 15, 'opcional', NULL, '31869B');
INSERT INTO `columnas` VALUES ('producto_alto', 'producto_alto', 'Alto', 'producto', 0, 0, 58, 16, 'opcional', NULL, '31869B');
INSERT INTO `columnas` VALUES ('producto_peso', 'producto_peso', 'Peso', 'producto', 0, 0, 59, 17, 'opcional', NULL, '31869B');
INSERT INTO `columnas` VALUES ('producto_nota', 'producto_nota', 'Nota', 'producto', 0, 0, 60, 17, 'opcional', NULL, '31869B');
INSERT INTO `columnas` VALUES ('producto_cualidad', 'producto_cualidad', 'Cualidad', 'producto', 1, 1, 61, 12, 'obligatorio', 'Medible: Unidades contalbles, Pesable: KG. (¿MEDIBLE ó PESABLE?)', '31869B');
INSERT INTO `columnas` VALUES ('producto_codigo_interno', 'producto_codigo_interno', 'Código interno', 'producto', 1, 1, 62, 1, 'opcional', 'De no asignar un código, el Sistema lo autogenerará', 'F79646');
INSERT INTO `columnas` VALUES ('producto_titulo_imagen', 'producto_titulo_imagen', 'Titulo Imagen', 'producto', 0, 0, 63, 19, 'opcional', NULL, '31869B');
INSERT INTO `columnas` VALUES ('producto_descripcion_img', 'producto_descripcion_img', 'Descripcion Imagen', 'producto', 0, 0, 64, 20, 'opcional', NULL, '31869B');
INSERT INTO `columnas` VALUES ('producto_vencimiento', 'producto_vencimiento', 'Fecha de Vencimiento', 'producto', 0, 0, 66, 14, 'opcional', NULL, '31869B');
INSERT INTO `columnas` VALUES ('producto_afectacion_impuesto', 'producto_afectacion_impuesto', 'Afectación del impuesto', 'producto', 1, 1, 67, 11, 'obligatorio', 'Precisar si su producto esta: Gravable/Exonerada/Inafecta', '31869B');
INSERT INTO `columnas` VALUES ('stock', 'stock', 'Control de Inventario', 'producto', 1, 1, 68, 14, 'obligatorio', '¿Dese controlar stock? SI=1/NO=0', '31869B');
INSERT INTO `columnas` VALUES ('producto_estado', 'producto_estado', 'Estado', 'producto', 1, 1, 69, 15, 'obligatorio', '1=activo \n0=inactivo', '31869B');

-- ----------------------------
-- Table structure for compra_anticipo_temporal
-- ----------------------------
DROP TABLE IF EXISTS `compra_anticipo_temporal`;
CREATE TABLE `compra_anticipo_temporal`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `idAnticipo` int NOT NULL,
  `idCompra` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `importeAnticipo` decimal(18, 2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of compra_anticipo_temporal
-- ----------------------------

-- ----------------------------
-- Table structure for condiciones_pago
-- ----------------------------
DROP TABLE IF EXISTS `condiciones_pago`;
CREATE TABLE `condiciones_pago`  (
  `id_condiciones` bigint NOT NULL AUTO_INCREMENT,
  `nombre_condiciones` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status_condiciones` tinyint(1) NULL DEFAULT 1,
  `dias` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_condiciones`, `nombre_condiciones`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of condiciones_pago
-- ----------------------------
INSERT INTO `condiciones_pago` VALUES (1, 'Contado', 1, 0);
INSERT INTO `condiciones_pago` VALUES (2, 'Crédito', 1, 30);

-- ----------------------------
-- Table structure for configuraciones
-- ----------------------------
DROP TABLE IF EXISTS `configuraciones`;
CREATE TABLE `configuraciones`  (
  `config_id` bigint NOT NULL AUTO_INCREMENT,
  `config_key` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `config_value` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  INDEX `config_id`(`config_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 86 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of configuraciones
-- ----------------------------
INSERT INTO `configuraciones` VALUES (1, 'EMPRESA_NOMBRE', 'AMBIENTE EN BLANCO');
INSERT INTO `configuraciones` VALUES (2, 'EMPRESA_DIRECCION', '');
INSERT INTO `configuraciones` VALUES (3, 'EMPRESA_TELEFONO', '');
INSERT INTO `configuraciones` VALUES (4, 'VENTA_DEFAULT', 'NOMBRE');
INSERT INTO `configuraciones` VALUES (5, 'INICIAL_PORCENTAJE_VTA_CRED', '0');
INSERT INTO `configuraciones` VALUES (7, 'TASA_INTERES', '0');
INSERT INTO `configuraciones` VALUES (8, 'DATABASE_IP', NULL);
INSERT INTO `configuraciones` VALUES (9, 'DATABASE_NAME', NULL);
INSERT INTO `configuraciones` VALUES (10, 'DATABASE_USERNAME', NULL);
INSERT INTO `configuraciones` VALUES (11, 'MODIFICADOR_PRECIO', 'SI');
INSERT INTO `configuraciones` VALUES (12, 'CODIGO_DEFAULT', 'INTERNO');
INSERT INTO `configuraciones` VALUES (13, 'VALOR_UNICO', 'NOMBRE');
INSERT INTO `configuraciones` VALUES (14, 'PRODUCTO_SERIE', '0');
INSERT INTO `configuraciones` VALUES (15, 'MAXIMO_CUOTAS_CREDITO', '24');
INSERT INTO `configuraciones` VALUES (16, 'GENERAR_FACTURACION', 'SI');
INSERT INTO `configuraciones` VALUES (17, 'PAGOS_ANTICIPADOS', NULL);
INSERT INTO `configuraciones` VALUES (18, 'ADELANTO_PAGO_CUOTA', '0');
INSERT INTO `configuraciones` VALUES (19, 'FACTURAR_INGRESO', 'NO');
INSERT INTO `configuraciones` VALUES (20, 'VISTA_CREDITO', 'AVANZADO');
INSERT INTO `configuraciones` VALUES (21, 'PRECIO_BASE', 'COSTO');
INSERT INTO `configuraciones` VALUES (22, 'CONTABLE_COSTO', 'NO');
INSERT INTO `configuraciones` VALUES (23, 'VENTAS_COBRAR', 'NO');
INSERT INTO `configuraciones` VALUES (24, 'PRECIO_DE_VENTA', 'MANUAL');
INSERT INTO `configuraciones` VALUES (25, 'PRECIO_DE_VENTA', 'MANUAL');
INSERT INTO `configuraciones` VALUES (26, 'BUSCAR_PRODUCTOS_VENTA', 'NOMBRE');
INSERT INTO `configuraciones` VALUES (27, 'PRECIO_INGRESO', 'COSTO');
INSERT INTO `configuraciones` VALUES (28, 'ACTIVAR_FACTURACION_VENTA', '0');
INSERT INTO `configuraciones` VALUES (29, 'ACTIVAR_FACTURACION_INGRESO', '0');
INSERT INTO `configuraciones` VALUES (30, 'ACTIVAR_SHADOW', '0');
INSERT INTO `configuraciones` VALUES (31, 'INGRESO_COSTO', '0');
INSERT INTO `configuraciones` VALUES (32, 'INGRESO_UTILIDAD', '0');
INSERT INTO `configuraciones` VALUES (33, 'CREDITO_INICIAL', '0');
INSERT INTO `configuraciones` VALUES (34, 'CREDITO_TASA', '0');
INSERT INTO `configuraciones` VALUES (35, 'CREDITO_CUOTAS', '24');
INSERT INTO `configuraciones` VALUES (36, 'COSTO_AUMENTO', NULL);
INSERT INTO `configuraciones` VALUES (37, 'INCORPORAR_IGV', '0');
INSERT INTO `configuraciones` VALUES (38, 'COBRAR_CAJA', '0');
INSERT INTO `configuraciones` VALUES (39, 'COTIZACION_INFORMACION', 'Año del dialogo y la reconciliación');
INSERT INTO `configuraciones` VALUES (40, 'COTIZACION_CONDICION', 'Cte. Dolares: 193-XXXXXXX (Banco de Crédito - BCP)<br>Cte. Soles: 194-XX-XXXXXXX (Banco de Crédito - BCP)<br> Este documento compromete al cliente a mantener en estricta reserva verbal o escrita.');
INSERT INTO `configuraciones` VALUES (41, 'COTIZACION_PIE_PAGINA', '<a target=\"_blank\" rel=\"nofollow\" href=\"https://www.tupagina.pe/\">https://www.tupagina.pe/</a>');
INSERT INTO `configuraciones` VALUES (42, 'COMPROBANTE', '0');
INSERT INTO `configuraciones` VALUES (43, 'EMPRESA_IDENTIFICACION', '');
INSERT INTO `configuraciones` VALUES (44, 'FACTURACION', '1');
INSERT INTO `configuraciones` VALUES (45, 'EMPRESA_CORREO', '');
INSERT INTO `configuraciones` VALUES (46, 'EMPRESA_CONTACTO', '');
INSERT INTO `configuraciones` VALUES (47, 'HOST_IMPRESION', NULL);
INSERT INTO `configuraciones` VALUES (48, 'EMPRESA_LOGO', '');
INSERT INTO `configuraciones` VALUES (55, 'DOCUMENTO_DEFECTO', '6');
INSERT INTO `configuraciones` VALUES (56, 'BOTONES_VENTA', '[\"1\",\"0\",\"1\",\"0\"]');
INSERT INTO `configuraciones` VALUES (57, 'NOMBRE_PRODUCTO', '[\"0\",\"0\",\"0\",\"0\",\"0\",\"0\"]');
INSERT INTO `configuraciones` VALUES (60, 'COTIZACION_COLOR_FORMATO', '[\"#f00\",\"#010911\"]');
INSERT INTO `configuraciones` VALUES (61, 'EMBALAJE_IMPRESION', '1');
INSERT INTO `configuraciones` VALUES (62, 'NUMERO_DECIMALES', '2');
INSERT INTO `configuraciones` VALUES (63, 'VALOR_COMPROBANTE', 'NOMBRE');
INSERT INTO `configuraciones` VALUES (64, 'REDONDEO_VENTAS', '0');
INSERT INTO `configuraciones` VALUES (67, 'POPUP_CAMBIOS', 'SI');
INSERT INTO `configuraciones` VALUES (68, 'TIPO_IMPRECION', 'T');
INSERT INTO `configuraciones` VALUES (69, 'TRASPASO', 'AUTO');
INSERT INTO `configuraciones` VALUES (75, 'GR_ACTIVACION_ELECTRONICA', '1');
INSERT INTO `configuraciones` VALUES (76, 'GR_ACTIVACION_MANUAL', '1');
INSERT INTO `configuraciones` VALUES (77, 'GR_POR_DEFECTO', 'ELECTRONICA');
INSERT INTO `configuraciones` VALUES (78, 'GR_UNIDADES_MINIMAS_IMPRIMIR', '1');
INSERT INTO `configuraciones` VALUES (79, 'GRE_FORMATO_IMPRESION_DEFECTO', 'A4');
INSERT INTO `configuraciones` VALUES (80, 'GRM_PLANTILLA_REMISION', 'PDF');
INSERT INTO `configuraciones` VALUES (81, 'PROCESO_ANTICIPOS', '0');
INSERT INTO `configuraciones` VALUES (82, 'TIPO_PRECIO', 'UNITARIO');
INSERT INTO `configuraciones` VALUES (83, 'SUNAT_DIRECTO', '1');
INSERT INTO `configuraciones` VALUES (84, 'PLANTILLA_REMISION', 'WORD');
INSERT INTO `configuraciones` VALUES (85, 'RESUMEN_AUTO', '0');

-- ----------------------------
-- Table structure for contado
-- ----------------------------
DROP TABLE IF EXISTS `contado`;
CREATE TABLE `contado`  (
  `id_venta` bigint NOT NULL,
  `status` varchar(13) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `montopagado` decimal(18, 2) NOT NULL,
  PRIMARY KEY (`id_venta`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contado
-- ----------------------------
INSERT INTO `contado` VALUES (1, 'PagoCancelado', 1.00);
INSERT INTO `contado` VALUES (2, 'PagoCancelado', 1.00);
INSERT INTO `contado` VALUES (3, 'PagoCancelado', 2.00);
INSERT INTO `contado` VALUES (4, 'PagoCancelado', 3.00);
INSERT INTO `contado` VALUES (5, 'PagoCancelado', 1.00);
INSERT INTO `contado` VALUES (6, 'PagoCancelado', 4.00);
INSERT INTO `contado` VALUES (7, 'PagoCancelado', 5.00);
INSERT INTO `contado` VALUES (8, 'PagoCancelado', 1.00);
INSERT INTO `contado` VALUES (9, 'PagoCancelado', 1.00);
INSERT INTO `contado` VALUES (10, 'PagoCancelado', 3.00);
INSERT INTO `contado` VALUES (11, 'PagoCancelado', 1700.00);
INSERT INTO `contado` VALUES (12, 'PagoCancelado', 2.00);
INSERT INTO `contado` VALUES (13, 'PagoCancelado', 2.00);
INSERT INTO `contado` VALUES (14, 'PagoCancelado', 2.00);
INSERT INTO `contado` VALUES (15, 'PagoCancelado', 3.00);
INSERT INTO `contado` VALUES (16, 'PagoCancelado', 6.00);
INSERT INTO `contado` VALUES (17, 'PagoCancelado', 4.00);
INSERT INTO `contado` VALUES (18, 'PagoCancelado', 12.00);
INSERT INTO `contado` VALUES (19, 'PagoCancelado', 12.00);
INSERT INTO `contado` VALUES (20, 'PagoCancelado', 8.00);
INSERT INTO `contado` VALUES (21, 'PagoCancelado', 4.00);
INSERT INTO `contado` VALUES (23, 'PagoCancelado', 8.00);
INSERT INTO `contado` VALUES (24, 'PagoCancelado', 5000.00);

-- ----------------------------
-- Table structure for correlativos
-- ----------------------------
DROP TABLE IF EXISTS `correlativos`;
CREATE TABLE `correlativos`  (
  `id_local` int NOT NULL,
  `id_documento` int NOT NULL,
  `serie` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `correlativo` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id_local`, `id_documento`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of correlativos
-- ----------------------------
INSERT INTO `correlativos` VALUES (1, 1, '001', 13);
INSERT INTO `correlativos` VALUES (1, 2, '001', 1);
INSERT INTO `correlativos` VALUES (1, 3, '001', 52);
INSERT INTO `correlativos` VALUES (1, 4, '001', 2);
INSERT INTO `correlativos` VALUES (1, 5, '001', 1);
INSERT INTO `correlativos` VALUES (1, 6, '001', 24);
INSERT INTO `correlativos` VALUES (1, 7, '001', 1);
INSERT INTO `correlativos` VALUES (1, 8, 'N01', 1);
INSERT INTO `correlativos` VALUES (1, 9, 'N01', 1);
INSERT INTO `correlativos` VALUES (1, 10, '001', 1);
INSERT INTO `correlativos` VALUES (1, 11, '001', 1);
INSERT INTO `correlativos` VALUES (1, 12, '001', 1);
INSERT INTO `correlativos` VALUES (1, 13, '001', 1);
INSERT INTO `correlativos` VALUES (1, 14, '001', 1);
INSERT INTO `correlativos` VALUES (1, 15, '001', 1);
INSERT INTO `correlativos` VALUES (1, 16, '001', 2);
INSERT INTO `correlativos` VALUES (1, 18, '002', 4);
INSERT INTO `correlativos` VALUES (1, 19, '001', 1);
INSERT INTO `correlativos` VALUES (2, 1, '001', 1);
INSERT INTO `correlativos` VALUES (2, 2, '001', 1);
INSERT INTO `correlativos` VALUES (2, 3, '001', 1);
INSERT INTO `correlativos` VALUES (2, 4, '001', 1);
INSERT INTO `correlativos` VALUES (2, 5, '001', 1);
INSERT INTO `correlativos` VALUES (2, 6, '001', 1);
INSERT INTO `correlativos` VALUES (2, 7, '001', 1);
INSERT INTO `correlativos` VALUES (2, 8, '001', 1);
INSERT INTO `correlativos` VALUES (2, 9, '001', 1);
INSERT INTO `correlativos` VALUES (2, 10, '001', 1);
INSERT INTO `correlativos` VALUES (2, 11, '001', 1);
INSERT INTO `correlativos` VALUES (2, 12, '001', 1);
INSERT INTO `correlativos` VALUES (2, 13, '001', 1);
INSERT INTO `correlativos` VALUES (2, 14, '001', 1);
INSERT INTO `correlativos` VALUES (2, 15, '001', 1);
INSERT INTO `correlativos` VALUES (2, 16, '001', 1);

-- ----------------------------
-- Table structure for cotizacion
-- ----------------------------
DROP TABLE IF EXISTS `cotizacion`;
CREATE TABLE `cotizacion`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL,
  `local_id` bigint NOT NULL,
  `cliente_id` bigint NOT NULL,
  `vendedor_id` bigint NOT NULL,
  `documento_id` bigint NOT NULL,
  `tipo_pago_id` bigint NOT NULL,
  `moneda_id` bigint NOT NULL,
  `estado` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `impuesto` decimal(18, 2) NOT NULL,
  `subtotal` decimal(18, 2) NOT NULL,
  `total` decimal(18, 2) NOT NULL,
  `tasa_cambio` float NULL DEFAULT 0,
  `credito_periodo` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `periodo_per` int NULL DEFAULT NULL,
  `fecha_entrega` datetime NULL DEFAULT NULL,
  `lugar_entrega` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp,
  `tipo_impuesto` tinyint(1) NULL DEFAULT NULL,
  `nota` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL COMMENT 'Nota de la cotizacion',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cotizacion
-- ----------------------------

-- ----------------------------
-- Table structure for cotizacion_detalles
-- ----------------------------
DROP TABLE IF EXISTS `cotizacion_detalles`;
CREATE TABLE `cotizacion_detalles`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cotizacion_id` bigint NOT NULL,
  `producto_id` bigint NOT NULL,
  `unidad_id` bigint NOT NULL,
  `precio` decimal(18, 8) NOT NULL,
  `cantidad` decimal(18, 2) NOT NULL,
  `cantidad_parcial` decimal(18, 2) NOT NULL,
  `impuesto` decimal(18, 2) NOT NULL DEFAULT 0.00,
  `precio_venta` decimal(18, 8) NULL DEFAULT 0.00000000,
  `descuento` decimal(18, 2) NULL DEFAULT 0.00 COMMENT 'Porcentaje de descuento',
  `afectacion_impuesto` int NULL DEFAULT NULL,
  `gratis` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cotizacion_detalles
-- ----------------------------

-- ----------------------------
-- Table structure for credito
-- ----------------------------
DROP TABLE IF EXISTS `credito`;
CREATE TABLE `credito`  (
  `id_venta` bigint NOT NULL,
  `int_credito_nrocuota` int NOT NULL,
  `dec_credito_montocuota` decimal(18, 2) NOT NULL,
  `var_credito_estado` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `dec_credito_montodebito` decimal(18, 2) NULL DEFAULT 0.00,
  `num_corre` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_moneda` int NULL DEFAULT NULL,
  `tasa_cambio` decimal(4, 2) NULL DEFAULT NULL,
  `fec_emi_compro` date NULL DEFAULT NULL,
  `num_corre_gr` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pago_anticipado` int NULL DEFAULT NULL,
  `fecha_cancelado` datetime NULL DEFAULT NULL,
  `periodo_gracia` int NULL DEFAULT 0,
  `tasa_interes` float NULL DEFAULT 0,
  `respaldo` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_venta`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of credito
-- ----------------------------
INSERT INTO `credito` VALUES (22, 3, 8.00, 'PagoPendiente', 0.00, NULL, 1029, 0.00, NULL, NULL, NULL, NULL, 0, 0, 0);

-- ----------------------------
-- Table structure for credito_cuotas
-- ----------------------------
DROP TABLE IF EXISTS `credito_cuotas`;
CREATE TABLE `credito_cuotas`  (
  `id_credito_cuota` bigint NOT NULL AUTO_INCREMENT,
  `nro_letra` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `numero_unico` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fecha_giro` datetime NULL DEFAULT NULL,
  `fecha_vencimiento` datetime NULL DEFAULT NULL,
  `fecha_corte` datetime NULL DEFAULT current_timestamp,
  `monto` decimal(18, 2) NULL DEFAULT NULL,
  `isgiro` int NULL DEFAULT NULL,
  `id_venta` int NULL DEFAULT NULL,
  `ispagado` int NULL DEFAULT 0,
  `ultimo_pago` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id_credito_cuota`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of credito_cuotas
-- ----------------------------
INSERT INTO `credito_cuotas` VALUES (1, '1 / 3', NULL, '2023-02-24 00:00:00', '2023-03-24 00:00:00', '2023-03-24 00:00:00', 2.67, 0, 22, 0, NULL);
INSERT INTO `credito_cuotas` VALUES (2, '2 / 3', NULL, '2023-02-24 00:00:00', '2023-04-24 00:00:00', '2023-04-24 00:00:00', 2.67, 0, 22, 0, NULL);
INSERT INTO `credito_cuotas` VALUES (3, '3 / 3', NULL, '2023-02-24 00:00:00', '2023-05-24 00:00:00', '2023-05-24 00:00:00', 2.67, 0, 22, 0, NULL);

-- ----------------------------
-- Table structure for credito_cuotas_abono
-- ----------------------------
DROP TABLE IF EXISTS `credito_cuotas_abono`;
CREATE TABLE `credito_cuotas_abono`  (
  `abono_id` bigint NOT NULL AUTO_INCREMENT,
  `credito_cuota_id` bigint NULL DEFAULT NULL,
  `monto_abono` decimal(18, 2) NULL DEFAULT NULL,
  `fecha_abono` datetime NOT NULL,
  `tipo_pago` bigint NULL DEFAULT NULL,
  `monto_restante` decimal(18, 2) NULL DEFAULT NULL,
  `usuario_pago` bigint NULL DEFAULT NULL,
  `banco_id` bigint NULL DEFAULT NULL,
  `nro_operacion` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`abono_id`) USING BTREE,
  INDEX `credito_cuota_id`(`credito_cuota_id` ASC) USING BTREE,
  INDEX `tipo_pago`(`tipo_pago` ASC) USING BTREE,
  INDEX `usuario_pago`(`usuario_pago` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of credito_cuotas_abono
-- ----------------------------

-- ----------------------------
-- Table structure for cronogramapago
-- ----------------------------
DROP TABLE IF EXISTS `cronogramapago`;
CREATE TABLE `cronogramapago`  (
  `nCPagoCodigo` bigint NOT NULL AUTO_INCREMENT,
  `int_cronpago_nrocuota` int NOT NULL,
  `dat_cronpago_fecinicio` date NOT NULL,
  `dat_cronpago_fecpago` date NOT NULL,
  `dec_cronpago_pagocuota` decimal(18, 2) NOT NULL,
  `dec_cronpago_pagorecibido` decimal(18, 2) NULL DEFAULT 0.00,
  `nVenCodigo` bigint NOT NULL,
  PRIMARY KEY (`nCPagoCodigo`) USING BTREE,
  INDEX `cronogramapago_venta_idx`(`nVenCodigo` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cronogramapago
-- ----------------------------

-- ----------------------------
-- Table structure for detalle_venta
-- ----------------------------
DROP TABLE IF EXISTS `detalle_venta`;
CREATE TABLE `detalle_venta`  (
  `id_detalle` bigint NOT NULL AUTO_INCREMENT,
  `id_venta` bigint NULL DEFAULT NULL,
  `id_producto` bigint NULL DEFAULT NULL,
  `precio` decimal(18, 8) NULL DEFAULT 0.00000000,
  `cantidad` decimal(18, 2) NOT NULL DEFAULT 0.00,
  `cantidad_devuelta` decimal(18, 2) NULL DEFAULT NULL,
  `unidad_medida` bigint NULL DEFAULT NULL,
  `detalle_importe` decimal(18, 2) NULL DEFAULT NULL,
  `detalle_costo_promedio` decimal(18, 2) NULL DEFAULT 0.00,
  `detalle_costo_ultimo` decimal(18, 2) NULL DEFAULT 0.00,
  `detalle_utilidad` decimal(18, 2) NULL DEFAULT 0.00,
  `impuesto_id` int NULL DEFAULT NULL,
  `afectacion_impuesto` varchar(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `impuesto_porciento` decimal(18, 2) NULL DEFAULT NULL,
  `precio_venta` decimal(18, 8) NULL DEFAULT 0.00000000,
  `tipo_impuesto_compra` tinyint NULL DEFAULT NULL COMMENT 'tipo de impuesto de la compra: 1=Incluye impuesto, 2=Agregar impuesto, 3=No considerar impuesto',
  `gratis` tinyint(1) NULL DEFAULT 0,
  `descuento` decimal(18, 2) NULL DEFAULT 0.00,
  `cantidad_parcial` decimal(18, 2) NULL DEFAULT NULL,
  `impuesto_bolsa` decimal(18, 2) NOT NULL DEFAULT 0.00,
  `unidades` int NULL DEFAULT 1,
  PRIMARY KEY (`id_detalle`) USING BTREE,
  INDEX `R_9`(`id_venta` ASC) USING BTREE,
  INDEX `transaccion_ibfk_2_idx`(`precio` ASC) USING BTREE,
  INDEX `transaccion_ibfk_3_idx`(`unidad_medida` ASC) USING BTREE,
  INDEX `transaccion_ibfk_4_idx`(`id_producto` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of detalle_venta
-- ----------------------------
INSERT INTO `detalle_venta` VALUES (1, 1, 1, 1.00000000, 1.00, 0.00, 1, 1.00, 0.00, 0.00, 0.00, 1, '1', 18.00, 1.00000000, 1, 0, 0.00, 1.00, 0.00, 1);
INSERT INTO `detalle_venta` VALUES (2, 2, 1, 1.00000000, 1.00, 0.00, 1, 1.00, 0.00, 0.00, 0.00, 1, '1', 18.00, 1.00000000, 1, 0, 0.00, 1.00, 0.00, 1);
INSERT INTO `detalle_venta` VALUES (3, 3, 1, 1.00000000, 2.00, 2.00, 1, 2.00, 0.00, 0.00, 0.00, 1, '1', 18.00, 1.00000000, 1, 0, 0.00, 2.00, 0.00, 1);
INSERT INTO `detalle_venta` VALUES (4, 4, 1, 1.00000000, 3.00, 0.00, 1, 3.00, 0.00, 0.00, 0.00, 1, '1', 18.00, 1.00000000, 1, 0, 0.00, 3.00, 0.00, 1);
INSERT INTO `detalle_venta` VALUES (5, 5, 1, 1.00000000, 1.00, 0.00, 1, 1.00, 0.00, 0.00, 0.00, 1, '1', 18.00, 1.00000000, 1, 0, 0.00, 0.00, 0.00, 1);
INSERT INTO `detalle_venta` VALUES (6, 6, 1, 1.00000000, 4.00, 4.00, 1, 4.00, 0.00, 0.00, 0.00, 1, '1', 18.00, 1.00000000, 1, 0, 0.00, 4.00, 0.00, 1);
INSERT INTO `detalle_venta` VALUES (7, 7, 1, 1.00000000, 5.00, 0.00, 1, 5.00, 0.00, 0.00, 0.00, 1, '1', 18.00, 1.00000000, 1, 0, 0.00, 5.00, 0.00, 1);
INSERT INTO `detalle_venta` VALUES (8, 8, 1, 1.00000000, 1.00, 0.00, 1, 1.00, 0.00, 0.00, 0.00, 1, '1', 18.00, 1.00000000, 1, 0, 0.00, 1.00, 0.00, 1);
INSERT INTO `detalle_venta` VALUES (9, 9, 1, 1.00000000, 1.00, 0.00, 1, 1.00, 0.00, 0.00, 0.00, 1, '1', 18.00, 1.00000000, 1, 0, 0.00, 1.00, 0.00, 1);
INSERT INTO `detalle_venta` VALUES (10, 10, 1, 1.00000000, 3.00, 0.00, 1, 3.00, 0.00, 0.00, 0.00, 1, '1', 18.00, 1.00000000, 1, 0, 0.00, 0.00, 0.00, 1);
INSERT INTO `detalle_venta` VALUES (11, 11, 2, 85.00000000, 20.00, 20.00, 1, 1700.00, 0.00, 0.00, 0.00, 1, '1', 18.00, 85.00000000, NULL, 0, 0.00, 20.00, 0.00, 1);
INSERT INTO `detalle_venta` VALUES (12, 12, 2, 2.00000000, 1.00, 1.00, 1, 2.00, 0.00, 0.00, 0.00, 1, '1', 18.00, 2.00000000, NULL, 0, 0.00, 0.00, 0.00, 1);
INSERT INTO `detalle_venta` VALUES (13, 13, 2, 2.00000000, 1.00, 0.00, 1, 2.00, 0.00, 0.00, 0.00, 1, '1', 18.00, 2.00000000, NULL, 0, 0.00, 0.00, 0.00, 1);
INSERT INTO `detalle_venta` VALUES (14, 14, 2, 2.00000000, 1.00, 0.00, 1, 2.00, 0.00, 0.00, 0.00, 1, '1', 18.00, 2.00000000, NULL, 0, 0.00, 1.00, 0.00, 1);
INSERT INTO `detalle_venta` VALUES (15, 15, 1, 1.00000000, 1.00, 0.00, 1, 1.00, 0.00, 0.00, 0.00, 1, '1', 18.00, 1.00000000, 1, 0, 0.00, 1.00, 0.00, 1);
INSERT INTO `detalle_venta` VALUES (16, 15, 2, 2.00000000, 1.00, 0.00, 1, 2.00, 0.00, 0.00, 0.00, 1, '1', 18.00, 2.00000000, NULL, 0, 0.00, 1.00, 0.00, 1);
INSERT INTO `detalle_venta` VALUES (17, 16, 1, 1.00000000, 2.00, 0.00, 1, 2.00, 0.00, 0.00, 0.00, 1, '1', 18.00, 1.00000000, 1, 0, 0.00, 2.00, 0.00, 1);
INSERT INTO `detalle_venta` VALUES (18, 16, 2, 2.00000000, 2.00, 0.00, 1, 4.00, 0.00, 0.00, 0.00, 1, '1', 18.00, 2.00000000, NULL, 0, 0.00, 2.00, 0.00, 1);
INSERT INTO `detalle_venta` VALUES (19, 17, 2, 2.00000000, 2.00, 0.00, 1, 4.00, 1.00, 1.00, 0.00, 1, '1', 18.00, 2.00000000, 1, 0, 0.00, 0.00, 0.00, 1);
INSERT INTO `detalle_venta` VALUES (20, 18, 3, 4.00000000, 3.00, 0.00, 1, 12.00, 0.50, 0.50, 0.00, 1, '1', 18.00, 4.00000000, 1, 0, 0.00, 0.00, 0.00, 1);
INSERT INTO `detalle_venta` VALUES (21, 19, 3, 4.00000000, 3.00, 3.00, 1, 12.00, 0.50, 0.50, 0.00, 1, '1', 18.00, 4.00000000, 1, 0, 0.00, 3.00, 0.00, 1);
INSERT INTO `detalle_venta` VALUES (22, 20, 3, 4.00000000, 2.00, 0.00, 1, 8.00, 0.50, 0.50, 0.00, 1, '1', 18.00, 4.00000000, 1, 0, 0.00, 2.00, 0.00, 1);
INSERT INTO `detalle_venta` VALUES (23, 21, 2, 2.00000000, 2.00, 0.00, 1, 4.00, 1.00, 1.00, 0.00, 1, '1', 18.00, 2.00000000, 1, 0, 0.00, 2.00, 0.00, 1);
INSERT INTO `detalle_venta` VALUES (24, 22, 3, 4.00000000, 2.00, 0.00, 1, 8.00, 0.50, 0.50, 0.00, 1, '1', 18.00, 4.00000000, 1, 0, 0.00, 2.00, 0.00, 1);
INSERT INTO `detalle_venta` VALUES (25, 23, 3, 4.00000000, 2.00, 0.00, 1, 8.00, 0.50, 0.50, 0.00, 1, '1', 18.00, 4.00000000, 1, 0, 0.00, 2.00, 0.00, 1);
INSERT INTO `detalle_venta` VALUES (26, 24, 2, 5000.00000000, 1.00, 0.00, 1, 5000.00, 1.00, 1.00, 0.00, 1, '1', 18.00, 5000.00000000, 1, 0, 0.00, 1.00, 0.00, 1);

-- ----------------------------
-- Table structure for detalleingreso
-- ----------------------------
DROP TABLE IF EXISTS `detalleingreso`;
CREATE TABLE `detalleingreso`  (
  `id_detalle_ingreso` bigint NOT NULL AUTO_INCREMENT,
  `id_ingreso` bigint NULL DEFAULT NULL,
  `id_producto` bigint NULL DEFAULT NULL,
  `cantidad` decimal(18, 2) NULL DEFAULT NULL,
  `precio` decimal(18, 2) NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT 1,
  `unidad_medida` bigint NULL DEFAULT NULL,
  `total_detalle` decimal(20, 2) NULL DEFAULT NULL,
  `precio_venta` decimal(18, 2) NULL DEFAULT 0.00,
  `impuesto_id` int NULL DEFAULT NULL,
  `impuesto_porciento` decimal(18, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id_detalle_ingreso`) USING BTREE,
  INDEX `DetalleOrdenCompraFKOrdenCompra_idx`(`id_ingreso` ASC) USING BTREE,
  INDEX `fk_detalle_ingreso2_idx`(`id_producto` ASC) USING BTREE,
  INDEX `fk_detalle_ingreso3_idx`(`unidad_medida` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of detalleingreso
-- ----------------------------
INSERT INTO `detalleingreso` VALUES (1, 1, 2, 1.00, 1.00, 1, 1, 1.00, 0.00, 1, 18.00);
INSERT INTO `detalleingreso` VALUES (2, 2, 3, 100.00, 0.50, 1, 1, 50.00, 0.00, 1, 18.00);

-- ----------------------------
-- Table structure for detalleingreso_contable
-- ----------------------------
DROP TABLE IF EXISTS `detalleingreso_contable`;
CREATE TABLE `detalleingreso_contable`  (
  `id_detalle_ingreso` bigint NOT NULL AUTO_INCREMENT,
  `id_ingreso` bigint NULL DEFAULT NULL,
  `id_producto` bigint NULL DEFAULT NULL,
  `cantidad` decimal(18, 2) NULL DEFAULT NULL,
  `precio` decimal(18, 2) NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT 1,
  `unidad_medida` bigint NULL DEFAULT NULL,
  `total_detalle` decimal(20, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id_detalle_ingreso`) USING BTREE,
  INDEX `id_ingreso`(`id_ingreso` ASC) USING BTREE,
  INDEX `id_producto`(`id_producto` ASC) USING BTREE,
  INDEX `unidad_medida`(`unidad_medida` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of detalleingreso_contable
-- ----------------------------

-- ----------------------------
-- Table structure for dia_semana
-- ----------------------------
DROP TABLE IF EXISTS `dia_semana`;
CREATE TABLE `dia_semana`  (
  `id_dia` smallint NOT NULL,
  `nombre_dia` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_dia`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dia_semana
-- ----------------------------

-- ----------------------------
-- Table structure for diccionario_termino
-- ----------------------------
DROP TABLE IF EXISTS `diccionario_termino`;
CREATE TABLE `diccionario_termino`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `valor` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `longitud` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `activo` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '1',
  `grupo` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of diccionario_termino
-- ----------------------------
INSERT INTO `diccionario_termino` VALUES (1, 'Identificacion persona', 'DNI', '8', '1', NULL);
INSERT INTO `diccionario_termino` VALUES (2, 'Identificacion empresa', 'RUC', '11', '1', NULL);
INSERT INTO `diccionario_termino` VALUES (3, 'Impuesto', 'IGV', '2', '1', NULL);
INSERT INTO `diccionario_termino` VALUES (4, 'operador', 'COMBUSTIBLE', '9', '1', 3);

-- ----------------------------
-- Table structure for distrito
-- ----------------------------
DROP TABLE IF EXISTS `distrito`;
CREATE TABLE `distrito`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `ciudad_id` int NULL DEFAULT NULL,
  `subId_ubigeo` varchar(6) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nombre` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `estado` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `idUbigeo` varchar(6) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2045 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of distrito
-- ----------------------------
INSERT INTO `distrito` VALUES (1, 1, '01', 'Chachapoyas', NULL, '010101');
INSERT INTO `distrito` VALUES (2, 1, '02', 'Asunción', NULL, '010102');
INSERT INTO `distrito` VALUES (3, 1, '03', 'Balsas', NULL, '010103');
INSERT INTO `distrito` VALUES (4, 1, '04', 'Cheto', NULL, '010104');
INSERT INTO `distrito` VALUES (5, 1, '05', 'Chiliquin', NULL, '010105');
INSERT INTO `distrito` VALUES (6, 1, '06', 'Chuquibamba', NULL, '010106');
INSERT INTO `distrito` VALUES (7, 1, '07', 'Granada', NULL, '010107');
INSERT INTO `distrito` VALUES (8, 1, '08', 'Huancas', NULL, '010108');
INSERT INTO `distrito` VALUES (9, 1, '09', 'La Jalca', NULL, '010109');
INSERT INTO `distrito` VALUES (10, 1, '10', 'Leimebamba', NULL, '010110');
INSERT INTO `distrito` VALUES (11, 1, '11', 'Levanto', NULL, '010111');
INSERT INTO `distrito` VALUES (12, 1, '12', 'Magdalena', NULL, '010112');
INSERT INTO `distrito` VALUES (13, 1, '13', 'Mariscal Castilla', NULL, '010113');
INSERT INTO `distrito` VALUES (14, 1, '14', 'Molinopampa', NULL, '010114');
INSERT INTO `distrito` VALUES (15, 1, '15', 'Montevideo', NULL, '010115');
INSERT INTO `distrito` VALUES (16, 1, '16', 'Olleros', NULL, '010116');
INSERT INTO `distrito` VALUES (17, 1, '17', 'Quinjalca', NULL, '010117');
INSERT INTO `distrito` VALUES (18, 1, '18', 'San Francisco de Daguas', NULL, '010118');
INSERT INTO `distrito` VALUES (19, 1, '19', 'San Isidro de Maino', NULL, '010119');
INSERT INTO `distrito` VALUES (20, 1, '20', 'Soloco', NULL, '010120');
INSERT INTO `distrito` VALUES (21, 1, '21', 'Sonche', NULL, '010121');
INSERT INTO `distrito` VALUES (22, 2, '01', 'Bagua', NULL, '010201');
INSERT INTO `distrito` VALUES (23, 2, '02', 'Aramango', NULL, '010202');
INSERT INTO `distrito` VALUES (24, 2, '03', 'Copallin', NULL, '010203');
INSERT INTO `distrito` VALUES (25, 2, '04', 'El Parco', NULL, '010204');
INSERT INTO `distrito` VALUES (26, 2, '05', 'Imaza', NULL, '010205');
INSERT INTO `distrito` VALUES (27, 2, '06', 'La Peca', NULL, '010206');
INSERT INTO `distrito` VALUES (28, 3, '01', 'Jumbilla', NULL, '010301');
INSERT INTO `distrito` VALUES (29, 3, '02', 'Chisquilla', NULL, '010302');
INSERT INTO `distrito` VALUES (30, 3, '03', 'Churuja', NULL, '010303');
INSERT INTO `distrito` VALUES (31, 3, '04', 'Corosha', NULL, '010304');
INSERT INTO `distrito` VALUES (32, 3, '05', 'Cuispes', NULL, '010305');
INSERT INTO `distrito` VALUES (33, 3, '06', 'Florida', NULL, '010306');
INSERT INTO `distrito` VALUES (34, 3, '07', 'Jazan', NULL, '010307');
INSERT INTO `distrito` VALUES (35, 3, '08', 'Recta', NULL, '010308');
INSERT INTO `distrito` VALUES (36, 3, '09', 'San Carlos', NULL, '010309');
INSERT INTO `distrito` VALUES (37, 3, '10', 'Shipasbamba', NULL, '010310');
INSERT INTO `distrito` VALUES (38, 3, '11', 'Valera', NULL, '010311');
INSERT INTO `distrito` VALUES (39, 3, '12', 'Yambrasbamba', NULL, '010312');
INSERT INTO `distrito` VALUES (40, 4, '01', 'Nieva', NULL, '010401');
INSERT INTO `distrito` VALUES (41, 4, '02', 'El Cenepa', NULL, '010402');
INSERT INTO `distrito` VALUES (42, 4, '03', 'Río Santiago', NULL, '010403');
INSERT INTO `distrito` VALUES (43, 5, '01', 'Lamud', NULL, '010501');
INSERT INTO `distrito` VALUES (44, 5, '02', 'Camporredondo', NULL, '010502');
INSERT INTO `distrito` VALUES (45, 5, '03', 'Cocabamba', NULL, '010503');
INSERT INTO `distrito` VALUES (46, 5, '04', 'Colcamar', NULL, '010504');
INSERT INTO `distrito` VALUES (47, 5, '05', 'Conila', NULL, '010505');
INSERT INTO `distrito` VALUES (48, 5, '06', 'Inguilpata', NULL, '010506');
INSERT INTO `distrito` VALUES (49, 5, '07', 'Longuita', NULL, '010507');
INSERT INTO `distrito` VALUES (50, 5, '08', 'Lonya Chico', NULL, '010508');
INSERT INTO `distrito` VALUES (51, 5, '09', 'Luya', NULL, '010509');
INSERT INTO `distrito` VALUES (52, 5, '10', 'Luya Viejo', NULL, '010510');
INSERT INTO `distrito` VALUES (53, 5, '11', 'María', NULL, '010511');
INSERT INTO `distrito` VALUES (54, 5, '12', 'Ocalli', NULL, '010512');
INSERT INTO `distrito` VALUES (55, 5, '13', 'Ocumal', NULL, '010513');
INSERT INTO `distrito` VALUES (56, 5, '14', 'Pisuquia', NULL, '010514');
INSERT INTO `distrito` VALUES (57, 5, '15', 'Providencia', NULL, '010515');
INSERT INTO `distrito` VALUES (58, 5, '16', 'San Cristóbal', NULL, '010516');
INSERT INTO `distrito` VALUES (59, 5, '17', 'San Francisco de Yeso', NULL, '010517');
INSERT INTO `distrito` VALUES (60, 5, '18', 'San Jerónimo', NULL, '010518');
INSERT INTO `distrito` VALUES (61, 5, '19', 'San Juan de Lopecancha', NULL, '010519');
INSERT INTO `distrito` VALUES (62, 5, '20', 'Santa Catalina', NULL, '010520');
INSERT INTO `distrito` VALUES (63, 5, '21', 'Santo Tomas', NULL, '010521');
INSERT INTO `distrito` VALUES (64, 5, '22', 'Tingo', NULL, '010522');
INSERT INTO `distrito` VALUES (65, 5, '23', 'Trita', NULL, '010523');
INSERT INTO `distrito` VALUES (66, 6, '01', 'San Nicolás', NULL, '010601');
INSERT INTO `distrito` VALUES (67, 6, '02', 'Chirimoto', NULL, '010602');
INSERT INTO `distrito` VALUES (68, 6, '03', 'Cochamal', NULL, '010603');
INSERT INTO `distrito` VALUES (69, 6, '04', 'Huambo', NULL, '010604');
INSERT INTO `distrito` VALUES (70, 6, '05', 'Limabamba', NULL, '010605');
INSERT INTO `distrito` VALUES (71, 6, '06', 'Longar', NULL, '010606');
INSERT INTO `distrito` VALUES (72, 6, '07', 'Mariscal Benavides', NULL, '010607');
INSERT INTO `distrito` VALUES (73, 6, '08', 'Milpuc', NULL, '010608');
INSERT INTO `distrito` VALUES (74, 6, '09', 'Omia', NULL, '010609');
INSERT INTO `distrito` VALUES (75, 6, '10', 'Santa Rosa', NULL, '010610');
INSERT INTO `distrito` VALUES (76, 6, '11', 'Totora', NULL, '010611');
INSERT INTO `distrito` VALUES (77, 6, '12', 'Vista Alegre', NULL, '010612');
INSERT INTO `distrito` VALUES (78, 7, '01', 'Bagua Grande', NULL, '010701');
INSERT INTO `distrito` VALUES (79, 7, '02', 'Cajaruro', NULL, '010702');
INSERT INTO `distrito` VALUES (80, 7, '03', 'Cumba', NULL, '010703');
INSERT INTO `distrito` VALUES (81, 7, '04', 'El Milagro', NULL, '010704');
INSERT INTO `distrito` VALUES (82, 7, '05', 'Jamalca', NULL, '010705');
INSERT INTO `distrito` VALUES (83, 7, '06', 'Lonya Grande', NULL, '010706');
INSERT INTO `distrito` VALUES (84, 7, '07', 'Yamon', NULL, '010707');
INSERT INTO `distrito` VALUES (85, 8, '01', 'Huaraz', NULL, '020101');
INSERT INTO `distrito` VALUES (86, 8, '02', 'Cochabamba', NULL, '020102');
INSERT INTO `distrito` VALUES (87, 8, '03', 'Colcabamba', NULL, '020103');
INSERT INTO `distrito` VALUES (88, 8, '04', 'Huanchay', NULL, '020104');
INSERT INTO `distrito` VALUES (89, 8, '05', 'Independencia', NULL, '020105');
INSERT INTO `distrito` VALUES (90, 8, '06', 'Jangas', NULL, '020106');
INSERT INTO `distrito` VALUES (91, 8, '07', 'La Libertad', NULL, '020107');
INSERT INTO `distrito` VALUES (92, 8, '08', 'Olleros', NULL, '020108');
INSERT INTO `distrito` VALUES (93, 8, '09', 'Pampas Grande', NULL, '020109');
INSERT INTO `distrito` VALUES (94, 8, '10', 'Pariacoto', NULL, '020110');
INSERT INTO `distrito` VALUES (95, 8, '11', 'Pira', NULL, '020111');
INSERT INTO `distrito` VALUES (96, 8, '12', 'Tarica', NULL, '020112');
INSERT INTO `distrito` VALUES (97, 9, '01', 'Aija', NULL, '020201');
INSERT INTO `distrito` VALUES (98, 9, '02', 'Coris', NULL, '020202');
INSERT INTO `distrito` VALUES (99, 9, '03', 'Huacllan', NULL, '020203');
INSERT INTO `distrito` VALUES (100, 9, '04', 'La Merced', NULL, '020204');
INSERT INTO `distrito` VALUES (101, 9, '05', 'Succha', NULL, '020205');
INSERT INTO `distrito` VALUES (102, 10, '01', 'Llamellin', NULL, '020301');
INSERT INTO `distrito` VALUES (103, 10, '02', 'Aczo', NULL, '020302');
INSERT INTO `distrito` VALUES (104, 10, '03', 'Chaccho', NULL, '020303');
INSERT INTO `distrito` VALUES (105, 10, '04', 'Chingas', NULL, '020304');
INSERT INTO `distrito` VALUES (106, 10, '05', 'Mirgas', NULL, '020305');
INSERT INTO `distrito` VALUES (107, 10, '06', 'San Juan de Rontoy', NULL, '020306');
INSERT INTO `distrito` VALUES (108, 11, '01', 'Chacas', NULL, '020401');
INSERT INTO `distrito` VALUES (109, 11, '02', 'Acochaca', NULL, '020402');
INSERT INTO `distrito` VALUES (110, 12, '01', 'Chiquian', NULL, '020501');
INSERT INTO `distrito` VALUES (111, 12, '02', 'Abelardo Pardo Lezameta', NULL, '020502');
INSERT INTO `distrito` VALUES (112, 12, '03', 'Antonio Raymondi', NULL, '020503');
INSERT INTO `distrito` VALUES (113, 12, '04', 'Aquia', NULL, '020504');
INSERT INTO `distrito` VALUES (114, 12, '05', 'Cajacay', NULL, '020505');
INSERT INTO `distrito` VALUES (115, 12, '06', 'Canis', NULL, '020506');
INSERT INTO `distrito` VALUES (116, 12, '07', 'Colquioc', NULL, '020507');
INSERT INTO `distrito` VALUES (117, 12, '08', 'Huallanca', NULL, '020508');
INSERT INTO `distrito` VALUES (118, 12, '09', 'Huasta', NULL, '020509');
INSERT INTO `distrito` VALUES (119, 12, '10', 'Huayllacayan', NULL, '020510');
INSERT INTO `distrito` VALUES (120, 12, '11', 'La Primavera', NULL, '020511');
INSERT INTO `distrito` VALUES (121, 12, '12', 'Mangas', NULL, '020512');
INSERT INTO `distrito` VALUES (122, 12, '13', 'Pacllon', NULL, '020513');
INSERT INTO `distrito` VALUES (123, 12, '14', 'San Miguel de Corpanqui', NULL, '020514');
INSERT INTO `distrito` VALUES (124, 12, '15', 'Ticllos', NULL, '020515');
INSERT INTO `distrito` VALUES (125, 13, '01', 'Carhuaz', NULL, '020601');
INSERT INTO `distrito` VALUES (126, 13, '02', 'Acopampa', NULL, '020602');
INSERT INTO `distrito` VALUES (127, 13, '03', 'Amashca', NULL, '020603');
INSERT INTO `distrito` VALUES (128, 13, '04', 'Anta', NULL, '020604');
INSERT INTO `distrito` VALUES (129, 13, '05', 'Ataquero', NULL, '020605');
INSERT INTO `distrito` VALUES (130, 13, '06', 'Marcara', NULL, '020606');
INSERT INTO `distrito` VALUES (131, 13, '07', 'Pariahuanca', NULL, '020607');
INSERT INTO `distrito` VALUES (132, 13, '08', 'San Miguel de Aco', NULL, '020608');
INSERT INTO `distrito` VALUES (133, 13, '09', 'Shilla', NULL, '020609');
INSERT INTO `distrito` VALUES (134, 13, '10', 'Tinco', NULL, '020610');
INSERT INTO `distrito` VALUES (135, 13, '11', 'Yungar', NULL, '020611');
INSERT INTO `distrito` VALUES (136, 14, '01', 'San Luis', NULL, '020701');
INSERT INTO `distrito` VALUES (137, 14, '02', 'San Nicolás', NULL, '020702');
INSERT INTO `distrito` VALUES (138, 14, '03', 'Yauya', NULL, '020703');
INSERT INTO `distrito` VALUES (139, 15, '01', 'Casma', NULL, '020801');
INSERT INTO `distrito` VALUES (140, 15, '02', 'Buena Vista Alta', NULL, '020802');
INSERT INTO `distrito` VALUES (141, 15, '03', 'Comandante Noel', NULL, '020803');
INSERT INTO `distrito` VALUES (142, 15, '04', 'Yautan', NULL, '020804');
INSERT INTO `distrito` VALUES (143, 16, '01', 'Corongo', NULL, '020901');
INSERT INTO `distrito` VALUES (144, 16, '02', 'Aco', NULL, '020902');
INSERT INTO `distrito` VALUES (145, 16, '03', 'Bambas', NULL, '020903');
INSERT INTO `distrito` VALUES (146, 16, '04', 'Cusca', NULL, '020904');
INSERT INTO `distrito` VALUES (147, 16, '05', 'La Pampa', NULL, '020905');
INSERT INTO `distrito` VALUES (148, 16, '06', 'Yanac', NULL, '020906');
INSERT INTO `distrito` VALUES (149, 16, '07', 'Yupan', NULL, '020907');
INSERT INTO `distrito` VALUES (150, 17, '01', 'Huari', NULL, '021001');
INSERT INTO `distrito` VALUES (151, 17, '02', 'Anra', NULL, '021002');
INSERT INTO `distrito` VALUES (152, 17, '03', 'Cajay', NULL, '021003');
INSERT INTO `distrito` VALUES (153, 17, '04', 'Chavin de Huantar', NULL, '021004');
INSERT INTO `distrito` VALUES (154, 17, '05', 'Huacachi', NULL, '021005');
INSERT INTO `distrito` VALUES (155, 17, '06', 'Huacchis', NULL, '021006');
INSERT INTO `distrito` VALUES (156, 17, '07', 'Huachis', NULL, '021007');
INSERT INTO `distrito` VALUES (157, 17, '08', 'Huantar', NULL, '021008');
INSERT INTO `distrito` VALUES (158, 17, '09', 'Masin', NULL, '021009');
INSERT INTO `distrito` VALUES (159, 17, '10', 'Paucas', NULL, '021010');
INSERT INTO `distrito` VALUES (160, 17, '11', 'Ponto', NULL, '021011');
INSERT INTO `distrito` VALUES (161, 17, '12', 'Rahuapampa', NULL, '021012');
INSERT INTO `distrito` VALUES (162, 17, '13', 'Rapayan', NULL, '021013');
INSERT INTO `distrito` VALUES (163, 17, '14', 'San Marcos', NULL, '021014');
INSERT INTO `distrito` VALUES (164, 17, '15', 'San Pedro de Chana', NULL, '021015');
INSERT INTO `distrito` VALUES (165, 17, '16', 'Uco', NULL, '021016');
INSERT INTO `distrito` VALUES (166, 18, '01', 'Huarmey', NULL, '021101');
INSERT INTO `distrito` VALUES (167, 18, '02', 'Cochapeti', NULL, '021102');
INSERT INTO `distrito` VALUES (168, 18, '03', 'Culebras', NULL, '021103');
INSERT INTO `distrito` VALUES (169, 18, '04', 'Huayan', NULL, '021104');
INSERT INTO `distrito` VALUES (170, 18, '05', 'Malvas', NULL, '021105');
INSERT INTO `distrito` VALUES (171, 19, '01', 'Caraz', NULL, '021201');
INSERT INTO `distrito` VALUES (172, 19, '02', 'Huallanca', NULL, '021202');
INSERT INTO `distrito` VALUES (173, 19, '03', 'Huata', NULL, '021203');
INSERT INTO `distrito` VALUES (174, 19, '04', 'Huaylas', NULL, '021204');
INSERT INTO `distrito` VALUES (175, 19, '05', 'Mato', NULL, '021205');
INSERT INTO `distrito` VALUES (176, 19, '06', 'Pamparomas', NULL, '021206');
INSERT INTO `distrito` VALUES (177, 19, '07', 'Pueblo Libre', NULL, '021207');
INSERT INTO `distrito` VALUES (178, 19, '08', 'Santa Cruz', NULL, '021208');
INSERT INTO `distrito` VALUES (179, 19, '09', 'Santo Toribio', NULL, '021209');
INSERT INTO `distrito` VALUES (180, 19, '10', 'Yuracmarca', NULL, '021210');
INSERT INTO `distrito` VALUES (181, 20, '01', 'Piscobamba', NULL, '021301');
INSERT INTO `distrito` VALUES (182, 20, '02', 'Casca', NULL, '021302');
INSERT INTO `distrito` VALUES (183, 20, '03', 'Eleazar Guzmán Barron', NULL, '021303');
INSERT INTO `distrito` VALUES (184, 20, '04', 'Fidel Olivas Escudero', NULL, '021304');
INSERT INTO `distrito` VALUES (185, 20, '05', 'Llama', NULL, '021305');
INSERT INTO `distrito` VALUES (186, 20, '06', 'Llumpa', NULL, '021306');
INSERT INTO `distrito` VALUES (187, 20, '07', 'Lucma', NULL, '021307');
INSERT INTO `distrito` VALUES (188, 20, '08', 'Musga', NULL, '021308');
INSERT INTO `distrito` VALUES (189, 21, '01', 'Ocros', NULL, '021401');
INSERT INTO `distrito` VALUES (190, 21, '02', 'Acas', NULL, '021402');
INSERT INTO `distrito` VALUES (191, 21, '03', 'Cajamarquilla', NULL, '021403');
INSERT INTO `distrito` VALUES (192, 21, '04', 'Carhuapampa', NULL, '021404');
INSERT INTO `distrito` VALUES (193, 21, '05', 'Cochas', NULL, '021405');
INSERT INTO `distrito` VALUES (194, 21, '06', 'Congas', NULL, '021406');
INSERT INTO `distrito` VALUES (195, 21, '07', 'Llipa', NULL, '021407');
INSERT INTO `distrito` VALUES (196, 21, '08', 'San Cristóbal de Rajan', NULL, '021408');
INSERT INTO `distrito` VALUES (197, 21, '09', 'San Pedro', NULL, '021409');
INSERT INTO `distrito` VALUES (198, 21, '10', 'Santiago de Chilcas', NULL, '021410');
INSERT INTO `distrito` VALUES (199, 22, '01', 'Cabana', NULL, '021501');
INSERT INTO `distrito` VALUES (200, 22, '02', 'Bolognesi', NULL, '021502');
INSERT INTO `distrito` VALUES (201, 22, '03', 'Conchucos', NULL, '021503');
INSERT INTO `distrito` VALUES (202, 22, '04', 'Huacaschuque', NULL, '021504');
INSERT INTO `distrito` VALUES (203, 22, '05', 'Huandoval', NULL, '021505');
INSERT INTO `distrito` VALUES (204, 22, '06', 'Lacabamba', NULL, '021506');
INSERT INTO `distrito` VALUES (205, 22, '07', 'Llapo', NULL, '021507');
INSERT INTO `distrito` VALUES (206, 22, '08', 'Pallasca', NULL, '021508');
INSERT INTO `distrito` VALUES (207, 22, '09', 'Pampas', NULL, '021509');
INSERT INTO `distrito` VALUES (208, 22, '10', 'Santa Rosa', NULL, '021510');
INSERT INTO `distrito` VALUES (209, 22, '11', 'Tauca', NULL, '021511');
INSERT INTO `distrito` VALUES (210, 23, '01', 'Pomabamba', NULL, '021601');
INSERT INTO `distrito` VALUES (211, 23, '02', 'Huayllan', NULL, '021602');
INSERT INTO `distrito` VALUES (212, 23, '03', 'Parobamba', NULL, '021603');
INSERT INTO `distrito` VALUES (213, 23, '04', 'Quinuabamba', NULL, '021604');
INSERT INTO `distrito` VALUES (214, 24, '01', 'Recuay', NULL, '021701');
INSERT INTO `distrito` VALUES (215, 24, '02', 'Catac', NULL, '021702');
INSERT INTO `distrito` VALUES (216, 24, '03', 'Cotaparaco', NULL, '021703');
INSERT INTO `distrito` VALUES (217, 24, '04', 'Huayllapampa', NULL, '021704');
INSERT INTO `distrito` VALUES (218, 24, '05', 'Llacllin', NULL, '021705');
INSERT INTO `distrito` VALUES (219, 24, '06', 'Marca', NULL, '021706');
INSERT INTO `distrito` VALUES (220, 24, '07', 'Pampas Chico', NULL, '021707');
INSERT INTO `distrito` VALUES (221, 24, '08', 'Pararin', NULL, '021708');
INSERT INTO `distrito` VALUES (222, 24, '09', 'Tapacocha', NULL, '021709');
INSERT INTO `distrito` VALUES (223, 24, '10', 'Ticapampa', NULL, '021710');
INSERT INTO `distrito` VALUES (224, 25, '01', 'Chimbote', NULL, '021801');
INSERT INTO `distrito` VALUES (225, 25, '02', 'Cáceres del Perú', NULL, '021802');
INSERT INTO `distrito` VALUES (226, 25, '03', 'Coishco', NULL, '021803');
INSERT INTO `distrito` VALUES (227, 25, '04', 'Macate', NULL, '021804');
INSERT INTO `distrito` VALUES (228, 25, '05', 'Moro', NULL, '021805');
INSERT INTO `distrito` VALUES (229, 25, '06', 'Nepeña', NULL, '021806');
INSERT INTO `distrito` VALUES (230, 25, '07', 'Samanco', NULL, '021807');
INSERT INTO `distrito` VALUES (231, 25, '08', 'Santa', NULL, '021808');
INSERT INTO `distrito` VALUES (232, 25, '09', 'Nuevo Chimbote', NULL, '021809');
INSERT INTO `distrito` VALUES (233, 26, '01', 'Sihuas', NULL, '021901');
INSERT INTO `distrito` VALUES (234, 26, '02', 'Acobamba', NULL, '021902');
INSERT INTO `distrito` VALUES (235, 26, '03', 'Alfonso Ugarte', NULL, '021903');
INSERT INTO `distrito` VALUES (236, 26, '04', 'Cashapampa', NULL, '021904');
INSERT INTO `distrito` VALUES (237, 26, '05', 'Chingalpo', NULL, '021905');
INSERT INTO `distrito` VALUES (238, 26, '06', 'Huayllabamba', NULL, '021906');
INSERT INTO `distrito` VALUES (239, 26, '07', 'Quiches', NULL, '021907');
INSERT INTO `distrito` VALUES (240, 26, '08', 'Ragash', NULL, '021908');
INSERT INTO `distrito` VALUES (241, 26, '09', 'San Juan', NULL, '021909');
INSERT INTO `distrito` VALUES (242, 26, '10', 'Sicsibamba', NULL, '021910');
INSERT INTO `distrito` VALUES (243, 27, '01', 'Yungay', NULL, '022001');
INSERT INTO `distrito` VALUES (244, 27, '02', 'Cascapara', NULL, '022002');
INSERT INTO `distrito` VALUES (245, 27, '03', 'Mancos', NULL, '022003');
INSERT INTO `distrito` VALUES (246, 27, '04', 'Matacoto', NULL, '022004');
INSERT INTO `distrito` VALUES (247, 27, '05', 'Quillo', NULL, '022005');
INSERT INTO `distrito` VALUES (248, 27, '06', 'Ranrahirca', NULL, '022006');
INSERT INTO `distrito` VALUES (249, 27, '07', 'Shupluy', NULL, '022007');
INSERT INTO `distrito` VALUES (250, 27, '08', 'Yanama', NULL, '022008');
INSERT INTO `distrito` VALUES (251, 28, '01', 'Abancay', NULL, '030101');
INSERT INTO `distrito` VALUES (252, 28, '02', 'Chacoche', NULL, '030102');
INSERT INTO `distrito` VALUES (253, 28, '03', 'Circa', NULL, '030103');
INSERT INTO `distrito` VALUES (254, 28, '04', 'Curahuasi', NULL, '030104');
INSERT INTO `distrito` VALUES (255, 28, '05', 'Huanipaca', NULL, '030105');
INSERT INTO `distrito` VALUES (256, 28, '06', 'Lambrama', NULL, '030106');
INSERT INTO `distrito` VALUES (257, 28, '07', 'Pichirhua', NULL, '030107');
INSERT INTO `distrito` VALUES (258, 28, '08', 'San Pedro de Cachora', NULL, '030108');
INSERT INTO `distrito` VALUES (259, 28, '09', 'Tamburco', NULL, '030109');
INSERT INTO `distrito` VALUES (260, 29, '01', 'Andahuaylas', NULL, '030201');
INSERT INTO `distrito` VALUES (261, 29, '02', 'Andarapa', NULL, '030202');
INSERT INTO `distrito` VALUES (262, 29, '03', 'Chiara', NULL, '030203');
INSERT INTO `distrito` VALUES (263, 29, '04', 'Huancarama', NULL, '030204');
INSERT INTO `distrito` VALUES (264, 29, '05', 'Huancaray', NULL, '030205');
INSERT INTO `distrito` VALUES (265, 29, '06', 'Huayana', NULL, '030206');
INSERT INTO `distrito` VALUES (266, 29, '07', 'Kishuara', NULL, '030207');
INSERT INTO `distrito` VALUES (267, 29, '08', 'Pacobamba', NULL, '030208');
INSERT INTO `distrito` VALUES (268, 29, '09', 'Pacucha', NULL, '030209');
INSERT INTO `distrito` VALUES (269, 29, '10', 'Pampachiri', NULL, '030210');
INSERT INTO `distrito` VALUES (270, 29, '11', 'Pomacocha', NULL, '030211');
INSERT INTO `distrito` VALUES (271, 29, '12', 'San Antonio de Cachi', NULL, '030212');
INSERT INTO `distrito` VALUES (272, 29, '13', 'San Jerónimo', NULL, '030213');
INSERT INTO `distrito` VALUES (273, 29, '14', 'San Miguel de Chaccrampa', NULL, '030214');
INSERT INTO `distrito` VALUES (274, 29, '15', 'Santa María de Chicmo', NULL, '030215');
INSERT INTO `distrito` VALUES (275, 29, '16', 'Talavera', NULL, '030216');
INSERT INTO `distrito` VALUES (276, 29, '17', 'Tumay Huaraca', NULL, '030217');
INSERT INTO `distrito` VALUES (277, 29, '18', 'Turpo', NULL, '030218');
INSERT INTO `distrito` VALUES (278, 29, '19', 'Kaquiabamba', NULL, '030219');
INSERT INTO `distrito` VALUES (279, 29, '20', 'José María Arguedas', NULL, '030220');
INSERT INTO `distrito` VALUES (280, 30, '01', 'Antabamba', NULL, '030301');
INSERT INTO `distrito` VALUES (281, 30, '02', 'El Oro', NULL, '030302');
INSERT INTO `distrito` VALUES (282, 30, '03', 'Huaquirca', NULL, '030303');
INSERT INTO `distrito` VALUES (283, 30, '04', 'Juan Espinoza Medrano', NULL, '030304');
INSERT INTO `distrito` VALUES (284, 30, '05', 'Oropesa', NULL, '030305');
INSERT INTO `distrito` VALUES (285, 30, '06', 'Pachaconas', NULL, '030306');
INSERT INTO `distrito` VALUES (286, 30, '07', 'Sabaino', NULL, '030307');
INSERT INTO `distrito` VALUES (287, 31, '01', 'Chalhuanca', NULL, '030401');
INSERT INTO `distrito` VALUES (288, 31, '02', 'Capaya', NULL, '030402');
INSERT INTO `distrito` VALUES (289, 31, '03', 'Caraybamba', NULL, '030403');
INSERT INTO `distrito` VALUES (290, 31, '04', 'Chapimarca', NULL, '030404');
INSERT INTO `distrito` VALUES (291, 31, '05', 'Colcabamba', NULL, '030405');
INSERT INTO `distrito` VALUES (292, 31, '06', 'Cotaruse', NULL, '030406');
INSERT INTO `distrito` VALUES (293, 31, '07', 'Huayllo', NULL, '030407');
INSERT INTO `distrito` VALUES (294, 31, '08', 'Justo Apu Sahuaraura', NULL, '030408');
INSERT INTO `distrito` VALUES (295, 31, '09', 'Lucre', NULL, '030409');
INSERT INTO `distrito` VALUES (296, 31, '10', 'Pocohuanca', NULL, '030410');
INSERT INTO `distrito` VALUES (297, 31, '11', 'San Juan de Chacña', NULL, '030411');
INSERT INTO `distrito` VALUES (298, 31, '12', 'Sañayca', NULL, '030412');
INSERT INTO `distrito` VALUES (299, 31, '13', 'Soraya', NULL, '030413');
INSERT INTO `distrito` VALUES (300, 31, '14', 'Tapairihua', NULL, '030414');
INSERT INTO `distrito` VALUES (301, 31, '15', 'Tintay', NULL, '030415');
INSERT INTO `distrito` VALUES (302, 31, '16', 'Toraya', NULL, '030416');
INSERT INTO `distrito` VALUES (303, 31, '17', 'Yanaca', NULL, '030417');
INSERT INTO `distrito` VALUES (304, 32, '01', 'Tambobamba', NULL, '030501');
INSERT INTO `distrito` VALUES (305, 32, '02', 'Cotabambas', NULL, '030502');
INSERT INTO `distrito` VALUES (306, 32, '03', 'Coyllurqui', NULL, '030503');
INSERT INTO `distrito` VALUES (307, 32, '04', 'Haquira', NULL, '030504');
INSERT INTO `distrito` VALUES (308, 32, '05', 'Mara', NULL, '030505');
INSERT INTO `distrito` VALUES (309, 32, '06', 'Challhuahuacho', NULL, '030506');
INSERT INTO `distrito` VALUES (310, 33, '01', 'Chincheros', NULL, '030601');
INSERT INTO `distrito` VALUES (311, 33, '02', 'Anco_Huallo', NULL, '030602');
INSERT INTO `distrito` VALUES (312, 33, '03', 'Cocharcas', NULL, '030603');
INSERT INTO `distrito` VALUES (313, 33, '04', 'Huaccana', NULL, '030604');
INSERT INTO `distrito` VALUES (314, 33, '05', 'Ocobamba', NULL, '030605');
INSERT INTO `distrito` VALUES (315, 33, '06', 'Ongoy', NULL, '030606');
INSERT INTO `distrito` VALUES (316, 33, '07', 'Uranmarca', NULL, '030607');
INSERT INTO `distrito` VALUES (317, 33, '08', 'Ranracancha', NULL, '030608');
INSERT INTO `distrito` VALUES (318, 34, '01', 'Chuquibambilla', NULL, '030701');
INSERT INTO `distrito` VALUES (319, 34, '02', 'Curpahuasi', NULL, '030702');
INSERT INTO `distrito` VALUES (320, 34, '03', 'Gamarra', NULL, '030703');
INSERT INTO `distrito` VALUES (321, 34, '04', 'Huayllati', NULL, '030704');
INSERT INTO `distrito` VALUES (322, 34, '05', 'Mamara', NULL, '030705');
INSERT INTO `distrito` VALUES (323, 34, '06', 'Micaela Bastidas', NULL, '030706');
INSERT INTO `distrito` VALUES (324, 34, '07', 'Pataypampa', NULL, '030707');
INSERT INTO `distrito` VALUES (325, 34, '08', 'Progreso', NULL, '030708');
INSERT INTO `distrito` VALUES (326, 34, '09', 'San Antonio', NULL, '030709');
INSERT INTO `distrito` VALUES (327, 34, '10', 'Santa Rosa', NULL, '030710');
INSERT INTO `distrito` VALUES (328, 34, '11', 'Turpay', NULL, '030711');
INSERT INTO `distrito` VALUES (329, 34, '12', 'Vilcabamba', NULL, '030712');
INSERT INTO `distrito` VALUES (330, 34, '13', 'Virundo', NULL, '030713');
INSERT INTO `distrito` VALUES (331, 34, '14', 'Curasco', NULL, '030714');
INSERT INTO `distrito` VALUES (332, 35, '01', 'Arequipa', NULL, '040101');
INSERT INTO `distrito` VALUES (333, 35, '02', 'Alto Selva Alegre', NULL, '040102');
INSERT INTO `distrito` VALUES (334, 35, '03', 'Cayma', NULL, '040103');
INSERT INTO `distrito` VALUES (335, 35, '04', 'Cerro Colorado', NULL, '040104');
INSERT INTO `distrito` VALUES (336, 35, '05', 'Characato', NULL, '040105');
INSERT INTO `distrito` VALUES (337, 35, '06', 'Chiguata', NULL, '040106');
INSERT INTO `distrito` VALUES (338, 35, '07', 'Jacobo Hunter', NULL, '040107');
INSERT INTO `distrito` VALUES (339, 35, '08', 'La Joya', NULL, '040108');
INSERT INTO `distrito` VALUES (340, 35, '09', 'Mariano Melgar', NULL, '040109');
INSERT INTO `distrito` VALUES (341, 35, '10', 'Miraflores', NULL, '040110');
INSERT INTO `distrito` VALUES (342, 35, '11', 'Mollebaya', NULL, '040111');
INSERT INTO `distrito` VALUES (343, 35, '12', 'Paucarpata', NULL, '040112');
INSERT INTO `distrito` VALUES (344, 35, '13', 'Pocsi', NULL, '040113');
INSERT INTO `distrito` VALUES (345, 35, '14', 'Polobaya', NULL, '040114');
INSERT INTO `distrito` VALUES (346, 35, '15', 'Quequeña', NULL, '040115');
INSERT INTO `distrito` VALUES (347, 35, '16', 'Sabandia', NULL, '040116');
INSERT INTO `distrito` VALUES (348, 35, '17', 'Sachaca', NULL, '040117');
INSERT INTO `distrito` VALUES (349, 35, '18', 'San Juan de Siguas', NULL, '040118');
INSERT INTO `distrito` VALUES (350, 35, '19', 'San Juan de Tarucani', NULL, '040119');
INSERT INTO `distrito` VALUES (351, 35, '20', 'Santa Isabel de Siguas', NULL, '040120');
INSERT INTO `distrito` VALUES (352, 35, '21', 'Santa Rita de Siguas', NULL, '040121');
INSERT INTO `distrito` VALUES (353, 35, '22', 'Socabaya', NULL, '040122');
INSERT INTO `distrito` VALUES (354, 35, '23', 'Tiabaya', NULL, '040123');
INSERT INTO `distrito` VALUES (355, 35, '24', 'Uchumayo', NULL, '040124');
INSERT INTO `distrito` VALUES (356, 35, '25', 'Vitor', NULL, '040125');
INSERT INTO `distrito` VALUES (357, 35, '26', 'Yanahuara', NULL, '040126');
INSERT INTO `distrito` VALUES (358, 35, '27', 'Yarabamba', NULL, '040127');
INSERT INTO `distrito` VALUES (359, 35, '28', 'Yura', NULL, '040128');
INSERT INTO `distrito` VALUES (360, 35, '29', 'José Luis Bustamante Y Rivero', NULL, '040129');
INSERT INTO `distrito` VALUES (361, 36, '01', 'Camaná', NULL, '040201');
INSERT INTO `distrito` VALUES (362, 36, '02', 'José María Quimper', NULL, '040202');
INSERT INTO `distrito` VALUES (363, 36, '03', 'Mariano Nicolás Valcárcel', NULL, '040203');
INSERT INTO `distrito` VALUES (364, 36, '04', 'Mariscal Cáceres', NULL, '040204');
INSERT INTO `distrito` VALUES (365, 36, '05', 'Nicolás de Pierola', NULL, '040205');
INSERT INTO `distrito` VALUES (366, 36, '06', 'Ocoña', NULL, '040206');
INSERT INTO `distrito` VALUES (367, 36, '07', 'Quilca', NULL, '040207');
INSERT INTO `distrito` VALUES (368, 36, '08', 'Samuel Pastor', NULL, '040208');
INSERT INTO `distrito` VALUES (369, 37, '01', 'Caravelí', NULL, '040301');
INSERT INTO `distrito` VALUES (370, 37, '02', 'Acarí', NULL, '040302');
INSERT INTO `distrito` VALUES (371, 37, '03', 'Atico', NULL, '040303');
INSERT INTO `distrito` VALUES (372, 37, '04', 'Atiquipa', NULL, '040304');
INSERT INTO `distrito` VALUES (373, 37, '05', 'Bella Unión', NULL, '040305');
INSERT INTO `distrito` VALUES (374, 37, '06', 'Cahuacho', NULL, '040306');
INSERT INTO `distrito` VALUES (375, 37, '07', 'Chala', NULL, '040307');
INSERT INTO `distrito` VALUES (376, 37, '08', 'Chaparra', NULL, '040308');
INSERT INTO `distrito` VALUES (377, 37, '09', 'Huanuhuanu', NULL, '040309');
INSERT INTO `distrito` VALUES (378, 37, '10', 'Jaqui', NULL, '040310');
INSERT INTO `distrito` VALUES (379, 37, '11', 'Lomas', NULL, '040311');
INSERT INTO `distrito` VALUES (380, 37, '12', 'Quicacha', NULL, '040312');
INSERT INTO `distrito` VALUES (381, 37, '13', 'Yauca', NULL, '040313');
INSERT INTO `distrito` VALUES (382, 38, '01', 'Aplao', NULL, '040401');
INSERT INTO `distrito` VALUES (383, 38, '02', 'Andagua', NULL, '040402');
INSERT INTO `distrito` VALUES (384, 38, '03', 'Ayo', NULL, '040403');
INSERT INTO `distrito` VALUES (385, 38, '04', 'Chachas', NULL, '040404');
INSERT INTO `distrito` VALUES (386, 38, '05', 'Chilcaymarca', NULL, '040405');
INSERT INTO `distrito` VALUES (387, 38, '06', 'Choco', NULL, '040406');
INSERT INTO `distrito` VALUES (388, 38, '07', 'Huancarqui', NULL, '040407');
INSERT INTO `distrito` VALUES (389, 38, '08', 'Machaguay', NULL, '040408');
INSERT INTO `distrito` VALUES (390, 38, '09', 'Orcopampa', NULL, '040409');
INSERT INTO `distrito` VALUES (391, 38, '10', 'Pampacolca', NULL, '040410');
INSERT INTO `distrito` VALUES (392, 38, '11', 'Tipan', NULL, '040411');
INSERT INTO `distrito` VALUES (393, 38, '12', 'Uñon', NULL, '040412');
INSERT INTO `distrito` VALUES (394, 38, '13', 'Uraca', NULL, '040413');
INSERT INTO `distrito` VALUES (395, 38, '14', 'Viraco', NULL, '040414');
INSERT INTO `distrito` VALUES (396, 39, '01', 'Chivay', NULL, '040501');
INSERT INTO `distrito` VALUES (397, 39, '02', 'Achoma', NULL, '040502');
INSERT INTO `distrito` VALUES (398, 39, '03', 'Cabanaconde', NULL, '040503');
INSERT INTO `distrito` VALUES (399, 39, '04', 'Callalli', NULL, '040504');
INSERT INTO `distrito` VALUES (400, 39, '05', 'Caylloma', NULL, '040505');
INSERT INTO `distrito` VALUES (401, 39, '06', 'Coporaque', NULL, '040506');
INSERT INTO `distrito` VALUES (402, 39, '07', 'Huambo', NULL, '040507');
INSERT INTO `distrito` VALUES (403, 39, '08', 'Huanca', NULL, '040508');
INSERT INTO `distrito` VALUES (404, 39, '09', 'Ichupampa', NULL, '040509');
INSERT INTO `distrito` VALUES (405, 39, '10', 'Lari', NULL, '040510');
INSERT INTO `distrito` VALUES (406, 39, '11', 'Lluta', NULL, '040511');
INSERT INTO `distrito` VALUES (407, 39, '12', 'Maca', NULL, '040512');
INSERT INTO `distrito` VALUES (408, 39, '13', 'Madrigal', NULL, '040513');
INSERT INTO `distrito` VALUES (409, 39, '14', 'San Antonio de Chuca', NULL, '040514');
INSERT INTO `distrito` VALUES (410, 39, '15', 'Sibayo', NULL, '040515');
INSERT INTO `distrito` VALUES (411, 39, '16', 'Tapay', NULL, '040516');
INSERT INTO `distrito` VALUES (412, 39, '17', 'Tisco', NULL, '040517');
INSERT INTO `distrito` VALUES (413, 39, '18', 'Tuti', NULL, '040518');
INSERT INTO `distrito` VALUES (414, 39, '19', 'Yanque', NULL, '040519');
INSERT INTO `distrito` VALUES (415, 39, '20', 'Majes', NULL, '040520');
INSERT INTO `distrito` VALUES (416, 40, '01', 'Chuquibamba', NULL, '040601');
INSERT INTO `distrito` VALUES (417, 40, '02', 'Andaray', NULL, '040602');
INSERT INTO `distrito` VALUES (418, 40, '03', 'Cayarani', NULL, '040603');
INSERT INTO `distrito` VALUES (419, 40, '04', 'Chichas', NULL, '040604');
INSERT INTO `distrito` VALUES (420, 40, '05', 'Iray', NULL, '040605');
INSERT INTO `distrito` VALUES (421, 40, '06', 'Río Grande', NULL, '040606');
INSERT INTO `distrito` VALUES (422, 40, '07', 'Salamanca', NULL, '040607');
INSERT INTO `distrito` VALUES (423, 40, '08', 'Yanaquihua', NULL, '040608');
INSERT INTO `distrito` VALUES (424, 41, '01', 'Mollendo', NULL, '040701');
INSERT INTO `distrito` VALUES (425, 41, '02', 'Cocachacra', NULL, '040702');
INSERT INTO `distrito` VALUES (426, 41, '03', 'Dean Valdivia', NULL, '040703');
INSERT INTO `distrito` VALUES (427, 41, '04', 'Islay', NULL, '040704');
INSERT INTO `distrito` VALUES (428, 41, '05', 'Mejia', NULL, '040705');
INSERT INTO `distrito` VALUES (429, 41, '06', 'Punta de Bombón', NULL, '040706');
INSERT INTO `distrito` VALUES (430, 42, '01', 'Cotahuasi', NULL, '040801');
INSERT INTO `distrito` VALUES (431, 42, '02', 'Alca', NULL, '040802');
INSERT INTO `distrito` VALUES (432, 42, '03', 'Charcana', NULL, '040803');
INSERT INTO `distrito` VALUES (433, 42, '04', 'Huaynacotas', NULL, '040804');
INSERT INTO `distrito` VALUES (434, 42, '05', 'Pampamarca', NULL, '040805');
INSERT INTO `distrito` VALUES (435, 42, '06', 'Puyca', NULL, '040806');
INSERT INTO `distrito` VALUES (436, 42, '07', 'Quechualla', NULL, '040807');
INSERT INTO `distrito` VALUES (437, 42, '08', 'Sayla', NULL, '040808');
INSERT INTO `distrito` VALUES (438, 42, '09', 'Tauria', NULL, '040809');
INSERT INTO `distrito` VALUES (439, 42, '10', 'Tomepampa', NULL, '040810');
INSERT INTO `distrito` VALUES (440, 42, '11', 'Toro', NULL, '040811');
INSERT INTO `distrito` VALUES (441, 43, '01', 'Ayacucho', NULL, '050101');
INSERT INTO `distrito` VALUES (442, 43, '02', 'Acocro', NULL, '050102');
INSERT INTO `distrito` VALUES (443, 43, '03', 'Acos Vinchos', NULL, '050103');
INSERT INTO `distrito` VALUES (444, 43, '04', 'Carmen Alto', NULL, '050104');
INSERT INTO `distrito` VALUES (445, 43, '05', 'Chiara', NULL, '050105');
INSERT INTO `distrito` VALUES (446, 43, '06', 'Ocros', NULL, '050106');
INSERT INTO `distrito` VALUES (447, 43, '07', 'Pacaycasa', NULL, '050107');
INSERT INTO `distrito` VALUES (448, 43, '08', 'Quinua', NULL, '050108');
INSERT INTO `distrito` VALUES (449, 43, '09', 'San José de Ticllas', NULL, '050109');
INSERT INTO `distrito` VALUES (450, 43, '10', 'San Juan Bautista', NULL, '050110');
INSERT INTO `distrito` VALUES (451, 43, '11', 'Santiago de Pischa', NULL, '050111');
INSERT INTO `distrito` VALUES (452, 43, '12', 'Socos', NULL, '050112');
INSERT INTO `distrito` VALUES (453, 43, '13', 'Tambillo', NULL, '050113');
INSERT INTO `distrito` VALUES (454, 43, '14', 'Vinchos', NULL, '050114');
INSERT INTO `distrito` VALUES (455, 43, '15', 'Jesús Nazareno', NULL, '050115');
INSERT INTO `distrito` VALUES (456, 43, '16', 'Andrés Avelino Cáceres Dorregaray', NULL, '050116');
INSERT INTO `distrito` VALUES (457, 44, '01', 'Cangallo', NULL, '050201');
INSERT INTO `distrito` VALUES (458, 44, '02', 'Chuschi', NULL, '050202');
INSERT INTO `distrito` VALUES (459, 44, '03', 'Los Morochucos', NULL, '050203');
INSERT INTO `distrito` VALUES (460, 44, '04', 'María Parado de Bellido', NULL, '050204');
INSERT INTO `distrito` VALUES (461, 44, '05', 'Paras', NULL, '050205');
INSERT INTO `distrito` VALUES (462, 44, '06', 'Totos', NULL, '050206');
INSERT INTO `distrito` VALUES (463, 45, '01', 'Sancos', NULL, '050301');
INSERT INTO `distrito` VALUES (464, 45, '02', 'Carapo', NULL, '050302');
INSERT INTO `distrito` VALUES (465, 45, '03', 'Sacsamarca', NULL, '050303');
INSERT INTO `distrito` VALUES (466, 45, '04', 'Santiago de Lucanamarca', NULL, '050304');
INSERT INTO `distrito` VALUES (467, 46, '01', 'Huanta', NULL, '050401');
INSERT INTO `distrito` VALUES (468, 46, '02', 'Ayahuanco', NULL, '050402');
INSERT INTO `distrito` VALUES (469, 46, '03', 'Huamanguilla', NULL, '050403');
INSERT INTO `distrito` VALUES (470, 46, '04', 'Iguain', NULL, '050404');
INSERT INTO `distrito` VALUES (471, 46, '05', 'Luricocha', NULL, '050405');
INSERT INTO `distrito` VALUES (472, 46, '06', 'Santillana', NULL, '050406');
INSERT INTO `distrito` VALUES (473, 46, '07', 'Sivia', NULL, '050407');
INSERT INTO `distrito` VALUES (474, 46, '08', 'Llochegua', NULL, '050408');
INSERT INTO `distrito` VALUES (475, 46, '09', 'Canayre', NULL, '050409');
INSERT INTO `distrito` VALUES (476, 46, '10', 'Uchuraccay', NULL, '050410');
INSERT INTO `distrito` VALUES (477, 46, '11', 'Pucacolpa', NULL, '050411');
INSERT INTO `distrito` VALUES (478, 47, '01', 'San Miguel', NULL, '050501');
INSERT INTO `distrito` VALUES (479, 47, '02', 'Anco', NULL, '050502');
INSERT INTO `distrito` VALUES (480, 47, '03', 'Ayna', NULL, '050503');
INSERT INTO `distrito` VALUES (481, 47, '04', 'Chilcas', NULL, '050504');
INSERT INTO `distrito` VALUES (482, 47, '05', 'Chungui', NULL, '050505');
INSERT INTO `distrito` VALUES (483, 47, '06', 'Luis Carranza', NULL, '050506');
INSERT INTO `distrito` VALUES (484, 47, '07', 'Santa Rosa', NULL, '050507');
INSERT INTO `distrito` VALUES (485, 47, '08', 'Tambo', NULL, '050508');
INSERT INTO `distrito` VALUES (486, 47, '09', 'Samugari', NULL, '050509');
INSERT INTO `distrito` VALUES (487, 47, '10', 'Anchihuay', NULL, '050510');
INSERT INTO `distrito` VALUES (488, 48, '01', 'Puquio', NULL, '050601');
INSERT INTO `distrito` VALUES (489, 48, '02', 'Aucara', NULL, '050602');
INSERT INTO `distrito` VALUES (490, 48, '03', 'Cabana', NULL, '050603');
INSERT INTO `distrito` VALUES (491, 48, '04', 'Carmen Salcedo', NULL, '050604');
INSERT INTO `distrito` VALUES (492, 48, '05', 'Chaviña', NULL, '050605');
INSERT INTO `distrito` VALUES (493, 48, '06', 'Chipao', NULL, '050606');
INSERT INTO `distrito` VALUES (494, 48, '07', 'Huac-Huas', NULL, '050607');
INSERT INTO `distrito` VALUES (495, 48, '08', 'Laramate', NULL, '050608');
INSERT INTO `distrito` VALUES (496, 48, '09', 'Leoncio Prado', NULL, '050609');
INSERT INTO `distrito` VALUES (497, 48, '10', 'Llauta', NULL, '050610');
INSERT INTO `distrito` VALUES (498, 48, '11', 'Lucanas', NULL, '050611');
INSERT INTO `distrito` VALUES (499, 48, '12', 'Ocaña', NULL, '050612');
INSERT INTO `distrito` VALUES (500, 48, '13', 'Otoca', NULL, '050613');
INSERT INTO `distrito` VALUES (501, 48, '14', 'Saisa', NULL, '050614');
INSERT INTO `distrito` VALUES (502, 48, '15', 'San Cristóbal', NULL, '050615');
INSERT INTO `distrito` VALUES (503, 48, '16', 'San Juan', NULL, '050616');
INSERT INTO `distrito` VALUES (504, 48, '17', 'San Pedro', NULL, '050617');
INSERT INTO `distrito` VALUES (505, 48, '18', 'San Pedro de Palco', NULL, '050618');
INSERT INTO `distrito` VALUES (506, 48, '19', 'Sancos', NULL, '050619');
INSERT INTO `distrito` VALUES (507, 48, '20', 'Santa Ana de Huaycahuacho', NULL, '050620');
INSERT INTO `distrito` VALUES (508, 48, '21', 'Santa Lucia', NULL, '050621');
INSERT INTO `distrito` VALUES (509, 49, '01', 'Coracora', NULL, '050701');
INSERT INTO `distrito` VALUES (510, 49, '02', 'Chumpi', NULL, '050702');
INSERT INTO `distrito` VALUES (511, 49, '03', 'Coronel Castañeda', NULL, '050703');
INSERT INTO `distrito` VALUES (512, 49, '04', 'Pacapausa', NULL, '050704');
INSERT INTO `distrito` VALUES (513, 49, '05', 'Pullo', NULL, '050705');
INSERT INTO `distrito` VALUES (514, 49, '06', 'Puyusca', NULL, '050706');
INSERT INTO `distrito` VALUES (515, 49, '07', 'San Francisco de Ravacayco', NULL, '050707');
INSERT INTO `distrito` VALUES (516, 49, '08', 'Upahuacho', NULL, '050708');
INSERT INTO `distrito` VALUES (517, 50, '01', 'Pausa', NULL, '050801');
INSERT INTO `distrito` VALUES (518, 50, '02', 'Colta', NULL, '050802');
INSERT INTO `distrito` VALUES (519, 50, '03', 'Corculla', NULL, '050803');
INSERT INTO `distrito` VALUES (520, 50, '04', 'Lampa', NULL, '050804');
INSERT INTO `distrito` VALUES (521, 50, '05', 'Marcabamba', NULL, '050805');
INSERT INTO `distrito` VALUES (522, 50, '06', 'Oyolo', NULL, '050806');
INSERT INTO `distrito` VALUES (523, 50, '07', 'Pararca', NULL, '050807');
INSERT INTO `distrito` VALUES (524, 50, '08', 'San Javier de Alpabamba', NULL, '050808');
INSERT INTO `distrito` VALUES (525, 50, '09', 'San José de Ushua', NULL, '050809');
INSERT INTO `distrito` VALUES (526, 50, '10', 'Sara Sara', NULL, '050810');
INSERT INTO `distrito` VALUES (527, 51, '01', 'Querobamba', NULL, '050901');
INSERT INTO `distrito` VALUES (528, 51, '02', 'Belén', NULL, '050902');
INSERT INTO `distrito` VALUES (529, 51, '03', 'Chalcos', NULL, '050903');
INSERT INTO `distrito` VALUES (530, 51, '04', 'Chilcayoc', NULL, '050904');
INSERT INTO `distrito` VALUES (531, 51, '05', 'Huacaña', NULL, '050905');
INSERT INTO `distrito` VALUES (532, 51, '06', 'Morcolla', NULL, '050906');
INSERT INTO `distrito` VALUES (533, 51, '07', 'Paico', NULL, '050907');
INSERT INTO `distrito` VALUES (534, 51, '08', 'San Pedro de Larcay', NULL, '050908');
INSERT INTO `distrito` VALUES (535, 51, '09', 'San Salvador de Quije', NULL, '050909');
INSERT INTO `distrito` VALUES (536, 51, '10', 'Santiago de Paucaray', NULL, '050910');
INSERT INTO `distrito` VALUES (537, 51, '11', 'Soras', NULL, '050911');
INSERT INTO `distrito` VALUES (538, 52, '01', 'Huancapi', NULL, '051001');
INSERT INTO `distrito` VALUES (539, 52, '02', 'Alcamenca', NULL, '051002');
INSERT INTO `distrito` VALUES (540, 52, '03', 'Apongo', NULL, '051003');
INSERT INTO `distrito` VALUES (541, 52, '04', 'Asquipata', NULL, '051004');
INSERT INTO `distrito` VALUES (542, 52, '05', 'Canaria', NULL, '051005');
INSERT INTO `distrito` VALUES (543, 52, '06', 'Cayara', NULL, '051006');
INSERT INTO `distrito` VALUES (544, 52, '07', 'Colca', NULL, '051007');
INSERT INTO `distrito` VALUES (545, 52, '08', 'Huamanquiquia', NULL, '051008');
INSERT INTO `distrito` VALUES (546, 52, '09', 'Huancaraylla', NULL, '051009');
INSERT INTO `distrito` VALUES (547, 52, '10', 'Huaya', NULL, '051010');
INSERT INTO `distrito` VALUES (548, 52, '11', 'Sarhua', NULL, '051011');
INSERT INTO `distrito` VALUES (549, 52, '12', 'Vilcanchos', NULL, '051012');
INSERT INTO `distrito` VALUES (550, 53, '01', 'Vilcas Huaman', NULL, '051101');
INSERT INTO `distrito` VALUES (551, 53, '02', 'Accomarca', NULL, '051102');
INSERT INTO `distrito` VALUES (552, 53, '03', 'Carhuanca', NULL, '051103');
INSERT INTO `distrito` VALUES (553, 53, '04', 'Concepción', NULL, '051104');
INSERT INTO `distrito` VALUES (554, 53, '05', 'Huambalpa', NULL, '051105');
INSERT INTO `distrito` VALUES (555, 53, '06', 'Independencia', NULL, '051106');
INSERT INTO `distrito` VALUES (556, 53, '07', 'Saurama', NULL, '051107');
INSERT INTO `distrito` VALUES (557, 53, '08', 'Vischongo', NULL, '051108');
INSERT INTO `distrito` VALUES (558, 54, '01', 'Cajamarca', NULL, '060101');
INSERT INTO `distrito` VALUES (559, 54, '02', 'Asunción', NULL, '060102');
INSERT INTO `distrito` VALUES (560, 54, '03', 'Chetilla', NULL, '060103');
INSERT INTO `distrito` VALUES (561, 54, '04', 'Cospan', NULL, '060104');
INSERT INTO `distrito` VALUES (562, 54, '05', 'Encañada', NULL, '060105');
INSERT INTO `distrito` VALUES (563, 54, '06', 'Jesús', NULL, '060106');
INSERT INTO `distrito` VALUES (564, 54, '07', 'Llacanora', NULL, '060107');
INSERT INTO `distrito` VALUES (565, 54, '08', 'Los Baños del Inca', NULL, '060108');
INSERT INTO `distrito` VALUES (566, 54, '09', 'Magdalena', NULL, '060109');
INSERT INTO `distrito` VALUES (567, 54, '10', 'Matara', NULL, '060110');
INSERT INTO `distrito` VALUES (568, 54, '11', 'Namora', NULL, '060111');
INSERT INTO `distrito` VALUES (569, 54, '12', 'San Juan', NULL, '060112');
INSERT INTO `distrito` VALUES (570, 55, '01', 'Cajabamba', NULL, '060201');
INSERT INTO `distrito` VALUES (571, 55, '02', 'Cachachi', NULL, '060202');
INSERT INTO `distrito` VALUES (572, 55, '03', 'Condebamba', NULL, '060203');
INSERT INTO `distrito` VALUES (573, 55, '04', 'Sitacocha', NULL, '060204');
INSERT INTO `distrito` VALUES (574, 56, '01', 'Celendín', NULL, '060301');
INSERT INTO `distrito` VALUES (575, 56, '02', 'Chumuch', NULL, '060302');
INSERT INTO `distrito` VALUES (576, 56, '03', 'Cortegana', NULL, '060303');
INSERT INTO `distrito` VALUES (577, 56, '04', 'Huasmin', NULL, '060304');
INSERT INTO `distrito` VALUES (578, 56, '05', 'Jorge Chávez', NULL, '060305');
INSERT INTO `distrito` VALUES (579, 56, '06', 'José Gálvez', NULL, '060306');
INSERT INTO `distrito` VALUES (580, 56, '07', 'Miguel Iglesias', NULL, '060307');
INSERT INTO `distrito` VALUES (581, 56, '08', 'Oxamarca', NULL, '060308');
INSERT INTO `distrito` VALUES (582, 56, '09', 'Sorochuco', NULL, '060309');
INSERT INTO `distrito` VALUES (583, 56, '10', 'Sucre', NULL, '060310');
INSERT INTO `distrito` VALUES (584, 56, '11', 'Utco', NULL, '060311');
INSERT INTO `distrito` VALUES (585, 56, '12', 'La Libertad de Pallan', NULL, '060312');
INSERT INTO `distrito` VALUES (586, 57, '01', 'Chota', NULL, '060401');
INSERT INTO `distrito` VALUES (587, 57, '02', 'Anguia', NULL, '060402');
INSERT INTO `distrito` VALUES (588, 57, '03', 'Chadin', NULL, '060403');
INSERT INTO `distrito` VALUES (589, 57, '04', 'Chiguirip', NULL, '060404');
INSERT INTO `distrito` VALUES (590, 57, '05', 'Chimban', NULL, '060405');
INSERT INTO `distrito` VALUES (591, 57, '06', 'Choropampa', NULL, '060406');
INSERT INTO `distrito` VALUES (592, 57, '07', 'Cochabamba', NULL, '060407');
INSERT INTO `distrito` VALUES (593, 57, '08', 'Conchan', NULL, '060408');
INSERT INTO `distrito` VALUES (594, 57, '09', 'Huambos', NULL, '060409');
INSERT INTO `distrito` VALUES (595, 57, '10', 'Lajas', NULL, '060410');
INSERT INTO `distrito` VALUES (596, 57, '11', 'Llama', NULL, '060411');
INSERT INTO `distrito` VALUES (597, 57, '12', 'Miracosta', NULL, '060412');
INSERT INTO `distrito` VALUES (598, 57, '13', 'Paccha', NULL, '060413');
INSERT INTO `distrito` VALUES (599, 57, '14', 'Pion', NULL, '060414');
INSERT INTO `distrito` VALUES (600, 57, '15', 'Querocoto', NULL, '060415');
INSERT INTO `distrito` VALUES (601, 57, '16', 'San Juan de Licupis', NULL, '060416');
INSERT INTO `distrito` VALUES (602, 57, '17', 'Tacabamba', NULL, '060417');
INSERT INTO `distrito` VALUES (603, 57, '18', 'Tocmoche', NULL, '060418');
INSERT INTO `distrito` VALUES (604, 57, '19', 'Chalamarca', NULL, '060419');
INSERT INTO `distrito` VALUES (605, 58, '01', 'Contumaza', NULL, '060501');
INSERT INTO `distrito` VALUES (606, 58, '02', 'Chilete', NULL, '060502');
INSERT INTO `distrito` VALUES (607, 58, '03', 'Cupisnique', NULL, '060503');
INSERT INTO `distrito` VALUES (608, 58, '04', 'Guzmango', NULL, '060504');
INSERT INTO `distrito` VALUES (609, 58, '05', 'San Benito', NULL, '060505');
INSERT INTO `distrito` VALUES (610, 58, '06', 'Santa Cruz de Toledo', NULL, '060506');
INSERT INTO `distrito` VALUES (611, 58, '07', 'Tantarica', NULL, '060507');
INSERT INTO `distrito` VALUES (612, 58, '08', 'Yonan', NULL, '060508');
INSERT INTO `distrito` VALUES (613, 59, '01', 'Cutervo', NULL, '060601');
INSERT INTO `distrito` VALUES (614, 59, '02', 'Callayuc', NULL, '060602');
INSERT INTO `distrito` VALUES (615, 59, '03', 'Choros', NULL, '060603');
INSERT INTO `distrito` VALUES (616, 59, '04', 'Cujillo', NULL, '060604');
INSERT INTO `distrito` VALUES (617, 59, '05', 'La Ramada', NULL, '060605');
INSERT INTO `distrito` VALUES (618, 59, '06', 'Pimpingos', NULL, '060606');
INSERT INTO `distrito` VALUES (619, 59, '07', 'Querocotillo', NULL, '060607');
INSERT INTO `distrito` VALUES (620, 59, '08', 'San Andrés de Cutervo', NULL, '060608');
INSERT INTO `distrito` VALUES (621, 59, '09', 'San Juan de Cutervo', NULL, '060609');
INSERT INTO `distrito` VALUES (622, 59, '10', 'San Luis de Lucma', NULL, '060610');
INSERT INTO `distrito` VALUES (623, 59, '11', 'Santa Cruz', NULL, '060611');
INSERT INTO `distrito` VALUES (624, 59, '12', 'Santo Domingo de la Capilla', NULL, '060612');
INSERT INTO `distrito` VALUES (625, 59, '13', 'Santo Tomas', NULL, '060613');
INSERT INTO `distrito` VALUES (626, 59, '14', 'Socota', NULL, '060614');
INSERT INTO `distrito` VALUES (627, 59, '15', 'Toribio Casanova', NULL, '060615');
INSERT INTO `distrito` VALUES (628, 60, '01', 'Bambamarca', NULL, '060701');
INSERT INTO `distrito` VALUES (629, 60, '02', 'Chugur', NULL, '060702');
INSERT INTO `distrito` VALUES (630, 60, '03', 'Hualgayoc', NULL, '060703');
INSERT INTO `distrito` VALUES (631, 61, '01', 'Jaén', NULL, '060801');
INSERT INTO `distrito` VALUES (632, 61, '02', 'Bellavista', NULL, '060802');
INSERT INTO `distrito` VALUES (633, 61, '03', 'Chontali', NULL, '060803');
INSERT INTO `distrito` VALUES (634, 61, '04', 'Colasay', NULL, '060804');
INSERT INTO `distrito` VALUES (635, 61, '05', 'Huabal', NULL, '060805');
INSERT INTO `distrito` VALUES (636, 61, '06', 'Las Pirias', NULL, '060806');
INSERT INTO `distrito` VALUES (637, 61, '07', 'Pomahuaca', NULL, '060807');
INSERT INTO `distrito` VALUES (638, 61, '08', 'Pucara', NULL, '060808');
INSERT INTO `distrito` VALUES (639, 61, '09', 'Sallique', NULL, '060809');
INSERT INTO `distrito` VALUES (640, 61, '10', 'San Felipe', NULL, '060810');
INSERT INTO `distrito` VALUES (641, 61, '11', 'San José del Alto', NULL, '060811');
INSERT INTO `distrito` VALUES (642, 61, '12', 'Santa Rosa', NULL, '060812');
INSERT INTO `distrito` VALUES (643, 62, '01', 'San Ignacio', NULL, '060901');
INSERT INTO `distrito` VALUES (644, 62, '02', 'Chirinos', NULL, '060902');
INSERT INTO `distrito` VALUES (645, 62, '03', 'Huarango', NULL, '060903');
INSERT INTO `distrito` VALUES (646, 62, '04', 'La Coipa', NULL, '060904');
INSERT INTO `distrito` VALUES (647, 62, '05', 'Namballe', NULL, '060905');
INSERT INTO `distrito` VALUES (648, 62, '06', 'San José de Lourdes', NULL, '060906');
INSERT INTO `distrito` VALUES (649, 62, '07', 'Tabaconas', NULL, '060907');
INSERT INTO `distrito` VALUES (650, 63, '01', 'Pedro Gálvez', NULL, '061001');
INSERT INTO `distrito` VALUES (651, 63, '02', 'Chancay', NULL, '061002');
INSERT INTO `distrito` VALUES (652, 63, '03', 'Eduardo Villanueva', NULL, '061003');
INSERT INTO `distrito` VALUES (653, 63, '04', 'Gregorio Pita', NULL, '061004');
INSERT INTO `distrito` VALUES (654, 63, '05', 'Ichocan', NULL, '061005');
INSERT INTO `distrito` VALUES (655, 63, '06', 'José Manuel Quiroz', NULL, '061006');
INSERT INTO `distrito` VALUES (656, 63, '07', 'José Sabogal', NULL, '061007');
INSERT INTO `distrito` VALUES (657, 64, '01', 'San Miguel', NULL, '061101');
INSERT INTO `distrito` VALUES (658, 64, '02', 'Bolívar', NULL, '061102');
INSERT INTO `distrito` VALUES (659, 64, '03', 'Calquis', NULL, '061103');
INSERT INTO `distrito` VALUES (660, 64, '04', 'Catilluc', NULL, '061104');
INSERT INTO `distrito` VALUES (661, 64, '05', 'El Prado', NULL, '061105');
INSERT INTO `distrito` VALUES (662, 64, '06', 'La Florida', NULL, '061106');
INSERT INTO `distrito` VALUES (663, 64, '07', 'Llapa', NULL, '061107');
INSERT INTO `distrito` VALUES (664, 64, '08', 'Nanchoc', NULL, '061108');
INSERT INTO `distrito` VALUES (665, 64, '09', 'Niepos', NULL, '061109');
INSERT INTO `distrito` VALUES (666, 64, '10', 'San Gregorio', NULL, '061110');
INSERT INTO `distrito` VALUES (667, 64, '11', 'San Silvestre de Cochan', NULL, '061111');
INSERT INTO `distrito` VALUES (668, 64, '12', 'Tongod', NULL, '061112');
INSERT INTO `distrito` VALUES (669, 64, '13', 'Unión Agua Blanca', NULL, '061113');
INSERT INTO `distrito` VALUES (670, 65, '01', 'San Pablo', NULL, '061201');
INSERT INTO `distrito` VALUES (671, 65, '02', 'San Bernardino', NULL, '061202');
INSERT INTO `distrito` VALUES (672, 65, '03', 'San Luis', NULL, '061203');
INSERT INTO `distrito` VALUES (673, 65, '04', 'Tumbaden', NULL, '061204');
INSERT INTO `distrito` VALUES (674, 66, '01', 'Santa Cruz', NULL, '061301');
INSERT INTO `distrito` VALUES (675, 66, '02', 'Andabamba', NULL, '061302');
INSERT INTO `distrito` VALUES (676, 66, '03', 'Catache', NULL, '061303');
INSERT INTO `distrito` VALUES (677, 66, '04', 'Chancaybaños', NULL, '061304');
INSERT INTO `distrito` VALUES (678, 66, '05', 'La Esperanza', NULL, '061305');
INSERT INTO `distrito` VALUES (679, 66, '06', 'Ninabamba', NULL, '061306');
INSERT INTO `distrito` VALUES (680, 66, '07', 'Pulan', NULL, '061307');
INSERT INTO `distrito` VALUES (681, 66, '08', 'Saucepampa', NULL, '061308');
INSERT INTO `distrito` VALUES (682, 66, '09', 'Sexi', NULL, '061309');
INSERT INTO `distrito` VALUES (683, 66, '10', 'Uticyacu', NULL, '061310');
INSERT INTO `distrito` VALUES (684, 66, '11', 'Yauyucan', NULL, '061311');
INSERT INTO `distrito` VALUES (685, 67, '01', 'Callao', NULL, '070101');
INSERT INTO `distrito` VALUES (686, 67, '02', 'Bellavista', NULL, '070102');
INSERT INTO `distrito` VALUES (687, 67, '03', 'Carmen de la Legua Reynoso', NULL, '070103');
INSERT INTO `distrito` VALUES (688, 67, '04', 'La Perla', NULL, '070104');
INSERT INTO `distrito` VALUES (689, 67, '05', 'La Punta', NULL, '070105');
INSERT INTO `distrito` VALUES (690, 67, '06', 'Ventanilla', NULL, '070106');
INSERT INTO `distrito` VALUES (691, 67, '07', 'Mi Perú', NULL, '070107');
INSERT INTO `distrito` VALUES (692, 68, '01', 'Cusco', NULL, '080101');
INSERT INTO `distrito` VALUES (693, 68, '02', 'Ccorca', NULL, '080102');
INSERT INTO `distrito` VALUES (694, 68, '03', 'Poroy', NULL, '080103');
INSERT INTO `distrito` VALUES (695, 68, '04', 'San Jerónimo', NULL, '080104');
INSERT INTO `distrito` VALUES (696, 68, '05', 'San Sebastian', NULL, '080105');
INSERT INTO `distrito` VALUES (697, 68, '06', 'Santiago', NULL, '080106');
INSERT INTO `distrito` VALUES (698, 68, '07', 'Saylla', NULL, '080107');
INSERT INTO `distrito` VALUES (699, 68, '08', 'Wanchaq', NULL, '080108');
INSERT INTO `distrito` VALUES (700, 69, '01', 'Acomayo', NULL, '080201');
INSERT INTO `distrito` VALUES (701, 69, '02', 'Acopia', NULL, '080202');
INSERT INTO `distrito` VALUES (702, 69, '03', 'Acos', NULL, '080203');
INSERT INTO `distrito` VALUES (703, 69, '04', 'Mosoc Llacta', NULL, '080204');
INSERT INTO `distrito` VALUES (704, 69, '05', 'Pomacanchi', NULL, '080205');
INSERT INTO `distrito` VALUES (705, 69, '06', 'Rondocan', NULL, '080206');
INSERT INTO `distrito` VALUES (706, 69, '07', 'Sangarara', NULL, '080207');
INSERT INTO `distrito` VALUES (707, 70, '01', 'Anta', NULL, '080301');
INSERT INTO `distrito` VALUES (708, 70, '02', 'Ancahuasi', NULL, '080302');
INSERT INTO `distrito` VALUES (709, 70, '03', 'Cachimayo', NULL, '080303');
INSERT INTO `distrito` VALUES (710, 70, '04', 'Chinchaypujio', NULL, '080304');
INSERT INTO `distrito` VALUES (711, 70, '05', 'Huarocondo', NULL, '080305');
INSERT INTO `distrito` VALUES (712, 70, '06', 'Limatambo', NULL, '080306');
INSERT INTO `distrito` VALUES (713, 70, '07', 'Mollepata', NULL, '080307');
INSERT INTO `distrito` VALUES (714, 70, '08', 'Pucyura', NULL, '080308');
INSERT INTO `distrito` VALUES (715, 70, '09', 'Zurite', NULL, '080309');
INSERT INTO `distrito` VALUES (716, 71, '01', 'Calca', NULL, '080401');
INSERT INTO `distrito` VALUES (717, 71, '02', 'Coya', NULL, '080402');
INSERT INTO `distrito` VALUES (718, 71, '03', 'Lamay', NULL, '080403');
INSERT INTO `distrito` VALUES (719, 71, '04', 'Lares', NULL, '080404');
INSERT INTO `distrito` VALUES (720, 71, '05', 'Pisac', NULL, '080405');
INSERT INTO `distrito` VALUES (721, 71, '06', 'San Salvador', NULL, '080406');
INSERT INTO `distrito` VALUES (722, 71, '07', 'Taray', NULL, '080407');
INSERT INTO `distrito` VALUES (723, 71, '08', 'Yanatile', NULL, '080408');
INSERT INTO `distrito` VALUES (724, 72, '01', 'Yanaoca', NULL, '080501');
INSERT INTO `distrito` VALUES (725, 72, '02', 'Checca', NULL, '080502');
INSERT INTO `distrito` VALUES (726, 72, '03', 'Kunturkanki', NULL, '080503');
INSERT INTO `distrito` VALUES (727, 72, '04', 'Langui', NULL, '080504');
INSERT INTO `distrito` VALUES (728, 72, '05', 'Layo', NULL, '080505');
INSERT INTO `distrito` VALUES (729, 72, '06', 'Pampamarca', NULL, '080506');
INSERT INTO `distrito` VALUES (730, 72, '07', 'Quehue', NULL, '080507');
INSERT INTO `distrito` VALUES (731, 72, '08', 'Tupac Amaru', NULL, '080508');
INSERT INTO `distrito` VALUES (732, 73, '01', 'Sicuani', NULL, '080601');
INSERT INTO `distrito` VALUES (733, 73, '02', 'Checacupe', NULL, '080602');
INSERT INTO `distrito` VALUES (734, 73, '03', 'Combapata', NULL, '080603');
INSERT INTO `distrito` VALUES (735, 73, '04', 'Marangani', NULL, '080604');
INSERT INTO `distrito` VALUES (736, 73, '05', 'Pitumarca', NULL, '080605');
INSERT INTO `distrito` VALUES (737, 73, '06', 'San Pablo', NULL, '080606');
INSERT INTO `distrito` VALUES (738, 73, '07', 'San Pedro', NULL, '080607');
INSERT INTO `distrito` VALUES (739, 73, '08', 'Tinta', NULL, '080608');
INSERT INTO `distrito` VALUES (740, 74, '01', 'Santo Tomas', NULL, '080701');
INSERT INTO `distrito` VALUES (741, 74, '02', 'Capacmarca', NULL, '080702');
INSERT INTO `distrito` VALUES (742, 74, '03', 'Chamaca', NULL, '080703');
INSERT INTO `distrito` VALUES (743, 74, '04', 'Colquemarca', NULL, '080704');
INSERT INTO `distrito` VALUES (744, 74, '05', 'Livitaca', NULL, '080705');
INSERT INTO `distrito` VALUES (745, 74, '06', 'Llusco', NULL, '080706');
INSERT INTO `distrito` VALUES (746, 74, '07', 'Quiñota', NULL, '080707');
INSERT INTO `distrito` VALUES (747, 74, '08', 'Velille', NULL, '080708');
INSERT INTO `distrito` VALUES (748, 75, '01', 'Espinar', NULL, '080801');
INSERT INTO `distrito` VALUES (749, 75, '02', 'Condoroma', NULL, '080802');
INSERT INTO `distrito` VALUES (750, 75, '03', 'Coporaque', NULL, '080803');
INSERT INTO `distrito` VALUES (751, 75, '04', 'Ocoruro', NULL, '080804');
INSERT INTO `distrito` VALUES (752, 75, '05', 'Pallpata', NULL, '080805');
INSERT INTO `distrito` VALUES (753, 75, '06', 'Pichigua', NULL, '080806');
INSERT INTO `distrito` VALUES (754, 75, '07', 'Suyckutambo', NULL, '080807');
INSERT INTO `distrito` VALUES (755, 75, '08', 'Alto Pichigua', NULL, '080808');
INSERT INTO `distrito` VALUES (756, 76, '01', 'Santa Ana', NULL, '080901');
INSERT INTO `distrito` VALUES (757, 76, '02', 'Echarate', NULL, '080902');
INSERT INTO `distrito` VALUES (758, 76, '03', 'Huayopata', NULL, '080903');
INSERT INTO `distrito` VALUES (759, 76, '04', 'Maranura', NULL, '080904');
INSERT INTO `distrito` VALUES (760, 76, '05', 'Ocobamba', NULL, '080905');
INSERT INTO `distrito` VALUES (761, 76, '06', 'Quellouno', NULL, '080906');
INSERT INTO `distrito` VALUES (762, 76, '07', 'Kimbiri', NULL, '080907');
INSERT INTO `distrito` VALUES (763, 76, '08', 'Santa Teresa', NULL, '080908');
INSERT INTO `distrito` VALUES (764, 76, '09', 'Vilcabamba', NULL, '080909');
INSERT INTO `distrito` VALUES (765, 76, '10', 'Pichari', NULL, '080910');
INSERT INTO `distrito` VALUES (766, 76, '11', 'Inkawasi', NULL, '080911');
INSERT INTO `distrito` VALUES (767, 76, '12', 'Villa Virgen', NULL, '080912');
INSERT INTO `distrito` VALUES (768, 76, '13', 'Villa Kintiarina', NULL, '080913');
INSERT INTO `distrito` VALUES (769, 77, '01', 'Paruro', NULL, '081001');
INSERT INTO `distrito` VALUES (770, 77, '02', 'Accha', NULL, '081002');
INSERT INTO `distrito` VALUES (771, 77, '03', 'Ccapi', NULL, '081003');
INSERT INTO `distrito` VALUES (772, 77, '04', 'Colcha', NULL, '081004');
INSERT INTO `distrito` VALUES (773, 77, '05', 'Huanoquite', NULL, '081005');
INSERT INTO `distrito` VALUES (774, 77, '06', 'Omacha', NULL, '081006');
INSERT INTO `distrito` VALUES (775, 77, '07', 'Paccaritambo', NULL, '081007');
INSERT INTO `distrito` VALUES (776, 77, '08', 'Pillpinto', NULL, '081008');
INSERT INTO `distrito` VALUES (777, 77, '09', 'Yaurisque', NULL, '081009');
INSERT INTO `distrito` VALUES (778, 78, '01', 'Paucartambo', NULL, '081101');
INSERT INTO `distrito` VALUES (779, 78, '02', 'Caicay', NULL, '081102');
INSERT INTO `distrito` VALUES (780, 78, '03', 'Challabamba', NULL, '081103');
INSERT INTO `distrito` VALUES (781, 78, '04', 'Colquepata', NULL, '081104');
INSERT INTO `distrito` VALUES (782, 78, '05', 'Huancarani', NULL, '081105');
INSERT INTO `distrito` VALUES (783, 78, '06', 'Kosñipata', NULL, '081106');
INSERT INTO `distrito` VALUES (784, 79, '01', 'Urcos', NULL, '081201');
INSERT INTO `distrito` VALUES (785, 79, '02', 'Andahuaylillas', NULL, '081202');
INSERT INTO `distrito` VALUES (786, 79, '03', 'Camanti', NULL, '081203');
INSERT INTO `distrito` VALUES (787, 79, '04', 'Ccarhuayo', NULL, '081204');
INSERT INTO `distrito` VALUES (788, 79, '05', 'Ccatca', NULL, '081205');
INSERT INTO `distrito` VALUES (789, 79, '06', 'Cusipata', NULL, '081206');
INSERT INTO `distrito` VALUES (790, 79, '07', 'Huaro', NULL, '081207');
INSERT INTO `distrito` VALUES (791, 79, '08', 'Lucre', NULL, '081208');
INSERT INTO `distrito` VALUES (792, 79, '09', 'Marcapata', NULL, '081209');
INSERT INTO `distrito` VALUES (793, 79, '10', 'Ocongate', NULL, '081210');
INSERT INTO `distrito` VALUES (794, 79, '11', 'Oropesa', NULL, '081211');
INSERT INTO `distrito` VALUES (795, 79, '12', 'Quiquijana', NULL, '081212');
INSERT INTO `distrito` VALUES (796, 80, '01', 'Urubamba', NULL, '081301');
INSERT INTO `distrito` VALUES (797, 80, '02', 'Chinchero', NULL, '081302');
INSERT INTO `distrito` VALUES (798, 80, '03', 'Huayllabamba', NULL, '081303');
INSERT INTO `distrito` VALUES (799, 80, '04', 'Machupicchu', NULL, '081304');
INSERT INTO `distrito` VALUES (800, 80, '05', 'Maras', NULL, '081305');
INSERT INTO `distrito` VALUES (801, 80, '06', 'Ollantaytambo', NULL, '081306');
INSERT INTO `distrito` VALUES (802, 80, '07', 'Yucay', NULL, '081307');
INSERT INTO `distrito` VALUES (803, 81, '01', 'Huancavelica', NULL, '090101');
INSERT INTO `distrito` VALUES (804, 81, '02', 'Acobambilla', NULL, '090102');
INSERT INTO `distrito` VALUES (805, 81, '03', 'Acoria', NULL, '090103');
INSERT INTO `distrito` VALUES (806, 81, '04', 'Conayca', NULL, '090104');
INSERT INTO `distrito` VALUES (807, 81, '05', 'Cuenca', NULL, '090105');
INSERT INTO `distrito` VALUES (808, 81, '06', 'Huachocolpa', NULL, '090106');
INSERT INTO `distrito` VALUES (809, 81, '07', 'Huayllahuara', NULL, '090107');
INSERT INTO `distrito` VALUES (810, 81, '08', 'Izcuchaca', NULL, '090108');
INSERT INTO `distrito` VALUES (811, 81, '09', 'Laria', NULL, '090109');
INSERT INTO `distrito` VALUES (812, 81, '10', 'Manta', NULL, '090110');
INSERT INTO `distrito` VALUES (813, 81, '11', 'Mariscal Cáceres', NULL, '090111');
INSERT INTO `distrito` VALUES (814, 81, '12', 'Moya', NULL, '090112');
INSERT INTO `distrito` VALUES (815, 81, '13', 'Nuevo Occoro', NULL, '090113');
INSERT INTO `distrito` VALUES (816, 81, '14', 'Palca', NULL, '090114');
INSERT INTO `distrito` VALUES (817, 81, '15', 'Pilchaca', NULL, '090115');
INSERT INTO `distrito` VALUES (818, 81, '16', 'Vilca', NULL, '090116');
INSERT INTO `distrito` VALUES (819, 81, '17', 'Yauli', NULL, '090117');
INSERT INTO `distrito` VALUES (820, 81, '18', 'Ascensión', NULL, '090118');
INSERT INTO `distrito` VALUES (821, 81, '19', 'Huando', NULL, '090119');
INSERT INTO `distrito` VALUES (822, 82, '01', 'Acobamba', NULL, '090201');
INSERT INTO `distrito` VALUES (823, 82, '02', 'Andabamba', NULL, '090202');
INSERT INTO `distrito` VALUES (824, 82, '03', 'Anta', NULL, '090203');
INSERT INTO `distrito` VALUES (825, 82, '04', 'Caja', NULL, '090204');
INSERT INTO `distrito` VALUES (826, 82, '05', 'Marcas', NULL, '090205');
INSERT INTO `distrito` VALUES (827, 82, '06', 'Paucara', NULL, '090206');
INSERT INTO `distrito` VALUES (828, 82, '07', 'Pomacocha', NULL, '090207');
INSERT INTO `distrito` VALUES (829, 82, '08', 'Rosario', NULL, '090208');
INSERT INTO `distrito` VALUES (830, 83, '01', 'Lircay', NULL, '090301');
INSERT INTO `distrito` VALUES (831, 83, '02', 'Anchonga', NULL, '090302');
INSERT INTO `distrito` VALUES (832, 83, '03', 'Callanmarca', NULL, '090303');
INSERT INTO `distrito` VALUES (833, 83, '04', 'Ccochaccasa', NULL, '090304');
INSERT INTO `distrito` VALUES (834, 83, '05', 'Chincho', NULL, '090305');
INSERT INTO `distrito` VALUES (835, 83, '06', 'Congalla', NULL, '090306');
INSERT INTO `distrito` VALUES (836, 83, '07', 'Huanca-Huanca', NULL, '090307');
INSERT INTO `distrito` VALUES (837, 83, '08', 'Huayllay Grande', NULL, '090308');
INSERT INTO `distrito` VALUES (838, 83, '09', 'Julcamarca', NULL, '090309');
INSERT INTO `distrito` VALUES (839, 83, '10', 'San Antonio de Antaparco', NULL, '090310');
INSERT INTO `distrito` VALUES (840, 83, '11', 'Santo Tomas de Pata', NULL, '090311');
INSERT INTO `distrito` VALUES (841, 83, '12', 'Secclla', NULL, '090312');
INSERT INTO `distrito` VALUES (842, 84, '01', 'Castrovirreyna', NULL, '090401');
INSERT INTO `distrito` VALUES (843, 84, '02', 'Arma', NULL, '090402');
INSERT INTO `distrito` VALUES (844, 84, '03', 'Aurahua', NULL, '090403');
INSERT INTO `distrito` VALUES (845, 84, '04', 'Capillas', NULL, '090404');
INSERT INTO `distrito` VALUES (846, 84, '05', 'Chupamarca', NULL, '090405');
INSERT INTO `distrito` VALUES (847, 84, '06', 'Cocas', NULL, '090406');
INSERT INTO `distrito` VALUES (848, 84, '07', 'Huachos', NULL, '090407');
INSERT INTO `distrito` VALUES (849, 84, '08', 'Huamatambo', NULL, '090408');
INSERT INTO `distrito` VALUES (850, 84, '09', 'Mollepampa', NULL, '090409');
INSERT INTO `distrito` VALUES (851, 84, '10', 'San Juan', NULL, '090410');
INSERT INTO `distrito` VALUES (852, 84, '11', 'Santa Ana', NULL, '090411');
INSERT INTO `distrito` VALUES (853, 84, '12', 'Tantara', NULL, '090412');
INSERT INTO `distrito` VALUES (854, 84, '13', 'Ticrapo', NULL, '090413');
INSERT INTO `distrito` VALUES (855, 85, '01', 'Churcampa', NULL, '090501');
INSERT INTO `distrito` VALUES (856, 85, '02', 'Anco', NULL, '090502');
INSERT INTO `distrito` VALUES (857, 85, '03', 'Chinchihuasi', NULL, '090503');
INSERT INTO `distrito` VALUES (858, 85, '04', 'El Carmen', NULL, '090504');
INSERT INTO `distrito` VALUES (859, 85, '05', 'La Merced', NULL, '090505');
INSERT INTO `distrito` VALUES (860, 85, '06', 'Locroja', NULL, '090506');
INSERT INTO `distrito` VALUES (861, 85, '07', 'Paucarbamba', NULL, '090507');
INSERT INTO `distrito` VALUES (862, 85, '08', 'San Miguel de Mayocc', NULL, '090508');
INSERT INTO `distrito` VALUES (863, 85, '09', 'San Pedro de Coris', NULL, '090509');
INSERT INTO `distrito` VALUES (864, 85, '10', 'Pachamarca', NULL, '090510');
INSERT INTO `distrito` VALUES (865, 85, '11', 'Cosme', NULL, '090511');
INSERT INTO `distrito` VALUES (866, 86, '01', 'Huaytara', NULL, '090601');
INSERT INTO `distrito` VALUES (867, 86, '02', 'Ayavi', NULL, '090602');
INSERT INTO `distrito` VALUES (868, 86, '03', 'Córdova', NULL, '090603');
INSERT INTO `distrito` VALUES (869, 86, '04', 'Huayacundo Arma', NULL, '090604');
INSERT INTO `distrito` VALUES (870, 86, '05', 'Laramarca', NULL, '090605');
INSERT INTO `distrito` VALUES (871, 86, '06', 'Ocoyo', NULL, '090606');
INSERT INTO `distrito` VALUES (872, 86, '07', 'Pilpichaca', NULL, '090607');
INSERT INTO `distrito` VALUES (873, 86, '08', 'Querco', NULL, '090608');
INSERT INTO `distrito` VALUES (874, 86, '09', 'Quito-Arma', NULL, '090609');
INSERT INTO `distrito` VALUES (875, 86, '10', 'San Antonio de Cusicancha', NULL, '090610');
INSERT INTO `distrito` VALUES (876, 86, '11', 'San Francisco de Sangayaico', NULL, '090611');
INSERT INTO `distrito` VALUES (877, 86, '12', 'San Isidro', NULL, '090612');
INSERT INTO `distrito` VALUES (878, 86, '13', 'Santiago de Chocorvos', NULL, '090613');
INSERT INTO `distrito` VALUES (879, 86, '14', 'Santiago de Quirahuara', NULL, '090614');
INSERT INTO `distrito` VALUES (880, 86, '15', 'Santo Domingo de Capillas', NULL, '090615');
INSERT INTO `distrito` VALUES (881, 86, '16', 'Tambo', NULL, '090616');
INSERT INTO `distrito` VALUES (882, 87, '01', 'Pampas', NULL, '090701');
INSERT INTO `distrito` VALUES (883, 87, '02', 'Acostambo', NULL, '090702');
INSERT INTO `distrito` VALUES (884, 87, '03', 'Acraquia', NULL, '090703');
INSERT INTO `distrito` VALUES (885, 87, '04', 'Ahuaycha', NULL, '090704');
INSERT INTO `distrito` VALUES (886, 87, '05', 'Colcabamba', NULL, '090705');
INSERT INTO `distrito` VALUES (887, 87, '06', 'Daniel Hernández', NULL, '090706');
INSERT INTO `distrito` VALUES (888, 87, '07', 'Huachocolpa', NULL, '090707');
INSERT INTO `distrito` VALUES (889, 87, '09', 'Huaribamba', NULL, '090709');
INSERT INTO `distrito` VALUES (890, 87, '10', 'Ñahuimpuquio', NULL, '090710');
INSERT INTO `distrito` VALUES (891, 87, '11', 'Pazos', NULL, '090711');
INSERT INTO `distrito` VALUES (892, 87, '13', 'Quishuar', NULL, '090713');
INSERT INTO `distrito` VALUES (893, 87, '14', 'Salcabamba', NULL, '090714');
INSERT INTO `distrito` VALUES (894, 87, '15', 'Salcahuasi', NULL, '090715');
INSERT INTO `distrito` VALUES (895, 87, '16', 'San Marcos de Rocchac', NULL, '090716');
INSERT INTO `distrito` VALUES (896, 87, '17', 'Surcubamba', NULL, '090717');
INSERT INTO `distrito` VALUES (897, 87, '18', 'Tintay Puncu', NULL, '090718');
INSERT INTO `distrito` VALUES (898, 87, '19', 'Quichuas', NULL, '090719');
INSERT INTO `distrito` VALUES (899, 87, '20', 'Andaymarca', NULL, '090720');
INSERT INTO `distrito` VALUES (900, 88, '01', 'Huanuco', NULL, '100101');
INSERT INTO `distrito` VALUES (901, 88, '02', 'Amarilis', NULL, '100102');
INSERT INTO `distrito` VALUES (902, 88, '03', 'Chinchao', NULL, '100103');
INSERT INTO `distrito` VALUES (903, 88, '04', 'Churubamba', NULL, '100104');
INSERT INTO `distrito` VALUES (904, 88, '05', 'Margos', NULL, '100105');
INSERT INTO `distrito` VALUES (905, 88, '06', 'Quisqui (Kichki)', NULL, '100106');
INSERT INTO `distrito` VALUES (906, 88, '07', 'San Francisco de Cayran', NULL, '100107');
INSERT INTO `distrito` VALUES (907, 88, '08', 'San Pedro de Chaulan', NULL, '100108');
INSERT INTO `distrito` VALUES (908, 88, '09', 'Santa María del Valle', NULL, '100109');
INSERT INTO `distrito` VALUES (909, 88, '10', 'Yarumayo', NULL, '100110');
INSERT INTO `distrito` VALUES (910, 88, '11', 'Pillco Marca', NULL, '100111');
INSERT INTO `distrito` VALUES (911, 88, '12', 'Yacus', NULL, '100112');
INSERT INTO `distrito` VALUES (912, 89, '01', 'Ambo', NULL, '100201');
INSERT INTO `distrito` VALUES (913, 89, '02', 'Cayna', NULL, '100202');
INSERT INTO `distrito` VALUES (914, 89, '03', 'Colpas', NULL, '100203');
INSERT INTO `distrito` VALUES (915, 89, '04', 'Conchamarca', NULL, '100204');
INSERT INTO `distrito` VALUES (916, 89, '05', 'Huacar', NULL, '100205');
INSERT INTO `distrito` VALUES (917, 89, '06', 'San Francisco', NULL, '100206');
INSERT INTO `distrito` VALUES (918, 89, '07', 'San Rafael', NULL, '100207');
INSERT INTO `distrito` VALUES (919, 89, '08', 'Tomay Kichwa', NULL, '100208');
INSERT INTO `distrito` VALUES (920, 90, '01', 'La Unión', NULL, '100301');
INSERT INTO `distrito` VALUES (921, 90, '07', 'Chuquis', NULL, '100307');
INSERT INTO `distrito` VALUES (922, 90, '11', 'Marías', NULL, '100311');
INSERT INTO `distrito` VALUES (923, 90, '13', 'Pachas', NULL, '100313');
INSERT INTO `distrito` VALUES (924, 90, '16', 'Quivilla', NULL, '100316');
INSERT INTO `distrito` VALUES (925, 90, '17', 'Ripan', NULL, '100317');
INSERT INTO `distrito` VALUES (926, 90, '21', 'Shunqui', NULL, '100321');
INSERT INTO `distrito` VALUES (927, 90, '22', 'Sillapata', NULL, '100322');
INSERT INTO `distrito` VALUES (928, 90, '23', 'Yanas', NULL, '100323');
INSERT INTO `distrito` VALUES (929, 91, '01', 'Huacaybamba', NULL, '100401');
INSERT INTO `distrito` VALUES (930, 91, '02', 'Canchabamba', NULL, '100402');
INSERT INTO `distrito` VALUES (931, 91, '03', 'Cochabamba', NULL, '100403');
INSERT INTO `distrito` VALUES (932, 91, '04', 'Pinra', NULL, '100404');
INSERT INTO `distrito` VALUES (933, 92, '01', 'Llata', NULL, '100501');
INSERT INTO `distrito` VALUES (934, 92, '02', 'Arancay', NULL, '100502');
INSERT INTO `distrito` VALUES (935, 92, '03', 'Chavín de Pariarca', NULL, '100503');
INSERT INTO `distrito` VALUES (936, 92, '04', 'Jacas Grande', NULL, '100504');
INSERT INTO `distrito` VALUES (937, 92, '05', 'Jircan', NULL, '100505');
INSERT INTO `distrito` VALUES (938, 92, '06', 'Miraflores', NULL, '100506');
INSERT INTO `distrito` VALUES (939, 92, '07', 'Monzón', NULL, '100507');
INSERT INTO `distrito` VALUES (940, 92, '08', 'Punchao', NULL, '100508');
INSERT INTO `distrito` VALUES (941, 92, '09', 'Puños', NULL, '100509');
INSERT INTO `distrito` VALUES (942, 92, '10', 'Singa', NULL, '100510');
INSERT INTO `distrito` VALUES (943, 92, '11', 'Tantamayo', NULL, '100511');
INSERT INTO `distrito` VALUES (944, 93, '01', 'Rupa-Rupa', NULL, '100601');
INSERT INTO `distrito` VALUES (945, 93, '02', 'Daniel Alomía Robles', NULL, '100602');
INSERT INTO `distrito` VALUES (946, 93, '03', 'Hermílio Valdizan', NULL, '100603');
INSERT INTO `distrito` VALUES (947, 93, '04', 'José Crespo y Castillo', NULL, '100604');
INSERT INTO `distrito` VALUES (948, 93, '05', 'Luyando', NULL, '100605');
INSERT INTO `distrito` VALUES (949, 93, '06', 'Mariano Damaso Beraun', NULL, '100606');
INSERT INTO `distrito` VALUES (950, 94, '01', 'Huacrachuco', NULL, '100701');
INSERT INTO `distrito` VALUES (951, 94, '02', 'Cholon', NULL, '100702');
INSERT INTO `distrito` VALUES (952, 94, '03', 'San Buenaventura', NULL, '100703');
INSERT INTO `distrito` VALUES (953, 95, '01', 'Panao', NULL, '100801');
INSERT INTO `distrito` VALUES (954, 95, '02', 'Chaglla', NULL, '100802');
INSERT INTO `distrito` VALUES (955, 95, '03', 'Molino', NULL, '100803');
INSERT INTO `distrito` VALUES (956, 95, '04', 'Umari', NULL, '100804');
INSERT INTO `distrito` VALUES (957, 96, '01', 'Puerto Inca', NULL, '100901');
INSERT INTO `distrito` VALUES (958, 96, '02', 'Codo del Pozuzo', NULL, '100902');
INSERT INTO `distrito` VALUES (959, 96, '03', 'Honoria', NULL, '100903');
INSERT INTO `distrito` VALUES (960, 96, '04', 'Tournavista', NULL, '100904');
INSERT INTO `distrito` VALUES (961, 96, '05', 'Yuyapichis', NULL, '100905');
INSERT INTO `distrito` VALUES (962, 97, '01', 'Jesús', NULL, '101001');
INSERT INTO `distrito` VALUES (963, 97, '02', 'Baños', NULL, '101002');
INSERT INTO `distrito` VALUES (964, 97, '03', 'Jivia', NULL, '101003');
INSERT INTO `distrito` VALUES (965, 97, '04', 'Queropalca', NULL, '101004');
INSERT INTO `distrito` VALUES (966, 97, '05', 'Rondos', NULL, '101005');
INSERT INTO `distrito` VALUES (967, 97, '06', 'San Francisco de Asís', NULL, '101006');
INSERT INTO `distrito` VALUES (968, 97, '07', 'San Miguel de Cauri', NULL, '101007');
INSERT INTO `distrito` VALUES (969, 98, '01', 'Chavinillo', NULL, '101101');
INSERT INTO `distrito` VALUES (970, 98, '02', 'Cahuac', NULL, '101102');
INSERT INTO `distrito` VALUES (971, 98, '03', 'Chacabamba', NULL, '101103');
INSERT INTO `distrito` VALUES (972, 98, '04', 'Aparicio Pomares', NULL, '101104');
INSERT INTO `distrito` VALUES (973, 98, '05', 'Jacas Chico', NULL, '101105');
INSERT INTO `distrito` VALUES (974, 98, '06', 'Obas', NULL, '101106');
INSERT INTO `distrito` VALUES (975, 98, '07', 'Pampamarca', NULL, '101107');
INSERT INTO `distrito` VALUES (976, 98, '08', 'Choras', NULL, '101108');
INSERT INTO `distrito` VALUES (977, 99, '01', 'Ica', NULL, '110101');
INSERT INTO `distrito` VALUES (978, 99, '02', 'La Tinguiña', NULL, '110102');
INSERT INTO `distrito` VALUES (979, 99, '03', 'Los Aquijes', NULL, '110103');
INSERT INTO `distrito` VALUES (980, 99, '04', 'Ocucaje', NULL, '110104');
INSERT INTO `distrito` VALUES (981, 99, '05', 'Pachacutec', NULL, '110105');
INSERT INTO `distrito` VALUES (982, 99, '06', 'Parcona', NULL, '110106');
INSERT INTO `distrito` VALUES (983, 99, '07', 'Pueblo Nuevo', NULL, '110107');
INSERT INTO `distrito` VALUES (984, 99, '08', 'Salas', NULL, '110108');
INSERT INTO `distrito` VALUES (985, 99, '09', 'San José de Los Molinos', NULL, '110109');
INSERT INTO `distrito` VALUES (986, 99, '10', 'San Juan Bautista', NULL, '110110');
INSERT INTO `distrito` VALUES (987, 99, '11', 'Santiago', NULL, '110111');
INSERT INTO `distrito` VALUES (988, 99, '12', 'Subtanjalla', NULL, '110112');
INSERT INTO `distrito` VALUES (989, 99, '13', 'Tate', NULL, '110113');
INSERT INTO `distrito` VALUES (990, 99, '14', 'Yauca del Rosario', NULL, '110114');
INSERT INTO `distrito` VALUES (991, 100, '01', 'Chincha Alta', NULL, '110201');
INSERT INTO `distrito` VALUES (992, 100, '02', 'Alto Laran', NULL, '110202');
INSERT INTO `distrito` VALUES (993, 100, '03', 'Chavin', NULL, '110203');
INSERT INTO `distrito` VALUES (994, 100, '04', 'Chincha Baja', NULL, '110204');
INSERT INTO `distrito` VALUES (995, 100, '05', 'El Carmen', NULL, '110205');
INSERT INTO `distrito` VALUES (996, 100, '06', 'Grocio Prado', NULL, '110206');
INSERT INTO `distrito` VALUES (997, 100, '07', 'Pueblo Nuevo', NULL, '110207');
INSERT INTO `distrito` VALUES (998, 100, '08', 'San Juan de Yanac', NULL, '110208');
INSERT INTO `distrito` VALUES (999, 100, '09', 'San Pedro de Huacarpana', NULL, '110209');
INSERT INTO `distrito` VALUES (1000, 100, '10', 'Sunampe', NULL, '110210');
INSERT INTO `distrito` VALUES (1001, 100, '11', 'Tambo de Mora', NULL, '110211');
INSERT INTO `distrito` VALUES (1002, 101, '01', 'Nasca', NULL, '110301');
INSERT INTO `distrito` VALUES (1003, 101, '02', 'Changuillo', NULL, '110302');
INSERT INTO `distrito` VALUES (1004, 101, '03', 'El Ingenio', NULL, '110303');
INSERT INTO `distrito` VALUES (1005, 101, '04', 'Marcona', NULL, '110304');
INSERT INTO `distrito` VALUES (1006, 101, '05', 'Vista Alegre', NULL, '110305');
INSERT INTO `distrito` VALUES (1007, 102, '01', 'Palpa', NULL, '110401');
INSERT INTO `distrito` VALUES (1008, 102, '02', 'Llipata', NULL, '110402');
INSERT INTO `distrito` VALUES (1009, 102, '03', 'Río Grande', NULL, '110403');
INSERT INTO `distrito` VALUES (1010, 102, '04', 'Santa Cruz', NULL, '110404');
INSERT INTO `distrito` VALUES (1011, 102, '05', 'Tibillo', NULL, '110405');
INSERT INTO `distrito` VALUES (1012, 103, '01', 'Pisco', NULL, '110501');
INSERT INTO `distrito` VALUES (1013, 103, '02', 'Huancano', NULL, '110502');
INSERT INTO `distrito` VALUES (1014, 103, '03', 'Humay', NULL, '110503');
INSERT INTO `distrito` VALUES (1015, 103, '04', 'Independencia', NULL, '110504');
INSERT INTO `distrito` VALUES (1016, 103, '05', 'Paracas', NULL, '110505');
INSERT INTO `distrito` VALUES (1017, 103, '06', 'San Andrés', NULL, '110506');
INSERT INTO `distrito` VALUES (1018, 103, '07', 'San Clemente', NULL, '110507');
INSERT INTO `distrito` VALUES (1019, 103, '08', 'Tupac Amaru Inca', NULL, '110508');
INSERT INTO `distrito` VALUES (1020, 104, '01', 'Huancayo', NULL, '120101');
INSERT INTO `distrito` VALUES (1021, 104, '04', 'Carhuacallanga', NULL, '120104');
INSERT INTO `distrito` VALUES (1022, 104, '05', 'Chacapampa', NULL, '120105');
INSERT INTO `distrito` VALUES (1023, 104, '06', 'Chicche', NULL, '120106');
INSERT INTO `distrito` VALUES (1024, 104, '07', 'Chilca', NULL, '120107');
INSERT INTO `distrito` VALUES (1025, 104, '08', 'Chongos Alto', NULL, '120108');
INSERT INTO `distrito` VALUES (1026, 104, '11', 'Chupuro', NULL, '120111');
INSERT INTO `distrito` VALUES (1027, 104, '12', 'Colca', NULL, '120112');
INSERT INTO `distrito` VALUES (1028, 104, '13', 'Cullhuas', NULL, '120113');
INSERT INTO `distrito` VALUES (1029, 104, '14', 'El Tambo', NULL, '120114');
INSERT INTO `distrito` VALUES (1030, 104, '16', 'Huacrapuquio', NULL, '120116');
INSERT INTO `distrito` VALUES (1031, 104, '17', 'Hualhuas', NULL, '120117');
INSERT INTO `distrito` VALUES (1032, 104, '19', 'Huancan', NULL, '120119');
INSERT INTO `distrito` VALUES (1033, 104, '20', 'Huasicancha', NULL, '120120');
INSERT INTO `distrito` VALUES (1034, 104, '21', 'Huayucachi', NULL, '120121');
INSERT INTO `distrito` VALUES (1035, 104, '22', 'Ingenio', NULL, '120122');
INSERT INTO `distrito` VALUES (1036, 104, '24', 'Pariahuanca', NULL, '120124');
INSERT INTO `distrito` VALUES (1037, 104, '25', 'Pilcomayo', NULL, '120125');
INSERT INTO `distrito` VALUES (1038, 104, '26', 'Pucara', NULL, '120126');
INSERT INTO `distrito` VALUES (1039, 104, '27', 'Quichuay', NULL, '120127');
INSERT INTO `distrito` VALUES (1040, 104, '28', 'Quilcas', NULL, '120128');
INSERT INTO `distrito` VALUES (1041, 104, '29', 'San Agustín', NULL, '120129');
INSERT INTO `distrito` VALUES (1042, 104, '30', 'San Jerónimo de Tunan', NULL, '120130');
INSERT INTO `distrito` VALUES (1043, 104, '32', 'Saño', NULL, '120132');
INSERT INTO `distrito` VALUES (1044, 104, '33', 'Sapallanga', NULL, '120133');
INSERT INTO `distrito` VALUES (1045, 104, '34', 'Sicaya', NULL, '120134');
INSERT INTO `distrito` VALUES (1046, 104, '35', 'Santo Domingo de Acobamba', NULL, '120135');
INSERT INTO `distrito` VALUES (1047, 104, '36', 'Viques', NULL, '120136');
INSERT INTO `distrito` VALUES (1048, 105, '01', 'Concepción', NULL, '120201');
INSERT INTO `distrito` VALUES (1049, 105, '02', 'Aco', NULL, '120202');
INSERT INTO `distrito` VALUES (1050, 105, '03', 'Andamarca', NULL, '120203');
INSERT INTO `distrito` VALUES (1051, 105, '04', 'Chambara', NULL, '120204');
INSERT INTO `distrito` VALUES (1052, 105, '05', 'Cochas', NULL, '120205');
INSERT INTO `distrito` VALUES (1053, 105, '06', 'Comas', NULL, '120206');
INSERT INTO `distrito` VALUES (1054, 105, '07', 'Heroínas Toledo', NULL, '120207');
INSERT INTO `distrito` VALUES (1055, 105, '08', 'Manzanares', NULL, '120208');
INSERT INTO `distrito` VALUES (1056, 105, '09', 'Mariscal Castilla', NULL, '120209');
INSERT INTO `distrito` VALUES (1057, 105, '10', 'Matahuasi', NULL, '120210');
INSERT INTO `distrito` VALUES (1058, 105, '11', 'Mito', NULL, '120211');
INSERT INTO `distrito` VALUES (1059, 105, '12', 'Nueve de Julio', NULL, '120212');
INSERT INTO `distrito` VALUES (1060, 105, '13', 'Orcotuna', NULL, '120213');
INSERT INTO `distrito` VALUES (1061, 105, '14', 'San José de Quero', NULL, '120214');
INSERT INTO `distrito` VALUES (1062, 105, '15', 'Santa Rosa de Ocopa', NULL, '120215');
INSERT INTO `distrito` VALUES (1063, 106, '01', 'Chanchamayo', NULL, '120301');
INSERT INTO `distrito` VALUES (1064, 106, '02', 'Perene', NULL, '120302');
INSERT INTO `distrito` VALUES (1065, 106, '03', 'Pichanaqui', NULL, '120303');
INSERT INTO `distrito` VALUES (1066, 106, '04', 'San Luis de Shuaro', NULL, '120304');
INSERT INTO `distrito` VALUES (1067, 106, '05', 'San Ramón', NULL, '120305');
INSERT INTO `distrito` VALUES (1068, 106, '06', 'Vitoc', NULL, '120306');
INSERT INTO `distrito` VALUES (1069, 107, '01', 'Jauja', NULL, '120401');
INSERT INTO `distrito` VALUES (1070, 107, '02', 'Acolla', NULL, '120402');
INSERT INTO `distrito` VALUES (1071, 107, '03', 'Apata', NULL, '120403');
INSERT INTO `distrito` VALUES (1072, 107, '04', 'Ataura', NULL, '120404');
INSERT INTO `distrito` VALUES (1073, 107, '05', 'Canchayllo', NULL, '120405');
INSERT INTO `distrito` VALUES (1074, 107, '06', 'Curicaca', NULL, '120406');
INSERT INTO `distrito` VALUES (1075, 107, '07', 'El Mantaro', NULL, '120407');
INSERT INTO `distrito` VALUES (1076, 107, '08', 'Huamali', NULL, '120408');
INSERT INTO `distrito` VALUES (1077, 107, '09', 'Huaripampa', NULL, '120409');
INSERT INTO `distrito` VALUES (1078, 107, '10', 'Huertas', NULL, '120410');
INSERT INTO `distrito` VALUES (1079, 107, '11', 'Janjaillo', NULL, '120411');
INSERT INTO `distrito` VALUES (1080, 107, '12', 'Julcan', NULL, '120412');
INSERT INTO `distrito` VALUES (1081, 107, '13', 'Leonor Ordóñez', NULL, '120413');
INSERT INTO `distrito` VALUES (1082, 107, '14', 'Llocllapampa', NULL, '120414');
INSERT INTO `distrito` VALUES (1083, 107, '15', 'Marco', NULL, '120415');
INSERT INTO `distrito` VALUES (1084, 107, '16', 'Masma', NULL, '120416');
INSERT INTO `distrito` VALUES (1085, 107, '17', 'Masma Chicche', NULL, '120417');
INSERT INTO `distrito` VALUES (1086, 107, '18', 'Molinos', NULL, '120418');
INSERT INTO `distrito` VALUES (1087, 107, '19', 'Monobamba', NULL, '120419');
INSERT INTO `distrito` VALUES (1088, 107, '20', 'Muqui', NULL, '120420');
INSERT INTO `distrito` VALUES (1089, 107, '21', 'Muquiyauyo', NULL, '120421');
INSERT INTO `distrito` VALUES (1090, 107, '22', 'Paca', NULL, '120422');
INSERT INTO `distrito` VALUES (1091, 107, '23', 'Paccha', NULL, '120423');
INSERT INTO `distrito` VALUES (1092, 107, '24', 'Pancan', NULL, '120424');
INSERT INTO `distrito` VALUES (1093, 107, '25', 'Parco', NULL, '120425');
INSERT INTO `distrito` VALUES (1094, 107, '26', 'Pomacancha', NULL, '120426');
INSERT INTO `distrito` VALUES (1095, 107, '27', 'Ricran', NULL, '120427');
INSERT INTO `distrito` VALUES (1096, 107, '28', 'San Lorenzo', NULL, '120428');
INSERT INTO `distrito` VALUES (1097, 107, '29', 'San Pedro de Chunan', NULL, '120429');
INSERT INTO `distrito` VALUES (1098, 107, '30', 'Sausa', NULL, '120430');
INSERT INTO `distrito` VALUES (1099, 107, '31', 'Sincos', NULL, '120431');
INSERT INTO `distrito` VALUES (1100, 107, '32', 'Tunan Marca', NULL, '120432');
INSERT INTO `distrito` VALUES (1101, 107, '33', 'Yauli', NULL, '120433');
INSERT INTO `distrito` VALUES (1102, 107, '34', 'Yauyos', NULL, '120434');
INSERT INTO `distrito` VALUES (1103, 108, '01', 'Junin', NULL, '120501');
INSERT INTO `distrito` VALUES (1104, 108, '02', 'Carhuamayo', NULL, '120502');
INSERT INTO `distrito` VALUES (1105, 108, '03', 'Ondores', NULL, '120503');
INSERT INTO `distrito` VALUES (1106, 108, '04', 'Ulcumayo', NULL, '120504');
INSERT INTO `distrito` VALUES (1107, 109, '01', 'Satipo', NULL, '120601');
INSERT INTO `distrito` VALUES (1108, 109, '02', 'Coviriali', NULL, '120602');
INSERT INTO `distrito` VALUES (1109, 109, '03', 'Llaylla', NULL, '120603');
INSERT INTO `distrito` VALUES (1110, 109, '04', 'Mazamari', NULL, '120604');
INSERT INTO `distrito` VALUES (1111, 109, '05', 'Pampa Hermosa', NULL, '120605');
INSERT INTO `distrito` VALUES (1112, 109, '06', 'Pangoa', NULL, '120606');
INSERT INTO `distrito` VALUES (1113, 109, '07', 'Rio Negro', NULL, '120607');
INSERT INTO `distrito` VALUES (1114, 109, '08', 'Rio Tambo', NULL, '120608');
INSERT INTO `distrito` VALUES (1115, 109, '09', 'Vizcatan del Ene', NULL, '120609');
INSERT INTO `distrito` VALUES (1116, 110, '01', 'Tarma', NULL, '120701');
INSERT INTO `distrito` VALUES (1117, 110, '02', 'Acobamba', NULL, '120702');
INSERT INTO `distrito` VALUES (1118, 110, '03', 'Huaricolca', NULL, '120703');
INSERT INTO `distrito` VALUES (1119, 110, '04', 'Huasahuasi', NULL, '120704');
INSERT INTO `distrito` VALUES (1120, 110, '05', 'La Unión', NULL, '120705');
INSERT INTO `distrito` VALUES (1121, 110, '06', 'Palca', NULL, '120706');
INSERT INTO `distrito` VALUES (1122, 110, '07', 'Palcamayo', NULL, '120707');
INSERT INTO `distrito` VALUES (1123, 110, '08', 'San Pedro de Cajas', NULL, '120708');
INSERT INTO `distrito` VALUES (1124, 110, '09', 'Tapo', NULL, '120709');
INSERT INTO `distrito` VALUES (1125, 111, '01', 'La Oroya', NULL, '120801');
INSERT INTO `distrito` VALUES (1126, 111, '02', 'Chacapalpa', NULL, '120802');
INSERT INTO `distrito` VALUES (1127, 111, '03', 'Huay-Huay', NULL, '120803');
INSERT INTO `distrito` VALUES (1128, 111, '04', 'Marcapomacocha', NULL, '120804');
INSERT INTO `distrito` VALUES (1129, 111, '05', 'Morococha', NULL, '120805');
INSERT INTO `distrito` VALUES (1130, 111, '06', 'Paccha', NULL, '120806');
INSERT INTO `distrito` VALUES (1131, 111, '07', 'Santa Bárbara de Carhuacayan', NULL, '120807');
INSERT INTO `distrito` VALUES (1132, 111, '08', 'Santa Rosa de Sacco', NULL, '120808');
INSERT INTO `distrito` VALUES (1133, 111, '09', 'Suitucancha', NULL, '120809');
INSERT INTO `distrito` VALUES (1134, 111, '10', 'Yauli', NULL, '120810');
INSERT INTO `distrito` VALUES (1135, 112, '01', 'Chupaca', NULL, '120901');
INSERT INTO `distrito` VALUES (1136, 112, '02', 'Ahuac', NULL, '120902');
INSERT INTO `distrito` VALUES (1137, 112, '03', 'Chongos Bajo', NULL, '120903');
INSERT INTO `distrito` VALUES (1138, 112, '04', 'Huachac', NULL, '120904');
INSERT INTO `distrito` VALUES (1139, 112, '05', 'Huamancaca Chico', NULL, '120905');
INSERT INTO `distrito` VALUES (1140, 112, '06', 'San Juan de Iscos', NULL, '120906');
INSERT INTO `distrito` VALUES (1141, 112, '07', 'San Juan de Jarpa', NULL, '120907');
INSERT INTO `distrito` VALUES (1142, 112, '08', 'Tres de Diciembre', NULL, '120908');
INSERT INTO `distrito` VALUES (1143, 112, '09', 'Yanacancha', NULL, '120909');
INSERT INTO `distrito` VALUES (1144, 113, '01', 'Trujillo', NULL, '130101');
INSERT INTO `distrito` VALUES (1145, 113, '02', 'El Porvenir', NULL, '130102');
INSERT INTO `distrito` VALUES (1146, 113, '03', 'Florencia de Mora', NULL, '130103');
INSERT INTO `distrito` VALUES (1147, 113, '04', 'Huanchaco', NULL, '130104');
INSERT INTO `distrito` VALUES (1148, 113, '05', 'La Esperanza', NULL, '130105');
INSERT INTO `distrito` VALUES (1149, 113, '06', 'Laredo', NULL, '130106');
INSERT INTO `distrito` VALUES (1150, 113, '07', 'Moche', NULL, '130107');
INSERT INTO `distrito` VALUES (1151, 113, '08', 'Poroto', NULL, '130108');
INSERT INTO `distrito` VALUES (1152, 113, '09', 'Salaverry', NULL, '130109');
INSERT INTO `distrito` VALUES (1153, 113, '10', 'Simbal', NULL, '130110');
INSERT INTO `distrito` VALUES (1154, 113, '11', 'Victor Larco Herrera', NULL, '130111');
INSERT INTO `distrito` VALUES (1155, 114, '01', 'Ascope', NULL, '130201');
INSERT INTO `distrito` VALUES (1156, 114, '02', 'Chicama', NULL, '130202');
INSERT INTO `distrito` VALUES (1157, 114, '03', 'Chocope', NULL, '130203');
INSERT INTO `distrito` VALUES (1158, 114, '04', 'Magdalena de Cao', NULL, '130204');
INSERT INTO `distrito` VALUES (1159, 114, '05', 'Paijan', NULL, '130205');
INSERT INTO `distrito` VALUES (1160, 114, '06', 'Razuri', NULL, '130206');
INSERT INTO `distrito` VALUES (1161, 114, '07', 'Santiago de Cao', NULL, '130207');
INSERT INTO `distrito` VALUES (1162, 114, '08', 'Casa Grande', NULL, '130208');
INSERT INTO `distrito` VALUES (1163, 115, '01', 'Bolívar', NULL, '130301');
INSERT INTO `distrito` VALUES (1164, 115, '02', 'Bambamarca', NULL, '130302');
INSERT INTO `distrito` VALUES (1165, 115, '03', 'Condormarca', NULL, '130303');
INSERT INTO `distrito` VALUES (1166, 115, '04', 'Longotea', NULL, '130304');
INSERT INTO `distrito` VALUES (1167, 115, '05', 'Uchumarca', NULL, '130305');
INSERT INTO `distrito` VALUES (1168, 115, '06', 'Ucuncha', NULL, '130306');
INSERT INTO `distrito` VALUES (1169, 116, '01', 'Chepen', NULL, '130401');
INSERT INTO `distrito` VALUES (1170, 116, '02', 'Pacanga', NULL, '130402');
INSERT INTO `distrito` VALUES (1171, 116, '03', 'Pueblo Nuevo', NULL, '130403');
INSERT INTO `distrito` VALUES (1172, 117, '01', 'Julcan', NULL, '130501');
INSERT INTO `distrito` VALUES (1173, 117, '02', 'Calamarca', NULL, '130502');
INSERT INTO `distrito` VALUES (1174, 117, '03', 'Carabamba', NULL, '130503');
INSERT INTO `distrito` VALUES (1175, 117, '04', 'Huaso', NULL, '130504');
INSERT INTO `distrito` VALUES (1176, 118, '01', 'Otuzco', NULL, '130601');
INSERT INTO `distrito` VALUES (1177, 118, '02', 'Agallpampa', NULL, '130602');
INSERT INTO `distrito` VALUES (1178, 118, '04', 'Charat', NULL, '130604');
INSERT INTO `distrito` VALUES (1179, 118, '05', 'Huaranchal', NULL, '130605');
INSERT INTO `distrito` VALUES (1180, 118, '06', 'La Cuesta', NULL, '130606');
INSERT INTO `distrito` VALUES (1181, 118, '08', 'Mache', NULL, '130608');
INSERT INTO `distrito` VALUES (1182, 118, '10', 'Paranday', NULL, '130610');
INSERT INTO `distrito` VALUES (1183, 118, '11', 'Salpo', NULL, '130611');
INSERT INTO `distrito` VALUES (1184, 118, '13', 'Sinsicap', NULL, '130613');
INSERT INTO `distrito` VALUES (1185, 118, '14', 'Usquil', NULL, '130614');
INSERT INTO `distrito` VALUES (1186, 119, '01', 'San Pedro de Lloc', NULL, '130701');
INSERT INTO `distrito` VALUES (1187, 119, '02', 'Guadalupe', NULL, '130702');
INSERT INTO `distrito` VALUES (1188, 119, '03', 'Jequetepeque', NULL, '130703');
INSERT INTO `distrito` VALUES (1189, 119, '04', 'Pacasmayo', NULL, '130704');
INSERT INTO `distrito` VALUES (1190, 119, '05', 'San José', NULL, '130705');
INSERT INTO `distrito` VALUES (1191, 120, '01', 'Tayabamba', NULL, '130801');
INSERT INTO `distrito` VALUES (1192, 120, '02', 'Buldibuyo', NULL, '130802');
INSERT INTO `distrito` VALUES (1193, 120, '03', 'Chillia', NULL, '130803');
INSERT INTO `distrito` VALUES (1194, 120, '04', 'Huancaspata', NULL, '130804');
INSERT INTO `distrito` VALUES (1195, 120, '05', 'Huaylillas', NULL, '130805');
INSERT INTO `distrito` VALUES (1196, 120, '06', 'Huayo', NULL, '130806');
INSERT INTO `distrito` VALUES (1197, 120, '07', 'Ongon', NULL, '130807');
INSERT INTO `distrito` VALUES (1198, 120, '08', 'Parcoy', NULL, '130808');
INSERT INTO `distrito` VALUES (1199, 120, '09', 'Pataz', NULL, '130809');
INSERT INTO `distrito` VALUES (1200, 120, '10', 'Pias', NULL, '130810');
INSERT INTO `distrito` VALUES (1201, 120, '11', 'Santiago de Challas', NULL, '130811');
INSERT INTO `distrito` VALUES (1202, 120, '12', 'Taurija', NULL, '130812');
INSERT INTO `distrito` VALUES (1203, 120, '13', 'Urpay', NULL, '130813');
INSERT INTO `distrito` VALUES (1204, 121, '01', 'Huamachuco', NULL, '130901');
INSERT INTO `distrito` VALUES (1205, 121, '02', 'Chugay', NULL, '130902');
INSERT INTO `distrito` VALUES (1206, 121, '03', 'Cochorco', NULL, '130903');
INSERT INTO `distrito` VALUES (1207, 121, '04', 'Curgos', NULL, '130904');
INSERT INTO `distrito` VALUES (1208, 121, '05', 'Marcabal', NULL, '130905');
INSERT INTO `distrito` VALUES (1209, 121, '06', 'Sanagoran', NULL, '130906');
INSERT INTO `distrito` VALUES (1210, 121, '07', 'Sarin', NULL, '130907');
INSERT INTO `distrito` VALUES (1211, 121, '08', 'Sartimbamba', NULL, '130908');
INSERT INTO `distrito` VALUES (1212, 122, '01', 'Santiago de Chuco', NULL, '131001');
INSERT INTO `distrito` VALUES (1213, 122, '02', 'Angasmarca', NULL, '131002');
INSERT INTO `distrito` VALUES (1214, 122, '03', 'Cachicadan', NULL, '131003');
INSERT INTO `distrito` VALUES (1215, 122, '04', 'Mollebamba', NULL, '131004');
INSERT INTO `distrito` VALUES (1216, 122, '05', 'Mollepata', NULL, '131005');
INSERT INTO `distrito` VALUES (1217, 122, '06', 'Quiruvilca', NULL, '131006');
INSERT INTO `distrito` VALUES (1218, 122, '07', 'Santa Cruz de Chuca', NULL, '131007');
INSERT INTO `distrito` VALUES (1219, 122, '08', 'Sitabamba', NULL, '131008');
INSERT INTO `distrito` VALUES (1220, 123, '01', 'Cascas', NULL, '131101');
INSERT INTO `distrito` VALUES (1221, 123, '02', 'Lucma', NULL, '131102');
INSERT INTO `distrito` VALUES (1222, 123, '03', 'Marmot', NULL, '131103');
INSERT INTO `distrito` VALUES (1223, 123, '04', 'Sayapullo', NULL, '131104');
INSERT INTO `distrito` VALUES (1224, 124, '01', 'Viru', NULL, '131201');
INSERT INTO `distrito` VALUES (1225, 124, '02', 'Chao', NULL, '131202');
INSERT INTO `distrito` VALUES (1226, 124, '03', 'Guadalupito', NULL, '131203');
INSERT INTO `distrito` VALUES (1227, 125, '01', 'Chiclayo', NULL, '140101');
INSERT INTO `distrito` VALUES (1228, 125, '02', 'Chongoyape', NULL, '140102');
INSERT INTO `distrito` VALUES (1229, 125, '03', 'Eten', NULL, '140103');
INSERT INTO `distrito` VALUES (1230, 125, '04', 'Eten Puerto', NULL, '140104');
INSERT INTO `distrito` VALUES (1231, 125, '05', 'José Leonardo Ortiz', NULL, '140105');
INSERT INTO `distrito` VALUES (1232, 125, '06', 'La Victoria', NULL, '140106');
INSERT INTO `distrito` VALUES (1233, 125, '07', 'Lagunas', NULL, '140107');
INSERT INTO `distrito` VALUES (1234, 125, '08', 'Monsefu', NULL, '140108');
INSERT INTO `distrito` VALUES (1235, 125, '09', 'Nueva Arica', NULL, '140109');
INSERT INTO `distrito` VALUES (1236, 125, '10', 'Oyotun', NULL, '140110');
INSERT INTO `distrito` VALUES (1237, 125, '11', 'Picsi', NULL, '140111');
INSERT INTO `distrito` VALUES (1238, 125, '12', 'Pimentel', NULL, '140112');
INSERT INTO `distrito` VALUES (1239, 125, '13', 'Reque', NULL, '140113');
INSERT INTO `distrito` VALUES (1240, 125, '14', 'Santa Rosa', NULL, '140114');
INSERT INTO `distrito` VALUES (1241, 125, '15', 'Sana', NULL, '140115');
INSERT INTO `distrito` VALUES (1242, 125, '16', 'Cayalti', NULL, '140116');
INSERT INTO `distrito` VALUES (1243, 125, '17', 'Patapo', NULL, '140117');
INSERT INTO `distrito` VALUES (1244, 125, '18', 'Pomalca', NULL, '140118');
INSERT INTO `distrito` VALUES (1245, 125, '19', 'Pucala', NULL, '140119');
INSERT INTO `distrito` VALUES (1246, 125, '20', 'Tuman', NULL, '140120');
INSERT INTO `distrito` VALUES (1247, 126, '01', 'Ferreñafe', NULL, '140201');
INSERT INTO `distrito` VALUES (1248, 126, '02', 'Cañaris', NULL, '140202');
INSERT INTO `distrito` VALUES (1249, 126, '03', 'Incahuasi', NULL, '140203');
INSERT INTO `distrito` VALUES (1250, 126, '04', 'Manuel Antonio Mesones Muro', NULL, '140204');
INSERT INTO `distrito` VALUES (1251, 126, '05', 'Pitipo', NULL, '140205');
INSERT INTO `distrito` VALUES (1252, 126, '06', 'Pueblo Nuevo', NULL, '140206');
INSERT INTO `distrito` VALUES (1253, 127, '01', 'Lambayeque', NULL, '140301');
INSERT INTO `distrito` VALUES (1254, 127, '02', 'Chochope', NULL, '140302');
INSERT INTO `distrito` VALUES (1255, 127, '03', 'Illimo', NULL, '140303');
INSERT INTO `distrito` VALUES (1256, 127, '04', 'Jayanca', NULL, '140304');
INSERT INTO `distrito` VALUES (1257, 127, '05', 'Mochumi', NULL, '140305');
INSERT INTO `distrito` VALUES (1258, 127, '06', 'Morrope', NULL, '140306');
INSERT INTO `distrito` VALUES (1259, 127, '07', 'Motupe', NULL, '140307');
INSERT INTO `distrito` VALUES (1260, 127, '08', 'Olmos', NULL, '140308');
INSERT INTO `distrito` VALUES (1261, 127, '09', 'Pacora', NULL, '140309');
INSERT INTO `distrito` VALUES (1262, 127, '10', 'Salas', NULL, '140310');
INSERT INTO `distrito` VALUES (1263, 127, '11', 'San Jose', NULL, '140311');
INSERT INTO `distrito` VALUES (1264, 127, '12', 'Tucume', NULL, '140312');
INSERT INTO `distrito` VALUES (1265, 128, '01', 'Lima', NULL, '150101');
INSERT INTO `distrito` VALUES (1266, 128, '02', 'Ancón', NULL, '150102');
INSERT INTO `distrito` VALUES (1267, 128, '03', 'Ate', NULL, '150103');
INSERT INTO `distrito` VALUES (1268, 128, '04', 'Barranco', NULL, '150104');
INSERT INTO `distrito` VALUES (1269, 128, '05', 'Breña', NULL, '150105');
INSERT INTO `distrito` VALUES (1270, 128, '06', 'Carabayllo', NULL, '150106');
INSERT INTO `distrito` VALUES (1271, 128, '07', 'Chaclacayo', NULL, '150107');
INSERT INTO `distrito` VALUES (1272, 128, '08', 'Chorrillos', NULL, '150108');
INSERT INTO `distrito` VALUES (1273, 128, '09', 'Cieneguilla', NULL, '150109');
INSERT INTO `distrito` VALUES (1274, 128, '10', 'Comas', NULL, '150110');
INSERT INTO `distrito` VALUES (1275, 128, '11', 'El Agustino', NULL, '150111');
INSERT INTO `distrito` VALUES (1276, 128, '12', 'Independencia', NULL, '150112');
INSERT INTO `distrito` VALUES (1277, 128, '13', 'Jesus María', NULL, '150113');
INSERT INTO `distrito` VALUES (1278, 128, '14', 'La Molina', NULL, '150114');
INSERT INTO `distrito` VALUES (1279, 128, '15', 'La Victoria', NULL, '150115');
INSERT INTO `distrito` VALUES (1280, 128, '16', 'Lince', NULL, '150116');
INSERT INTO `distrito` VALUES (1281, 128, '17', 'Los Olivos', NULL, '150117');
INSERT INTO `distrito` VALUES (1282, 128, '18', 'Lurigancho', NULL, '150118');
INSERT INTO `distrito` VALUES (1283, 128, '19', 'Lurin', NULL, '150119');
INSERT INTO `distrito` VALUES (1284, 128, '20', 'Magdalena del Mar', NULL, '150120');
INSERT INTO `distrito` VALUES (1285, 128, '21', 'Pueblo Libre', NULL, '150121');
INSERT INTO `distrito` VALUES (1286, 128, '22', 'Miraflores', NULL, '150122');
INSERT INTO `distrito` VALUES (1287, 128, '23', 'Pachacamac', NULL, '150123');
INSERT INTO `distrito` VALUES (1288, 128, '24', 'Pucusana', NULL, '150124');
INSERT INTO `distrito` VALUES (1289, 128, '25', 'Puente Piedra', NULL, '150125');
INSERT INTO `distrito` VALUES (1290, 128, '26', 'Punta Hermosa', NULL, '150126');
INSERT INTO `distrito` VALUES (1291, 128, '27', 'Punta Negra', NULL, '150127');
INSERT INTO `distrito` VALUES (1292, 128, '28', 'Rímac', NULL, '150128');
INSERT INTO `distrito` VALUES (1293, 128, '29', 'San Bartolo', NULL, '150129');
INSERT INTO `distrito` VALUES (1294, 128, '30', 'San Borja', NULL, '150130');
INSERT INTO `distrito` VALUES (1295, 128, '31', 'San Isidro', NULL, '150131');
INSERT INTO `distrito` VALUES (1296, 128, '32', 'San Juan de Lurigancho', NULL, '150132');
INSERT INTO `distrito` VALUES (1297, 128, '33', 'San Juan de Miraflores', NULL, '150133');
INSERT INTO `distrito` VALUES (1298, 128, '34', 'San Luis', NULL, '150134');
INSERT INTO `distrito` VALUES (1299, 128, '35', 'San Martín de Porres', NULL, '150135');
INSERT INTO `distrito` VALUES (1300, 128, '36', 'San Miguel', NULL, '150136');
INSERT INTO `distrito` VALUES (1301, 128, '37', 'Santa Anita', NULL, '150137');
INSERT INTO `distrito` VALUES (1302, 128, '38', 'Santa María del Mar', NULL, '150138');
INSERT INTO `distrito` VALUES (1303, 128, '39', 'Santa Rosa', NULL, '150139');
INSERT INTO `distrito` VALUES (1304, 128, '40', 'Santiago de Surco', NULL, '150140');
INSERT INTO `distrito` VALUES (1305, 128, '41', 'Surquillo', NULL, '150141');
INSERT INTO `distrito` VALUES (1306, 128, '42', 'Villa El Salvador', NULL, '150142');
INSERT INTO `distrito` VALUES (1307, 128, '43', 'Villa María del Triunfo', NULL, '150143');
INSERT INTO `distrito` VALUES (1308, 129, '01', 'Barranca', NULL, '150201');
INSERT INTO `distrito` VALUES (1309, 129, '02', 'Paramonga', NULL, '150202');
INSERT INTO `distrito` VALUES (1310, 129, '03', 'Pativilca', NULL, '150203');
INSERT INTO `distrito` VALUES (1311, 129, '04', 'Supe', NULL, '150204');
INSERT INTO `distrito` VALUES (1312, 129, '05', 'Supe Puerto', NULL, '150205');
INSERT INTO `distrito` VALUES (1313, 130, '01', 'Cajatambo', NULL, '150301');
INSERT INTO `distrito` VALUES (1314, 130, '02', 'Copa', NULL, '150302');
INSERT INTO `distrito` VALUES (1315, 130, '03', 'Gorgor', NULL, '150303');
INSERT INTO `distrito` VALUES (1316, 130, '04', 'Huancapon', NULL, '150304');
INSERT INTO `distrito` VALUES (1317, 130, '05', 'Manas', NULL, '150305');
INSERT INTO `distrito` VALUES (1318, 131, '01', 'Canta', NULL, '150401');
INSERT INTO `distrito` VALUES (1319, 131, '02', 'Arahuay', NULL, '150402');
INSERT INTO `distrito` VALUES (1320, 131, '03', 'Huamantanga', NULL, '150403');
INSERT INTO `distrito` VALUES (1321, 131, '04', 'Huaros', NULL, '150404');
INSERT INTO `distrito` VALUES (1322, 131, '05', 'Lachaqui', NULL, '150405');
INSERT INTO `distrito` VALUES (1323, 131, '06', 'San Buenaventura', NULL, '150406');
INSERT INTO `distrito` VALUES (1324, 131, '07', 'Santa Rosa de Quives', NULL, '150407');
INSERT INTO `distrito` VALUES (1325, 132, '01', 'San Vicente de Cañete', NULL, '150501');
INSERT INTO `distrito` VALUES (1326, 132, '02', 'Asia', NULL, '150502');
INSERT INTO `distrito` VALUES (1327, 132, '03', 'Calango', NULL, '150503');
INSERT INTO `distrito` VALUES (1328, 132, '04', 'Cerro Azul', NULL, '150504');
INSERT INTO `distrito` VALUES (1329, 132, '05', 'Chilca', NULL, '150505');
INSERT INTO `distrito` VALUES (1330, 132, '06', 'Coayllo', NULL, '150506');
INSERT INTO `distrito` VALUES (1331, 132, '07', 'Imperial', NULL, '150507');
INSERT INTO `distrito` VALUES (1332, 132, '08', 'Lunahuana', NULL, '150508');
INSERT INTO `distrito` VALUES (1333, 132, '09', 'Mala', NULL, '150509');
INSERT INTO `distrito` VALUES (1334, 132, '10', 'Nuevo Imperial', NULL, '150510');
INSERT INTO `distrito` VALUES (1335, 132, '11', 'Pacaran', NULL, '150511');
INSERT INTO `distrito` VALUES (1336, 132, '12', 'Quilmana', NULL, '150512');
INSERT INTO `distrito` VALUES (1337, 132, '13', 'San Antonio', NULL, '150513');
INSERT INTO `distrito` VALUES (1338, 132, '14', 'San Luis', NULL, '150514');
INSERT INTO `distrito` VALUES (1339, 132, '15', 'Santa Cruz de Flores', NULL, '150515');
INSERT INTO `distrito` VALUES (1340, 132, '16', 'Zúñiga', NULL, '150516');
INSERT INTO `distrito` VALUES (1341, 133, '01', 'Huaral', NULL, '150601');
INSERT INTO `distrito` VALUES (1342, 133, '02', 'Atavillos Alto', NULL, '150602');
INSERT INTO `distrito` VALUES (1343, 133, '03', 'Atavillos Bajo', NULL, '150603');
INSERT INTO `distrito` VALUES (1344, 133, '04', 'Aucallama', NULL, '150604');
INSERT INTO `distrito` VALUES (1345, 133, '05', 'Chancay', NULL, '150605');
INSERT INTO `distrito` VALUES (1346, 133, '06', 'Ihuari', NULL, '150606');
INSERT INTO `distrito` VALUES (1347, 133, '07', 'Lampian', NULL, '150607');
INSERT INTO `distrito` VALUES (1348, 133, '08', 'Pacaraos', NULL, '150608');
INSERT INTO `distrito` VALUES (1349, 133, '09', 'San Miguel de Acos', NULL, '150609');
INSERT INTO `distrito` VALUES (1350, 133, '10', 'Santa Cruz de Andamarca', NULL, '150610');
INSERT INTO `distrito` VALUES (1351, 133, '11', 'Sumbilca', NULL, '150611');
INSERT INTO `distrito` VALUES (1352, 133, '12', 'Veintisiete de Noviembre', NULL, '150612');
INSERT INTO `distrito` VALUES (1353, 134, '01', 'Matucana', NULL, '150701');
INSERT INTO `distrito` VALUES (1354, 134, '02', 'Antioquia', NULL, '150702');
INSERT INTO `distrito` VALUES (1355, 134, '03', 'Callahuanca', NULL, '150703');
INSERT INTO `distrito` VALUES (1356, 134, '04', 'Carampoma', NULL, '150704');
INSERT INTO `distrito` VALUES (1357, 134, '05', 'Chicla', NULL, '150705');
INSERT INTO `distrito` VALUES (1358, 134, '06', 'Cuenca', NULL, '150706');
INSERT INTO `distrito` VALUES (1359, 134, '07', 'Huachupampa', NULL, '150707');
INSERT INTO `distrito` VALUES (1360, 134, '08', 'Huanza', NULL, '150708');
INSERT INTO `distrito` VALUES (1361, 134, '09', 'Huarochiri', NULL, '150709');
INSERT INTO `distrito` VALUES (1362, 134, '10', 'Lahuaytambo', NULL, '150710');
INSERT INTO `distrito` VALUES (1363, 134, '11', 'Langa', NULL, '150711');
INSERT INTO `distrito` VALUES (1364, 134, '12', 'Laraos', NULL, '150712');
INSERT INTO `distrito` VALUES (1365, 134, '13', 'Mariatana', NULL, '150713');
INSERT INTO `distrito` VALUES (1366, 134, '14', 'Ricardo Palma', NULL, '150714');
INSERT INTO `distrito` VALUES (1367, 134, '15', 'San Andrés de Tupicocha', NULL, '150715');
INSERT INTO `distrito` VALUES (1368, 134, '16', 'San Antonio', NULL, '150716');
INSERT INTO `distrito` VALUES (1369, 134, '17', 'San Bartolomé', NULL, '150717');
INSERT INTO `distrito` VALUES (1370, 134, '18', 'San Damian', NULL, '150718');
INSERT INTO `distrito` VALUES (1371, 134, '19', 'San Juan de Iris', NULL, '150719');
INSERT INTO `distrito` VALUES (1372, 134, '20', 'San Juan de Tantaranche', NULL, '150720');
INSERT INTO `distrito` VALUES (1373, 134, '21', 'San Lorenzo de Quinti', NULL, '150721');
INSERT INTO `distrito` VALUES (1374, 134, '22', 'San Mateo', NULL, '150722');
INSERT INTO `distrito` VALUES (1375, 134, '23', 'San Mateo de Otao', NULL, '150723');
INSERT INTO `distrito` VALUES (1376, 134, '24', 'San Pedro de Casta', NULL, '150724');
INSERT INTO `distrito` VALUES (1377, 134, '25', 'San Pedro de Huancayre', NULL, '150725');
INSERT INTO `distrito` VALUES (1378, 134, '26', 'Sangallaya', NULL, '150726');
INSERT INTO `distrito` VALUES (1379, 134, '27', 'Santa Cruz de Cocachacra', NULL, '150727');
INSERT INTO `distrito` VALUES (1380, 134, '28', 'Santa Eulalia', NULL, '150728');
INSERT INTO `distrito` VALUES (1381, 134, '29', 'Santiago de Anchucaya', NULL, '150729');
INSERT INTO `distrito` VALUES (1382, 134, '30', 'Santiago de Tuna', NULL, '150730');
INSERT INTO `distrito` VALUES (1383, 134, '31', 'Santo Domingo de Los Olleros', NULL, '150731');
INSERT INTO `distrito` VALUES (1384, 134, '32', 'Surco', NULL, '150732');
INSERT INTO `distrito` VALUES (1385, 135, '01', 'Huacho', NULL, '150801');
INSERT INTO `distrito` VALUES (1386, 135, '02', 'Ambar', NULL, '150802');
INSERT INTO `distrito` VALUES (1387, 135, '03', 'Caleta de Carquin', NULL, '150803');
INSERT INTO `distrito` VALUES (1388, 135, '04', 'Checras', NULL, '150804');
INSERT INTO `distrito` VALUES (1389, 135, '05', 'Hualmay', NULL, '150805');
INSERT INTO `distrito` VALUES (1390, 135, '06', 'Huaura', NULL, '150806');
INSERT INTO `distrito` VALUES (1391, 135, '07', 'Leoncio Prado', NULL, '150807');
INSERT INTO `distrito` VALUES (1392, 135, '08', 'Paccho', NULL, '150808');
INSERT INTO `distrito` VALUES (1393, 135, '09', 'Santa Leonor', NULL, '150809');
INSERT INTO `distrito` VALUES (1394, 135, '10', 'Santa María', NULL, '150810');
INSERT INTO `distrito` VALUES (1395, 135, '11', 'Sayan', NULL, '150811');
INSERT INTO `distrito` VALUES (1396, 135, '12', 'Vegueta', NULL, '150812');
INSERT INTO `distrito` VALUES (1397, 136, '01', 'Oyon', NULL, '150901');
INSERT INTO `distrito` VALUES (1398, 136, '02', 'Andajes', NULL, '150902');
INSERT INTO `distrito` VALUES (1399, 136, '03', 'Caujul', NULL, '150903');
INSERT INTO `distrito` VALUES (1400, 136, '04', 'Cochamarca', NULL, '150904');
INSERT INTO `distrito` VALUES (1401, 136, '05', 'Navan', NULL, '150905');
INSERT INTO `distrito` VALUES (1402, 136, '06', 'Pachangara', NULL, '150906');
INSERT INTO `distrito` VALUES (1403, 137, '01', 'Yauyos', NULL, '151001');
INSERT INTO `distrito` VALUES (1404, 137, '02', 'Alis', NULL, '151002');
INSERT INTO `distrito` VALUES (1405, 137, '03', 'Allauca', NULL, '151003');
INSERT INTO `distrito` VALUES (1406, 137, '04', 'Ayaviri', NULL, '151004');
INSERT INTO `distrito` VALUES (1407, 137, '05', 'Azángaro', NULL, '151005');
INSERT INTO `distrito` VALUES (1408, 137, '06', 'Cacra', NULL, '151006');
INSERT INTO `distrito` VALUES (1409, 137, '07', 'Carania', NULL, '151007');
INSERT INTO `distrito` VALUES (1410, 137, '08', 'Catahuasi', NULL, '151008');
INSERT INTO `distrito` VALUES (1411, 137, '09', 'Chocos', NULL, '151009');
INSERT INTO `distrito` VALUES (1412, 137, '10', 'Cochas', NULL, '151010');
INSERT INTO `distrito` VALUES (1413, 137, '11', 'Colonia', NULL, '151011');
INSERT INTO `distrito` VALUES (1414, 137, '12', 'Hongos', NULL, '151012');
INSERT INTO `distrito` VALUES (1415, 137, '13', 'Huampara', NULL, '151013');
INSERT INTO `distrito` VALUES (1416, 137, '14', 'Huancaya', NULL, '151014');
INSERT INTO `distrito` VALUES (1417, 137, '15', 'Huangascar', NULL, '151015');
INSERT INTO `distrito` VALUES (1418, 137, '16', 'Huantan', NULL, '151016');
INSERT INTO `distrito` VALUES (1419, 137, '17', 'Huañec', NULL, '151017');
INSERT INTO `distrito` VALUES (1420, 137, '18', 'Laraos', NULL, '151018');
INSERT INTO `distrito` VALUES (1421, 137, '19', 'Lincha', NULL, '151019');
INSERT INTO `distrito` VALUES (1422, 137, '20', 'Madean', NULL, '151020');
INSERT INTO `distrito` VALUES (1423, 137, '21', 'Miraflores', NULL, '151021');
INSERT INTO `distrito` VALUES (1424, 137, '22', 'Omas', NULL, '151022');
INSERT INTO `distrito` VALUES (1425, 137, '23', 'Putinza', NULL, '151023');
INSERT INTO `distrito` VALUES (1426, 137, '24', 'Quinches', NULL, '151024');
INSERT INTO `distrito` VALUES (1427, 137, '25', 'Quinocay', NULL, '151025');
INSERT INTO `distrito` VALUES (1428, 137, '26', 'San Joaquín', NULL, '151026');
INSERT INTO `distrito` VALUES (1429, 137, '27', 'San Pedro de Pilas', NULL, '151027');
INSERT INTO `distrito` VALUES (1430, 137, '28', 'Tanta', NULL, '151028');
INSERT INTO `distrito` VALUES (1431, 137, '29', 'Tauripampa', NULL, '151029');
INSERT INTO `distrito` VALUES (1432, 137, '30', 'Tomas', NULL, '151030');
INSERT INTO `distrito` VALUES (1433, 137, '31', 'Tupe', NULL, '151031');
INSERT INTO `distrito` VALUES (1434, 137, '32', 'Viñac', NULL, '151032');
INSERT INTO `distrito` VALUES (1435, 137, '33', 'Vitis', NULL, '151033');
INSERT INTO `distrito` VALUES (1436, 138, '01', 'Iquitos', NULL, '160101');
INSERT INTO `distrito` VALUES (1437, 138, '02', 'Alto Nanay', NULL, '160102');
INSERT INTO `distrito` VALUES (1438, 138, '03', 'Fernando Lores', NULL, '160103');
INSERT INTO `distrito` VALUES (1439, 138, '04', 'Indiana', NULL, '160104');
INSERT INTO `distrito` VALUES (1440, 138, '05', 'Las Amazonas', NULL, '160105');
INSERT INTO `distrito` VALUES (1441, 138, '06', 'Mazan', NULL, '160106');
INSERT INTO `distrito` VALUES (1442, 138, '07', 'Napo', NULL, '160107');
INSERT INTO `distrito` VALUES (1443, 138, '08', 'Punchana', NULL, '160108');
INSERT INTO `distrito` VALUES (1444, 138, '10', 'Torres Causana', NULL, '160110');
INSERT INTO `distrito` VALUES (1445, 138, '12', 'Belén', NULL, '160112');
INSERT INTO `distrito` VALUES (1446, 138, '13', 'San Juan Bautista', NULL, '160113');
INSERT INTO `distrito` VALUES (1447, 139, '01', 'Yurimaguas', NULL, '160201');
INSERT INTO `distrito` VALUES (1448, 139, '02', 'Balsapuerto', NULL, '160202');
INSERT INTO `distrito` VALUES (1449, 139, '05', 'Jeberos', NULL, '160205');
INSERT INTO `distrito` VALUES (1450, 139, '06', 'Lagunas', NULL, '160206');
INSERT INTO `distrito` VALUES (1451, 139, '10', 'Santa Cruz', NULL, '160210');
INSERT INTO `distrito` VALUES (1452, 139, '11', 'Teniente Cesar López Rojas', NULL, '160211');
INSERT INTO `distrito` VALUES (1453, 140, '01', 'Nauta', NULL, '160301');
INSERT INTO `distrito` VALUES (1454, 140, '02', 'Parinari', NULL, '160302');
INSERT INTO `distrito` VALUES (1455, 140, '03', 'Tigre', NULL, '160303');
INSERT INTO `distrito` VALUES (1456, 140, '04', 'Trompeteros', NULL, '160304');
INSERT INTO `distrito` VALUES (1457, 140, '05', 'Urarinas', NULL, '160305');
INSERT INTO `distrito` VALUES (1458, 141, '01', 'Ramón Castilla', NULL, '160401');
INSERT INTO `distrito` VALUES (1459, 141, '02', 'Pebas', NULL, '160402');
INSERT INTO `distrito` VALUES (1460, 141, '03', 'Yavari', NULL, '160403');
INSERT INTO `distrito` VALUES (1461, 141, '04', 'San Pablo', NULL, '160404');
INSERT INTO `distrito` VALUES (1462, 142, '01', 'Requena', NULL, '160501');
INSERT INTO `distrito` VALUES (1463, 142, '02', 'Alto Tapiche', NULL, '160502');
INSERT INTO `distrito` VALUES (1464, 142, '03', 'Capelo', NULL, '160503');
INSERT INTO `distrito` VALUES (1465, 142, '04', 'Emilio San Martín', NULL, '160504');
INSERT INTO `distrito` VALUES (1466, 142, '05', 'Maquia', NULL, '160505');
INSERT INTO `distrito` VALUES (1467, 142, '06', 'Puinahua', NULL, '160506');
INSERT INTO `distrito` VALUES (1468, 142, '07', 'Saquena', NULL, '160507');
INSERT INTO `distrito` VALUES (1469, 142, '08', 'Soplin', NULL, '160508');
INSERT INTO `distrito` VALUES (1470, 142, '09', 'Tapiche', NULL, '160509');
INSERT INTO `distrito` VALUES (1471, 142, '10', 'Jenaro Herrera', NULL, '160510');
INSERT INTO `distrito` VALUES (1472, 142, '11', 'Yaquerana', NULL, '160511');
INSERT INTO `distrito` VALUES (1473, 143, '01', 'Contamana', NULL, '160601');
INSERT INTO `distrito` VALUES (1474, 143, '02', 'Inahuaya', NULL, '160602');
INSERT INTO `distrito` VALUES (1475, 143, '03', 'Padre Márquez', NULL, '160603');
INSERT INTO `distrito` VALUES (1476, 143, '04', 'Pampa Hermosa', NULL, '160604');
INSERT INTO `distrito` VALUES (1477, 143, '05', 'Sarayacu', NULL, '160605');
INSERT INTO `distrito` VALUES (1478, 143, '06', 'Vargas Guerra', NULL, '160606');
INSERT INTO `distrito` VALUES (1479, 144, '01', 'Barranca', NULL, '160701');
INSERT INTO `distrito` VALUES (1480, 144, '02', 'Cahuapanas', NULL, '160702');
INSERT INTO `distrito` VALUES (1481, 144, '03', 'Manseriche', NULL, '160703');
INSERT INTO `distrito` VALUES (1482, 144, '04', 'Morona', NULL, '160704');
INSERT INTO `distrito` VALUES (1483, 144, '05', 'Pastaza', NULL, '160705');
INSERT INTO `distrito` VALUES (1484, 144, '06', 'Andoas', NULL, '160706');
INSERT INTO `distrito` VALUES (1485, 145, '01', 'Putumayo', NULL, '160801');
INSERT INTO `distrito` VALUES (1486, 145, '02', 'Rosa Panduro', NULL, '160802');
INSERT INTO `distrito` VALUES (1487, 145, '03', 'Teniente Manuel Clavero', NULL, '160803');
INSERT INTO `distrito` VALUES (1488, 145, '04', 'Yaguas', NULL, '160804');
INSERT INTO `distrito` VALUES (1489, 146, '01', 'Tambopata', NULL, '170101');
INSERT INTO `distrito` VALUES (1490, 146, '02', 'Inambari', NULL, '170102');
INSERT INTO `distrito` VALUES (1491, 146, '03', 'Las Piedras', NULL, '170103');
INSERT INTO `distrito` VALUES (1492, 146, '04', 'Laberinto', NULL, '170104');
INSERT INTO `distrito` VALUES (1493, 147, '01', 'Manu', NULL, '170201');
INSERT INTO `distrito` VALUES (1494, 147, '02', 'Fitzcarrald', NULL, '170202');
INSERT INTO `distrito` VALUES (1495, 147, '03', 'Madre de Dios', NULL, '170203');
INSERT INTO `distrito` VALUES (1496, 147, '04', 'Huepetuhe', NULL, '170204');
INSERT INTO `distrito` VALUES (1497, 148, '01', 'Iñapari', NULL, '170301');
INSERT INTO `distrito` VALUES (1498, 148, '02', 'Iberia', NULL, '170302');
INSERT INTO `distrito` VALUES (1499, 148, '03', 'Tahuamanu', NULL, '170303');
INSERT INTO `distrito` VALUES (1500, 149, '01', 'Moquegua', NULL, '180101');
INSERT INTO `distrito` VALUES (1501, 149, '02', 'Carumas', NULL, '180102');
INSERT INTO `distrito` VALUES (1502, 149, '03', 'Cuchumbaya', NULL, '180103');
INSERT INTO `distrito` VALUES (1503, 149, '04', 'Samegua', NULL, '180104');
INSERT INTO `distrito` VALUES (1504, 149, '05', 'San Cristóbal', NULL, '180105');
INSERT INTO `distrito` VALUES (1505, 149, '06', 'Torata', NULL, '180106');
INSERT INTO `distrito` VALUES (1506, 150, '01', 'Omate', NULL, '180201');
INSERT INTO `distrito` VALUES (1507, 150, '02', 'Chojata', NULL, '180202');
INSERT INTO `distrito` VALUES (1508, 150, '03', 'Coalaque', NULL, '180203');
INSERT INTO `distrito` VALUES (1509, 150, '04', 'Ichuña', NULL, '180204');
INSERT INTO `distrito` VALUES (1510, 150, '05', 'La Capilla', NULL, '180205');
INSERT INTO `distrito` VALUES (1511, 150, '06', 'Lloque', NULL, '180206');
INSERT INTO `distrito` VALUES (1512, 150, '07', 'Matalaque', NULL, '180207');
INSERT INTO `distrito` VALUES (1513, 150, '08', 'Puquina', NULL, '180208');
INSERT INTO `distrito` VALUES (1514, 150, '09', 'Quinistaquillas', NULL, '180209');
INSERT INTO `distrito` VALUES (1515, 150, '10', 'Ubinas', NULL, '180210');
INSERT INTO `distrito` VALUES (1516, 150, '11', 'Yunga', NULL, '180211');
INSERT INTO `distrito` VALUES (1517, 151, '01', 'Ilo', NULL, '180301');
INSERT INTO `distrito` VALUES (1518, 151, '02', 'El Algarrobal', NULL, '180302');
INSERT INTO `distrito` VALUES (1519, 151, '03', 'Pacocha', NULL, '180303');
INSERT INTO `distrito` VALUES (1520, 152, '01', 'Chaupimarca', NULL, '190101');
INSERT INTO `distrito` VALUES (1521, 152, '02', 'Huachon', NULL, '190102');
INSERT INTO `distrito` VALUES (1522, 152, '03', 'Huariaca', NULL, '190103');
INSERT INTO `distrito` VALUES (1523, 152, '04', 'Huayllay', NULL, '190104');
INSERT INTO `distrito` VALUES (1524, 152, '05', 'Ninacaca', NULL, '190105');
INSERT INTO `distrito` VALUES (1525, 152, '06', 'Pallanchacra', NULL, '190106');
INSERT INTO `distrito` VALUES (1526, 152, '07', 'Paucartambo', NULL, '190107');
INSERT INTO `distrito` VALUES (1527, 152, '08', 'San Francisco de Asís de Yarusyacan', NULL, '190108');
INSERT INTO `distrito` VALUES (1528, 152, '09', 'Simon Bolívar', NULL, '190109');
INSERT INTO `distrito` VALUES (1529, 152, '10', 'Ticlacayan', NULL, '190110');
INSERT INTO `distrito` VALUES (1530, 152, '11', 'Tinyahuarco', NULL, '190111');
INSERT INTO `distrito` VALUES (1531, 152, '12', 'Vicco', NULL, '190112');
INSERT INTO `distrito` VALUES (1532, 152, '13', 'Yanacancha', NULL, '190113');
INSERT INTO `distrito` VALUES (1533, 153, '01', 'Yanahuanca', NULL, '190201');
INSERT INTO `distrito` VALUES (1534, 153, '02', 'Chacayan', NULL, '190202');
INSERT INTO `distrito` VALUES (1535, 153, '03', 'Goyllarisquizga', NULL, '190203');
INSERT INTO `distrito` VALUES (1536, 153, '04', 'Paucar', NULL, '190204');
INSERT INTO `distrito` VALUES (1537, 153, '05', 'San Pedro de Pillao', NULL, '190205');
INSERT INTO `distrito` VALUES (1538, 153, '06', 'Santa Ana de Tusi', NULL, '190206');
INSERT INTO `distrito` VALUES (1539, 153, '07', 'Tapuc', NULL, '190207');
INSERT INTO `distrito` VALUES (1540, 153, '08', 'Vilcabamba', NULL, '190208');
INSERT INTO `distrito` VALUES (1541, 154, '01', 'Oxapampa', NULL, '190301');
INSERT INTO `distrito` VALUES (1542, 154, '02', 'Chontabamba', NULL, '190302');
INSERT INTO `distrito` VALUES (1543, 154, '03', 'Huancabamba', NULL, '190303');
INSERT INTO `distrito` VALUES (1544, 154, '04', 'Palcazu', NULL, '190304');
INSERT INTO `distrito` VALUES (1545, 154, '05', 'Pozuzo', NULL, '190305');
INSERT INTO `distrito` VALUES (1546, 154, '06', 'Puerto Bermúdez', NULL, '190306');
INSERT INTO `distrito` VALUES (1547, 154, '07', 'Villa Rica', NULL, '190307');
INSERT INTO `distrito` VALUES (1548, 154, '08', 'Constitución', NULL, '190308');
INSERT INTO `distrito` VALUES (1549, 155, '01', 'Piura', NULL, '200101');
INSERT INTO `distrito` VALUES (1550, 155, '04', 'Castilla', NULL, '200104');
INSERT INTO `distrito` VALUES (1551, 155, '05', 'Atacaos', NULL, '200105');
INSERT INTO `distrito` VALUES (1552, 155, '07', 'Cura Mori', NULL, '200107');
INSERT INTO `distrito` VALUES (1553, 155, '08', 'El Tallan', NULL, '200108');
INSERT INTO `distrito` VALUES (1554, 155, '09', 'La Arena', NULL, '200109');
INSERT INTO `distrito` VALUES (1555, 155, '10', 'La Unión', NULL, '200110');
INSERT INTO `distrito` VALUES (1556, 155, '11', 'Las Lomas', NULL, '200111');
INSERT INTO `distrito` VALUES (1557, 155, '14', 'Tambo Grande', NULL, '200114');
INSERT INTO `distrito` VALUES (1558, 155, '15', 'Veintiseis de Octubre', NULL, '200115');
INSERT INTO `distrito` VALUES (1559, 156, '01', 'Ayabaca', NULL, '200201');
INSERT INTO `distrito` VALUES (1560, 156, '02', 'Frias', NULL, '200202');
INSERT INTO `distrito` VALUES (1561, 156, '03', 'Jilili', NULL, '200203');
INSERT INTO `distrito` VALUES (1562, 156, '04', 'Lagunas', NULL, '200204');
INSERT INTO `distrito` VALUES (1563, 156, '05', 'Montero', NULL, '200205');
INSERT INTO `distrito` VALUES (1564, 156, '06', 'Pacaipampa', NULL, '200206');
INSERT INTO `distrito` VALUES (1565, 156, '07', 'Paimas', NULL, '200207');
INSERT INTO `distrito` VALUES (1566, 156, '08', 'Sapillica', NULL, '200208');
INSERT INTO `distrito` VALUES (1567, 156, '09', 'Sicchez', NULL, '200209');
INSERT INTO `distrito` VALUES (1568, 156, '10', 'Suyo', NULL, '200210');
INSERT INTO `distrito` VALUES (1569, 157, '01', 'Huancabamba', NULL, '200301');
INSERT INTO `distrito` VALUES (1570, 157, '02', 'Canchaque', NULL, '200302');
INSERT INTO `distrito` VALUES (1571, 157, '03', 'El Carmen de la Frontera', NULL, '200303');
INSERT INTO `distrito` VALUES (1572, 157, '04', 'Huarmaca', NULL, '200304');
INSERT INTO `distrito` VALUES (1573, 157, '05', 'Lalaquiz', NULL, '200305');
INSERT INTO `distrito` VALUES (1574, 157, '06', 'San Miguel de El Faique', NULL, '200306');
INSERT INTO `distrito` VALUES (1575, 157, '07', 'Sondor', NULL, '200307');
INSERT INTO `distrito` VALUES (1576, 157, '08', 'Sondorillo', NULL, '200308');
INSERT INTO `distrito` VALUES (1577, 158, '01', 'Chulucanas', NULL, '200401');
INSERT INTO `distrito` VALUES (1578, 158, '02', 'Buenos Aires', NULL, '200402');
INSERT INTO `distrito` VALUES (1579, 158, '03', 'Chalaco', NULL, '200403');
INSERT INTO `distrito` VALUES (1580, 158, '04', 'La Matanza', NULL, '200404');
INSERT INTO `distrito` VALUES (1581, 158, '05', 'Morropon', NULL, '200405');
INSERT INTO `distrito` VALUES (1582, 158, '06', 'Salitral', NULL, '200406');
INSERT INTO `distrito` VALUES (1583, 158, '07', 'San Juan de Bigote', NULL, '200407');
INSERT INTO `distrito` VALUES (1584, 158, '08', 'Santa Catalina de Mossa', NULL, '200408');
INSERT INTO `distrito` VALUES (1585, 158, '09', 'Santo Domingo', NULL, '200409');
INSERT INTO `distrito` VALUES (1586, 158, '10', 'Yamango', NULL, '200410');
INSERT INTO `distrito` VALUES (1587, 159, '01', 'Paita', NULL, '200501');
INSERT INTO `distrito` VALUES (1588, 159, '02', 'Amotape', NULL, '200502');
INSERT INTO `distrito` VALUES (1589, 159, '03', 'Arenal', NULL, '200503');
INSERT INTO `distrito` VALUES (1590, 159, '04', 'Colan', NULL, '200504');
INSERT INTO `distrito` VALUES (1591, 159, '05', 'La Huaca', NULL, '200505');
INSERT INTO `distrito` VALUES (1592, 159, '06', 'Tamarindo', NULL, '200506');
INSERT INTO `distrito` VALUES (1593, 159, '07', 'Vichayal', NULL, '200507');
INSERT INTO `distrito` VALUES (1594, 160, '01', 'Sullana', NULL, '200601');
INSERT INTO `distrito` VALUES (1595, 160, '02', 'Bellavista', NULL, '200602');
INSERT INTO `distrito` VALUES (1596, 160, '03', 'Ignacio Escudero', NULL, '200603');
INSERT INTO `distrito` VALUES (1597, 160, '04', 'Lancones', NULL, '200604');
INSERT INTO `distrito` VALUES (1598, 160, '05', 'Marcavelica', NULL, '200605');
INSERT INTO `distrito` VALUES (1599, 160, '06', 'Miguel Checa', NULL, '200606');
INSERT INTO `distrito` VALUES (1600, 160, '07', 'Querecotillo', NULL, '200607');
INSERT INTO `distrito` VALUES (1601, 160, '08', 'Salitral', NULL, '200608');
INSERT INTO `distrito` VALUES (1602, 161, '01', 'Pariñas', NULL, '200701');
INSERT INTO `distrito` VALUES (1603, 161, '02', 'El Alto', NULL, '200702');
INSERT INTO `distrito` VALUES (1604, 161, '03', 'La Brea', NULL, '200703');
INSERT INTO `distrito` VALUES (1605, 161, '04', 'Lobitos', NULL, '200704');
INSERT INTO `distrito` VALUES (1606, 161, '05', 'Los Organos', NULL, '200705');
INSERT INTO `distrito` VALUES (1607, 161, '06', 'Mancora', NULL, '200706');
INSERT INTO `distrito` VALUES (1608, 162, '01', 'Sechura', NULL, '200801');
INSERT INTO `distrito` VALUES (1609, 162, '02', 'Bellavista de la Unión', NULL, '200802');
INSERT INTO `distrito` VALUES (1610, 162, '03', 'Bernal', NULL, '200803');
INSERT INTO `distrito` VALUES (1611, 162, '04', 'Cristo Nos Valga', NULL, '200804');
INSERT INTO `distrito` VALUES (1612, 162, '05', 'Vice', NULL, '200805');
INSERT INTO `distrito` VALUES (1613, 162, '06', 'Rinconada Llicuar', NULL, '200806');
INSERT INTO `distrito` VALUES (1614, 163, '01', 'Puno', NULL, '210101');
INSERT INTO `distrito` VALUES (1615, 163, '02', 'Acora', NULL, '210102');
INSERT INTO `distrito` VALUES (1616, 163, '03', 'Amantani', NULL, '210103');
INSERT INTO `distrito` VALUES (1617, 163, '04', 'Atuncolla', NULL, '210104');
INSERT INTO `distrito` VALUES (1618, 163, '05', 'Capachica', NULL, '210105');
INSERT INTO `distrito` VALUES (1619, 163, '06', 'Chucuito', NULL, '210106');
INSERT INTO `distrito` VALUES (1620, 163, '07', 'Coata', NULL, '210107');
INSERT INTO `distrito` VALUES (1621, 163, '08', 'Huata', NULL, '210108');
INSERT INTO `distrito` VALUES (1622, 163, '09', 'Mañazo', NULL, '210109');
INSERT INTO `distrito` VALUES (1623, 163, '10', 'Paucarcolla', NULL, '210110');
INSERT INTO `distrito` VALUES (1624, 163, '11', 'Pichacani', NULL, '210111');
INSERT INTO `distrito` VALUES (1625, 163, '12', 'Plateria', NULL, '210112');
INSERT INTO `distrito` VALUES (1626, 163, '13', 'San Antonio', NULL, '210113');
INSERT INTO `distrito` VALUES (1627, 163, '14', 'Tiquillaca', NULL, '210114');
INSERT INTO `distrito` VALUES (1628, 163, '15', 'Vilque', NULL, '210115');
INSERT INTO `distrito` VALUES (1629, 164, '01', 'Azángaro', NULL, '210201');
INSERT INTO `distrito` VALUES (1630, 164, '02', 'Achaya', NULL, '210202');
INSERT INTO `distrito` VALUES (1631, 164, '03', 'Arapa', NULL, '210203');
INSERT INTO `distrito` VALUES (1632, 164, '04', 'Asillo', NULL, '210204');
INSERT INTO `distrito` VALUES (1633, 164, '05', 'Caminaca', NULL, '210205');
INSERT INTO `distrito` VALUES (1634, 164, '06', 'Chupa', NULL, '210206');
INSERT INTO `distrito` VALUES (1635, 164, '07', 'Jose Domingo Choquehuanca', NULL, '210207');
INSERT INTO `distrito` VALUES (1636, 164, '08', 'Munani', NULL, '210208');
INSERT INTO `distrito` VALUES (1637, 164, '09', 'Potoni', NULL, '210209');
INSERT INTO `distrito` VALUES (1638, 164, '10', 'Saman', NULL, '210210');
INSERT INTO `distrito` VALUES (1639, 164, '11', 'San Anton', NULL, '210211');
INSERT INTO `distrito` VALUES (1640, 164, '12', 'San Jose', NULL, '210212');
INSERT INTO `distrito` VALUES (1641, 164, '13', 'San Juan de Salinas', NULL, '210213');
INSERT INTO `distrito` VALUES (1642, 164, '14', 'Santiago de Pupuja', NULL, '210214');
INSERT INTO `distrito` VALUES (1643, 164, '15', 'Tirapata', NULL, '210215');
INSERT INTO `distrito` VALUES (1644, 165, '01', 'Macusani', NULL, '210301');
INSERT INTO `distrito` VALUES (1645, 165, '02', 'Ajoyani', NULL, '210302');
INSERT INTO `distrito` VALUES (1646, 165, '03', 'Ayapata', NULL, '210303');
INSERT INTO `distrito` VALUES (1647, 165, '04', 'Coasa', NULL, '210304');
INSERT INTO `distrito` VALUES (1648, 165, '05', 'Corani', NULL, '210305');
INSERT INTO `distrito` VALUES (1649, 165, '06', 'Crucero', NULL, '210306');
INSERT INTO `distrito` VALUES (1650, 165, '07', 'Ituata', NULL, '210307');
INSERT INTO `distrito` VALUES (1651, 165, '08', 'Ollachea', NULL, '210308');
INSERT INTO `distrito` VALUES (1652, 165, '09', 'San Gaban', NULL, '210309');
INSERT INTO `distrito` VALUES (1653, 165, '10', 'Usicayos', NULL, '210310');
INSERT INTO `distrito` VALUES (1654, 166, '01', 'Juli', NULL, '210401');
INSERT INTO `distrito` VALUES (1655, 166, '02', 'Desaguadero', NULL, '210402');
INSERT INTO `distrito` VALUES (1656, 166, '03', 'Huacullani', NULL, '210403');
INSERT INTO `distrito` VALUES (1657, 166, '04', 'Kelluyo', NULL, '210404');
INSERT INTO `distrito` VALUES (1658, 166, '05', 'Pisacoma', NULL, '210405');
INSERT INTO `distrito` VALUES (1659, 166, '06', 'Pomata', NULL, '210406');
INSERT INTO `distrito` VALUES (1660, 166, '07', 'Zepita', NULL, '210407');
INSERT INTO `distrito` VALUES (1661, 167, '01', 'Ilave', NULL, '210501');
INSERT INTO `distrito` VALUES (1662, 167, '02', 'Capazo', NULL, '210502');
INSERT INTO `distrito` VALUES (1663, 167, '03', 'Pilcuyo', NULL, '210503');
INSERT INTO `distrito` VALUES (1664, 167, '04', 'Santa Rosa', NULL, '210504');
INSERT INTO `distrito` VALUES (1665, 167, '05', 'Conduriri', NULL, '210505');
INSERT INTO `distrito` VALUES (1666, 168, '01', 'Huancane', NULL, '210601');
INSERT INTO `distrito` VALUES (1667, 168, '02', 'Cojata', NULL, '210602');
INSERT INTO `distrito` VALUES (1668, 168, '03', 'Huatasani', NULL, '210603');
INSERT INTO `distrito` VALUES (1669, 168, '04', 'Inchupalla', NULL, '210604');
INSERT INTO `distrito` VALUES (1670, 168, '05', 'Pusi', NULL, '210605');
INSERT INTO `distrito` VALUES (1671, 168, '06', 'Rosaspata', NULL, '210606');
INSERT INTO `distrito` VALUES (1672, 168, '07', 'Taraco', NULL, '210607');
INSERT INTO `distrito` VALUES (1673, 168, '08', 'Vilque Chico', NULL, '210608');
INSERT INTO `distrito` VALUES (1674, 169, '01', 'Lampa', NULL, '210701');
INSERT INTO `distrito` VALUES (1675, 169, '02', 'Cabanilla', NULL, '210702');
INSERT INTO `distrito` VALUES (1676, 169, '03', 'Calapuja', NULL, '210703');
INSERT INTO `distrito` VALUES (1677, 169, '04', 'Nicasio', NULL, '210704');
INSERT INTO `distrito` VALUES (1678, 169, '05', 'Ocuviri', NULL, '210705');
INSERT INTO `distrito` VALUES (1679, 169, '06', 'Palca', NULL, '210706');
INSERT INTO `distrito` VALUES (1680, 169, '07', 'Paratia', NULL, '210707');
INSERT INTO `distrito` VALUES (1681, 169, '08', 'Pucara', NULL, '210708');
INSERT INTO `distrito` VALUES (1682, 169, '09', 'Santa Lucia', NULL, '210709');
INSERT INTO `distrito` VALUES (1683, 169, '10', 'Vilavila', NULL, '210710');
INSERT INTO `distrito` VALUES (1684, 170, '01', 'Ayaviri', NULL, '210801');
INSERT INTO `distrito` VALUES (1685, 170, '02', 'Antauta', NULL, '210802');
INSERT INTO `distrito` VALUES (1686, 170, '03', 'Cupi', NULL, '210803');
INSERT INTO `distrito` VALUES (1687, 170, '04', 'Llalli', NULL, '210804');
INSERT INTO `distrito` VALUES (1688, 170, '05', 'Macari', NULL, '210805');
INSERT INTO `distrito` VALUES (1689, 170, '06', 'Nuñoa', NULL, '210806');
INSERT INTO `distrito` VALUES (1690, 170, '07', 'Orurillo', NULL, '210807');
INSERT INTO `distrito` VALUES (1691, 170, '08', 'Santa Rosa', NULL, '210808');
INSERT INTO `distrito` VALUES (1692, 170, '09', 'Umachiri', NULL, '210809');
INSERT INTO `distrito` VALUES (1693, 171, '01', 'Moho', NULL, '210901');
INSERT INTO `distrito` VALUES (1694, 171, '02', 'Conima', NULL, '210902');
INSERT INTO `distrito` VALUES (1695, 171, '03', 'Huayrapata', NULL, '210903');
INSERT INTO `distrito` VALUES (1696, 171, '04', 'Tilali', NULL, '210904');
INSERT INTO `distrito` VALUES (1697, 172, '01', 'Putina', NULL, '211001');
INSERT INTO `distrito` VALUES (1698, 172, '02', 'Ananea', NULL, '211002');
INSERT INTO `distrito` VALUES (1699, 172, '03', 'Pedro Vilca Apaza', NULL, '211003');
INSERT INTO `distrito` VALUES (1700, 172, '04', 'Quilcapuncu', NULL, '211004');
INSERT INTO `distrito` VALUES (1701, 172, '05', 'Sina', NULL, '211005');
INSERT INTO `distrito` VALUES (1702, 173, '01', 'Juliaca', NULL, '211101');
INSERT INTO `distrito` VALUES (1703, 173, '02', 'Cabana', NULL, '211102');
INSERT INTO `distrito` VALUES (1704, 173, '03', 'Cabanillas', NULL, '211103');
INSERT INTO `distrito` VALUES (1705, 173, '04', 'Caracoto', NULL, '211104');
INSERT INTO `distrito` VALUES (1706, 174, '01', 'Sandia', NULL, '211201');
INSERT INTO `distrito` VALUES (1707, 174, '02', 'Cuyocuyo', NULL, '211202');
INSERT INTO `distrito` VALUES (1708, 174, '03', 'Limbani', NULL, '211203');
INSERT INTO `distrito` VALUES (1709, 174, '04', 'Patambuco', NULL, '211204');
INSERT INTO `distrito` VALUES (1710, 174, '05', 'Phara', NULL, '211205');
INSERT INTO `distrito` VALUES (1711, 174, '06', 'Quiaca', NULL, '211206');
INSERT INTO `distrito` VALUES (1712, 174, '07', 'San Juan del Oro', NULL, '211207');
INSERT INTO `distrito` VALUES (1713, 174, '08', 'Yanahuaya', NULL, '211208');
INSERT INTO `distrito` VALUES (1714, 174, '09', 'Alto Inambari', NULL, '211209');
INSERT INTO `distrito` VALUES (1715, 174, '10', 'San Pedro de Putina Punco', NULL, '211210');
INSERT INTO `distrito` VALUES (1716, 175, '01', 'Yunguyo', NULL, '211301');
INSERT INTO `distrito` VALUES (1717, 175, '02', 'Anapia', NULL, '211302');
INSERT INTO `distrito` VALUES (1718, 175, '03', 'Copani', NULL, '211303');
INSERT INTO `distrito` VALUES (1719, 175, '04', 'Cuturapi', NULL, '211304');
INSERT INTO `distrito` VALUES (1720, 175, '05', 'Ollaraya', NULL, '211305');
INSERT INTO `distrito` VALUES (1721, 175, '06', 'Tinicachi', NULL, '211306');
INSERT INTO `distrito` VALUES (1722, 175, '07', 'Unicachi', NULL, '211307');
INSERT INTO `distrito` VALUES (1723, 176, '01', 'Moyobamba', NULL, '220101');
INSERT INTO `distrito` VALUES (1724, 176, '02', 'Calzada', NULL, '220102');
INSERT INTO `distrito` VALUES (1725, 176, '03', 'Habana', NULL, '220103');
INSERT INTO `distrito` VALUES (1726, 176, '04', 'Jepelacio', NULL, '220104');
INSERT INTO `distrito` VALUES (1727, 176, '05', 'Soritor', NULL, '220105');
INSERT INTO `distrito` VALUES (1728, 176, '06', 'Yantalo', NULL, '220106');
INSERT INTO `distrito` VALUES (1729, 177, '01', 'Bellavista', NULL, '220201');
INSERT INTO `distrito` VALUES (1730, 177, '02', 'Alto Biavo', NULL, '220202');
INSERT INTO `distrito` VALUES (1731, 177, '03', 'Bajo Biavo', NULL, '220203');
INSERT INTO `distrito` VALUES (1732, 177, '04', 'Huallaga', NULL, '220204');
INSERT INTO `distrito` VALUES (1733, 177, '05', 'San Pablo', NULL, '220205');
INSERT INTO `distrito` VALUES (1734, 177, '06', 'San Rafael', NULL, '220206');
INSERT INTO `distrito` VALUES (1735, 178, '01', 'San José de Sisa', NULL, '220301');
INSERT INTO `distrito` VALUES (1736, 178, '02', 'Agua Blanca', NULL, '220302');
INSERT INTO `distrito` VALUES (1737, 178, '03', 'San Martín', NULL, '220303');
INSERT INTO `distrito` VALUES (1738, 178, '04', 'Santa Rosa', NULL, '220304');
INSERT INTO `distrito` VALUES (1739, 178, '05', 'Shatoja', NULL, '220305');
INSERT INTO `distrito` VALUES (1740, 179, '01', 'Saposoa', NULL, '220401');
INSERT INTO `distrito` VALUES (1741, 179, '02', 'Alto Saposoa', NULL, '220402');
INSERT INTO `distrito` VALUES (1742, 179, '03', 'El Eslabón', NULL, '220403');
INSERT INTO `distrito` VALUES (1743, 179, '04', 'Piscoyacu', NULL, '220404');
INSERT INTO `distrito` VALUES (1744, 179, '05', 'Sacanche', NULL, '220405');
INSERT INTO `distrito` VALUES (1745, 179, '06', 'Tingo de Saposoa', NULL, '220406');
INSERT INTO `distrito` VALUES (1746, 180, '01', 'Lamas', NULL, '220501');
INSERT INTO `distrito` VALUES (1747, 180, '02', 'Alonso de Alvarado', NULL, '220502');
INSERT INTO `distrito` VALUES (1748, 180, '03', 'Barranquita', NULL, '220503');
INSERT INTO `distrito` VALUES (1749, 180, '04', 'Caynarachi', NULL, '220504');
INSERT INTO `distrito` VALUES (1750, 180, '05', 'Cuñumbuqui', NULL, '220505');
INSERT INTO `distrito` VALUES (1751, 180, '06', 'Pinto Recodo', NULL, '220506');
INSERT INTO `distrito` VALUES (1752, 180, '07', 'Rumisapa', NULL, '220507');
INSERT INTO `distrito` VALUES (1753, 180, '08', 'San Roque de Cumbaza', NULL, '220508');
INSERT INTO `distrito` VALUES (1754, 180, '09', 'Shanao', NULL, '220509');
INSERT INTO `distrito` VALUES (1755, 180, '10', 'Tabalosos', NULL, '220510');
INSERT INTO `distrito` VALUES (1756, 180, '11', 'Zapatero', NULL, '220511');
INSERT INTO `distrito` VALUES (1757, 181, '01', 'Juanjuí', NULL, '220601');
INSERT INTO `distrito` VALUES (1758, 181, '02', 'Campanilla', NULL, '220602');
INSERT INTO `distrito` VALUES (1759, 181, '03', 'Huicungo', NULL, '220603');
INSERT INTO `distrito` VALUES (1760, 181, '04', 'Pachiza', NULL, '220604');
INSERT INTO `distrito` VALUES (1761, 181, '05', 'Pajarillo', NULL, '220605');
INSERT INTO `distrito` VALUES (1762, 182, '01', 'Picota', NULL, '220701');
INSERT INTO `distrito` VALUES (1763, 182, '02', 'Buenos Aires', NULL, '220702');
INSERT INTO `distrito` VALUES (1764, 182, '03', 'Caspisapa', NULL, '220703');
INSERT INTO `distrito` VALUES (1765, 182, '04', 'Pilluana', NULL, '220704');
INSERT INTO `distrito` VALUES (1766, 182, '05', 'Pucacaca', NULL, '220705');
INSERT INTO `distrito` VALUES (1767, 182, '06', 'San Cristóbal', NULL, '220706');
INSERT INTO `distrito` VALUES (1768, 182, '07', 'San Hilarión', NULL, '220707');
INSERT INTO `distrito` VALUES (1769, 182, '08', 'Shamboyacu', NULL, '220708');
INSERT INTO `distrito` VALUES (1770, 182, '09', 'Tingo de Ponasa', NULL, '220709');
INSERT INTO `distrito` VALUES (1771, 182, '10', 'Tres Unidos', NULL, '220710');
INSERT INTO `distrito` VALUES (1772, 183, '01', 'Rioja', NULL, '220801');
INSERT INTO `distrito` VALUES (1773, 183, '02', 'Awajun', NULL, '220802');
INSERT INTO `distrito` VALUES (1774, 183, '03', 'Elías Soplin Vargas', NULL, '220803');
INSERT INTO `distrito` VALUES (1775, 183, '04', 'Nueva Cajamarca', NULL, '220804');
INSERT INTO `distrito` VALUES (1776, 183, '05', 'Pardo Miguel', NULL, '220805');
INSERT INTO `distrito` VALUES (1777, 183, '06', 'Posic', NULL, '220806');
INSERT INTO `distrito` VALUES (1778, 183, '07', 'San Fernando', NULL, '220807');
INSERT INTO `distrito` VALUES (1779, 183, '08', 'Yorongos', NULL, '220808');
INSERT INTO `distrito` VALUES (1780, 183, '09', 'Yuracyacu', NULL, '220809');
INSERT INTO `distrito` VALUES (1781, 184, '01', 'Tarapoto', NULL, '220901');
INSERT INTO `distrito` VALUES (1782, 184, '02', 'Alberto Leveau', NULL, '220902');
INSERT INTO `distrito` VALUES (1783, 184, '03', 'Cacatachi', NULL, '220903');
INSERT INTO `distrito` VALUES (1784, 184, '04', 'Chazuta', NULL, '220904');
INSERT INTO `distrito` VALUES (1785, 184, '05', 'Chipurana', NULL, '220905');
INSERT INTO `distrito` VALUES (1786, 184, '06', 'El Porvenir', NULL, '220906');
INSERT INTO `distrito` VALUES (1787, 184, '07', 'Huimbayoc', NULL, '220907');
INSERT INTO `distrito` VALUES (1788, 184, '08', 'Juan Guerra', NULL, '220908');
INSERT INTO `distrito` VALUES (1789, 184, '09', 'La Banda de Shilcayo', NULL, '220909');
INSERT INTO `distrito` VALUES (1790, 184, '10', 'Morales', NULL, '220910');
INSERT INTO `distrito` VALUES (1791, 184, '11', 'Papaplaya', NULL, '220911');
INSERT INTO `distrito` VALUES (1792, 184, '12', 'San Antonio', NULL, '220912');
INSERT INTO `distrito` VALUES (1793, 184, '13', 'Sauce', NULL, '220913');
INSERT INTO `distrito` VALUES (1794, 184, '14', 'Shapaja', NULL, '220914');
INSERT INTO `distrito` VALUES (1795, 185, '01', 'Tocache', NULL, '221001');
INSERT INTO `distrito` VALUES (1796, 185, '02', 'Nuevo Progreso', NULL, '221002');
INSERT INTO `distrito` VALUES (1797, 185, '03', 'Polvora', NULL, '221003');
INSERT INTO `distrito` VALUES (1798, 185, '04', 'Shunte', NULL, '221004');
INSERT INTO `distrito` VALUES (1799, 185, '05', 'Uchiza', NULL, '221005');
INSERT INTO `distrito` VALUES (1800, 186, '01', 'Tacna', NULL, '230101');
INSERT INTO `distrito` VALUES (1801, 186, '02', 'Alto de la Alianza', NULL, '230102');
INSERT INTO `distrito` VALUES (1802, 186, '03', 'Calana', NULL, '230103');
INSERT INTO `distrito` VALUES (1803, 186, '04', 'Ciudad Nueva', NULL, '230104');
INSERT INTO `distrito` VALUES (1804, 186, '05', 'Inclan', NULL, '230105');
INSERT INTO `distrito` VALUES (1805, 186, '06', 'Pachia', NULL, '230106');
INSERT INTO `distrito` VALUES (1806, 186, '07', 'Palca', NULL, '230107');
INSERT INTO `distrito` VALUES (1807, 186, '08', 'Pocollay', NULL, '230108');
INSERT INTO `distrito` VALUES (1808, 186, '09', 'Sama', NULL, '230109');
INSERT INTO `distrito` VALUES (1809, 186, '10', 'Coronel Gregorio Albarracin Lanchipa', NULL, '230110');
INSERT INTO `distrito` VALUES (1810, 187, '01', 'Candarave', NULL, '230201');
INSERT INTO `distrito` VALUES (1811, 187, '02', 'Cairani', NULL, '230202');
INSERT INTO `distrito` VALUES (1812, 187, '03', 'Camilaca', NULL, '230203');
INSERT INTO `distrito` VALUES (1813, 187, '04', 'Curibaya', NULL, '230204');
INSERT INTO `distrito` VALUES (1814, 187, '05', 'Huanuara', NULL, '230205');
INSERT INTO `distrito` VALUES (1815, 187, '06', 'Quilahuani', NULL, '230206');
INSERT INTO `distrito` VALUES (1816, 188, '01', 'Locumba', NULL, '230301');
INSERT INTO `distrito` VALUES (1817, 188, '02', 'Ilabaya', NULL, '230302');
INSERT INTO `distrito` VALUES (1818, 188, '03', 'Ite', NULL, '230303');
INSERT INTO `distrito` VALUES (1819, 189, '01', 'Tarata', NULL, '230401');
INSERT INTO `distrito` VALUES (1820, 189, '02', 'Heroes Albarracin', NULL, '230402');
INSERT INTO `distrito` VALUES (1821, 189, '03', 'Estique', NULL, '230403');
INSERT INTO `distrito` VALUES (1822, 189, '04', 'Estique-Pampa', NULL, '230404');
INSERT INTO `distrito` VALUES (1823, 189, '05', 'Sitajara', NULL, '230405');
INSERT INTO `distrito` VALUES (1824, 189, '06', 'Susapaya', NULL, '230406');
INSERT INTO `distrito` VALUES (1825, 189, '07', 'Tarucachi', NULL, '230407');
INSERT INTO `distrito` VALUES (1826, 189, '08', 'Ticaco', NULL, '230408');
INSERT INTO `distrito` VALUES (1827, 190, '01', 'Tumbes', NULL, '240101');
INSERT INTO `distrito` VALUES (1828, 190, '02', 'Corrales', NULL, '240102');
INSERT INTO `distrito` VALUES (1829, 190, '03', 'La Cruz', NULL, '240103');
INSERT INTO `distrito` VALUES (1830, 190, '04', 'Pampas de Hospital', NULL, '240104');
INSERT INTO `distrito` VALUES (1831, 190, '05', 'San Jacinto', NULL, '240105');
INSERT INTO `distrito` VALUES (1832, 190, '06', 'San Juan de la Virgen', NULL, '240106');
INSERT INTO `distrito` VALUES (1833, 191, '01', 'Zorritos', NULL, '240201');
INSERT INTO `distrito` VALUES (1834, 191, '02', 'Casitas', NULL, '240202');
INSERT INTO `distrito` VALUES (1835, 191, '03', 'Canoas de Punta Sal', NULL, '240203');
INSERT INTO `distrito` VALUES (1836, 192, '01', 'Zarumilla', NULL, '240301');
INSERT INTO `distrito` VALUES (1837, 192, '02', 'Aguas Verdes', NULL, '240302');
INSERT INTO `distrito` VALUES (1838, 192, '03', 'Matapalo', NULL, '240303');
INSERT INTO `distrito` VALUES (1839, 192, '04', 'Papayal', NULL, '240304');
INSERT INTO `distrito` VALUES (1840, 193, '01', 'Calleria', NULL, '250101');
INSERT INTO `distrito` VALUES (1841, 193, '02', 'Campoverde', NULL, '250102');
INSERT INTO `distrito` VALUES (1842, 193, '03', 'Iparia', NULL, '250103');
INSERT INTO `distrito` VALUES (1843, 193, '04', 'Masisea', NULL, '250104');
INSERT INTO `distrito` VALUES (1844, 193, '05', 'Yarinacocha', NULL, '250105');
INSERT INTO `distrito` VALUES (1845, 193, '06', 'Nueva Requena', NULL, '250106');
INSERT INTO `distrito` VALUES (1846, 193, '07', 'Manantay', NULL, '250107');
INSERT INTO `distrito` VALUES (1847, 194, '01', 'Raymondi', NULL, '250201');
INSERT INTO `distrito` VALUES (1848, 194, '02', 'Sepahua', NULL, '250202');
INSERT INTO `distrito` VALUES (1849, 194, '03', 'Tahuania', NULL, '250203');
INSERT INTO `distrito` VALUES (1850, 194, '04', 'Yurua', NULL, '250204');
INSERT INTO `distrito` VALUES (1851, 195, '01', 'Padre Abad', NULL, '250301');
INSERT INTO `distrito` VALUES (1852, 195, '02', 'Irazola', NULL, '250302');
INSERT INTO `distrito` VALUES (1853, 195, '03', 'Curimana', NULL, '250303');
INSERT INTO `distrito` VALUES (1854, 195, '04', 'Neshuya', NULL, '250304');
INSERT INTO `distrito` VALUES (1855, 195, '05', 'Alexander Von Humboldt', NULL, '250305');
INSERT INTO `distrito` VALUES (1856, 196, '01', 'Purus', NULL, '250401');

-- ----------------------------
-- Table structure for documento_venta
-- ----------------------------
DROP TABLE IF EXISTS `documento_venta`;
CREATE TABLE `documento_venta`  (
  `id_tipo_documento` bigint NOT NULL AUTO_INCREMENT,
  `nombre_tipo_documento` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `documento_Serie` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `documento_Numero` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_tipo_documento`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of documento_venta
-- ----------------------------

-- ----------------------------
-- Table structure for documentos
-- ----------------------------
DROP TABLE IF EXISTS `documentos`;
CREATE TABLE `documentos`  (
  `id_doc` int NOT NULL,
  `codigo_sunat` varchar(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT 'Codigos segun SUNAT',
  `des_doc` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `estado` int NULL DEFAULT NULL,
  `abr_doc` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `compras` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '0' COMMENT '0=NO, 1=SI',
  `ventas` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '0' COMMENT '0=NO, 1=SI',
  `gastos` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '0' COMMENT '0=NO, 1=SI',
  `traspasos` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '0' COMMENT 'columna para las operaciones de traspaso',
  `es` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '0',
  `recargas` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '0',
  `combustible` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '0',
  PRIMARY KEY (`id_doc`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of documentos
-- ----------------------------
INSERT INTO `documentos` VALUES (1, '01', 'FACTURA', 1, 'FA', '1', '1', '1', '0', '0', '0', '1');
INSERT INTO `documentos` VALUES (2, '501', 'NOTA CREDITO', 1, 'NC', '1', '0', '0', '1', '1', '0', '0');
INSERT INTO `documentos` VALUES (3, '03', 'BOLETA VENTA', 1, 'BO', '1', '1', '1', '0', '0', '0', '1');
INSERT INTO `documentos` VALUES (4, '09', 'GUIA DE REMISION', 1, 'GR', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `documentos` VALUES (5, '502', 'PEDIDO COMPRA-VENTA', 1, 'PCV', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `documentos` VALUES (6, '503', 'NOTA VENTA', 1, 'NV', '1', '1', '1', '0', '0', '1', '1');
INSERT INTO `documentos` VALUES (7, '504', 'RECIBO DE CAJA', 1, 'RC', '0', '0', '1', '0', '0', '0', '0');
INSERT INTO `documentos` VALUES (8, '07', 'NC BOLETA', 1, 'NCB', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `documentos` VALUES (9, '07', 'NC FACTURA', 1, 'NCF', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `documentos` VALUES (10, '505', 'CRONOGRAMA DE PAGOS', 1, 'CP', '0', '0', '1', '0', '0', '0', '0');
INSERT INTO `documentos` VALUES (11, '02', 'RECIBO POR HONORARIOS', 1, 'RH', '0', '0', '1', '0', '0', '0', '0');
INSERT INTO `documentos` VALUES (12, '10', 'RECIBO POR ARENDAMIENTO', 1, 'RA', '0', '0', '1', '0', '0', '0', '0');
INSERT INTO `documentos` VALUES (13, '20', 'COMPROBANTE POR RETENCION', 1, 'CR', '0', '0', '1', '0', '0', '0', '0');
INSERT INTO `documentos` VALUES (14, '50', 'DECLARACION UNICA DE ADUANAS', 1, 'DUA', '0', '0', '1', '0', '0', '0', '0');
INSERT INTO `documentos` VALUES (15, '91', 'COMPROBANTE DE NO DOMICILIADO', 1, 'CND', '0', '0', '1', '0', '0', '0', '0');
INSERT INTO `documentos` VALUES (16, '506', 'CONTROL INTERNO', 1, 'CIN', '0', '0', '0', '1', '1', '0', '0');
INSERT INTO `documentos` VALUES (18, '09', 'GUIA DE REMISION ELECTRONICA', 1, 'GRE', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `documentos` VALUES (19, '508', 'ANTICIPOS', 1, 'ANT', '0', '0', '0', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for estados
-- ----------------------------
DROP TABLE IF EXISTS `estados`;
CREATE TABLE `estados`  (
  `estados_id` bigint NOT NULL AUTO_INCREMENT,
  `estados_nombre` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pais_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`estados_id`) USING BTREE,
  INDEX `estado_fk_1_idx`(`pais_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of estados
-- ----------------------------
INSERT INTO `estados` VALUES (1, 'Amazonas', 1);
INSERT INTO `estados` VALUES (2, 'Ancash', 1);
INSERT INTO `estados` VALUES (3, 'Apurimac', 1);
INSERT INTO `estados` VALUES (4, 'Arequipa', 1);
INSERT INTO `estados` VALUES (5, 'Ayacucho', 1);
INSERT INTO `estados` VALUES (6, 'Cajamarca', 1);
INSERT INTO `estados` VALUES (7, 'Callao', 1);
INSERT INTO `estados` VALUES (8, 'Cusco', 1);
INSERT INTO `estados` VALUES (9, 'Huancavelica', 1);
INSERT INTO `estados` VALUES (10, 'Huánuco', 1);
INSERT INTO `estados` VALUES (11, 'Ica', 1);
INSERT INTO `estados` VALUES (12, 'Junin', 1);
INSERT INTO `estados` VALUES (13, 'La Libertad', 1);
INSERT INTO `estados` VALUES (14, 'Lambayeque', 1);
INSERT INTO `estados` VALUES (15, 'Lima', 1);
INSERT INTO `estados` VALUES (16, 'Loreto', 1);
INSERT INTO `estados` VALUES (17, 'Madre de Dios', 1);
INSERT INTO `estados` VALUES (18, 'Moquegua', 1);
INSERT INTO `estados` VALUES (19, 'Pasco', 1);
INSERT INTO `estados` VALUES (20, 'Piura', 1);
INSERT INTO `estados` VALUES (21, 'Puno', 1);
INSERT INTO `estados` VALUES (22, 'San Martin', 1);
INSERT INTO `estados` VALUES (23, 'Tacna', 1);
INSERT INTO `estados` VALUES (24, 'Tumbes', 1);
INSERT INTO `estados` VALUES (25, 'Ucayali', 1);

-- ----------------------------
-- Table structure for facturacion
-- ----------------------------
DROP TABLE IF EXISTS `facturacion`;
CREATE TABLE `facturacion`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `local_id` bigint NOT NULL,
  `fecha` datetime NOT NULL,
  `fecha_cdr` datetime NULL DEFAULT NULL,
  `documento_tipo` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `documento_numero` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `documento_mod_tipo` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `documento_mod_numero` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `documento_mod_motivo` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `cliente_tipo` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `cliente_identificacion` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `cliente_nombre` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `cliente_direccion` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `total_gravadas` decimal(18, 2) NULL DEFAULT 0.00,
  `total_exoneradas` decimal(18, 2) NULL DEFAULT 0.00,
  `total_inafectas` decimal(18, 2) NULL DEFAULT 0.00,
  `total_gratuitas` decimal(18, 2) NULL DEFAULT 0.00,
  `total_descuento` decimal(18, 2) NULL DEFAULT 0.00,
  `total_bolsas` decimal(18, 2) NOT NULL DEFAULT 0.00,
  `subtotal` decimal(18, 2) NOT NULL DEFAULT 0.00,
  `impuesto` decimal(18, 2) NOT NULL DEFAULT 0.00,
  `total` decimal(18, 2) NOT NULL DEFAULT 0.00,
  `estado` tinyint NOT NULL DEFAULT 0,
  `condicion_pago` enum('Credito','Contado') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT 'Credito|Contado condicion de pago de la factura',
  `cuotas_registro` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT 'null | objeto json. Estructura: [{cuota:2,date:2021-03-24,monto:34.00},...]',
  `nota` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sunat_codigo` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hash_cpe` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hash_cdr` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ref_id` bigint NOT NULL,
  `descuento` decimal(18, 2) NULL DEFAULT 0.00,
  `estado_comprobante` tinyint NOT NULL DEFAULT 1 COMMENT '1 => Nuevo\n2 => Modificado\n3 => Anulado o dado de baja',
  `moneda_id` int NOT NULL DEFAULT 1029,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `facturacion_documento_tipo_documento_numero_uindex`(`documento_tipo` ASC, `documento_numero` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of facturacion
-- ----------------------------
INSERT INTO `facturacion` VALUES (1, 1, '2023-02-14 14:06:56', '2023-02-14 14:26:41', '03', 'B001-1', '', '', '', '1', '70798865', 'HUALLIPE MAMANI WILBER', NULL, 0.85, 0.00, 0.00, 0.00, 0.00, 0.00, 0.85, 0.15, 1.00, 3, 'Contado', NULL, 'El Comprobante numero B001-1, ha sido aceptado por el resumen RC-20230214-1', '0', 'Z2XQG4xfXVcGn3/S/6DyGtIecA4=', 'OJtyszeFz9Df4c80zMnRMQbxdHKRaOr85cBq1DS1f2/cZswpSQPouFVHfDpojOjODiQDA2GZck9Juflvt5Zyjw==', 1, 0.00, 1, 1029);
INSERT INTO `facturacion` VALUES (2, 1, '2023-02-14 14:34:58', '2023-02-14 15:29:00', '03', 'B001-41', '', '', '', '1', '77670689', 'SOLIS GOMEZ PAOLO FRANCIS', NULL, 0.85, 0.00, 0.00, 0.00, 0.00, 0.00, 0.85, 0.15, 1.00, 3, 'Contado', NULL, 'El Comprobante numero B001-41, ha sido aceptado por el resumen RC-20230214-3', '0', 'VvumQPu1sy5F/1wmHVpbLKWQ7bs=', 'f9T+SJlUQNn25Lz3ZbIodYS8cWFLTJqInJRB2B0tQ14=', 2, 0.00, 1, 1029);
INSERT INTO `facturacion` VALUES (3, 1, '2023-02-14 16:33:59', '2023-02-14 17:29:43', '03', 'B001-42', '', '', '', '1', '77670689', 'SOLIS GOMEZ PAOLO FRANCIS', NULL, 1.69, 0.00, 0.00, 0.00, 0.00, 0.00, 1.69, 0.31, 2.00, 3, 'Contado', NULL, 'El Comprobante numero B001-42, ha sido aceptado por el resumen RC-20230214-5', '0', 'Bk0EBqvHmwce534Ys/WEICNEtcA=', 'uqShYbk6PlUN2O7ZTIsDJ9Gfjl16VkKWpienCBtYmQI=', 3, 0.00, 3, 1029);
INSERT INTO `facturacion` VALUES (4, 1, '2023-02-15 09:50:57', '2023-02-15 09:50:33', '01', 'F001-1', '', '', '', '6', '20454713061', 'CONSORCIO JM S.A.C.', 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', 2.54, 0.00, 0.00, 0.00, 0.00, 0.00, 2.54, 0.46, 3.00, 3, 'Contado', NULL, 'La Factura numero F001-1, ha sido aceptada', '0', 'HUt/i/oo2o+snzgi+eA9b4fw26I=', 'juHseUpgDzs4+wKVUcUvjTtf15Lt+1EFsNGZ9aFrFW2AtT0h48P3psGwK3tB3eBLQFbtndr7Xh1BFz5435XG6w==', 4, 0.00, 1, 1029);
INSERT INTO `facturacion` VALUES (5, 1, '2023-02-15 10:22:00', '2023-02-15 10:21:36', '01', 'F001-2', '', '', '', '6', '20454713061', 'CONSORCIO JM S.A.C.', 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', 0.85, 0.00, 0.00, 0.00, 0.00, 0.00, 0.85, 0.15, 1.00, 3, 'Contado', NULL, 'La Factura numero F001-2, ha sido aceptada', '0', 'qZnUzZEEgARi3TZ2oGZsuk8Zc98=', 'OuDXzIfyxXJ5l93mdBb2XiJvuHjIFSbUm2EB+oeIEaTfB+kzmlZqs9sWzel6kIa16wyqcAZWyt1rH/99Td1BlA==', 5, 0.00, 1, 1029);
INSERT INTO `facturacion` VALUES (6, 1, '2023-02-15 10:27:27', '2023-02-15 10:27:02', '01', 'F001-3', '', '', '', '6', '20454713061', 'CONSORCIO JM S.A.C.', 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', 3.39, 0.00, 0.00, 0.00, 0.00, 0.00, 3.39, 0.61, 4.00, 3, 'Contado', NULL, 'La Factura numero F001-3, ha sido aceptada', '0', 'uES7G0ug04IBtrPJr3W2Gqbd148=', 'CJpnu2Qpmdiqnbzdk1rez3hRAvFmdqXri/efLcLhwzfZdSztCMQEvGdKRKjy0V98qR0Stkd8XTrT/uPfaSe3BQ==', 6, 0.00, 3, 1029);
INSERT INTO `facturacion` VALUES (7, 1, '2023-02-15 15:46:18', NULL, '03', 'B001-43', '', '', '', '1', '11111111', 'Cliente frecuente', NULL, 4.24, 0.00, 0.00, 0.00, 0.00, 0.00, 4.24, 0.76, 5.00, 1, 'Contado', NULL, 'La Boleta B001-43 ha sido generada correctamente', '0', 'tLLTQ4OrXfZ+UEOw0Km6p4jRqFk=', NULL, 7, 0.00, 1, 1029);
INSERT INTO `facturacion` VALUES (8, 1, '2023-02-16 10:30:18', '2023-02-16 10:29:51', '03', 'B001-44', '', '', '', '1', '11111111', 'Cliente frecuente', NULL, 0.85, 0.00, 0.00, 0.00, 0.00, 0.00, 0.85, 0.15, 1.00, 3, 'Contado', NULL, 'La Boleta numero B001-44, ha sido aceptada', '0', 'ntNsqXhduttob9mcrud8+FPEqXQ=', 'OLzT/u7LpX6FPd9wGusetLit6tgaNFPvXlggVc6gG7JfbNzMIvIxt4kwRgsSMb8Udr4BWOKKkR77KvkX2J5fMw==', 8, 0.00, 1, 1029);
INSERT INTO `facturacion` VALUES (9, 1, '2023-02-16 11:00:24', '2023-02-16 10:59:57', '03', 'B001-45', '', '', '', '1', '77670689', 'SOLIS GOMEZ PAOLO FRANCIS', NULL, 0.85, 0.00, 0.00, 0.00, 0.00, 0.00, 0.85, 0.15, 1.00, 3, 'Contado', NULL, 'La Boleta numero B001-45, ha sido aceptada', '0', 'gfBmOZd4CfPhGEtZIIpTVhE8u1I=', 'WI5aC9j2veM9bt4ZBsG1sstiKNbMexI4JOPp7dfvjncReTPJGKoVPJ5V5ER6BiTPBMGY3unA3VCF8/bnX5LIjw==', 9, 0.00, 1, 1029);
INSERT INTO `facturacion` VALUES (10, 1, '2023-02-16 11:09:30', '2023-02-16 11:09:03', '01', 'F001-4', '', '', '', '6', '20454713061', 'CONSORCIO JM S.A.C.', 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', 2.54, 0.00, 0.00, 0.00, 0.00, 0.00, 2.54, 0.46, 3.00, 3, 'Contado', NULL, 'La Factura numero F001-4, ha sido aceptada', '0', 'bJkASbIpBGLAKLnbavRbMMgoy4Y=', '48HFC0njadpPNFoFrRX2WugeW/Jt0d/qkxioFWrAfbfDvoCJW4n9HN4O7WzVnWLD/MUai+VdVo5qXYpxc5GCKA==', 10, 0.00, 1, 1029);
INSERT INTO `facturacion` VALUES (11, 1, '2023-02-16 14:43:47', NULL, '01', 'F001-5', '', '', '', '6', '20454713061', 'CONSORCIO JM S.A.C.', 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', 864.41, 0.00, 0.00, 0.00, 0.00, 0.00, 864.41, 155.59, 1020.00, 0, 'Contado', NULL, 'No enviado', NULL, NULL, NULL, 11, 40.00, 1, 1029);
INSERT INTO `facturacion` VALUES (12, 1, '2023-02-16 14:43:59', NULL, '01', 'F001-6', '', '', '', '6', '20454713061', 'CONSORCIO JM S.A.C.', 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', 1008.47, 0.00, 0.00, 0.00, 0.00, 0.00, 1008.47, 181.53, 1190.00, 0, 'Contado', NULL, 'No enviado', NULL, NULL, NULL, 11, 30.00, 1, 1029);
INSERT INTO `facturacion` VALUES (13, 1, '2023-02-16 14:44:24', NULL, '01', 'F001-7', '', '', '', '6', '20454713061', 'CONSORCIO JM S.A.C.', 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', 1152.54, 0.00, 0.00, 0.00, 0.00, 0.00, 1152.54, 207.46, 1360.00, 0, 'Contado', NULL, 'No enviado', NULL, NULL, NULL, 11, 20.00, 1, 1029);
INSERT INTO `facturacion` VALUES (14, 1, '2023-02-16 14:46:10', '2023-02-16 14:48:04', '01', 'F001-8', '', '', '', '6', '20454713061', 'CONSORCIO JM S.A.C.', 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', 1008.47, 0.00, 0.00, 0.00, 0.00, 0.00, 1008.47, 181.53, 1190.00, 4, 'Contado', NULL, 'El producto del factor y monto base de la afectación del IGV/IVAP no corresponde al monto de afectacion de linea. - Detalle: xxx.xxx.xxx value=\'ticket: 1676576856952 error: Error en la linea: 1 Tributo: 1000, MontoTributoCalculado: 100.847, MontoTributo: 181.53, BaseImponible: 1008.47, Tasa: 10.00: 3103 (nodo: \"cac:TaxSubtotal/cbc:TaxAmount\" valor: \"181.53\")\'', '3103', '7hc026ccvHT7SpTxgcUhXXR0FYI=', NULL, 11, 30.00, 1, 1029);
INSERT INTO `facturacion` VALUES (15, 1, '2023-02-17 09:43:39', '2023-02-17 09:43:40', '01', 'F001-663', '', '', '', '6', '20454713061', 'CONSORCIO JM S.A.C.', 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', 1.69, 0.00, 0.00, 0.00, 0.00, 0.00, 1.69, 0.31, 2.00, 3, 'Contado', NULL, 'La Factura numero F001-663, ha sido aceptado', '0', 'rOhQeKuR3QaWebw9+tEzHxrRoE4=', 'smsV1lhf5JduzRdYnKGXmUavZKJcS7OxOjq+/GxFyOk=', 12, 0.00, 3, 1029);
INSERT INTO `facturacion` VALUES (16, 1, '2023-02-20 12:10:06', '2023-02-20 12:10:06', '01', 'F001-664', '', '', '', '6', '20454713061', 'CONSORCIO JM S.A.C.', 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', 1.69, 0.00, 0.00, 0.00, 0.00, 0.00, 1.69, 0.31, 2.00, 3, 'Contado', NULL, 'La Factura numero F001-664, ha sido aceptado', '0', 'M81mXFwpUfYRUJyFI1knWwMVJmw=', 'c1BXXtTXuHIoT3S3gBnH1+GJO50AN3/dGZewfwtJYFM=', 13, 0.00, 1, 1029);
INSERT INTO `facturacion` VALUES (17, 1, '2023-02-21 14:44:08', '2023-02-21 15:24:35', '01', 'F001-9', '', '', '', '6', '20454713061', 'CONSORCIO JM S.A.C.', 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', 1.69, 0.00, 0.00, 0.00, 0.00, 0.00, 1.69, 0.31, 2.00, 3, 'Contado', NULL, 'La Factura numero F001-9, ha sido aceptada', '0', '3a5vmjTnBp0fMIZTTLHhsWtcD64=', 'xD0cae+VQZQuS67G3mDiHawGWVoB249Xkb4/Nt1HWBb28GWIPR2ue1+LNzhUncaOUxjmGZp6keitxCitq2Ra+g==', 14, 0.00, 1, 1029);
INSERT INTO `facturacion` VALUES (18, 1, '2023-02-21 16:20:15', '2023-02-21 16:20:15', '03', 'B001-46', '', '', '', '1', '77670689', 'SOLIS GOMEZ PAOLO FRANCIS', NULL, 2.54, 0.00, 0.00, 0.00, 0.00, 0.00, 2.54, 0.46, 3.00, 3, 'Contado', NULL, 'La Boleta de Venta Electrónica B001-46 ha sido ACEPTADA', '0', 'AY8ji9PiRaroOUXUTP81SWiBeKc=', 'q2+fgBxix3Qe8cg0y82P6lWLzwDnxOizE6QqMyKOqIA=', 15, 0.00, 1, 1029);
INSERT INTO `facturacion` VALUES (19, 1, '2023-02-21 16:22:43', '2023-02-21 16:22:43', '01', 'F001-10', '', '', '', '6', '20454713061', 'CONSORCIO JM S.A.C.', 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', 5.08, 0.00, 0.00, 0.00, 0.00, 0.00, 5.08, 0.92, 6.00, 3, 'Contado', NULL, 'La Factura Electrónica F001-10 ha sido ACEPTADA', '0', 'poYGwucZsSrB2/quQs3b9ovyJg0=', 'sUwKu2gvNRgCeusMwYKgMUsNsfEEvTukMMO6YwISHY4=', 16, 0.00, 1, 1029);
INSERT INTO `facturacion` VALUES (20, 1, '2023-02-22 12:44:22', '2023-02-22 12:44:22', '03', 'B001-47', '', '', '', '1', '77670689', 'SOLIS GOMEZ PAOLO FRANCIS', NULL, 3.39, 0.00, 0.00, 0.00, 0.00, 0.00, 3.39, 0.61, 4.00, 3, 'Contado', NULL, 'La Boleta de Venta Electrónica B001-47 ha sido ACEPTADA', '0', 'U5al2PdZFzs5wvqb8ZC5LaT3l1I=', 'tF53D/sBA6KVIGFsERBYENeqoMGNwpe+jIBqMEIfFC8=', 17, 0.00, 1, 1029);
INSERT INTO `facturacion` VALUES (21, 1, '2023-02-23 09:19:47', '2023-02-23 15:05:35', '01', 'F001-11', '', '', '', '6', '20454713061', 'CONSORCIO JM S.A.C.', 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', 10.17, 0.00, 0.00, 0.00, 0.00, 0.00, 10.17, 1.83, 12.00, 3, '', '', 'La Factura numero F001-11, ha sido aceptada', '0', 'UEgaxE/Z9Ng3rB+QlFkOWJzubnE=', 'pHySYKRIzxQFU3t+TnmIIoxzZZ1K+sYCvnlDSYOOCxJpGooERUnNPvQmMG7m8MFG/6cTmVFe0yyNgyYvl/zIXA==', 18, 0.00, 1, 1029);
INSERT INTO `facturacion` VALUES (22, 1, '2023-02-23 15:22:19', '2023-02-23 15:22:20', '03', 'B001-48', '', '', '', '1', '11111111', 'Cliente frecuente', NULL, 10.17, 0.00, 0.00, 0.00, 0.00, 0.00, 10.17, 1.83, 12.00, 1, 'Contado', NULL, 'Este comprobante ha sido anulado', '0', 'uYwfBD6fyKC3zqL09GGrtnZQJjk=', NULL, 19, 0.00, 3, 1029);
INSERT INTO `facturacion` VALUES (23, 1, '2023-02-23 17:23:23', '2023-02-23 17:23:23', '03', 'B001-49', '', '', '', '1', '11111111', 'Cliente frecuente', NULL, 6.78, 0.00, 0.00, 0.00, 0.00, 0.00, 6.78, 1.22, 8.00, 3, 'Contado', NULL, 'La Boleta de Venta Electrónica B001-49 ha sido ACEPTADA', '0', '1bMEl6GVnpZAcc3lOijr5krfegg=', 'YEWqjUJ6Af7p8rAUZQgxw0vxcePwEi6GoCfQ8buAm1Q=', 20, 0.00, 1, 1029);
INSERT INTO `facturacion` VALUES (24, 1, '2023-02-24 11:39:26', '2023-02-24 11:39:27', '03', 'B001-50', '', '', '', '1', '11111111', 'Cliente frecuente', NULL, 3.39, 0.00, 0.00, 0.00, 0.00, 0.00, 3.39, 0.61, 4.00, 3, 'Contado', NULL, 'La Boleta de Venta Electrónica B001-50 ha sido ACEPTADA', '0', 'xHht/JwxcZlCqINwIDbn6DXvZBI=', 'oPuzO8N+XmldNeanp3l2fi1k519iyKizuTWkJN5oSGs=', 21, 0.00, 1, 1029);
INSERT INTO `facturacion` VALUES (25, 1, '2023-02-24 14:07:49', NULL, '03', 'B001-51', '', '', '', '1', '11111111', 'Cliente frecuente', NULL, 6.78, 0.00, 0.00, 0.00, 0.00, 0.00, 6.78, 1.22, 8.00, 1, 'Contado', NULL, 'La Boleta B001-51 ha sido generada correctamente', '0', '26b2gT8NmaVK5TOLzGee1LN4SFw=', NULL, 23, 0.00, 1, 1029);
INSERT INTO `facturacion` VALUES (26, 1, '2023-02-27 11:26:27', '2023-02-27 11:26:44', '01', 'F001-12', '', '', '', '6', '20454713061', 'CONSORCIO JM S.A.C.', 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', 2542.37, 0.00, 0.00, 0.00, 0.00, 0.00, 2542.37, 457.63, 3000.00, 3, 'Contado', NULL, 'La Factura Electrónica F001-12 ha sido ACEPTADA', '0', 'uRdCncbb5ZWgoGio6KO/z/FluIg=', 'JUsadMyoDN92+mTXnkFe/2XMbeQNKclUdmRBR2lMRio=', 24, 40.00, 1, 1029);

-- ----------------------------
-- Table structure for facturacion_baja
-- ----------------------------
DROP TABLE IF EXISTS `facturacion_baja`;
CREATE TABLE `facturacion_baja`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fecha_emision` date NOT NULL,
  `correlativo` int NOT NULL,
  `estado` tinyint NOT NULL,
  `nota` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sunat_codigo` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hash_cpe` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hash_cdr` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ticket` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of facturacion_baja
-- ----------------------------
INSERT INTO `facturacion_baja` VALUES (1, '2023-02-15', 1, 3, 'La Comunicacion de baja RA-20230215-1, ha sido aceptada', '0', 'wdjEeyUwzlW7K/7uyd+lAlQxye4=', 'ZXiVJbgZA86BDTwviqU9FasvMs+upVHWI2Lt8Wrq5Koq2b1ScZHFZwdIyTkRXuhURvEji5sQuQhbf24e8blrKg==', '1676475067827');
INSERT INTO `facturacion_baja` VALUES (2, '2023-02-20', 1, 3, 'La Comunicación de Baja numero 20230220-1, ha sido aceptado', '0', 'CXIge/fsSTbS3JoV1M9EM0TNnhk=', 'vRd2x3Xib+JJG2pvAOm+rjjWS6aBiv8uOv40MPaHVo4=', '400000016979352');

-- ----------------------------
-- Table structure for facturacion_baja_comprobantes
-- ----------------------------
DROP TABLE IF EXISTS `facturacion_baja_comprobantes`;
CREATE TABLE `facturacion_baja_comprobantes`  (
  `comprobante_id` bigint NOT NULL,
  `baja_id` bigint NOT NULL,
  `motivo` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`comprobante_id`, `baja_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of facturacion_baja_comprobantes
-- ----------------------------
INSERT INTO `facturacion_baja_comprobantes` VALUES (6, 1, 'PRUEBA DE ANULACION');
INSERT INTO `facturacion_baja_comprobantes` VALUES (15, 2, 'ERROR DE PRUEBA');

-- ----------------------------
-- Table structure for facturacion_detalle
-- ----------------------------
DROP TABLE IF EXISTS `facturacion_detalle`;
CREATE TABLE `facturacion_detalle`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `facturacion_id` bigint NOT NULL,
  `producto_codigo` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `producto_descripcion` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `embalaje` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `um` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `cantidad` decimal(18, 3) NOT NULL,
  `precio` decimal(18, 8) NOT NULL,
  `precio_venta` decimal(18, 2) NOT NULL DEFAULT 0.00,
  `impuesto` decimal(18, 2) NOT NULL,
  `afectacion_impuesto` tinyint(1) NOT NULL DEFAULT 1,
  `tipo_precio` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '01',
  `tipo_tributo` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '10',
  `gratis` tinyint(1) NOT NULL DEFAULT 0,
  `descuento` decimal(18, 2) NOT NULL DEFAULT 0.00,
  `impuesto_bolsa` decimal(18, 2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of facturacion_detalle
-- ----------------------------
INSERT INTO `facturacion_detalle` VALUES (1, 1, '1', 'galleta oreo', '', 'UND', 1.000, 1.00000000, 1.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (2, 2, '1', 'galleta oreo', '', 'UND', 1.000, 1.00000000, 1.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (3, 3, '1', 'galleta oreo', '', 'UND', 2.000, 1.00000000, 1.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (4, 4, '1', 'galleta oreo', '', 'UND', 3.000, 1.00000000, 1.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (5, 5, '1', 'galleta oreo', '', 'UND', 1.000, 1.00000000, 1.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (6, 6, '1', 'galleta oreo', '', 'UND', 4.000, 1.00000000, 1.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (7, 7, '1', 'galleta oreo', '', 'UND', 5.000, 1.00000000, 1.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (8, 8, '1', 'galleta oreo', '', 'UND', 1.000, 1.00000000, 1.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (9, 9, '1', 'galleta oreo', '', 'UND', 1.000, 1.00000000, 1.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (10, 10, '1', 'galleta oreo', '', 'UND', 3.000, 1.00000000, 1.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (11, 11, '4455', 'nuevo producto', '', 'UND', 20.000, 51.00000000, 85.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (12, 12, '4455', 'nuevo producto', '', 'UND', 20.000, 59.50000000, 85.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (13, 13, '4455', 'nuevo producto', '', 'UND', 20.000, 68.00000000, 85.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (14, 14, '4455', 'nuevo producto', '', 'UND', 20.000, 59.50000000, 85.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (15, 15, '4455', 'foco led', '', 'UND', 1.000, 2.00000000, 2.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (16, 16, '4455', 'foco led', '', 'UND', 1.000, 2.00000000, 2.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (17, 17, '4455', 'foco led', '', 'UND', 1.000, 2.00000000, 2.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (18, 18, '1', 'galleta oreo', '', 'UND', 1.000, 1.00000000, 1.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (19, 18, '4455', 'foco led', '', 'UND', 1.000, 2.00000000, 2.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (20, 19, '1', 'galleta oreo', '', 'UND', 2.000, 1.00000000, 1.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (21, 19, '4455', 'foco led', '', 'UND', 2.000, 2.00000000, 2.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (22, 20, '4455', 'foco led', '', 'UND', 2.000, 2.00000000, 2.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (24, 21, '12234434', 'producto de ejemplo', '', 'UND', 3.000, 4.00000000, 4.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (25, 22, '12234434', 'producto de ejemplo', '', 'UND', 3.000, 4.00000000, 4.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (26, 23, '12234434', 'producto de ejemplo', '', 'UND', 2.000, 4.00000000, 4.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (27, 24, '4455', 'foco led', '', 'UND', 2.000, 2.00000000, 2.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (28, 25, '12234434', 'producto de ejemplo', '', 'UND', 2.000, 4.00000000, 4.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);
INSERT INTO `facturacion_detalle` VALUES (29, 26, '4455', 'foco led', '', 'UND', 1.000, 3000.00000000, 5000.00, 18.00, 1, '01', '10', 0, 0.00, 0.00);

-- ----------------------------
-- Table structure for facturacion_emisor
-- ----------------------------
DROP TABLE IF EXISTS `facturacion_emisor`;
CREATE TABLE `facturacion_emisor`  (
  `ruc` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `razon_social` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nombre_comercial` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `direccion` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `departamento_id` int NULL DEFAULT NULL,
  `provincia_id` int NULL DEFAULT NULL,
  `distrito_id` int NULL DEFAULT NULL,
  `ubigeo` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `moneda` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `env` enum('PROD','DEV') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'PROD',
  `user_sol` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pass_sol` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pass_sign` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `idgre` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tockengre` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tipoconexion` enum('SUNAT','OSE') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'SUNAT',
  PRIMARY KEY (`ruc`) USING BTREE,
  UNIQUE INDEX `ruc_UNIQUE`(`ruc` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of facturacion_emisor
-- ----------------------------
INSERT INTO `facturacion_emisor` VALUES ('20603943059', 'CORPORACION SIGA S.A.C.', 'CORPORACION SIGA S.A.C.', 'JR. PEDRO RUIZ GALLO NRO. 944 URB. BATIEVSKY (OVALO PEDRO RUIZ GALLO) LIMA - LIMA - BREÑA', 15, 128, 1269, '150105', 'PEN', 'DEV', 'MODDATOS', 'MODDATOS', 'Secund2020', 'test-85e5b0ae-255c-4891-a595-0b98c65c9854', 'test-Hty/M6QshYvPgItX2P0+Kw==', 'OSE');

-- ----------------------------
-- Table structure for facturacion_formato
-- ----------------------------
DROP TABLE IF EXISTS `facturacion_formato`;
CREATE TABLE `facturacion_formato`  (
  `id` int NOT NULL DEFAULT 1,
  `template_id` int NOT NULL DEFAULT 1,
  `razon_social` tinyint(1) NOT NULL DEFAULT 1,
  `nombre_comercial` tinyint(1) NOT NULL DEFAULT 1,
  `direccion_fisica` tinyint(1) NOT NULL DEFAULT 1,
  `direccion_sucursal` tinyint(1) NOT NULL DEFAULT 1,
  `local_nombre` tinyint(1) NOT NULL DEFAULT 1,
  `telefono` tinyint(1) NOT NULL DEFAULT 1,
  `publicidad` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `pie_pagina` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `qr` tinyint(1) NOT NULL DEFAULT 1,
  `logo_ticket` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of facturacion_formato
-- ----------------------------
INSERT INTO `facturacion_formato` VALUES (1, 1, 1, 0, 1, 0, 0, 1, '', '', 1, 0);

-- ----------------------------
-- Table structure for facturacion_resumen
-- ----------------------------
DROP TABLE IF EXISTS `facturacion_resumen`;
CREATE TABLE `facturacion_resumen`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `fecha_ref` date NOT NULL,
  `correlativo` int NOT NULL,
  `estado` tinyint NOT NULL,
  `nota` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `sunat_codigo` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hash_cpe` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hash_cdr` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ticket` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `facturacion_resumen_fecha_correlativo_uindex`(`fecha`, `correlativo`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 8 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of facturacion_resumen
-- ----------------------------
INSERT INTO `facturacion_resumen` VALUES (1, '2023-02-14', '2023-02-14', 1, 3, 'El Resumen diario RC-20230214-1, ha sido aceptado', '0', 'nj6WTazy6iZG90nSfS+zNTN3bZg=', 'OJtyszeFz9Df4c80zMnRMQbxdHKRaOr85cBq1DS1f2/cZswpSQPouFVHfDpojOjODiQDA2GZck9Juflvt5Zyjw==', '1676402801549');
INSERT INTO `facturacion_resumen` VALUES (2, '2023-02-14', '2023-02-14', 2, 3, 'El Resumen diario RC-20230214-2, ha sido aceptado', '0', 'BA1XaJeDpSM1sxb7UvgX2Z9Pptk=', 'hwA2KbFG2G+3WUGSoRfPpou7zNjVJgYlDbFRro4dUTptiGO3bO+CfkwPxGmAXivKQ6WcvPdyl2j+cWFoZxmTUg==', '1676404957747');
INSERT INTO `facturacion_resumen` VALUES (5, '2023-02-14', '2023-02-14', 3, 3, 'El Resumen Diario numero 20230214-3, ha sido aceptado', '0', 'LObCi2kuRuiQyByT262HPBSS2Kw=', 'f9T+SJlUQNn25Lz3ZbIodYS8cWFLTJqInJRB2B0tQ14=', '400000016207716');
INSERT INTO `facturacion_resumen` VALUES (6, '2023-02-14', '2023-02-14', 4, 3, 'El Resumen Diario numero 20230214-4, ha sido aceptado', '0', 'pXkAJlL6dc6tt4XAPWxO5KxPBaw=', 'ElGxFDNIZ3sW7Ptekhu9rz6VFARRJpxNDG39JNWKP3k=', '400000016213739');
INSERT INTO `facturacion_resumen` VALUES (7, '2023-02-14', '2023-02-14', 5, 3, 'El Resumen Diario numero 20230214-5, ha sido aceptado', '0', 'aKNxasn4UOnxCDEa9UKb+Qa9SVI=', 'uqShYbk6PlUN2O7ZTIsDJ9Gfjl16VkKWpienCBtYmQI=', '400000016221468');

-- ----------------------------
-- Table structure for facturacion_resumen_comprobantes
-- ----------------------------
DROP TABLE IF EXISTS `facturacion_resumen_comprobantes`;
CREATE TABLE `facturacion_resumen_comprobantes`  (
  `comprobante_id` int NOT NULL,
  `resumen_id` int NOT NULL,
  `estado` int NOT NULL,
  PRIMARY KEY (`comprobante_id`, `resumen_id`, `estado`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of facturacion_resumen_comprobantes
-- ----------------------------
INSERT INTO `facturacion_resumen_comprobantes` VALUES (1, 1, 1);
INSERT INTO `facturacion_resumen_comprobantes` VALUES (2, 2, 1);
INSERT INTO `facturacion_resumen_comprobantes` VALUES (2, 4, 1);
INSERT INTO `facturacion_resumen_comprobantes` VALUES (2, 5, 1);
INSERT INTO `facturacion_resumen_comprobantes` VALUES (3, 6, 1);
INSERT INTO `facturacion_resumen_comprobantes` VALUES (3, 7, 3);

-- ----------------------------
-- Table structure for familia
-- ----------------------------
DROP TABLE IF EXISTS `familia`;
CREATE TABLE `familia`  (
  `id_familia` bigint NOT NULL AUTO_INCREMENT,
  `nombre_familia` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `estatus_familia` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`id_familia`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of familia
-- ----------------------------

-- ----------------------------
-- Table structure for garante
-- ----------------------------
DROP TABLE IF EXISTS `garante`;
CREATE TABLE `garante`  (
  `dni` int NOT NULL,
  `nombre_full` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `direccion` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `refe_direccion` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `celular` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `correo` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `centro_traba` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `direc_trab` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nombre_conyu` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`dni`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of garante
-- ----------------------------

-- ----------------------------
-- Table structure for gastos
-- ----------------------------
DROP TABLE IF EXISTS `gastos`;
CREATE TABLE `gastos`  (
  `id_gastos` bigint NOT NULL AUTO_INCREMENT,
  `fecha_registro` datetime NULL DEFAULT NULL,
  `fecha` datetime NULL DEFAULT NULL,
  `descripcion` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `id_impuesto` int NULL DEFAULT NULL,
  `subtotal` float NULL DEFAULT NULL,
  `impuesto` float NULL DEFAULT NULL,
  `total` float(22, 2) NULL DEFAULT NULL,
  `tipo_gasto` bigint NULL DEFAULT NULL,
  `medio_pago` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `local_id` bigint NULL DEFAULT NULL,
  `status_gastos` tinyint(1) NULL DEFAULT 1,
  `gasto_usuario` bigint NULL DEFAULT NULL,
  `id_moneda` int NULL DEFAULT NULL,
  `tasa_cambio` decimal(4, 2) NULL DEFAULT NULL,
  `proveedor_id` bigint NULL DEFAULT NULL,
  `usuario_id` bigint NULL DEFAULT NULL,
  `responsable_id` bigint NULL DEFAULT NULL,
  `motivo_eliminar` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `gravable` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '0' COMMENT 'GRAVABLE 1=SI Y 0=NO',
  `id_documento` int NULL DEFAULT NULL COMMENT 'DOCUMENTO',
  `serie` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT 'NUMERO DE SERIE',
  `numero` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT 'NUMERO',
  `condicion_pago` int NULL DEFAULT NULL,
  `compra_ref_id` int NULL DEFAULT 0,
  PRIMARY KEY (`id_gastos`) USING BTREE,
  INDEX `tipos_gasto_fk1_idx`(`tipo_gasto` ASC) USING BTREE,
  INDEX `tipos_gasto_fk2_idx`(`local_id` ASC) USING BTREE,
  INDEX `gasto_usuario`(`gasto_usuario` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gastos
-- ----------------------------

-- ----------------------------
-- Table structure for gastos_detalle
-- ----------------------------
DROP TABLE IF EXISTS `gastos_detalle`;
CREATE TABLE `gastos_detalle`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_gastos` int NULL DEFAULT NULL,
  `descripcion` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `cantidad` int NULL DEFAULT NULL,
  `precio` decimal(18, 2) NULL DEFAULT NULL,
  `impuesto` decimal(18, 2) NULL DEFAULT NULL,
  `subtotal` decimal(18, 2) NULL DEFAULT NULL,
  `total` decimal(18, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gastos_detalle
-- ----------------------------

-- ----------------------------
-- Table structure for grupo_gastos
-- ----------------------------
DROP TABLE IF EXISTS `grupo_gastos`;
CREATE TABLE `grupo_gastos`  (
  `id_grupo_gastos` int NOT NULL AUTO_INCREMENT,
  `nom_grupo_gastos` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_grupo_gastos`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 7 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of grupo_gastos
-- ----------------------------
INSERT INTO `grupo_gastos` VALUES (1, 'GASTO DE VENTA');
INSERT INTO `grupo_gastos` VALUES (2, 'GASTO ADMINISTRATIVO');
INSERT INTO `grupo_gastos` VALUES (3, 'GASTO FINANCIERO');
INSERT INTO `grupo_gastos` VALUES (4, 'PLANILLA');
INSERT INTO `grupo_gastos` VALUES (5, 'GASTOS FINANCIEROS');
INSERT INTO `grupo_gastos` VALUES (6, 'SERVICIOS');

-- ----------------------------
-- Table structure for grupos
-- ----------------------------
DROP TABLE IF EXISTS `grupos`;
CREATE TABLE `grupos`  (
  `id_grupo` bigint NOT NULL AUTO_INCREMENT,
  `nombre_grupo` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `estatus_grupo` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`id_grupo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of grupos
-- ----------------------------

-- ----------------------------
-- Table structure for grupos_cliente
-- ----------------------------
DROP TABLE IF EXISTS `grupos_cliente`;
CREATE TABLE `grupos_cliente`  (
  `id_grupos_cliente` bigint NOT NULL AUTO_INCREMENT,
  `nombre_grupos_cliente` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status_grupos_cliente` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`id_grupos_cliente`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of grupos_cliente
-- ----------------------------
INSERT INTO `grupos_cliente` VALUES (1, 'GENERAL', 1);

-- ----------------------------
-- Table structure for grupos_usuarios
-- ----------------------------
DROP TABLE IF EXISTS `grupos_usuarios`;
CREATE TABLE `grupos_usuarios`  (
  `id_grupos_usuarios` bigint NOT NULL AUTO_INCREMENT,
  `nombre_grupos_usuarios` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status_grupos_usuarios` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`id_grupos_usuarios`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of grupos_usuarios
-- ----------------------------
INSERT INTO `grupos_usuarios` VALUES (1, 'CEO APLICATION', 1);
INSERT INTO `grupos_usuarios` VALUES (2, 'Administrador', 1);
INSERT INTO `grupos_usuarios` VALUES (8, 'Ventas', 1);
INSERT INTO `grupos_usuarios` VALUES (9, 'Gerente', 1);
INSERT INTO `grupos_usuarios` VALUES (11, 'Contador', 1);

-- ----------------------------
-- Table structure for guia
-- ----------------------------
DROP TABLE IF EXISTS `guia`;
CREATE TABLE `guia`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `motivo_traslado` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `modalidad_transporte` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ruc` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `razon_social` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `placa` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `certificado` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `conductor_tipo` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `conductor_id` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `subcontratacion` int NOT NULL,
  `estado` int NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of guia
-- ----------------------------

-- ----------------------------
-- Table structure for guia_remision
-- ----------------------------
DROP TABLE IF EXISTS `guia_remision`;
CREATE TABLE `guia_remision`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_documento` int NULL DEFAULT NULL,
  `id_cliente` bigint NOT NULL,
  `destinatario` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tipo_operacion` enum('cotizacion','venta','traslado','generico','guia_remision','traspaso','entradas_salidas') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `local_id` int NULL DEFAULT NULL,
  `serie` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `numero` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tipo_operacion_id` int NOT NULL,
  `tipo_operacion_remision_id` int NOT NULL,
  `nro_orden_compra` int NULL DEFAULT NULL,
  `fecha_emision` date NOT NULL,
  `fecha_inicio_traslado` date NOT NULL,
  `motivo_traslado_id` int NOT NULL,
  `otros_motivo` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `punto_partida` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `ubigeo_punto_partida` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `punto_llegada` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `ubigeo_punto_llegada` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `cantidad_total` int NOT NULL,
  `cantidad_parcial` int NOT NULL,
  `total` decimal(8, 2) NOT NULL,
  `peso_total` int NULL DEFAULT NULL,
  `transportista_id` int NOT NULL,
  `tipo_transportista` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `placa` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `ruc_transportista` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `razon_social_transportista` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tipo_documento_persona_id` int NULL DEFAULT NULL,
  `identificacion_conductor` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `nombre_conductor` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `nota` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `estado` tinyint(1) NOT NULL,
  `sunat_codigo` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hash_cpe` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hash_cdr` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sunat_nota` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `sunat_estado` int NOT NULL DEFAULT 0,
  `apellido_conductor` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `licencia_conductor` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of guia_remision
-- ----------------------------
INSERT INTO `guia_remision` VALUES (1, 18, 4, 'CONSORCIO JM', 'venta', 1, '002', '2', 2, 13, NULL, '2023-02-20', '2023-02-20', 1, '     ', 'JR LOS PINOS', '150101', 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', '040104', 1, 0, 2.00, 1, 1, '02', 'B1M140', '', '', 1, '70798865', 'WILBER', '', 1, NULL, NULL, NULL, NULL, 1, 'HUALLIPE MAMANI', 'Q00000001');
INSERT INTO `guia_remision` VALUES (2, 18, 3, 'SOLIS GOMEZ PAOLO FRANCIS', 'venta', 1, '002', '2', 2, 17, NULL, '2023-02-22', '2023-02-22', 1, '     ', 'JR PEDRO RUIZ', '150101', 'AV. SUCRE', '040102', 1, 0, 4.00, 1, 1, '02', 'B1M140', '', '', 1, '70798865', 'WILBER ', '', 1, '0', 'GDOc84yo6QJj1lH4eEbKkrA5Iy0=', '', 'El comprobante ha sido ACEPTADA', 3, 'HUALLIPE MAMANI', 'Q87654321');
INSERT INTO `guia_remision` VALUES (3, 18, 4, 'CONSORCIO JM S.A.C.', 'venta', 1, '002', '3', 2, 18, NULL, '2023-02-23', '2023-02-23', 1, '     ', 'JR PREDUIZ GALLO', '150101', 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', '040101', 1, 0, 12.00, 1, 1, '01', '1', '20535625078', 'NANOTECH SOLUTION', 1, '1', '1', '', 1, '0', '+wACUK9x9g/Sig1KuVkorInFPfo=', '', 'El comprobante ha sido ACEPTADA', 3, '', '');

-- ----------------------------
-- Table structure for guia_remision_detalle
-- ----------------------------
DROP TABLE IF EXISTS `guia_remision_detalle`;
CREATE TABLE `guia_remision_detalle`  (
  `guia_remision_id` int NOT NULL,
  `detalle_id` int NOT NULL,
  `producto_id` int NOT NULL,
  `importe` decimal(18, 2) NULL DEFAULT 0.00,
  `cantidad_total` decimal(8, 2) NOT NULL,
  `cantidad_parcial` decimal(8, 2) NOT NULL,
  `cantidad_despachar` decimal(8, 2) NOT NULL,
  `precio_und_min` decimal(18, 2) NULL DEFAULT 0.00,
  `unidad_abr` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `unidad` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_unidad` bigint NOT NULL,
  PRIMARY KEY (`guia_remision_id`, `detalle_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of guia_remision_detalle
-- ----------------------------
INSERT INTO `guia_remision_detalle` VALUES (1, 13, 2, 2.00, 1.00, 1.00, 1.00, 2.00, 'UND', 'UND', 1);
INSERT INTO `guia_remision_detalle` VALUES (2, 19, 2, 4.00, 2.00, 2.00, 2.00, 2.00, 'UND', 'UND', 1);
INSERT INTO `guia_remision_detalle` VALUES (3, 20, 3, 12.00, 3.00, 3.00, 3.00, 4.00, 'UND', 'UND', 1);

-- ----------------------------
-- Table structure for impuestos
-- ----------------------------
DROP TABLE IF EXISTS `impuestos`;
CREATE TABLE `impuestos`  (
  `id_impuesto` bigint NOT NULL AUTO_INCREMENT,
  `nombre_impuesto` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `porcentaje_impuesto` float NULL DEFAULT NULL,
  `estatus_impuesto` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`id_impuesto`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of impuestos
-- ----------------------------
INSERT INTO `impuestos` VALUES (1, 'IGV', 18, 1);

-- ----------------------------
-- Table structure for ingreso
-- ----------------------------
DROP TABLE IF EXISTS `ingreso`;
CREATE TABLE `ingreso`  (
  `id_ingreso` bigint NOT NULL AUTO_INCREMENT,
  `fecha_registro` timestamp NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `int_Proveedor_id` bigint NULL DEFAULT NULL,
  `nUsuCodigo` bigint NULL DEFAULT NULL,
  `local_id` bigint NULL DEFAULT NULL,
  `tipo_documento` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `documento_serie` char(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `documento_numero` char(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ingreso_status` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fecha_emision` timestamp NULL DEFAULT NULL,
  `tipo_ingreso` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `impuesto_ingreso` double NULL DEFAULT NULL,
  `sub_total_ingreso` double NULL DEFAULT NULL,
  `total_ingreso` double NULL DEFAULT NULL,
  `medio_pago` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pago` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ingreso_observacion` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `id_moneda` int NULL DEFAULT NULL,
  `tasa_cambio` decimal(4, 2) NULL DEFAULT NULL,
  `factura_ingreso_id` bigint NULL DEFAULT NULL,
  `facturado` tinyint(1) NULL DEFAULT 0,
  `tipo_impuesto` tinyint(1) NULL DEFAULT NULL,
  `id_gastos` int NULL DEFAULT NULL COMMENT 'CODIGO UNICO DE TABLA GASTOS',
  `int_usuario_id` int NULL DEFAULT NULL COMMENT 'CODIGO UNICO DE USUARIO PARA GASTOS',
  `costo_por` int NOT NULL DEFAULT 0,
  `utilidad_por` int NOT NULL DEFAULT 0,
  `motivo_anulacion` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_ingreso`) USING BTREE,
  INDEX `fk_OrdenCompra_personal1_idx`(`nUsuCodigo` ASC) USING BTREE,
  INDEX `fk_OrdenCompra_proveedor_idx`(`int_Proveedor_id` ASC) USING BTREE,
  INDEX `fk_ingreso_local_idx`(`local_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ingreso
-- ----------------------------
INSERT INTO `ingreso` VALUES (1, '2023-02-22 11:50:43', 2, 1, 1, 'FACTURA', 'F001', '2', 'COMPLETADO', '2023-02-15 10:22:00', 'COMPRA', 0.15, 0.85, 1, '3', 'CONTADO', '', 1029, 0.00, NULL, 0, 1, 0, 0, 0, 0, NULL);
INSERT INTO `ingreso` VALUES (2, '2023-02-23 09:18:37', 1, 1, 1, 'FACTURA', 'F001', '234', 'COMPLETADO', '2023-02-23 09:18:37', 'COMPRA', 7.63, 42.37, 50, '3', 'CONTADO', '', 1029, NULL, NULL, 0, 1, 0, 0, 0, 0, NULL);

-- ----------------------------
-- Table structure for ingreso_credito
-- ----------------------------
DROP TABLE IF EXISTS `ingreso_credito`;
CREATE TABLE `ingreso_credito`  (
  `ingreso_id` bigint NOT NULL,
  `numero_cuotas` int NOT NULL,
  `capital` decimal(18, 0) NULL DEFAULT NULL,
  `interes` decimal(18, 0) NULL DEFAULT NULL,
  `comision` decimal(18, 0) NULL DEFAULT NULL,
  `monto_cuota` decimal(18, 2) NOT NULL,
  `monto_debito` decimal(18, 2) NOT NULL DEFAULT 0.00,
  `estado` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `inicial` decimal(18, 2) NOT NULL,
  `periodo_gracia` int NULL DEFAULT NULL,
  `ultima_fecha_pago` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`ingreso_id`) USING BTREE,
  UNIQUE INDEX `ingreso_id_UNIQUE`(`ingreso_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ingreso_credito
-- ----------------------------

-- ----------------------------
-- Table structure for ingreso_credito_cuotas
-- ----------------------------
DROP TABLE IF EXISTS `ingreso_credito_cuotas`;
CREATE TABLE `ingreso_credito_cuotas`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `ingreso_id` bigint NOT NULL,
  `monto` decimal(18, 2) NOT NULL,
  `capital` decimal(18, 0) NULL DEFAULT NULL,
  `interes` decimal(18, 0) NULL DEFAULT NULL,
  `comision` decimal(18, 0) NULL DEFAULT NULL,
  `letra` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `fecha_vencimiento` datetime NOT NULL,
  `pagado` tinyint(1) NOT NULL DEFAULT 0,
  `fecha_cancelada` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ingreso_credito_cuotas
-- ----------------------------

-- ----------------------------
-- Table structure for kardex
-- ----------------------------
DROP TABLE IF EXISTS `kardex`;
CREATE TABLE `kardex`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL,
  `usuario_id` bigint NOT NULL,
  `local_id` bigint NOT NULL,
  `producto_id` bigint NOT NULL,
  `unidad_id` bigint NOT NULL,
  `cantidad` float(22, 3) NOT NULL DEFAULT 0.000,
  `cantidad_saldo` float(22, 3) NULL DEFAULT 0.000,
  `costo` decimal(18, 2) NULL DEFAULT NULL,
  `moneda_id` int NULL DEFAULT NULL,
  `io` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tipo` int NOT NULL,
  `operacion` int NOT NULL,
  `serie` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `numero` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ref_id` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ref_val` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kardex
-- ----------------------------
INSERT INTO `kardex` VALUES (1, '2023-02-14 14:05:07', 2, 1, 1, 1, 100.000, 100.000, 0.00, 1029, '1', 16, 16, '1', '1', '1', '');
INSERT INTO `kardex` VALUES (2, '2023-02-14 14:06:56', 2, 1, 1, 1, 1.000, 99.000, 0.85, 1029, '2', 3, 1, '001', '00000001', '1', NULL);
INSERT INTO `kardex` VALUES (3, '2023-02-14 14:34:58', 1, 1, 1, 1, 1.000, 98.000, 0.85, 1029, '2', 3, 1, '001', '00000041', '2', NULL);
INSERT INTO `kardex` VALUES (4, '2023-02-14 16:33:59', 1, 1, 1, 1, 2.000, 96.000, 0.85, 1029, '2', 3, 1, '001', '00000042', '3', NULL);
INSERT INTO `kardex` VALUES (5, '2023-02-14 17:29:23', 1, 1, 1, 1, -2.000, 98.000, 0.85, 1029, '2', 3, 1, '001', '00000042', '3', 'ANULADO');
INSERT INTO `kardex` VALUES (6, '2023-02-15 09:50:57', 1, 1, 1, 1, 3.000, 95.000, 0.85, 1029, '2', 1, 1, '001', '00000001', '4', NULL);
INSERT INTO `kardex` VALUES (7, '2023-02-15 10:22:00', 1, 1, 1, 1, 1.000, 94.000, 0.85, 1029, '2', 1, 1, '001', '00000002', '5', NULL);
INSERT INTO `kardex` VALUES (8, '2023-02-15 10:27:27', 1, 1, 1, 1, 4.000, 90.000, 0.85, 1029, '2', 1, 1, '001', '00000003', '6', NULL);
INSERT INTO `kardex` VALUES (9, '2023-02-15 10:31:32', 1, 1, 1, 1, -4.000, 94.000, 0.85, 1029, '2', 1, 1, '001', '00000003', '6', 'ANULADO');
INSERT INTO `kardex` VALUES (10, '2023-02-15 15:46:18', 1, 1, 1, 1, 5.000, 89.000, 0.85, 1029, '2', 3, 1, '001', '00000043', '7', NULL);
INSERT INTO `kardex` VALUES (11, '2023-02-16 10:30:18', 1, 1, 1, 1, 1.000, 88.000, 0.85, 1029, '2', 3, 1, '001', '00000044', '8', NULL);
INSERT INTO `kardex` VALUES (12, '2023-02-16 11:00:24', 1, 1, 1, 1, 1.000, 87.000, 0.85, 1029, '2', 3, 1, '001', '00000045', '9', NULL);
INSERT INTO `kardex` VALUES (13, '2023-02-16 11:09:30', 1, 1, 1, 1, 3.000, 84.000, 0.85, 1029, '2', 1, 1, '001', '00000004', '10', NULL);
INSERT INTO `kardex` VALUES (14, '2023-02-16 14:42:56', 1, 1, 2, 1, 20.000, -20.000, 72.03, 1029, '2', 6, 1, '001', '00000011', '11', NULL);
INSERT INTO `kardex` VALUES (15, '2023-02-16 14:47:35', 1, 1, 2, 1, -20.000, 0.000, 72.03, 1029, '2', 1, 1, '001', '00000008', '11', 'RECHAZADO');
INSERT INTO `kardex` VALUES (16, '2023-02-17 09:43:39', 1, 1, 2, 1, 1.000, -1.000, 1.69, 1029, '2', 1, 1, '001', '00000663', '12', NULL);
INSERT INTO `kardex` VALUES (18, '2023-02-20 11:13:58', 1, 1, 2, 1, -1.000, 0.000, 1.69, 1029, '2', 1, 1, '001', '00000663', '12', 'ANULADO');
INSERT INTO `kardex` VALUES (19, '2023-02-20 12:10:06', 1, 1, 2, 1, 1.000, -1.000, 1.69, 1029, '2', 1, 1, '001', '00000664', '13', NULL);
INSERT INTO `kardex` VALUES (20, '2023-02-21 14:39:22', 1, 1, 2, 1, 1.000, -2.000, 1.69, 1029, '2', 6, 1, '001', '00000014', '14', NULL);
INSERT INTO `kardex` VALUES (21, '2023-02-21 16:20:15', 1, 1, 1, 1, 1.000, 83.000, 0.85, 1029, '2', 3, 1, '001', '00000046', '15', NULL);
INSERT INTO `kardex` VALUES (22, '2023-02-21 16:20:15', 1, 1, 2, 1, 1.000, -3.000, 1.69, 1029, '2', 3, 1, '001', '00000046', '15', NULL);
INSERT INTO `kardex` VALUES (23, '2023-02-21 16:22:43', 1, 1, 1, 1, 2.000, 81.000, 0.85, 1029, '2', 1, 1, '001', '00000010', '16', NULL);
INSERT INTO `kardex` VALUES (24, '2023-02-21 16:22:43', 1, 1, 2, 1, 2.000, -5.000, 1.69, 1029, '2', 1, 1, '001', '00000010', '16', NULL);
INSERT INTO `kardex` VALUES (25, '2023-02-22 11:50:43', 1, 1, 2, 1, 1.000, -4.000, 0.85, 1029, '1', 1, 2, 'F001', '2', '1', NULL);
INSERT INTO `kardex` VALUES (26, '2023-02-22 12:44:22', 1, 1, 2, 1, 2.000, -6.000, 1.69, 1029, '2', 3, 1, '001', '00000047', '17', NULL);
INSERT INTO `kardex` VALUES (27, '2023-02-23 09:18:37', 1, 1, 3, 1, 100.000, 100.000, 0.42, 1029, '1', 1, 2, 'F001', '234', '2', NULL);
INSERT INTO `kardex` VALUES (28, '2023-02-23 09:19:47', 1, 1, 3, 1, 3.000, 97.000, 3.39, 1029, '2', 1, 1, '001', '00000011', '18', NULL);
INSERT INTO `kardex` VALUES (29, '2023-02-23 15:22:19', 1, 1, 3, 1, 3.000, 94.000, 3.39, 1029, '2', 3, 1, '001', '00000048', '19', NULL);
INSERT INTO `kardex` VALUES (30, '2023-02-23 17:20:43', 1, 1, 3, 1, -3.000, 97.000, 3.39, 1029, '2', 3, 1, '001', '00000048', '19', 'ANULADO');
INSERT INTO `kardex` VALUES (31, '2023-02-23 17:23:23', 1, 1, 3, 1, 2.000, 95.000, 3.39, 1029, '2', 3, 1, '001', '00000049', '20', NULL);
INSERT INTO `kardex` VALUES (32, '2023-02-24 11:39:26', 1, 1, 2, 1, 2.000, -8.000, 1.69, 1029, '2', 3, 1, '001', '00000050', '21', NULL);
INSERT INTO `kardex` VALUES (33, '2023-02-24 12:01:52', 1, 1, 3, 1, 2.000, 93.000, 3.39, 1029, '2', 6, 1, '001', '00000022', '22', NULL);
INSERT INTO `kardex` VALUES (34, '2023-02-24 14:06:34', 1, 1, 3, 1, 2.000, 91.000, 3.39, 1029, '2', 6, 1, '001', '00000023', '23', NULL);
INSERT INTO `kardex` VALUES (35, '2023-02-27 11:17:15', 1, 1, 2, 1, 1.000, -9.000, 4237.29, 1029, '2', 6, 1, '001', '00000024', '24', NULL);

-- ----------------------------
-- Table structure for keys
-- ----------------------------
DROP TABLE IF EXISTS `keys`;
CREATE TABLE `keys`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `key` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `level` int NOT NULL,
  `ignore_limits` tinyint(1) NOT NULL DEFAULT 0,
  `is_private_key` tinyint(1) NOT NULL DEFAULT 0,
  `ip_addresses` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `date_created` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of keys
-- ----------------------------

-- ----------------------------
-- Table structure for lineas
-- ----------------------------
DROP TABLE IF EXISTS `lineas`;
CREATE TABLE `lineas`  (
  `id_linea` bigint NOT NULL AUTO_INCREMENT,
  `nombre_linea` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '' COMMENT 'Nombre de linea',
  `estatus_linea` tinyint(1) NULL DEFAULT 1 COMMENT '1 = Activo, 0 = Inactivo',
  PRIMARY KEY (`id_linea`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lineas
-- ----------------------------

-- ----------------------------
-- Table structure for local
-- ----------------------------
DROP TABLE IF EXISTS `local`;
CREATE TABLE `local`  (
  `int_local_id` bigint NOT NULL AUTO_INCREMENT,
  `local_nombre` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `local_status` tinyint(1) NOT NULL DEFAULT 1,
  `principal` tinyint(1) NOT NULL DEFAULT 0,
  `distrito_id` int NULL DEFAULT NULL,
  `direccion` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `telefono` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tipo` int NULL DEFAULT 0 COMMENT '0 = Establecimiento de venta (punto de venta); 1 = almacen ',
  PRIMARY KEY (`int_local_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of local
-- ----------------------------
INSERT INTO `local` VALUES (1, 'PRINCIPAL', 1, 1, 1265, '', '', 0);

-- ----------------------------
-- Table structure for logs
-- ----------------------------
DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs`  (
  `id` int NOT NULL,
  `uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `method` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `params` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `api_key` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `time` int NOT NULL,
  `rtime` float NULL DEFAULT NULL,
  `authorized` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `response_code` smallint NULL DEFAULT 0
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logs
-- ----------------------------

-- ----------------------------
-- Table structure for marcas
-- ----------------------------
DROP TABLE IF EXISTS `marcas`;
CREATE TABLE `marcas`  (
  `id_marca` bigint NOT NULL AUTO_INCREMENT,
  `nombre_marca` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `estatus_marca` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`id_marca`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of marcas
-- ----------------------------

-- ----------------------------
-- Table structure for metodos_pago
-- ----------------------------
DROP TABLE IF EXISTS `metodos_pago`;
CREATE TABLE `metodos_pago`  (
  `id_metodo` bigint NOT NULL AUTO_INCREMENT,
  `nombre_metodo` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status_metodo` tinyint(1) NULL DEFAULT 1,
  `tipo_metodo` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tipo_metodo_egreso` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'CAJA',
  PRIMARY KEY (`id_metodo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of metodos_pago
-- ----------------------------
INSERT INTO `metodos_pago` VALUES (3, 'EFECTIVO', 1, 'CAJA', 'CAJA');
INSERT INTO `metodos_pago` VALUES (4, 'DEPOSITO', 1, 'BANCO', 'CAJA');
INSERT INTO `metodos_pago` VALUES (5, 'CHEQUE', 1, 'CAJA', 'BANCO');
INSERT INTO `metodos_pago` VALUES (6, 'NOTA DE CREDITO', 0, 'CAJA', 'CAJA');
INSERT INTO `metodos_pago` VALUES (7, 'TARJETA', 1, 'BANCO', 'BANCO');
INSERT INTO `metodos_pago` VALUES (8, 'YAPE - PLIN', 1, 'BANCO', 'ALL');
INSERT INTO `metodos_pago` VALUES (9, 'TRANSFERENCIA BANCARIA', 1, 'BANCO', 'BANCO');

-- ----------------------------
-- Table structure for moneda
-- ----------------------------
DROP TABLE IF EXISTS `moneda`;
CREATE TABLE `moneda`  (
  `id_moneda` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `simbolo` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pais` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tasa_soles` decimal(4, 2) NULL DEFAULT NULL,
  `ope_tasa` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status_moneda` int NULL DEFAULT 1,
  PRIMARY KEY (`id_moneda`) USING BTREE,
  UNIQUE INDEX `fk_1_nombre_moneda`(`nombre` ASC) USING BTREE,
  UNIQUE INDEX `fk_1_nombre_simbolo`(`nombre` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1031 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of moneda
-- ----------------------------
INSERT INTO `moneda` VALUES (1029, 'Soles', 'S/', 'Peru', NULL, '/', 1);
INSERT INTO `moneda` VALUES (1030, 'Dolares', '$', 'EEUU', 3.35, '*', 0);

-- ----------------------------
-- Table structure for motivos_descripcion
-- ----------------------------
DROP TABLE IF EXISTS `motivos_descripcion`;
CREATE TABLE `motivos_descripcion`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(300) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `codigo_sunat` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_tipo_operacion` int NULL DEFAULT NULL,
  `estado` int NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id_tipo_operacion`(`id_tipo_operacion` ASC) USING BTREE,
  CONSTRAINT `motivos_descripcion_ibfk_1` FOREIGN KEY (`id_tipo_operacion`) REFERENCES `tipo_operacion` (`id_tipo_operacion`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of motivos_descripcion
-- ----------------------------
INSERT INTO `motivos_descripcion` VALUES (1, 'VENTA', '01', 3, 1);
INSERT INTO `motivos_descripcion` VALUES (2, 'COMPRA', '02', 3, 1);
INSERT INTO `motivos_descripcion` VALUES (3, 'DEVOLUCION', NULL, 3, 1);
INSERT INTO `motivos_descripcion` VALUES (4, 'VENTA SUJETA A CONFIRMACION', '14', 3, 1);
INSERT INTO `motivos_descripcion` VALUES (5, 'TRASLADO ENTRE ESTABLECIMIENTO DE LA MISMA EMPRESA', '04', 3, 1);
INSERT INTO `motivos_descripcion` VALUES (6, 'TRASLADO DE BIENES PARA TRANSFORMACIÓN', NULL, 3, 1);
INSERT INTO `motivos_descripcion` VALUES (7, 'RECOJO DE BIENES', NULL, 3, 1);
INSERT INTO `motivos_descripcion` VALUES (8, 'TRASLADO EMISOR ITINERANTE DE COMPROBANTE PAGO', '18', 3, 1);
INSERT INTO `motivos_descripcion` VALUES (9, 'TRASLADO ZONA PRIMARIA', '19', 3, 1);
INSERT INTO `motivos_descripcion` VALUES (10, 'VENTA CON ENTREGA A TERCEROS', NULL, 3, 1);
INSERT INTO `motivos_descripcion` VALUES (11, 'OTROS', '13', 3, 1);

-- ----------------------------
-- Table structure for motivos_guiaremision
-- ----------------------------
DROP TABLE IF EXISTS `motivos_guiaremision`;
CREATE TABLE `motivos_guiaremision`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_motivo_remision` int NOT NULL,
  `id_tipo_operacion_remision` int NOT NULL,
  `estado` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of motivos_guiaremision
-- ----------------------------
INSERT INTO `motivos_guiaremision` VALUES (1, 1, 2, 1);
INSERT INTO `motivos_guiaremision` VALUES (2, 2, 2, 0);
INSERT INTO `motivos_guiaremision` VALUES (3, 3, 2, 0);
INSERT INTO `motivos_guiaremision` VALUES (4, 4, 2, 1);
INSERT INTO `motivos_guiaremision` VALUES (5, 5, 2, 0);
INSERT INTO `motivos_guiaremision` VALUES (6, 6, 2, 1);
INSERT INTO `motivos_guiaremision` VALUES (7, 7, 2, 0);
INSERT INTO `motivos_guiaremision` VALUES (8, 8, 2, 1);
INSERT INTO `motivos_guiaremision` VALUES (9, 9, 2, 1);
INSERT INTO `motivos_guiaremision` VALUES (10, 10, 2, 0);
INSERT INTO `motivos_guiaremision` VALUES (11, 11, 2, 1);
INSERT INTO `motivos_guiaremision` VALUES (12, 1, 1, 0);
INSERT INTO `motivos_guiaremision` VALUES (13, 2, 1, 0);
INSERT INTO `motivos_guiaremision` VALUES (14, 3, 1, 0);
INSERT INTO `motivos_guiaremision` VALUES (15, 4, 1, 1);
INSERT INTO `motivos_guiaremision` VALUES (16, 5, 1, 0);
INSERT INTO `motivos_guiaremision` VALUES (17, 6, 1, 1);
INSERT INTO `motivos_guiaremision` VALUES (18, 7, 1, 1);
INSERT INTO `motivos_guiaremision` VALUES (19, 8, 1, 0);
INSERT INTO `motivos_guiaremision` VALUES (20, 9, 1, 0);
INSERT INTO `motivos_guiaremision` VALUES (21, 10, 1, 0);
INSERT INTO `motivos_guiaremision` VALUES (22, 11, 1, 1);
INSERT INTO `motivos_guiaremision` VALUES (23, 1, 5, 0);
INSERT INTO `motivos_guiaremision` VALUES (24, 2, 5, 0);
INSERT INTO `motivos_guiaremision` VALUES (25, 3, 5, 1);
INSERT INTO `motivos_guiaremision` VALUES (26, 4, 5, 1);
INSERT INTO `motivos_guiaremision` VALUES (27, 5, 5, 1);
INSERT INTO `motivos_guiaremision` VALUES (28, 6, 5, 1);
INSERT INTO `motivos_guiaremision` VALUES (29, 7, 5, 0);
INSERT INTO `motivos_guiaremision` VALUES (30, 8, 5, 0);
INSERT INTO `motivos_guiaremision` VALUES (31, 9, 5, 1);
INSERT INTO `motivos_guiaremision` VALUES (32, 10, 5, 0);
INSERT INTO `motivos_guiaremision` VALUES (33, 11, 5, 1);
INSERT INTO `motivos_guiaremision` VALUES (34, 1, 3, 0);
INSERT INTO `motivos_guiaremision` VALUES (35, 2, 3, 1);
INSERT INTO `motivos_guiaremision` VALUES (36, 3, 3, 1);
INSERT INTO `motivos_guiaremision` VALUES (37, 4, 3, 1);
INSERT INTO `motivos_guiaremision` VALUES (38, 5, 3, 1);
INSERT INTO `motivos_guiaremision` VALUES (39, 6, 3, 1);
INSERT INTO `motivos_guiaremision` VALUES (40, 7, 3, 1);
INSERT INTO `motivos_guiaremision` VALUES (41, 8, 3, 1);
INSERT INTO `motivos_guiaremision` VALUES (42, 9, 3, 1);
INSERT INTO `motivos_guiaremision` VALUES (43, 10, 3, 1);
INSERT INTO `motivos_guiaremision` VALUES (44, 11, 3, 1);
INSERT INTO `motivos_guiaremision` VALUES (45, 1, 4, 0);
INSERT INTO `motivos_guiaremision` VALUES (46, 2, 4, 0);
INSERT INTO `motivos_guiaremision` VALUES (47, 3, 4, 1);
INSERT INTO `motivos_guiaremision` VALUES (48, 4, 4, 0);
INSERT INTO `motivos_guiaremision` VALUES (49, 5, 4, 1);
INSERT INTO `motivos_guiaremision` VALUES (50, 6, 4, 1);
INSERT INTO `motivos_guiaremision` VALUES (51, 7, 4, 1);
INSERT INTO `motivos_guiaremision` VALUES (52, 8, 4, 1);
INSERT INTO `motivos_guiaremision` VALUES (53, 9, 4, 1);
INSERT INTO `motivos_guiaremision` VALUES (54, 10, 4, 0);
INSERT INTO `motivos_guiaremision` VALUES (55, 11, 4, 1);

-- ----------------------------
-- Table structure for motivos_guiaremision_descripcion
-- ----------------------------
DROP TABLE IF EXISTS `motivos_guiaremision_descripcion`;
CREATE TABLE `motivos_guiaremision_descripcion`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(300) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of motivos_guiaremision_descripcion
-- ----------------------------
INSERT INTO `motivos_guiaremision_descripcion` VALUES (1, 'VENTA');
INSERT INTO `motivos_guiaremision_descripcion` VALUES (2, 'COMPRA');
INSERT INTO `motivos_guiaremision_descripcion` VALUES (3, 'DEVOLUCION');
INSERT INTO `motivos_guiaremision_descripcion` VALUES (4, 'VENTA SUJETA A CONFIRMACION');
INSERT INTO `motivos_guiaremision_descripcion` VALUES (5, 'TRASLADO ENTRE ESTABLECIMIENTO DE LA MISMA EMPRESA');
INSERT INTO `motivos_guiaremision_descripcion` VALUES (6, 'TRASLADO DE BIENES PARA TRANSFORMACIÓN');
INSERT INTO `motivos_guiaremision_descripcion` VALUES (7, 'RECOJO DE BIENES');
INSERT INTO `motivos_guiaremision_descripcion` VALUES (8, 'TRASLADO EMISOR ITINERANTE DE COMPROBANTE PAGO');
INSERT INTO `motivos_guiaremision_descripcion` VALUES (9, 'TRASLADO ZONA PRIMARIA');
INSERT INTO `motivos_guiaremision_descripcion` VALUES (10, 'VENTA CON ENTREGA A TERCEROS');
INSERT INTO `motivos_guiaremision_descripcion` VALUES (11, 'OTROS');

-- ----------------------------
-- Table structure for movimiento_historico
-- ----------------------------
DROP TABLE IF EXISTS `movimiento_historico`;
CREATE TABLE `movimiento_historico`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `producto_id` bigint NOT NULL,
  `local_id` bigint NOT NULL,
  `usuario_id` bigint NOT NULL,
  `um_id` int NOT NULL,
  `cantidad` bigint NOT NULL,
  `old_cantidad` bigint NULL DEFAULT NULL,
  `cantidad_actual` bigint NULL DEFAULT 0,
  `date` datetime NOT NULL,
  `tipo_movimiento` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tipo_operacion` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `referencia_valor` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `referencia_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movimiento_historico
-- ----------------------------

-- ----------------------------
-- Table structure for movimientos_caja
-- ----------------------------
DROP TABLE IF EXISTS `movimientos_caja`;
CREATE TABLE `movimientos_caja`  (
  `id_mov` int NOT NULL AUTO_INCREMENT,
  `mto_mov` decimal(10, 2) NULL DEFAULT NULL,
  `id_caja` int NULL DEFAULT NULL,
  `id_moneda` int NULL DEFAULT NULL,
  `tasa_cambio` decimal(4, 2) NULL DEFAULT NULL,
  `fecha_mov` datetime NULL DEFAULT NULL,
  `id_usuario` int NULL DEFAULT NULL,
  `tipo_mov` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_mov`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movimientos_caja
-- ----------------------------

-- ----------------------------
-- Table structure for notas_credito
-- ----------------------------
DROP TABLE IF EXISTS `notas_credito`;
CREATE TABLE `notas_credito`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `venta_id` bigint NOT NULL,
  `usuario_id` bigint NOT NULL,
  `fecha` datetime NOT NULL,
  `serie` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `numero` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `motivo_codigo` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notas_credito
-- ----------------------------

-- ----------------------------
-- Table structure for notas_credito_detalle
-- ----------------------------
DROP TABLE IF EXISTS `notas_credito_detalle`;
CREATE TABLE `notas_credito_detalle`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `notas_credito_id` bigint NOT NULL,
  `detalle_id` bigint NOT NULL,
  `cantidad` decimal(18, 3) NOT NULL,
  `precio` decimal(18, 4) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notas_credito_detalle
-- ----------------------------

-- ----------------------------
-- Table structure for opcion
-- ----------------------------
DROP TABLE IF EXISTS `opcion`;
CREATE TABLE `opcion`  (
  `nOpcion` bigint NOT NULL AUTO_INCREMENT,
  `nOpcionClase` bigint NULL DEFAULT NULL,
  `cOpcionDescripcion` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `cOpcionNombre` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`nOpcion`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11187 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of opcion
-- ----------------------------
INSERT INTO `opcion` VALUES (1, NULL, 'inventario', 'Inventario');
INSERT INTO `opcion` VALUES (2, NULL, 'ingresos', 'Compras');
INSERT INTO `opcion` VALUES (3, NULL, 'ventas', 'Ventas');
INSERT INTO `opcion` VALUES (4, NULL, 'clientespadre', 'Clientes');
INSERT INTO `opcion` VALUES (5, NULL, 'proveedores', 'Proveedores');
INSERT INTO `opcion` VALUES (6, NULL, 'cajas', 'Caja y Bancos');
INSERT INTO `opcion` VALUES (7, NULL, 'reportes', 'Reportes');
INSERT INTO `opcion` VALUES (8, NULL, 'opciones', 'Configuraciones');
INSERT INTO `opcion` VALUES (9, NULL, 'dashboard', 'Dashboard');
INSERT INTO `opcion` VALUES (10, NULL, 'facturacion', 'Facturacion Electronica');
INSERT INTO `opcion` VALUES (11, NULL, 'accesomovil', 'Acceso Movil');
INSERT INTO `opcion` VALUES (13, NULL, 'criterioventas', 'Criterio de Ventas');
INSERT INTO `opcion` VALUES (14, NULL, 'modulo_guia_remision', 'Guía de remisión');
INSERT INTO `opcion` VALUES (101, 1, 'productos', 'Productos');
INSERT INTO `opcion` VALUES (102, 1, 'stock', 'Stock Productos');
INSERT INTO `opcion` VALUES (103, 1, 'traspaso', 'Traspasos de Almacen');
INSERT INTO `opcion` VALUES (104, 1, 'ajusteinventario', 'Entradas & Salidas');
INSERT INTO `opcion` VALUES (105, 1, 'listaprecios', 'Stock & Precios');
INSERT INTO `opcion` VALUES (106, 1, 'movimientoinventario', 'Kardex');
INSERT INTO `opcion` VALUES (107, 1, 'categorizacion', 'Categorizacion');
INSERT INTO `opcion` VALUES (108, 1, 'marcas', 'Marcas');
INSERT INTO `opcion` VALUES (109, 1, 'gruposproductos', 'Grupos');
INSERT INTO `opcion` VALUES (110, 1, 'familias', 'Familias');
INSERT INTO `opcion` VALUES (111, 1, 'lineas', 'Lineas');
INSERT INTO `opcion` VALUES (112, 1, 'packing', 'Packing List');
INSERT INTO `opcion` VALUES (201, 2, 'registraringreo', 'Registrar Compras');
INSERT INTO `opcion` VALUES (203, 2, 'consultarcompras', 'Consultar Compras');
INSERT INTO `opcion` VALUES (204, 2, 'devolucioningreso', 'Anulacion Compras');
INSERT INTO `opcion` VALUES (205, 2, 'registraringreoxml', 'Registrar Compras (XML)');
INSERT INTO `opcion` VALUES (301, 3, 'generarventa', 'Realizar Venta');
INSERT INTO `opcion` VALUES (302, 3, 'cobraencaja', 'Cobrar en Caja');
INSERT INTO `opcion` VALUES (303, 3, 'cotizaciones', 'Cotizaciones');
INSERT INTO `opcion` VALUES (304, 3, 'historialventas', 'Registro de Ventas');
INSERT INTO `opcion` VALUES (305, 3, 'anularventa', 'Anular & Devolver');
INSERT INTO `opcion` VALUES (306, 3, 'ofertas', 'Ofertas');
INSERT INTO `opcion` VALUES (307, 3, 'guia_remision', 'Guia de remision Manual');
INSERT INTO `opcion` VALUES (308, 3, 'configurarguia', 'Guia Remision Electronica');
INSERT INTO `opcion` VALUES (309, 3, 'generarRecarga', 'Recarga Telefonica');
INSERT INTO `opcion` VALUES (310, 3, 'combustible', 'Recarga Combustible');
INSERT INTO `opcion` VALUES (311, 3, 'configurarventa', 'Configurar venta');
INSERT INTO `opcion` VALUES (312, 3, 'etiquetasdespacho', 'Etiquetas de despacho');
INSERT INTO `opcion` VALUES (401, 4, 'clientes', 'Registrar clientes');
INSERT INTO `opcion` VALUES (402, 4, 'gruposcliente', 'Clasificación de clientes');
INSERT INTO `opcion` VALUES (403, 4, 'cuentasporcobrar', 'Cuentas x cobrar');
INSERT INTO `opcion` VALUES (404, 4, 'estadocuenta', 'Estado de cuenta Cliente');
INSERT INTO `opcion` VALUES (405, 4, 'listacuentasxcobrar', 'Lista de Vencimiento de cobros');
INSERT INTO `opcion` VALUES (406, 4, 'calendarioCuentasCobrar', 'Calendario Cuentas x Cobrar');
INSERT INTO `opcion` VALUES (501, 5, 'proveedor', 'Registrar proveedores');
INSERT INTO `opcion` VALUES (502, 5, 'cuentasporpagar', 'Cuentas x pagar');
INSERT INTO `opcion` VALUES (503, 5, 'calendarioCuentasPagar', 'Calendario de cuentas x pagar');
INSERT INTO `opcion` VALUES (601, 6, 'cajaybancos', 'Caja y bancos');
INSERT INTO `opcion` VALUES (602, 6, 'gastos', 'Gastos');
INSERT INTO `opcion` VALUES (603, 6, 'tiposgasto', 'Tipo gasto');
INSERT INTO `opcion` VALUES (604, 6, 'bancos', 'Bancos');
INSERT INTO `opcion` VALUES (605, 6, 'cuadrecaja', 'Corte de caja');
INSERT INTO `opcion` VALUES (606, 6, 'anticipos', 'Anticipos');
INSERT INTO `opcion` VALUES (701, 7, 'inventariopadre', 'Inventario');
INSERT INTO `opcion` VALUES (702, 7, 'valorizacioneinventario', 'Inventario Valorizado');
INSERT INTO `opcion` VALUES (703, 7, 'stockventas', 'Stock y ventas');
INSERT INTO `opcion` VALUES (704, 7, 'ingresodetallado', 'Ingreso detallado');
INSERT INTO `opcion` VALUES (705, 7, 'kardexvalorizado', 'Kardex Valorizado');
INSERT INTO `opcion` VALUES (706, 7, 'ventapadre', 'Venta');
INSERT INTO `opcion` VALUES (707, 7, 'resumenventas', 'Resumen de ventas');
INSERT INTO `opcion` VALUES (708, 7, 'comisionxvendedor', 'Comision x vendedor');
INSERT INTO `opcion` VALUES (709, 7, 'ventaxcomprobante', 'Venta x Comprobante');
INSERT INTO `opcion` VALUES (710, 7, 'productovendido', 'Productos + vendidos');
INSERT INTO `opcion` VALUES (711, 7, 'ventaSucursal', 'Ventas x sucursal');
INSERT INTO `opcion` VALUES (712, 7, 'ventaEmpleado', 'Ventas x empleado');
INSERT INTO `opcion` VALUES (713, 7, 'margenutilidad', 'Margen de utilidad');
INSERT INTO `opcion` VALUES (714, 7, 'utilidadProducto', 'Utilidad x venta');
INSERT INTO `opcion` VALUES (715, 7, 'hojaColecta', 'Reporte hoja de colecta');
INSERT INTO `opcion` VALUES (716, 7, 'recargaDia', 'Recargas telefonicas del día');
INSERT INTO `opcion` VALUES (717, 7, 'cobranzadeldia', 'Cobranza del día');
INSERT INTO `opcion` VALUES (718, 7, 'recargaCuentasC', 'Cuentas por cobrar');
INSERT INTO `opcion` VALUES (719, 7, 'creditofiscal', 'Credito Fiscal');
INSERT INTO `opcion` VALUES (720, 7, 'ventaxproducto', 'Ventas en cantidades x dia');
INSERT INTO `opcion` VALUES (721, 7, 'verificainventario', 'Verificacion Inventario');
INSERT INTO `opcion` VALUES (722, 7, 'comprapadre', 'Compra');
INSERT INTO `opcion` VALUES (723, 7, 'pagoproveedores', 'Pago a proveedores');
INSERT INTO `opcion` VALUES (724, 7, 'cajapadre', 'Caja');
INSERT INTO `opcion` VALUES (725, 7, 'estadoresultado', 'Estado de Resultados');
INSERT INTO `opcion` VALUES (726, 7, 'comprasvsventas', 'Compras vs Ventas');
INSERT INTO `opcion` VALUES (727, 7, 'libroelectronico', 'Libro Electronico');
INSERT INTO `opcion` VALUES (801, 8, 'opcionesgenerales', 'Configurar');
INSERT INTO `opcion` VALUES (802, 8, 'locales', 'Locales');
INSERT INTO `opcion` VALUES (803, 8, 'usuariospadre', 'Usuarios');
INSERT INTO `opcion` VALUES (804, 8, 'usuarios', 'Registro Usuarios');
INSERT INTO `opcion` VALUES (805, 8, 'gruposusuarios', 'Perfiles');
INSERT INTO `opcion` VALUES (806, 8, 'region', 'Ubigeo');
INSERT INTO `opcion` VALUES (807, 8, 'pais', 'Paises');
INSERT INTO `opcion` VALUES (808, 8, 'estado', 'Departamento');
INSERT INTO `opcion` VALUES (809, 8, 'ciudad', 'Provincia');
INSERT INTO `opcion` VALUES (810, 8, 'distrito', 'Distrito');
INSERT INTO `opcion` VALUES (811, 8, 'regmonedas', 'Monedas');
INSERT INTO `opcion` VALUES (812, 8, 'unidadesmedida', 'Unidad de medida');
INSERT INTO `opcion` VALUES (813, 8, 'impuestos', 'Impuestos');
INSERT INTO `opcion` VALUES (901, 9, 'reporteVentas', 'Reporte semanal de salidas');
INSERT INTO `opcion` VALUES (902, 9, 'reporteCompras', 'Reporte semanal de compras');
INSERT INTO `opcion` VALUES (903, 9, 'reporteFacturacion', 'Resumen Facturacion Electronica');
INSERT INTO `opcion` VALUES (1001, 10, 'comprobantes', 'Comprobantes');
INSERT INTO `opcion` VALUES (1002, 10, 'sistema_emision', 'Sistema de Emision');
INSERT INTO `opcion` VALUES (1003, 10, 'notas_pedido', 'Notas de Venta');
INSERT INTO `opcion` VALUES (1004, 10, 'disenocomprobantes', 'Diseño de Comprobante');
INSERT INTO `opcion` VALUES (1005, 10, 'reportes_facturacion', 'Reportes');
INSERT INTO `opcion` VALUES (1006, 10, 'ventas_emitidas', 'Ventas Emitidas');
INSERT INTO `opcion` VALUES (1007, 10, 'relacion_comprobantes', 'Relacion de Comprobantes');
INSERT INTO `opcion` VALUES (1008, 10, 'configurar_emisor', 'Configurar Emisor');
INSERT INTO `opcion` VALUES (1101, 11, 'ventas', 'Realizar Ventas');
INSERT INTO `opcion` VALUES (1102, 11, 'caja', 'Cobrar en Caja');
INSERT INTO `opcion` VALUES (1103, 11, 'registroventas', 'Registro de Ventas');
INSERT INTO `opcion` VALUES (1104, 11, 'cliente', 'Cliente');
INSERT INTO `opcion` VALUES (1105, 11, 'emision', 'Emision de comprobantes ');
INSERT INTO `opcion` VALUES (1106, 11, 'productos', 'Productos');
INSERT INTO `opcion` VALUES (1107, 11, 'inventario', 'Entradas & Salidas');
INSERT INTO `opcion` VALUES (1108, 11, 'reportes', 'Reportes');
INSERT INTO `opcion` VALUES (1301, 13, 'venta_precio_sistema_mas', 'Vender al precio del sistema o más');
INSERT INTO `opcion` VALUES (1302, 13, 'venta_precio_sistema', 'Vender solo al precio del sistema');
INSERT INTO `opcion` VALUES (1303, 13, 'vender_debajo_precio', 'Vender cualquier precio, incluso debajo');
INSERT INTO `opcion` VALUES (1304, 13, 'vender_cualquier_precio', 'Vender a cualquier precio mayor al costo');
INSERT INTO `opcion` VALUES (1401, 14, 'gr_guia_remision_historial', 'Registro de guía de remisión');
INSERT INTO `opcion` VALUES (1402, 14, 'gr_transportista', 'Transportistas');
INSERT INTO `opcion` VALUES (1403, 14, 'gr_vehiculo', 'Vehículos');
INSERT INTO `opcion` VALUES (1404, 14, 'gr_configurarguia', 'Configuración de guía');
INSERT INTO `opcion` VALUES (11186, 10, 'relacion_guias', 'Relacion de Guias');

-- ----------------------------
-- Table structure for opcion_grupo
-- ----------------------------
DROP TABLE IF EXISTS `opcion_grupo`;
CREATE TABLE `opcion_grupo`  (
  `grupo` bigint NOT NULL,
  `Opcion` bigint NOT NULL,
  `var_opcion_usuario_estado` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`grupo`, `Opcion`) USING BTREE,
  INDEX `nopcionUsuarioFKUsuario_idx`(`grupo` ASC) USING BTREE,
  INDEX `nopcionUsuarioFKOpcion_idx`(`Opcion` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of opcion_grupo
-- ----------------------------
INSERT INTO `opcion_grupo` VALUES (1, 1, 1);
INSERT INTO `opcion_grupo` VALUES (1, 2, 1);
INSERT INTO `opcion_grupo` VALUES (1, 3, 1);
INSERT INTO `opcion_grupo` VALUES (1, 4, 1);
INSERT INTO `opcion_grupo` VALUES (1, 5, 1);
INSERT INTO `opcion_grupo` VALUES (1, 6, 1);
INSERT INTO `opcion_grupo` VALUES (1, 7, 1);
INSERT INTO `opcion_grupo` VALUES (1, 8, 1);
INSERT INTO `opcion_grupo` VALUES (1, 9, 1);
INSERT INTO `opcion_grupo` VALUES (1, 10, 1);
INSERT INTO `opcion_grupo` VALUES (1, 11, 1);
INSERT INTO `opcion_grupo` VALUES (1, 13, 1);
INSERT INTO `opcion_grupo` VALUES (1, 29, 1);
INSERT INTO `opcion_grupo` VALUES (1, 30, 1);
INSERT INTO `opcion_grupo` VALUES (1, 31, 1);
INSERT INTO `opcion_grupo` VALUES (1, 32, 1);
INSERT INTO `opcion_grupo` VALUES (1, 33, 1);
INSERT INTO `opcion_grupo` VALUES (1, 34, 1);
INSERT INTO `opcion_grupo` VALUES (1, 35, 1);
INSERT INTO `opcion_grupo` VALUES (1, 36, 1);
INSERT INTO `opcion_grupo` VALUES (1, 37, 1);
INSERT INTO `opcion_grupo` VALUES (1, 38, 1);
INSERT INTO `opcion_grupo` VALUES (1, 39, 1);
INSERT INTO `opcion_grupo` VALUES (1, 40, 1);
INSERT INTO `opcion_grupo` VALUES (1, 41, 1);
INSERT INTO `opcion_grupo` VALUES (1, 42, 1);
INSERT INTO `opcion_grupo` VALUES (1, 43, 1);
INSERT INTO `opcion_grupo` VALUES (1, 44, 1);
INSERT INTO `opcion_grupo` VALUES (1, 45, 1);
INSERT INTO `opcion_grupo` VALUES (1, 46, 1);
INSERT INTO `opcion_grupo` VALUES (1, 47, 1);
INSERT INTO `opcion_grupo` VALUES (1, 48, 1);
INSERT INTO `opcion_grupo` VALUES (1, 49, 1);
INSERT INTO `opcion_grupo` VALUES (1, 50, 1);
INSERT INTO `opcion_grupo` VALUES (1, 51, 1);
INSERT INTO `opcion_grupo` VALUES (1, 52, 1);
INSERT INTO `opcion_grupo` VALUES (1, 53, 1);
INSERT INTO `opcion_grupo` VALUES (1, 54, 1);
INSERT INTO `opcion_grupo` VALUES (1, 55, 1);
INSERT INTO `opcion_grupo` VALUES (1, 56, 1);
INSERT INTO `opcion_grupo` VALUES (1, 57, 1);
INSERT INTO `opcion_grupo` VALUES (1, 58, 1);
INSERT INTO `opcion_grupo` VALUES (1, 59, 1);
INSERT INTO `opcion_grupo` VALUES (1, 60, 1);
INSERT INTO `opcion_grupo` VALUES (1, 61, 1);
INSERT INTO `opcion_grupo` VALUES (1, 62, 1);
INSERT INTO `opcion_grupo` VALUES (1, 63, 1);
INSERT INTO `opcion_grupo` VALUES (1, 64, 1);
INSERT INTO `opcion_grupo` VALUES (1, 65, 1);
INSERT INTO `opcion_grupo` VALUES (1, 66, 1);
INSERT INTO `opcion_grupo` VALUES (1, 67, 1);
INSERT INTO `opcion_grupo` VALUES (1, 68, 1);
INSERT INTO `opcion_grupo` VALUES (1, 69, 1);
INSERT INTO `opcion_grupo` VALUES (1, 70, 1);
INSERT INTO `opcion_grupo` VALUES (1, 71, 1);
INSERT INTO `opcion_grupo` VALUES (1, 72, 1);
INSERT INTO `opcion_grupo` VALUES (1, 73, 1);
INSERT INTO `opcion_grupo` VALUES (1, 74, 1);
INSERT INTO `opcion_grupo` VALUES (1, 75, 1);
INSERT INTO `opcion_grupo` VALUES (1, 76, 1);
INSERT INTO `opcion_grupo` VALUES (1, 100, 1);
INSERT INTO `opcion_grupo` VALUES (1, 101, 1);
INSERT INTO `opcion_grupo` VALUES (1, 102, 1);
INSERT INTO `opcion_grupo` VALUES (1, 103, 1);
INSERT INTO `opcion_grupo` VALUES (1, 104, 1);
INSERT INTO `opcion_grupo` VALUES (1, 105, 1);
INSERT INTO `opcion_grupo` VALUES (1, 106, 1);
INSERT INTO `opcion_grupo` VALUES (1, 107, 1);
INSERT INTO `opcion_grupo` VALUES (1, 108, 1);
INSERT INTO `opcion_grupo` VALUES (1, 109, 1);
INSERT INTO `opcion_grupo` VALUES (1, 110, 1);
INSERT INTO `opcion_grupo` VALUES (1, 111, 1);
INSERT INTO `opcion_grupo` VALUES (1, 112, 1);
INSERT INTO `opcion_grupo` VALUES (1, 113, 1);
INSERT INTO `opcion_grupo` VALUES (1, 114, 1);
INSERT INTO `opcion_grupo` VALUES (1, 115, 1);
INSERT INTO `opcion_grupo` VALUES (1, 116, 1);
INSERT INTO `opcion_grupo` VALUES (1, 117, 1);
INSERT INTO `opcion_grupo` VALUES (1, 118, 1);
INSERT INTO `opcion_grupo` VALUES (1, 201, 1);
INSERT INTO `opcion_grupo` VALUES (1, 203, 1);
INSERT INTO `opcion_grupo` VALUES (1, 204, 1);
INSERT INTO `opcion_grupo` VALUES (1, 205, 1);
INSERT INTO `opcion_grupo` VALUES (1, 301, 1);
INSERT INTO `opcion_grupo` VALUES (1, 302, 1);
INSERT INTO `opcion_grupo` VALUES (1, 303, 1);
INSERT INTO `opcion_grupo` VALUES (1, 304, 1);
INSERT INTO `opcion_grupo` VALUES (1, 305, 1);
INSERT INTO `opcion_grupo` VALUES (1, 306, 1);
INSERT INTO `opcion_grupo` VALUES (1, 307, 1);
INSERT INTO `opcion_grupo` VALUES (1, 308, 1);
INSERT INTO `opcion_grupo` VALUES (1, 309, 1);
INSERT INTO `opcion_grupo` VALUES (1, 310, 1);
INSERT INTO `opcion_grupo` VALUES (1, 311, 1);
INSERT INTO `opcion_grupo` VALUES (1, 401, 1);
INSERT INTO `opcion_grupo` VALUES (1, 402, 1);
INSERT INTO `opcion_grupo` VALUES (1, 403, 1);
INSERT INTO `opcion_grupo` VALUES (1, 404, 1);
INSERT INTO `opcion_grupo` VALUES (1, 405, 1);
INSERT INTO `opcion_grupo` VALUES (1, 406, 1);
INSERT INTO `opcion_grupo` VALUES (1, 501, 1);
INSERT INTO `opcion_grupo` VALUES (1, 502, 1);
INSERT INTO `opcion_grupo` VALUES (1, 503, 1);
INSERT INTO `opcion_grupo` VALUES (1, 601, 1);
INSERT INTO `opcion_grupo` VALUES (1, 602, 1);
INSERT INTO `opcion_grupo` VALUES (1, 603, 1);
INSERT INTO `opcion_grupo` VALUES (1, 604, 1);
INSERT INTO `opcion_grupo` VALUES (1, 605, 1);
INSERT INTO `opcion_grupo` VALUES (1, 701, 1);
INSERT INTO `opcion_grupo` VALUES (1, 702, 1);
INSERT INTO `opcion_grupo` VALUES (1, 703, 1);
INSERT INTO `opcion_grupo` VALUES (1, 704, 1);
INSERT INTO `opcion_grupo` VALUES (1, 705, 1);
INSERT INTO `opcion_grupo` VALUES (1, 706, 1);
INSERT INTO `opcion_grupo` VALUES (1, 707, 1);
INSERT INTO `opcion_grupo` VALUES (1, 708, 1);
INSERT INTO `opcion_grupo` VALUES (1, 709, 1);
INSERT INTO `opcion_grupo` VALUES (1, 710, 1);
INSERT INTO `opcion_grupo` VALUES (1, 711, 1);
INSERT INTO `opcion_grupo` VALUES (1, 712, 1);
INSERT INTO `opcion_grupo` VALUES (1, 713, 1);
INSERT INTO `opcion_grupo` VALUES (1, 714, 1);
INSERT INTO `opcion_grupo` VALUES (1, 715, 1);
INSERT INTO `opcion_grupo` VALUES (1, 716, 1);
INSERT INTO `opcion_grupo` VALUES (1, 717, 1);
INSERT INTO `opcion_grupo` VALUES (1, 718, 1);
INSERT INTO `opcion_grupo` VALUES (1, 719, 1);
INSERT INTO `opcion_grupo` VALUES (1, 720, 1);
INSERT INTO `opcion_grupo` VALUES (1, 721, 1);
INSERT INTO `opcion_grupo` VALUES (1, 722, 1);
INSERT INTO `opcion_grupo` VALUES (1, 723, 1);
INSERT INTO `opcion_grupo` VALUES (1, 724, 1);
INSERT INTO `opcion_grupo` VALUES (1, 725, 1);
INSERT INTO `opcion_grupo` VALUES (1, 726, 1);
INSERT INTO `opcion_grupo` VALUES (1, 727, 1);
INSERT INTO `opcion_grupo` VALUES (1, 801, 1);
INSERT INTO `opcion_grupo` VALUES (1, 802, 1);
INSERT INTO `opcion_grupo` VALUES (1, 803, 1);
INSERT INTO `opcion_grupo` VALUES (1, 804, 1);
INSERT INTO `opcion_grupo` VALUES (1, 805, 1);
INSERT INTO `opcion_grupo` VALUES (1, 806, 1);
INSERT INTO `opcion_grupo` VALUES (1, 807, 1);
INSERT INTO `opcion_grupo` VALUES (1, 808, 1);
INSERT INTO `opcion_grupo` VALUES (1, 809, 1);
INSERT INTO `opcion_grupo` VALUES (1, 810, 1);
INSERT INTO `opcion_grupo` VALUES (1, 811, 1);
INSERT INTO `opcion_grupo` VALUES (1, 812, 1);
INSERT INTO `opcion_grupo` VALUES (1, 813, 1);
INSERT INTO `opcion_grupo` VALUES (1, 901, 1);
INSERT INTO `opcion_grupo` VALUES (1, 902, 1);
INSERT INTO `opcion_grupo` VALUES (1, 903, 1);
INSERT INTO `opcion_grupo` VALUES (1, 1001, 1);
INSERT INTO `opcion_grupo` VALUES (1, 1002, 1);
INSERT INTO `opcion_grupo` VALUES (1, 1003, 1);
INSERT INTO `opcion_grupo` VALUES (1, 1004, 1);
INSERT INTO `opcion_grupo` VALUES (1, 1005, 1);
INSERT INTO `opcion_grupo` VALUES (1, 1006, 1);
INSERT INTO `opcion_grupo` VALUES (1, 1007, 1);
INSERT INTO `opcion_grupo` VALUES (1, 1008, 1);
INSERT INTO `opcion_grupo` VALUES (1, 1101, 1);
INSERT INTO `opcion_grupo` VALUES (1, 1102, 1);
INSERT INTO `opcion_grupo` VALUES (1, 1103, 1);
INSERT INTO `opcion_grupo` VALUES (1, 1104, 1);
INSERT INTO `opcion_grupo` VALUES (1, 1105, 1);
INSERT INTO `opcion_grupo` VALUES (1, 1106, 1);
INSERT INTO `opcion_grupo` VALUES (1, 1107, 1);
INSERT INTO `opcion_grupo` VALUES (1, 1108, 1);
INSERT INTO `opcion_grupo` VALUES (1, 1301, 1);
INSERT INTO `opcion_grupo` VALUES (1, 1302, 1);
INSERT INTO `opcion_grupo` VALUES (1, 1303, 1);
INSERT INTO `opcion_grupo` VALUES (1, 1304, 1);
INSERT INTO `opcion_grupo` VALUES (2, 1, 1);
INSERT INTO `opcion_grupo` VALUES (2, 2, 1);
INSERT INTO `opcion_grupo` VALUES (2, 3, 1);
INSERT INTO `opcion_grupo` VALUES (2, 4, 1);
INSERT INTO `opcion_grupo` VALUES (2, 5, 1);
INSERT INTO `opcion_grupo` VALUES (2, 6, 1);
INSERT INTO `opcion_grupo` VALUES (2, 7, 1);
INSERT INTO `opcion_grupo` VALUES (2, 8, 1);
INSERT INTO `opcion_grupo` VALUES (2, 9, 1);
INSERT INTO `opcion_grupo` VALUES (2, 10, 1);
INSERT INTO `opcion_grupo` VALUES (2, 11, 1);
INSERT INTO `opcion_grupo` VALUES (2, 14, 1);
INSERT INTO `opcion_grupo` VALUES (2, 101, 1);
INSERT INTO `opcion_grupo` VALUES (2, 102, 1);
INSERT INTO `opcion_grupo` VALUES (2, 103, 1);
INSERT INTO `opcion_grupo` VALUES (2, 104, 1);
INSERT INTO `opcion_grupo` VALUES (2, 106, 1);
INSERT INTO `opcion_grupo` VALUES (2, 201, 1);
INSERT INTO `opcion_grupo` VALUES (2, 203, 1);
INSERT INTO `opcion_grupo` VALUES (2, 204, 1);
INSERT INTO `opcion_grupo` VALUES (2, 301, 1);
INSERT INTO `opcion_grupo` VALUES (2, 303, 1);
INSERT INTO `opcion_grupo` VALUES (2, 304, 1);
INSERT INTO `opcion_grupo` VALUES (2, 305, 1);
INSERT INTO `opcion_grupo` VALUES (2, 401, 1);
INSERT INTO `opcion_grupo` VALUES (2, 402, 1);
INSERT INTO `opcion_grupo` VALUES (2, 403, 1);
INSERT INTO `opcion_grupo` VALUES (2, 404, 1);
INSERT INTO `opcion_grupo` VALUES (2, 405, 1);
INSERT INTO `opcion_grupo` VALUES (2, 501, 1);
INSERT INTO `opcion_grupo` VALUES (2, 502, 1);
INSERT INTO `opcion_grupo` VALUES (2, 503, 1);
INSERT INTO `opcion_grupo` VALUES (2, 601, 1);
INSERT INTO `opcion_grupo` VALUES (2, 602, 1);
INSERT INTO `opcion_grupo` VALUES (2, 603, 1);
INSERT INTO `opcion_grupo` VALUES (2, 604, 1);
INSERT INTO `opcion_grupo` VALUES (2, 605, 1);
INSERT INTO `opcion_grupo` VALUES (2, 701, 1);
INSERT INTO `opcion_grupo` VALUES (2, 702, 1);
INSERT INTO `opcion_grupo` VALUES (2, 703, 1);
INSERT INTO `opcion_grupo` VALUES (2, 704, 1);
INSERT INTO `opcion_grupo` VALUES (2, 705, 1);
INSERT INTO `opcion_grupo` VALUES (2, 706, 1);
INSERT INTO `opcion_grupo` VALUES (2, 707, 1);
INSERT INTO `opcion_grupo` VALUES (2, 708, 1);
INSERT INTO `opcion_grupo` VALUES (2, 709, 1);
INSERT INTO `opcion_grupo` VALUES (2, 710, 1);
INSERT INTO `opcion_grupo` VALUES (2, 711, 1);
INSERT INTO `opcion_grupo` VALUES (2, 712, 1);
INSERT INTO `opcion_grupo` VALUES (2, 713, 1);
INSERT INTO `opcion_grupo` VALUES (2, 714, 1);
INSERT INTO `opcion_grupo` VALUES (2, 715, 1);
INSERT INTO `opcion_grupo` VALUES (2, 716, 1);
INSERT INTO `opcion_grupo` VALUES (2, 717, 1);
INSERT INTO `opcion_grupo` VALUES (2, 719, 1);
INSERT INTO `opcion_grupo` VALUES (2, 720, 1);
INSERT INTO `opcion_grupo` VALUES (2, 721, 1);
INSERT INTO `opcion_grupo` VALUES (2, 803, 1);
INSERT INTO `opcion_grupo` VALUES (2, 804, 1);
INSERT INTO `opcion_grupo` VALUES (2, 811, 1);
INSERT INTO `opcion_grupo` VALUES (2, 812, 1);
INSERT INTO `opcion_grupo` VALUES (2, 901, 1);
INSERT INTO `opcion_grupo` VALUES (2, 902, 1);
INSERT INTO `opcion_grupo` VALUES (2, 903, 1);
INSERT INTO `opcion_grupo` VALUES (2, 1001, 1);
INSERT INTO `opcion_grupo` VALUES (2, 1002, 1);
INSERT INTO `opcion_grupo` VALUES (2, 1003, 1);
INSERT INTO `opcion_grupo` VALUES (2, 1005, 1);
INSERT INTO `opcion_grupo` VALUES (2, 1006, 1);
INSERT INTO `opcion_grupo` VALUES (2, 1007, 1);
INSERT INTO `opcion_grupo` VALUES (2, 1101, 1);
INSERT INTO `opcion_grupo` VALUES (2, 1102, 1);
INSERT INTO `opcion_grupo` VALUES (2, 1103, 1);
INSERT INTO `opcion_grupo` VALUES (2, 1104, 1);
INSERT INTO `opcion_grupo` VALUES (2, 1105, 1);
INSERT INTO `opcion_grupo` VALUES (2, 1106, 1);
INSERT INTO `opcion_grupo` VALUES (2, 1107, 1);
INSERT INTO `opcion_grupo` VALUES (2, 1108, 1);
INSERT INTO `opcion_grupo` VALUES (2, 1303, 1);
INSERT INTO `opcion_grupo` VALUES (2, 1401, 1);
INSERT INTO `opcion_grupo` VALUES (3, 1, 1);
INSERT INTO `opcion_grupo` VALUES (3, 3, 1);
INSERT INTO `opcion_grupo` VALUES (3, 4, 1);
INSERT INTO `opcion_grupo` VALUES (3, 6, 1);
INSERT INTO `opcion_grupo` VALUES (3, 11, 1);
INSERT INTO `opcion_grupo` VALUES (3, 102, 1);
INSERT INTO `opcion_grupo` VALUES (3, 105, 1);
INSERT INTO `opcion_grupo` VALUES (3, 301, 1);
INSERT INTO `opcion_grupo` VALUES (3, 302, 1);
INSERT INTO `opcion_grupo` VALUES (3, 303, 1);
INSERT INTO `opcion_grupo` VALUES (3, 304, 1);
INSERT INTO `opcion_grupo` VALUES (3, 307, 1);
INSERT INTO `opcion_grupo` VALUES (3, 401, 1);
INSERT INTO `opcion_grupo` VALUES (3, 403, 1);
INSERT INTO `opcion_grupo` VALUES (3, 404, 1);
INSERT INTO `opcion_grupo` VALUES (3, 405, 1);
INSERT INTO `opcion_grupo` VALUES (3, 607, 1);
INSERT INTO `opcion_grupo` VALUES (3, 1101, 1);
INSERT INTO `opcion_grupo` VALUES (3, 1102, 1);
INSERT INTO `opcion_grupo` VALUES (3, 1103, 1);
INSERT INTO `opcion_grupo` VALUES (3, 1114, 1);
INSERT INTO `opcion_grupo` VALUES (4, 1, 1);
INSERT INTO `opcion_grupo` VALUES (4, 2, 1);
INSERT INTO `opcion_grupo` VALUES (4, 3, 1);
INSERT INTO `opcion_grupo` VALUES (4, 4, 1);
INSERT INTO `opcion_grupo` VALUES (4, 5, 1);
INSERT INTO `opcion_grupo` VALUES (4, 6, 1);
INSERT INTO `opcion_grupo` VALUES (4, 8, 1);
INSERT INTO `opcion_grupo` VALUES (4, 9, 1);
INSERT INTO `opcion_grupo` VALUES (4, 101, 1);
INSERT INTO `opcion_grupo` VALUES (4, 102, 1);
INSERT INTO `opcion_grupo` VALUES (4, 103, 1);
INSERT INTO `opcion_grupo` VALUES (4, 104, 1);
INSERT INTO `opcion_grupo` VALUES (4, 105, 1);
INSERT INTO `opcion_grupo` VALUES (4, 106, 1);
INSERT INTO `opcion_grupo` VALUES (4, 107, 1);
INSERT INTO `opcion_grupo` VALUES (4, 108, 1);
INSERT INTO `opcion_grupo` VALUES (4, 109, 1);
INSERT INTO `opcion_grupo` VALUES (4, 110, 1);
INSERT INTO `opcion_grupo` VALUES (4, 111, 1);
INSERT INTO `opcion_grupo` VALUES (4, 201, 1);
INSERT INTO `opcion_grupo` VALUES (4, 203, 1);
INSERT INTO `opcion_grupo` VALUES (4, 204, 1);
INSERT INTO `opcion_grupo` VALUES (4, 301, 1);
INSERT INTO `opcion_grupo` VALUES (4, 302, 1);
INSERT INTO `opcion_grupo` VALUES (4, 303, 1);
INSERT INTO `opcion_grupo` VALUES (4, 304, 1);
INSERT INTO `opcion_grupo` VALUES (4, 401, 1);
INSERT INTO `opcion_grupo` VALUES (4, 402, 1);
INSERT INTO `opcion_grupo` VALUES (4, 403, 1);
INSERT INTO `opcion_grupo` VALUES (4, 404, 1);
INSERT INTO `opcion_grupo` VALUES (4, 405, 1);
INSERT INTO `opcion_grupo` VALUES (4, 501, 1);
INSERT INTO `opcion_grupo` VALUES (4, 502, 1);
INSERT INTO `opcion_grupo` VALUES (4, 503, 1);
INSERT INTO `opcion_grupo` VALUES (4, 601, 1);
INSERT INTO `opcion_grupo` VALUES (4, 602, 1);
INSERT INTO `opcion_grupo` VALUES (4, 604, 1);
INSERT INTO `opcion_grupo` VALUES (4, 605, 1);
INSERT INTO `opcion_grupo` VALUES (4, 606, 1);
INSERT INTO `opcion_grupo` VALUES (4, 801, 1);
INSERT INTO `opcion_grupo` VALUES (4, 803, 1);
INSERT INTO `opcion_grupo` VALUES (4, 804, 1);
INSERT INTO `opcion_grupo` VALUES (4, 805, 1);
INSERT INTO `opcion_grupo` VALUES (4, 812, 1);
INSERT INTO `opcion_grupo` VALUES (4, 901, 1);
INSERT INTO `opcion_grupo` VALUES (4, 902, 1);
INSERT INTO `opcion_grupo` VALUES (4, 1114, 1);
INSERT INTO `opcion_grupo` VALUES (8, 3, 1);
INSERT INTO `opcion_grupo` VALUES (8, 10, 1);
INSERT INTO `opcion_grupo` VALUES (8, 11, 1);
INSERT INTO `opcion_grupo` VALUES (8, 301, 1);
INSERT INTO `opcion_grupo` VALUES (8, 303, 1);
INSERT INTO `opcion_grupo` VALUES (8, 304, 1);
INSERT INTO `opcion_grupo` VALUES (8, 305, 1);
INSERT INTO `opcion_grupo` VALUES (8, 1001, 1);
INSERT INTO `opcion_grupo` VALUES (8, 1002, 1);
INSERT INTO `opcion_grupo` VALUES (8, 1003, 1);
INSERT INTO `opcion_grupo` VALUES (8, 1101, 1);
INSERT INTO `opcion_grupo` VALUES (8, 1103, 1);
INSERT INTO `opcion_grupo` VALUES (8, 1104, 1);
INSERT INTO `opcion_grupo` VALUES (8, 1105, 1);
INSERT INTO `opcion_grupo` VALUES (8, 1303, 1);
INSERT INTO `opcion_grupo` VALUES (11, 10, 1);
INSERT INTO `opcion_grupo` VALUES (11, 1005, 1);
INSERT INTO `opcion_grupo` VALUES (11, 1006, 1);
INSERT INTO `opcion_grupo` VALUES (11, 1007, 1);
INSERT INTO `opcion_grupo` VALUES (11, 1302, 1);

-- ----------------------------
-- Table structure for pagos_ingreso
-- ----------------------------
DROP TABLE IF EXISTS `pagos_ingreso`;
CREATE TABLE `pagos_ingreso`  (
  `pagoingreso_id` bigint NOT NULL AUTO_INCREMENT,
  `pagoingreso_ingreso_id` bigint NULL DEFAULT NULL,
  `pagoingreso_fecha` datetime NULL DEFAULT NULL,
  `pagoingreso_monto` float(22, 2) NULL DEFAULT NULL,
  `pagoingreso_restante` float(22, 2) NULL DEFAULT NULL,
  `pagoingreso_usuario` bigint NULL DEFAULT NULL,
  `medio_pago_id` bigint NULL DEFAULT NULL,
  `banco_id` bigint NULL DEFAULT NULL,
  `operacion` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `estado` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pagoingreso_id`) USING BTREE,
  INDEX `pagoingreso_ingreso_id`(`pagoingreso_ingreso_id` ASC) USING BTREE,
  INDEX `pagoingreso_usuario`(`pagoingreso_usuario` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pagos_ingreso
-- ----------------------------

-- ----------------------------
-- Table structure for pais
-- ----------------------------
DROP TABLE IF EXISTS `pais`;
CREATE TABLE `pais`  (
  `id_pais` bigint NOT NULL AUTO_INCREMENT,
  `nombre_pais` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_pais`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pais
-- ----------------------------
INSERT INTO `pais` VALUES (1, 'Peru');

-- ----------------------------
-- Table structure for precios
-- ----------------------------
DROP TABLE IF EXISTS `precios`;
CREATE TABLE `precios`  (
  `id_precio` bigint NOT NULL AUTO_INCREMENT,
  `nombre_precio` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `descuento_precio` double NULL DEFAULT NULL,
  `mostrar_precio` tinyint(1) NULL DEFAULT 0,
  `estatus_precio` tinyint(1) NULL DEFAULT 1,
  `orden` int NULL DEFAULT 0,
  PRIMARY KEY (`id_precio`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of precios
-- ----------------------------
INSERT INTO `precios` VALUES (1, 'Precio de venta', 0, 1, 1, 11);
INSERT INTO `precios` VALUES (2, 'Precio descuento', 0, NULL, 1, 111);
INSERT INTO `precios` VALUES (3, 'Precio unitario', 0, 1, 1, 1);

-- ----------------------------
-- Table structure for producto
-- ----------------------------
DROP TABLE IF EXISTS `producto`;
CREATE TABLE `producto`  (
  `producto_id` bigint NOT NULL AUTO_INCREMENT,
  `producto_codigo_interno` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `producto_codigo_barra` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `proveedor_codigo` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `producto_nombre` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `producto_descripcion` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `producto_vencimiento` datetime NULL DEFAULT NULL,
  `producto_marca` bigint NULL DEFAULT NULL,
  `producto_linea` bigint NULL DEFAULT NULL,
  `producto_familia` bigint NULL DEFAULT NULL,
  `produto_grupo` bigint NULL DEFAULT NULL,
  `producto_proveedor` bigint NULL DEFAULT NULL,
  `producto_stockminimo` decimal(18, 2) NULL DEFAULT NULL,
  `producto_afectacion_impuesto` varchar(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `producto_impuesto` bigint NULL DEFAULT NULL,
  `producto_estatus` tinyint(1) NULL DEFAULT 1,
  `producto_largo` float NULL DEFAULT NULL,
  `producto_ancho` float NULL DEFAULT NULL,
  `producto_alto` float NULL DEFAULT NULL,
  `producto_peso` float NULL DEFAULT NULL,
  `producto_nota` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `producto_cualidad` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `producto_estado` tinyint(1) NULL DEFAULT 1,
  `producto_costo_unitario` float(20, 8) NULL DEFAULT NULL,
  `producto_modelo` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `producto_titulo_imagen` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `producto_descripcion_img` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `producto_nombre_original` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT 'NOMBRE ORIGINAL DE NOMBRE DE PRODUCTO',
  `stock` tinyint(1) NOT NULL DEFAULT 1,
  `is_bolsa` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`producto_id`) USING BTREE,
  UNIQUE INDEX `producto_fx_7_idx`(`producto_modelo` ASC, `producto_nombre` ASC) USING BTREE,
  INDEX `R_19`(`producto_linea` ASC) USING BTREE,
  INDEX `producto_fk_1_idx`(`producto_marca` ASC) USING BTREE,
  INDEX `producto_fk_3_idx`(`producto_familia` ASC) USING BTREE,
  INDEX `producto_fk_4_idx`(`produto_grupo` ASC) USING BTREE,
  INDEX `producto_fk_5_idx`(`producto_proveedor` ASC) USING BTREE,
  INDEX `producto_fk_6_idx`(`producto_impuesto` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of producto
-- ----------------------------
INSERT INTO `producto` VALUES (1, '1', NULL, NULL, 'galleta oreo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.00, '1', 1, 1, NULL, NULL, NULL, NULL, NULL, 'MEDIBLE', 1, 0.60000002, NULL, NULL, NULL, 'galleta oreo', 1, 0);
INSERT INTO `producto` VALUES (2, '4455', NULL, '1', 'foco led', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.00, '1', 1, 1, NULL, NULL, NULL, NULL, NULL, 'MEDIBLE', 1, 1.00000000, NULL, NULL, NULL, 'foco led', 0, 0);
INSERT INTO `producto` VALUES (3, '12234434', NULL, NULL, 'producto de ejemplo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.00, '1', 1, 1, NULL, NULL, NULL, NULL, NULL, 'MEDIBLE', 1, 0.50000000, NULL, NULL, NULL, 'producto de ejemplo', 1, 0);

-- ----------------------------
-- Table structure for producto_almacen
-- ----------------------------
DROP TABLE IF EXISTS `producto_almacen`;
CREATE TABLE `producto_almacen`  (
  `id_local` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` float(22, 3) NOT NULL,
  `fraccion` float(22, 3) NOT NULL,
  PRIMARY KEY (`id_local`, `id_producto`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of producto_almacen
-- ----------------------------
INSERT INTO `producto_almacen` VALUES (1, 1, 81.000, 0.000);
INSERT INTO `producto_almacen` VALUES (1, 2, -9.000, 0.000);
INSERT INTO `producto_almacen` VALUES (1, 3, 91.000, 0.000);

-- ----------------------------
-- Table structure for producto_costo_unitario
-- ----------------------------
DROP TABLE IF EXISTS `producto_costo_unitario`;
CREATE TABLE `producto_costo_unitario`  (
  `producto_id` bigint NOT NULL,
  `moneda_id` int NOT NULL,
  `costo` decimal(18, 2) NOT NULL,
  `activo` varchar(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `contable_costo` decimal(18, 2) NULL DEFAULT 0.00,
  `contable_activo` varchar(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '0',
  `tipo_impuesto_compra` tinyint NULL DEFAULT NULL COMMENT 'tipo de impuesto de la compra: 1=Incluye impuesto, 2=Agregar impuesto, 3=No considerar impuesto',
  `porcentaje_utilidad` decimal(18, 2) NULL DEFAULT 0.00 COMMENT 'porcentaje de utilidad',
  `tipo_cambio` decimal(18, 2) NULL DEFAULT 0.00 COMMENT 'tipo de cambio'
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of producto_costo_unitario
-- ----------------------------
INSERT INTO `producto_costo_unitario` VALUES (2, 1029, 1.00, '1', 0.00, '1', 1, 0.00, 0.00);
INSERT INTO `producto_costo_unitario` VALUES (1, 1029, 0.60, '1', 0.00, '1', 1, 0.00, 0.00);
INSERT INTO `producto_costo_unitario` VALUES (3, 1029, 0.50, '1', 0.00, '1', 1, 0.00, 0.00);

-- ----------------------------
-- Table structure for producto_transito
-- ----------------------------
DROP TABLE IF EXISTS `producto_transito`;
CREATE TABLE `producto_transito`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_traspaso` int NOT NULL,
  `id_origen` int NOT NULL,
  `id_destino` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad_origen` float(22, 3) NOT NULL,
  `cantidad_destino` float(22, 3) NOT NULL,
  `cantidad_transito` float(22, 3) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of producto_transito
-- ----------------------------

-- ----------------------------
-- Table structure for productos_guia_remision
-- ----------------------------
DROP TABLE IF EXISTS `productos_guia_remision`;
CREATE TABLE `productos_guia_remision`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `guia_remision_id` int NOT NULL,
  `codigo_producto_interno` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `descripcion` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_unidad` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio` double NOT NULL,
  `subtotal` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of productos_guia_remision
-- ----------------------------

-- ----------------------------
-- Table structure for proforma
-- ----------------------------
DROP TABLE IF EXISTS `proforma`;
CREATE TABLE `proforma`  (
  `nProfCOdigo` bigint NOT NULL AUTO_INCREMENT,
  `nProvCodigo` bigint NOT NULL,
  `nProCodigo` bigint NOT NULL,
  `cProfSerie` char(6) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nCantidad` int NOT NULL,
  PRIMARY KEY (`nProfCOdigo`) USING BTREE,
  INDEX `ProveedorFKProforma_idx`(`nProvCodigo` ASC) USING BTREE,
  INDEX `ProductoFKProforma_idx`(`nProCodigo` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of proforma
-- ----------------------------

-- ----------------------------
-- Table structure for proveedor
-- ----------------------------
DROP TABLE IF EXISTS `proveedor`;
CREATE TABLE `proveedor`  (
  `id_proveedor` bigint NOT NULL AUTO_INCREMENT,
  `proveedor_ruc` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `proveedor_nombre` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `proveedor_direccion1` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `proveedor_paginaweb` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `proveedor_email` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `proveedor_telefono1` varchar(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `proveedor_contacto` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `proveedor_telefono2` varchar(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `proveedor_status` tinyint(1) NOT NULL DEFAULT 1,
  `proveedor_observacion` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  PRIMARY KEY (`id_proveedor`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of proveedor
-- ----------------------------
INSERT INTO `proveedor` VALUES (1, '20535625078', 'NANOTECH SOLUTIONS SAC', 'JR. LAS GARDENIAS NRO. 202 URB. REPARTICIÓN - LIMA LIMA COMAS', '', '', '', '', '', 1, '');
INSERT INTO `proveedor` VALUES (2, '20603943059', 'CORPORACION SIGA SAC', 'JR PEDRO RUIZ GALLO NRO 944 URB BATIEVSKY OVALO PEDRO RUIZ GALLO LIMA  LIMA  BRENA', '', '', '', NULL, '', 1, '');

-- ----------------------------
-- Table structure for recarga
-- ----------------------------
DROP TABLE IF EXISTS `recarga`;
CREATE TABLE `recarga`  (
  `rec_cod` int NOT NULL AUTO_INCREMENT,
  `id_venta` int NULL DEFAULT NULL,
  `rec_trans` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rec_nro` varchar(9) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rec_ope` int NULL DEFAULT NULL COMMENT 'Se enlaza con tabla diccionario_termino en el grupo 3',
  `rec_pob` int NULL DEFAULT NULL COMMENT 'Codigo de centro de poblado',
  PRIMARY KEY (`rec_cod`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recarga
-- ----------------------------

-- ----------------------------
-- Table structure for shadow_stock
-- ----------------------------
DROP TABLE IF EXISTS `shadow_stock`;
CREATE TABLE `shadow_stock`  (
  `producto_id` bigint NOT NULL,
  `stock` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`producto_id`) USING BTREE,
  UNIQUE INDEX `producto_id_UNIQUE`(`producto_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shadow_stock
-- ----------------------------

-- ----------------------------
-- Table structure for status
-- ----------------------------
DROP TABLE IF EXISTS `status`;
CREATE TABLE `status`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of status
-- ----------------------------
INSERT INTO `status` VALUES (1, 'process', 'PROCESO', '2019-02-13 17:30:22', '2019-02-20 13:52:12');
INSERT INTO `status` VALUES (2, 'transit', 'TRANSITO', '2019-02-13 17:30:22', '2019-02-20 13:52:18');
INSERT INTO `status` VALUES (3, 'received', 'RECIBIDO', '2019-02-13 17:30:55', '2019-02-20 13:52:23');
INSERT INTO `status` VALUES (4, 'dismissed', 'RECHAZADO', '2019-02-13 17:30:55', '2019-02-22 18:25:38');

-- ----------------------------
-- Table structure for tarjeta_pago
-- ----------------------------
DROP TABLE IF EXISTS `tarjeta_pago`;
CREATE TABLE `tarjeta_pago`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tarjeta_pago
-- ----------------------------
INSERT INTO `tarjeta_pago` VALUES (1, 'Visa');
INSERT INTO `tarjeta_pago` VALUES (2, 'Mastercard');

-- ----------------------------
-- Table structure for tipo_cambios
-- ----------------------------
DROP TABLE IF EXISTS `tipo_cambios`;
CREATE TABLE `tipo_cambios`  (
  `fecha` date NOT NULL,
  `venta` decimal(18, 3) NOT NULL DEFAULT 0.000,
  `compra` decimal(18, 3) NOT NULL DEFAULT 0.000,
  PRIMARY KEY (`fecha`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of tipo_cambios
-- ----------------------------
INSERT INTO `tipo_cambios` VALUES ('2023-02-24', 3.805, 3.800);

-- ----------------------------
-- Table structure for tipo_documento_persona
-- ----------------------------
DROP TABLE IF EXISTS `tipo_documento_persona`;
CREATE TABLE `tipo_documento_persona`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigotipo` int NULL DEFAULT NULL COMMENT 'Codigo interno generado por sunat',
  `descripcionlarga` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `descripcioncorta` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `longitud` bigint NULL DEFAULT NULL COMMENT 'tamaño maximo del valor a guardar',
  `buquedaapi` bigint NULL DEFAULT 0 COMMENT '0=NO; 1=SI; Existen valores que pueden ser recuperados desde paginas externas',
  `estado` bigint NULL DEFAULT NULL COMMENT '1 = activo; 0 = inactivo',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tipo_documento_persona
-- ----------------------------
INSERT INTO `tipo_documento_persona` VALUES (1, 1, 'LIBRETA ELECTORAL O DNI', 'DNI', 8, 1, 1);
INSERT INTO `tipo_documento_persona` VALUES (2, 4, 'CARNET DE EXTRANJERIA', 'CARNET EXT.', 12, 0, 1);
INSERT INTO `tipo_documento_persona` VALUES (3, 6, 'REG. UNICO DE CONTRIBUYENTES', 'RUC', 11, 1, 1);
INSERT INTO `tipo_documento_persona` VALUES (4, 7, 'PASAPORTE', 'PASSAPORTE', 12, 0, 1);
INSERT INTO `tipo_documento_persona` VALUES (5, 11, 'PART. DE NACIMIENTO-IDENTIDAD', 'P. NAC.', 15, 0, 1);
INSERT INTO `tipo_documento_persona` VALUES (6, 0, 'OTROS', 'OTROS', 15, 0, 1);

-- ----------------------------
-- Table structure for tipo_operacion
-- ----------------------------
DROP TABLE IF EXISTS `tipo_operacion`;
CREATE TABLE `tipo_operacion`  (
  `id_tipo_operacion` int NOT NULL AUTO_INCREMENT,
  `nombre_operacion` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_tipo_operacion`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tipo_operacion
-- ----------------------------
INSERT INTO `tipo_operacion` VALUES (1, 'cotizacion');
INSERT INTO `tipo_operacion` VALUES (2, 'venta');
INSERT INTO `tipo_operacion` VALUES (3, 'guia_remision');
INSERT INTO `tipo_operacion` VALUES (4, 'traspaso');
INSERT INTO `tipo_operacion` VALUES (5, 'entradas_salidas');

-- ----------------------------
-- Table structure for tipos_gasto
-- ----------------------------
DROP TABLE IF EXISTS `tipos_gasto`;
CREATE TABLE `tipos_gasto`  (
  `id_tipos_gasto` bigint NOT NULL AUTO_INCREMENT,
  `nombre_tipos_gasto` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status_tipos_gasto` tinyint(1) NULL DEFAULT 1,
  `tipo_tipos_gasto` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT '0 = Variable, 1 = Fijo',
  `id_grupo_gastos` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_tipos_gasto`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tipos_gasto
-- ----------------------------
INSERT INTO `tipos_gasto` VALUES (1, 'GASTOS VARIOS', 1, NULL, 2);
INSERT INTO `tipos_gasto` VALUES (2, 'PAGO A PROVEDORES', 1, NULL, 1);
INSERT INTO `tipos_gasto` VALUES (3, 'REMUNERACION con DSCTOs', 1, '0', 2);
INSERT INTO `tipos_gasto` VALUES (4, 'AFP', 1, NULL, 2);
INSERT INTO `tipos_gasto` VALUES (5, 'GASTO DE VENTA', 1, NULL, 1);
INSERT INTO `tipos_gasto` VALUES (6, 'GASTO DE SERVICIOS', 1, NULL, 2);
INSERT INTO `tipos_gasto` VALUES (7, 'GASTO ADMINISTRATIVO', 1, '0', 2);
INSERT INTO `tipos_gasto` VALUES (8, 'CARGOS FINANCIEROS', 1, NULL, 3);
INSERT INTO `tipos_gasto` VALUES (9, 'GASTOS FINANCIEROS', 1, NULL, 3);
INSERT INTO `tipos_gasto` VALUES (10, 'GASTOS LOGISTICOS', 1, '0', 2);
INSERT INTO `tipos_gasto` VALUES (11, 'GASTOS DE MARKETING', 1, '0', 1);
INSERT INTO `tipos_gasto` VALUES (12, 'COMISIONES', 1, '0', 1);
INSERT INTO `tipos_gasto` VALUES (13, 'EsSALUD', 1, '0', 4);
INSERT INTO `tipos_gasto` VALUES (14, 'PRESTAMO BANCARIO', 1, '0', 3);
INSERT INTO `tipos_gasto` VALUES (15, 'LIQUIDACIONES ', 1, '0', 4);
INSERT INTO `tipos_gasto` VALUES (16, 'HORAS EXTRA', 1, '0', 4);
INSERT INTO `tipos_gasto` VALUES (18, 'ALQUILER', 1, '1', 6);
INSERT INTO `tipos_gasto` VALUES (19, 'INTERES', 1, '0', 3);
INSERT INTO `tipos_gasto` VALUES (20, 'COMISION', 1, '0', 3);

-- ----------------------------
-- Table structure for transportista
-- ----------------------------
DROP TABLE IF EXISTS `transportista`;
CREATE TABLE `transportista`  (
  `id_transportista` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tipo_transportista` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '0',
  `ruc` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `razon_social` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tipo_documento_persona_id` int NULL DEFAULT NULL,
  `identificacion_conductor` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `nombre_conductor` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `placa` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `certificado` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `estado` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id_transportista`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of transportista
-- ----------------------------
INSERT INTO `transportista` VALUES (1, 'CLIENTE TRASLADO', '02', '', '', 1, '1', '1', '1', '', 1);

-- ----------------------------
-- Table structure for traspaso
-- ----------------------------
DROP TABLE IF EXISTS `traspaso`;
CREATE TABLE `traspaso`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `ref_id` int NULL DEFAULT NULL,
  `usuario_id` int NULL DEFAULT NULL,
  `local_origen` int NULL DEFAULT NULL,
  `local_destino` int NULL DEFAULT NULL,
  `fecha` datetime NULL DEFAULT NULL,
  `motivo` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `documento` int NULL DEFAULT NULL,
  `serie` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '0',
  `correlativo` bigint NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of traspaso
-- ----------------------------
INSERT INTO `traspaso` VALUES (1, 0, 2, NULL, 2, '2019-03-12 12:38:58', 'PRUEBA DE TRASPASO AUTOMATICO', 4, '001', 1);
INSERT INTO `traspaso` VALUES (2, 3, 2, NULL, 1, '2019-03-12 12:44:55', 'VENTA AL CONTADO', NULL, '0', 0);

-- ----------------------------
-- Table structure for traspaso_detalle
-- ----------------------------
DROP TABLE IF EXISTS `traspaso_detalle`;
CREATE TABLE `traspaso_detalle`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `traspaso_id` int NULL DEFAULT NULL,
  `local_origen` int NULL DEFAULT NULL,
  `kardex_id` int NULL DEFAULT NULL,
  `cantidad_parcial` float(22, 3) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `traspaso_id`(`traspaso_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of traspaso_detalle
-- ----------------------------

-- ----------------------------
-- Table structure for traspaso_status
-- ----------------------------
DROP TABLE IF EXISTS `traspaso_status`;
CREATE TABLE `traspaso_status`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_traspaso` int NOT NULL,
  `id_status` int NOT NULL DEFAULT 1,
  `id_usuario` int NOT NULL,
  `comentario` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of traspaso_status
-- ----------------------------

-- ----------------------------
-- Table structure for ubigeo
-- ----------------------------
DROP TABLE IF EXISTS `ubigeo`;
CREATE TABLE `ubigeo`  (
  `ubigeo` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `distrito` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `provincia` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `departamento` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `latitud` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `longitud` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pais` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`ubigeo`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ubigeo
-- ----------------------------
INSERT INTO `ubigeo` VALUES ('010101', 'Chachapoyas', 'Chachapoyas', 'Amazonas', '-6.2294', '-77.8714', '51');
INSERT INTO `ubigeo` VALUES ('010102', 'Asuncion', 'Chachapoyas', 'Amazonas', '-6.0317', '-77.7122', '51');
INSERT INTO `ubigeo` VALUES ('010103', 'Balsas', 'Chachapoyas', 'Amazonas', '-6.8375', '-78.0214', '51');
INSERT INTO `ubigeo` VALUES ('010104', 'Cheto', 'Chachapoyas', 'Amazonas', '-6.2558', '-77.7003', '51');
INSERT INTO `ubigeo` VALUES ('010105', 'Chiliquin', 'Chachapoyas', 'Amazonas', '-6.0778', '-77.7392', '51');
INSERT INTO `ubigeo` VALUES ('010106', 'Chuquibamba', 'Chachapoyas', 'Amazonas', '-6.9333', '-77.8575', '51');
INSERT INTO `ubigeo` VALUES ('010107', 'Granada', 'Chachapoyas', 'Amazonas', '-6.0997', '-77.6344', '51');
INSERT INTO `ubigeo` VALUES ('010108', 'Huancas', 'Chachapoyas', 'Amazonas', '-6.1747', '-77.8686', '51');
INSERT INTO `ubigeo` VALUES ('010109', 'La Jalca', 'Chachapoyas', 'Amazonas', '-6.4825', '-77.8192', '51');
INSERT INTO `ubigeo` VALUES ('010110', 'Leimebamba', 'Chachapoyas', 'Amazonas', '-6.6636', '-77.8006', '51');
INSERT INTO `ubigeo` VALUES ('010111', 'Levanto', 'Chachapoyas', 'Amazonas', '-6.3086', '-77.8994', '51');
INSERT INTO `ubigeo` VALUES ('010112', 'Magdalena', 'Chachapoyas', 'Amazonas', '-6.3736', '-77.9017', '51');
INSERT INTO `ubigeo` VALUES ('010113', 'Mariscal Castilla', 'Chachapoyas', 'Amazonas', '-6.5939', '-77.8053', '51');
INSERT INTO `ubigeo` VALUES ('010114', 'Molinopampa', 'Chachapoyas', 'Amazonas', '-6.2056', '-77.6683', '51');
INSERT INTO `ubigeo` VALUES ('010115', 'Montevideo', 'Chachapoyas', 'Amazonas', '-6.6133', '-77.8025', '51');
INSERT INTO `ubigeo` VALUES ('010116', 'Olleros', 'Chachapoyas', 'Amazonas', '-6.0239', '-77.6761', '51');
INSERT INTO `ubigeo` VALUES ('010117', 'Quinjalca', 'Chachapoyas', 'Amazonas', '-6.085', '-77.66', '51');
INSERT INTO `ubigeo` VALUES ('010118', 'San Francisco de Daguas', 'Chachapoyas', 'Amazonas', '-6.2333', '-77.7392', '51');
INSERT INTO `ubigeo` VALUES ('010119', 'San Isidro de Maino', 'Chachapoyas', 'Amazonas', '-6.3533', '-77.8439', '51');
INSERT INTO `ubigeo` VALUES ('010120', 'Soloco', 'Chachapoyas', 'Amazonas', '-6.2619', '-77.7453', '51');
INSERT INTO `ubigeo` VALUES ('010121', 'Sonche', 'Chachapoyas', 'Amazonas', '-6.2183', '-77.7753', '51');
INSERT INTO `ubigeo` VALUES ('010201', 'Bagua', 'Bagua', 'Amazonas', '-5.6389', '-78.5319', '51');
INSERT INTO `ubigeo` VALUES ('010202', 'Aramango', 'Bagua', 'Amazonas', '-5.4156', '-78.4361', '51');
INSERT INTO `ubigeo` VALUES ('010203', 'Copallin', 'Bagua', 'Amazonas', '-5.6733', '-78.4228', '51');
INSERT INTO `ubigeo` VALUES ('010204', 'El Parco', 'Bagua', 'Amazonas', '-5.6247', '-78.4764', '51');
INSERT INTO `ubigeo` VALUES ('010205', 'Imaza', 'Bagua', 'Amazonas', '-5.16', '-78.2903', '51');
INSERT INTO `ubigeo` VALUES ('010206', 'La Peca', 'Bagua', 'Amazonas', '-5.6092', '-78.4344', '51');
INSERT INTO `ubigeo` VALUES ('010301', 'Jumbilla', 'Bongara', 'Amazonas', '-5.9006', '-77.7958', '51');
INSERT INTO `ubigeo` VALUES ('010302', 'Chisquilla', 'Bongara', 'Amazonas', '-5.9003', '-77.7839', '51');
INSERT INTO `ubigeo` VALUES ('010303', 'Churuja', 'Bongara', 'Amazonas', '-6.0192', '-77.9517', '51');
INSERT INTO `ubigeo` VALUES ('010304', 'Corosha', 'Bongara', 'Amazonas', '-5.8294', '-77.84', '51');
INSERT INTO `ubigeo` VALUES ('010305', 'Cuispes', 'Bongara', 'Amazonas', '-5.9236', '-77.9392', '51');
INSERT INTO `ubigeo` VALUES ('010306', 'Florida', 'Bongara', 'Amazonas', '-5.8336', '-77.9714', '51');
INSERT INTO `ubigeo` VALUES ('010307', 'Jazan', 'Bongara', 'Amazonas', '-5.9419', '-77.9806', '51');
INSERT INTO `ubigeo` VALUES ('010308', 'Recta', 'Bongara', 'Amazonas', '-5.9194', '-77.7861', '51');
INSERT INTO `ubigeo` VALUES ('010309', 'San Carlos', 'Bongara', 'Amazonas', '-5.9636', '-77.9447', '51');
INSERT INTO `ubigeo` VALUES ('010310', 'Shipasbamba', 'Bongara', 'Amazonas', '-5.8744', '-78.0692', '51');
INSERT INTO `ubigeo` VALUES ('010311', 'Valera', 'Bongara', 'Amazonas', '-6.0425', '-77.9139', '51');
INSERT INTO `ubigeo` VALUES ('010312', 'Yambrasbamba', 'Bongara', 'Amazonas', '-5.6908', '-77.9772', '51');
INSERT INTO `ubigeo` VALUES ('010401', 'Nieva', 'Condorcanqui', 'Amazonas', '-4.5947', '-77.8672', '51');
INSERT INTO `ubigeo` VALUES ('010402', 'El Cenepa', 'Condorcanqui', 'Amazonas', '-4.4503', '-78.1592', '51');
INSERT INTO `ubigeo` VALUES ('010403', 'Rio Santiago', 'Condorcanqui', 'Amazonas', '-4.0106', '-77.7658', '51');
INSERT INTO `ubigeo` VALUES ('010501', 'Lamud', 'Luya', 'Amazonas', '-6.1308', '-77.9503', '51');
INSERT INTO `ubigeo` VALUES ('010502', 'Camporredondo', 'Luya', 'Amazonas', '-6.2136', '-78.3186', '51');
INSERT INTO `ubigeo` VALUES ('010503', 'Cocabamba', 'Luya', 'Amazonas', '-6.6297', '-78.0303', '51');
INSERT INTO `ubigeo` VALUES ('010504', 'Colcamar', 'Luya', 'Amazonas', '-6.3175', '-78.0019', '51');
INSERT INTO `ubigeo` VALUES ('010505', 'Conila', 'Luya', 'Amazonas', '-6.1592', '-78.1419', '51');
INSERT INTO `ubigeo` VALUES ('010506', 'Inguilpata', 'Luya', 'Amazonas', '-6.2428', '-77.9561', '51');
INSERT INTO `ubigeo` VALUES ('010507', 'Longuita', 'Luya', 'Amazonas', '-6.4147', '-77.9681', '51');
INSERT INTO `ubigeo` VALUES ('010508', 'Lonya Chico', 'Luya', 'Amazonas', '-6.2328', '-77.9564', '51');
INSERT INTO `ubigeo` VALUES ('010509', 'Luya', 'Luya', 'Amazonas', '-6.165', '-77.9469', '51');
INSERT INTO `ubigeo` VALUES ('010510', 'Luya Viejo', 'Luya', 'Amazonas', '-6.1275', '-78.0847', '51');
INSERT INTO `ubigeo` VALUES ('010511', 'Maria', 'Luya', 'Amazonas', '-6.4517', '-77.9733', '51');
INSERT INTO `ubigeo` VALUES ('010512', 'Ocalli', 'Luya', 'Amazonas', '-6.2347', '-78.2667', '51');
INSERT INTO `ubigeo` VALUES ('010513', 'Ocumal', 'Luya', 'Amazonas', '-6.3061', '-78.2294', '51');
INSERT INTO `ubigeo` VALUES ('010514', 'Pisuquia', 'Luya', 'Amazonas', '-6.5114', '-78.0747', '51');
INSERT INTO `ubigeo` VALUES ('010515', 'Providencia', 'Luya', 'Amazonas', '-6.3108', '-78.2503', '51');
INSERT INTO `ubigeo` VALUES ('010516', 'San Cristobal', 'Luya', 'Amazonas', '-6.0997', '-77.9525', '51');
INSERT INTO `ubigeo` VALUES ('010517', 'San Francisco del Yeso', 'Luya', 'Amazonas', '-6.5861', '-77.8469', '51');
INSERT INTO `ubigeo` VALUES ('010518', 'San Jeronimo', 'Luya', 'Amazonas', '-6.0344', '-77.9669', '51');
INSERT INTO `ubigeo` VALUES ('010519', 'San Juan de Lopecancha', 'Luya', 'Amazonas', '-6.4572', '-77.8969', '51');
INSERT INTO `ubigeo` VALUES ('010520', 'Santa Catalina', 'Luya', 'Amazonas', '-6.1117', '-78.0633', '51');
INSERT INTO `ubigeo` VALUES ('010521', 'Santo Tomas', 'Luya', 'Amazonas', '-6.5617', '-77.8739', '51');
INSERT INTO `ubigeo` VALUES ('010522', 'Tingo', 'Luya', 'Amazonas', '-6.3761', '-77.9056', '51');
INSERT INTO `ubigeo` VALUES ('010523', 'Trita', 'Luya', 'Amazonas', '-6.1519', '-77.9806', '51');
INSERT INTO `ubigeo` VALUES ('010601', 'San Nicolas', 'Rodriguez de Mendoza', 'Amazonas', '-6.3956', '-77.4831', '51');
INSERT INTO `ubigeo` VALUES ('010602', 'Chirimoto', 'Rodriguez de Mendoza', 'Amazonas', '-6.5283', '-77.4869', '51');
INSERT INTO `ubigeo` VALUES ('010603', 'Cochamal', 'Rodriguez de Mendoza', 'Amazonas', '-6.3933', '-77.5889', '51');
INSERT INTO `ubigeo` VALUES ('010604', 'Huambo', 'Rodriguez de Mendoza', 'Amazonas', '-6.4275', '-77.5369', '51');
INSERT INTO `ubigeo` VALUES ('010605', 'Limabamba', 'Rodriguez de Mendoza', 'Amazonas', '-6.5025', '-77.5097', '51');
INSERT INTO `ubigeo` VALUES ('010606', 'Longar', 'Rodriguez de Mendoza', 'Amazonas', '-6.3853', '-77.5461', '51');
INSERT INTO `ubigeo` VALUES ('010607', 'Mariscal Benavides', 'Rodriguez de Mendoza', 'Amazonas', '-6.3697', '-77.5003', '51');
INSERT INTO `ubigeo` VALUES ('010608', 'Milpuc', 'Rodriguez de Mendoza', 'Amazonas', '-6.4983', '-77.4358', '51');
INSERT INTO `ubigeo` VALUES ('010609', 'Omia', 'Rodriguez de Mendoza', 'Amazonas', '-6.4686', '-77.3947', '51');
INSERT INTO `ubigeo` VALUES ('010610', 'Santa Rosa', 'Rodriguez de Mendoza', 'Amazonas', '-6.4542', '-77.4539', '51');
INSERT INTO `ubigeo` VALUES ('010611', 'Totora', 'Rodriguez de Mendoza', 'Amazonas', '-6.4914', '-77.4711', '51');
INSERT INTO `ubigeo` VALUES ('010612', 'Vista Alegre', 'Rodriguez de Mendoza', 'Amazonas', '-6.1514', '-77.3019', '51');
INSERT INTO `ubigeo` VALUES ('010701', 'Bagua Grande', 'Utcubamba', 'Amazonas', '-5.7558', '-78.4428', '51');
INSERT INTO `ubigeo` VALUES ('010702', 'Cajaruro', 'Utcubamba', 'Amazonas', '-5.7364', '-78.4267', '51');
INSERT INTO `ubigeo` VALUES ('010703', 'Cumba', 'Utcubamba', 'Amazonas', '-5.9317', '-78.6653', '51');
INSERT INTO `ubigeo` VALUES ('010704', 'El Milagro', 'Utcubamba', 'Amazonas', '-5.6367', '-78.5578', '51');
INSERT INTO `ubigeo` VALUES ('010705', 'Jamalca', 'Utcubamba', 'Amazonas', '-5.9158', '-78.2203', '51');
INSERT INTO `ubigeo` VALUES ('010706', 'Lonya Grande', 'Utcubamba', 'Amazonas', '-6.0956', '-78.4219', '51');
INSERT INTO `ubigeo` VALUES ('010707', 'Yamon', 'Utcubamba', 'Amazonas', '-6.0525', '-78.5322', '51');
INSERT INTO `ubigeo` VALUES ('020101', 'Huaraz', 'Huaraz', 'Ancash', '-9.5272', '-77.5333', '51');
INSERT INTO `ubigeo` VALUES ('020102', 'Cochabamba', 'Huaraz', 'Ancash', '-9.4939', '-77.8619', '51');
INSERT INTO `ubigeo` VALUES ('020103', 'Colcabamba', 'Huaraz', 'Ancash', '-9.5956', '-77.8108', '51');
INSERT INTO `ubigeo` VALUES ('020104', 'Huanchay', 'Huaraz', 'Ancash', '-9.7236', '-77.8197', '51');
INSERT INTO `ubigeo` VALUES ('020105', 'Independencia', 'Huaraz', 'Ancash', '-9.5189', '-77.5344', '51');
INSERT INTO `ubigeo` VALUES ('020106', 'Jangas', 'Huaraz', 'Ancash', '-9.4014', '-77.5767', '51');
INSERT INTO `ubigeo` VALUES ('020107', 'La Libertad', 'Huaraz', 'Ancash', '-9.6333', '-77.7442', '51');
INSERT INTO `ubigeo` VALUES ('020108', 'Olleros', 'Huaraz', 'Ancash', '-9.6664', '-77.4661', '51');
INSERT INTO `ubigeo` VALUES ('020109', 'Pampas', 'Huaraz', 'Ancash', '-9.6556', '-77.8272', '51');
INSERT INTO `ubigeo` VALUES ('020110', 'Pariacoto', 'Huaraz', 'Ancash', '-9.5622', '-77.8931', '51');
INSERT INTO `ubigeo` VALUES ('020111', 'Pira', 'Huaraz', 'Ancash', '-9.5814', '-77.7075', '51');
INSERT INTO `ubigeo` VALUES ('020112', 'Tarica', 'Huaraz', 'Ancash', '-9.3919', '-77.5769', '51');
INSERT INTO `ubigeo` VALUES ('020201', 'Aija', 'Aija', 'Ancash', '-9.7819', '-77.6114', '51');
INSERT INTO `ubigeo` VALUES ('020202', 'Coris', 'Aija', 'Ancash', '-9.8211', '-77.7225', '51');
INSERT INTO `ubigeo` VALUES ('020203', 'Huacllan', 'Aija', 'Ancash', '-9.7975', '-77.6747', '51');
INSERT INTO `ubigeo` VALUES ('020204', 'La Merced', 'Aija', 'Ancash', '-9.7361', '-77.6189', '51');
INSERT INTO `ubigeo` VALUES ('020205', 'Succha', 'Aija', 'Ancash', '-9.8242', '-77.6497', '51');
INSERT INTO `ubigeo` VALUES ('020301', 'Llamellin', 'Antonio Raymondi', 'Ancash', '-9.1006', '-77.0183', '51');
INSERT INTO `ubigeo` VALUES ('020302', 'Aczo', 'Antonio Raymondi', 'Ancash', '-9.1525', '-76.9903', '51');
INSERT INTO `ubigeo` VALUES ('020303', 'Chaccho', 'Antonio Raymondi', 'Ancash', '-9.0586', '-77.0594', '51');
INSERT INTO `ubigeo` VALUES ('020304', 'Chingas', 'Antonio Raymondi', 'Ancash', '-9.12', '-76.9947', '51');
INSERT INTO `ubigeo` VALUES ('020305', 'Mirgas', 'Antonio Raymondi', 'Ancash', '-9.0792', '-77.0933', '51');
INSERT INTO `ubigeo` VALUES ('020306', 'San Juan de Rontoy', 'Antonio Raymondi', 'Ancash', '-9.1803', '-77.0044', '51');
INSERT INTO `ubigeo` VALUES ('020401', 'Chacas', 'Asuncion', 'Ancash', '-9.1622', '-77.3694', '51');
INSERT INTO `ubigeo` VALUES ('020402', 'Acochaca', 'Asuncion', 'Ancash', '-9.1139', '-77.3697', '51');
INSERT INTO `ubigeo` VALUES ('020501', 'Chiquian', 'Bolognesi', 'Ancash', '-10.1517', '-77.1586', '51');
INSERT INTO `ubigeo` VALUES ('020502', 'Abelardo Pardo Lezameta', 'Bolognesi', 'Ancash', '-10.2992', '-77.1508', '51');
INSERT INTO `ubigeo` VALUES ('020503', 'Antonio Raymondi', 'Bolognesi', 'Ancash', '-10.1575', '-77.4703', '51');
INSERT INTO `ubigeo` VALUES ('020504', 'Aquia', 'Bolognesi', 'Ancash', '-10.0742', '-77.1464', '51');
INSERT INTO `ubigeo` VALUES ('020505', 'Cajacay', 'Bolognesi', 'Ancash', '-10.1564', '-77.4419', '51');
INSERT INTO `ubigeo` VALUES ('020506', 'Canis', 'Bolognesi', 'Ancash', '-10.3381', '-77.1711', '51');
INSERT INTO `ubigeo` VALUES ('020507', 'Colquioc', 'Bolognesi', 'Ancash', '-10.3117', '-77.6156', '51');
INSERT INTO `ubigeo` VALUES ('020508', 'Huallanca', 'Bolognesi', 'Ancash', '-9.8994', '-76.9444', '51');
INSERT INTO `ubigeo` VALUES ('020509', 'Huasta', 'Bolognesi', 'Ancash', '-10.1225', '-77.1458', '51');
INSERT INTO `ubigeo` VALUES ('020510', 'Huayllacayan', 'Bolognesi', 'Ancash', '-10.2436', '-77.4342', '51');
INSERT INTO `ubigeo` VALUES ('020511', 'La Primavera', 'Bolognesi', 'Ancash', '-10.3344', '-77.1253', '51');
INSERT INTO `ubigeo` VALUES ('020512', 'Mangas', 'Bolognesi', 'Ancash', '-10.3694', '-77.1039', '51');
INSERT INTO `ubigeo` VALUES ('020513', 'Pacllon', 'Bolognesi', 'Ancash', '-10.2333', '-77.0722', '51');
INSERT INTO `ubigeo` VALUES ('020514', 'San Miguel de Corpanqui', 'Bolognesi', 'Ancash', '-10.285', '-77.2', '51');
INSERT INTO `ubigeo` VALUES ('020515', 'Ticllos', 'Bolognesi', 'Ancash', '-10.2522', '-77.1911', '51');
INSERT INTO `ubigeo` VALUES ('020601', 'Carhuaz', 'Carhuaz', 'Ancash', '-9.2806', '-77.6469', '51');
INSERT INTO `ubigeo` VALUES ('020602', 'Acopampa', 'Carhuaz', 'Ancash', '-9.2942', '-77.6225', '51');
INSERT INTO `ubigeo` VALUES ('020603', 'Amashca', 'Carhuaz', 'Ancash', '-9.2392', '-77.6464', '51');
INSERT INTO `ubigeo` VALUES ('020604', 'Anta', 'Carhuaz', 'Ancash', '-9.3569', '-77.5978', '51');
INSERT INTO `ubigeo` VALUES ('020605', 'Ataquero', 'Carhuaz', 'Ancash', '-9.2625', '-77.6914', '51');
INSERT INTO `ubigeo` VALUES ('020606', 'Marcara', 'Carhuaz', 'Ancash', '-9.3211', '-77.6033', '51');
INSERT INTO `ubigeo` VALUES ('020607', 'Pariahuanca', 'Carhuaz', 'Ancash', '-9.3642', '-77.5828', '51');
INSERT INTO `ubigeo` VALUES ('020608', 'San Miguel de Aco', 'Carhuaz', 'Ancash', '-9.3678', '-77.5644', '51');
INSERT INTO `ubigeo` VALUES ('020609', 'Shilla', 'Carhuaz', 'Ancash', '-9.2306', '-77.6256', '51');
INSERT INTO `ubigeo` VALUES ('020610', 'Tinco', 'Carhuaz', 'Ancash', '-9.2711', '-77.6819', '51');
INSERT INTO `ubigeo` VALUES ('020611', 'Yungar', 'Carhuaz', 'Ancash', '-9.3778', '-77.5931', '51');
INSERT INTO `ubigeo` VALUES ('020701', 'San Luis', 'Carlos Fermin Fitzca', 'Ancash', '-9.0933', '-77.3331', '51');
INSERT INTO `ubigeo` VALUES ('020702', 'San Nicolas', 'Carlos Fermin Fitzca', 'Ancash', '-8.9767', '-77.1842', '51');
INSERT INTO `ubigeo` VALUES ('020703', 'Yauya', 'Carlos Fermin Fitzca', 'Ancash', '-8.9875', '-77.2894', '51');
INSERT INTO `ubigeo` VALUES ('020801', 'Casma', 'Casma', 'Ancash', '-9.475', '-78.3036', '51');
INSERT INTO `ubigeo` VALUES ('020802', 'Buena Vista Alta', 'Casma', 'Ancash', '-9.4289', '-78.2047', '51');
INSERT INTO `ubigeo` VALUES ('020803', 'Comandante Noel', 'Casma', 'Ancash', '-9.4622', '-78.3831', '51');
INSERT INTO `ubigeo` VALUES ('020804', 'Yautan', 'Casma', 'Ancash', '-9.5097', '-77.9956', '51');
INSERT INTO `ubigeo` VALUES ('020901', 'Corongo', 'Corongo', 'Ancash', '-8.5683', '-77.8967', '51');
INSERT INTO `ubigeo` VALUES ('020902', 'Aco', 'Corongo', 'Ancash', '-8.5228', '-77.8769', '51');
INSERT INTO `ubigeo` VALUES ('020903', 'Bambas', 'Corongo', 'Ancash', '-8.6022', '-77.9925', '51');
INSERT INTO `ubigeo` VALUES ('020904', 'Cusca', 'Corongo', 'Ancash', '-8.5106', '-77.8631', '51');
INSERT INTO `ubigeo` VALUES ('020905', 'La Pampa', 'Corongo', 'Ancash', '-8.6619', '-77.9011', '51');
INSERT INTO `ubigeo` VALUES ('020906', 'Yanac', 'Corongo', 'Ancash', '-8.6178', '-77.8636', '51');
INSERT INTO `ubigeo` VALUES ('020907', 'Yupan', 'Corongo', 'Ancash', '-8.615', '-77.9661', '51');
INSERT INTO `ubigeo` VALUES ('021001', 'Huari', 'Huari', 'Ancash', '-9.3478', '-77.1725', '51');
INSERT INTO `ubigeo` VALUES ('021002', 'Anra', 'Huari', 'Ancash', '-9.2347', '-76.9253', '51');
INSERT INTO `ubigeo` VALUES ('021003', 'Cajay', 'Huari', 'Ancash', '-9.3253', '-77.1569', '51');
INSERT INTO `ubigeo` VALUES ('021004', 'Chavin de Huantar', 'Huari', 'Ancash', '-9.5869', '-77.1772', '51');
INSERT INTO `ubigeo` VALUES ('021005', 'Huacachi', 'Huari', 'Ancash', '-9.3164', '-76.9356', '51');
INSERT INTO `ubigeo` VALUES ('021006', 'Huacchis', 'Huari', 'Ancash', '-9.2', '-76.7875', '51');
INSERT INTO `ubigeo` VALUES ('021007', 'Huachis', 'Huari', 'Ancash', '-9.4097', '-77.1003', '51');
INSERT INTO `ubigeo` VALUES ('021008', 'Huantar', 'Huari', 'Ancash', '-9.4517', '-77.175', '51');
INSERT INTO `ubigeo` VALUES ('021009', 'Masin', 'Huari', 'Ancash', '-9.3653', '-77.0958', '51');
INSERT INTO `ubigeo` VALUES ('021010', 'Paucas', 'Huari', 'Ancash', '-9.1522', '-76.8983', '51');
INSERT INTO `ubigeo` VALUES ('021011', 'Ponto', 'Huari', 'Ancash', '-9.325', '-77.0047', '51');
INSERT INTO `ubigeo` VALUES ('021012', 'Rahuapampa', 'Huari', 'Ancash', '-9.3592', '-77.0772', '51');
INSERT INTO `ubigeo` VALUES ('021013', 'Rapayan', 'Huari', 'Ancash', '-9.2053', '-76.7611', '51');
INSERT INTO `ubigeo` VALUES ('021014', 'San Marcos', 'Huari', 'Ancash', '-9.525', '-77.1575', '51');
INSERT INTO `ubigeo` VALUES ('021015', 'San Pedro de Chana', 'Huari', 'Ancash', '-9.4025', '-77.0117', '51');
INSERT INTO `ubigeo` VALUES ('021016', 'Uco', 'Huari', 'Ancash', '-9.1886', '-76.9269', '51');
INSERT INTO `ubigeo` VALUES ('021101', 'Huarmey', 'Huarmey', 'Ancash', '-10.0697', '-78.1517', '51');
INSERT INTO `ubigeo` VALUES ('021102', 'Cochapeti', 'Huarmey', 'Ancash', '-9.9872', '-77.6467', '51');
INSERT INTO `ubigeo` VALUES ('021103', 'Culebras', 'Huarmey', 'Ancash', '-9.9486', '-78.2247', '51');
INSERT INTO `ubigeo` VALUES ('021104', 'Huayan', 'Huarmey', 'Ancash', '-9.8761', '-77.7081', '51');
INSERT INTO `ubigeo` VALUES ('021105', 'Malvas', 'Huarmey', 'Ancash', '-9.9294', '-77.6581', '51');
INSERT INTO `ubigeo` VALUES ('021201', 'Caraz', 'Huaylas', 'Ancash', '-9.0472', '-77.8108', '51');
INSERT INTO `ubigeo` VALUES ('021202', 'Huallanca', 'Huaylas', 'Ancash', '-8.8194', '-77.8653', '51');
INSERT INTO `ubigeo` VALUES ('021203', 'Huata', 'Huaylas', 'Ancash', '-9.0167', '-77.8625', '51');
INSERT INTO `ubigeo` VALUES ('021204', 'Huaylas', 'Huaylas', 'Ancash', '-8.8694', '-77.8925', '51');
INSERT INTO `ubigeo` VALUES ('021205', 'Mato', 'Huaylas', 'Ancash', '-8.9617', '-77.8456', '51');
INSERT INTO `ubigeo` VALUES ('021206', 'Pamparomas', 'Huaylas', 'Ancash', '-9.0731', '-77.9819', '51');
INSERT INTO `ubigeo` VALUES ('021207', 'Pueblo Libre', 'Huaylas', 'Ancash', '-9.1117', '-77.8025', '51');
INSERT INTO `ubigeo` VALUES ('021208', 'Santa Cruz', 'Huaylas', 'Ancash', '-8.9486', '-77.815', '51');
INSERT INTO `ubigeo` VALUES ('021209', 'Santo Toribio', 'Huaylas', 'Ancash', '-8.8644', '-77.915', '51');
INSERT INTO `ubigeo` VALUES ('021210', 'Yuracmarca', 'Huaylas', 'Ancash', '-8.7364', '-77.9036', '51');
INSERT INTO `ubigeo` VALUES ('021301', 'Piscobamba', 'Mariscal Luzuriaga', 'Ancash', '-8.8611', '-77.3567', '51');
INSERT INTO `ubigeo` VALUES ('021302', 'Casca', 'Mariscal Luzuriaga', 'Ancash', '-8.8553', '-77.3919', '51');
INSERT INTO `ubigeo` VALUES ('021303', 'Eleazar Guzman Barron', 'Mariscal Luzuriaga', 'Ancash', '-8.8997', '-77.2419', '51');
INSERT INTO `ubigeo` VALUES ('021304', 'Fidel Olivas Escudero', 'Mariscal Luzuriaga', 'Ancash', '-8.8067', '-77.2806', '51');
INSERT INTO `ubigeo` VALUES ('021305', 'Llama', 'Mariscal Luzuriaga', 'Ancash', '-8.9142', '-77.2994', '51');
INSERT INTO `ubigeo` VALUES ('021306', 'Llumpa', 'Mariscal Luzuriaga', 'Ancash', '-8.9467', '-77.3669', '51');
INSERT INTO `ubigeo` VALUES ('021307', 'Lucma', 'Mariscal Luzuriaga', 'Ancash', '-8.9194', '-77.4097', '51');
INSERT INTO `ubigeo` VALUES ('021308', 'Musga', 'Mariscal Luzuriaga', 'Ancash', '-8.9061', '-77.3372', '51');
INSERT INTO `ubigeo` VALUES ('021401', 'Ocros', 'Ocros', 'Ancash', '-10.4058', '-77.3958', '51');
INSERT INTO `ubigeo` VALUES ('021402', 'Acas', 'Ocros', 'Ancash', '-10.4592', '-77.3283', '51');
INSERT INTO `ubigeo` VALUES ('021403', 'Cajamarquilla', 'Ocros', 'Ancash', '-10.355', '-77.1997', '51');
INSERT INTO `ubigeo` VALUES ('021404', 'Carhuapampa', 'Ocros', 'Ancash', '-10.4969', '-77.2428', '51');
INSERT INTO `ubigeo` VALUES ('021405', 'Cochas', 'Ocros', 'Ancash', '-10.535', '-77.4236', '51');
INSERT INTO `ubigeo` VALUES ('021406', 'Congas', 'Ocros', 'Ancash', '-10.3361', '-77.4419', '51');
INSERT INTO `ubigeo` VALUES ('021407', 'Llipa', 'Ocros', 'Ancash', '-10.3808', '-77.2067', '51');
INSERT INTO `ubigeo` VALUES ('021408', 'San Cristobal de Rajan', 'Ocros', 'Ancash', '-10.3858', '-77.2192', '51');
INSERT INTO `ubigeo` VALUES ('021409', 'San Pedro', 'Ocros', 'Ancash', '-10.3706', '-77.4875', '51');
INSERT INTO `ubigeo` VALUES ('021410', 'Santiago de Chilcas', 'Ocros', 'Ancash', '-10.4381', '-77.3669', '51');
INSERT INTO `ubigeo` VALUES ('021501', 'Cabana', 'Pallasca', 'Ancash', '-8.3928', '-78.0089', '51');
INSERT INTO `ubigeo` VALUES ('021502', 'Bolognesi', 'Pallasca', 'Ancash', '-8.3517', '-78.0506', '51');
INSERT INTO `ubigeo` VALUES ('021503', 'Conchucos', 'Pallasca', 'Ancash', '-8.2658', '-77.8483', '51');
INSERT INTO `ubigeo` VALUES ('021504', 'Huacaschuque', 'Pallasca', 'Ancash', '-8.3061', '-78.0031', '51');
INSERT INTO `ubigeo` VALUES ('021505', 'Huandoval', 'Pallasca', 'Ancash', '-8.3272', '-77.9728', '51');
INSERT INTO `ubigeo` VALUES ('021506', 'Lacabamba', 'Pallasca', 'Ancash', '-8.2583', '-77.8958', '51');
INSERT INTO `ubigeo` VALUES ('021507', 'Llapo', 'Pallasca', 'Ancash', '-8.5111', '-78.0397', '51');
INSERT INTO `ubigeo` VALUES ('021508', 'Pallasca', 'Pallasca', 'Ancash', '-8.2494', '-77.9972', '51');
INSERT INTO `ubigeo` VALUES ('021509', 'Pampas', 'Pallasca', 'Ancash', '-8.1925', '-77.8931', '51');
INSERT INTO `ubigeo` VALUES ('021510', 'Santa Rosa', 'Pallasca', 'Ancash', '-8.5239', '-78.065', '51');
INSERT INTO `ubigeo` VALUES ('021511', 'Tauca', 'Pallasca', 'Ancash', '-8.4717', '-78.0347', '51');
INSERT INTO `ubigeo` VALUES ('021601', 'Pomabamba', 'Pomabamba', 'Ancash', '-8.8147', '-77.4592', '51');
INSERT INTO `ubigeo` VALUES ('021602', 'Huayllan', 'Pomabamba', 'Ancash', '-8.8547', '-77.4336', '51');
INSERT INTO `ubigeo` VALUES ('021603', 'Parobamba', 'Pomabamba', 'Ancash', '-8.6886', '-77.4294', '51');
INSERT INTO `ubigeo` VALUES ('021604', 'Quinuabamba', 'Pomabamba', 'Ancash', '-8.6944', '-77.3978', '51');
INSERT INTO `ubigeo` VALUES ('021701', 'Recuay', 'Recuay', 'Ancash', '-9.7214', '-77.455', '51');
INSERT INTO `ubigeo` VALUES ('021702', 'Catac', 'Recuay', 'Ancash', '-9.8017', '-77.4303', '51');
INSERT INTO `ubigeo` VALUES ('021703', 'Cotaparaco', 'Recuay', 'Ancash', '-9.9931', '-77.5878', '51');
INSERT INTO `ubigeo` VALUES ('021704', 'Huayllapampa', 'Recuay', 'Ancash', '-10.055', '-77.535', '51');
INSERT INTO `ubigeo` VALUES ('021705', 'Llacllin', 'Recuay', 'Ancash', '-10.07', '-77.6222', '51');
INSERT INTO `ubigeo` VALUES ('021706', 'Marca', 'Recuay', 'Ancash', '-10.0878', '-77.4747', '51');
INSERT INTO `ubigeo` VALUES ('021707', 'Pampas Chico', 'Recuay', 'Ancash', '-10.1147', '-77.3981', '51');
INSERT INTO `ubigeo` VALUES ('021708', 'Pararin', 'Recuay', 'Ancash', '-10.0497', '-77.6533', '51');
INSERT INTO `ubigeo` VALUES ('021709', 'Tapacocha', 'Recuay', 'Ancash', '-10.0097', '-77.5681', '51');
INSERT INTO `ubigeo` VALUES ('021710', 'Ticapampa', 'Recuay', 'Ancash', '-9.7578', '-77.4444', '51');
INSERT INTO `ubigeo` VALUES ('021801', 'Chimbote', 'Santa', 'Ancash', '-9.0758', '-78.5842', '51');
INSERT INTO `ubigeo` VALUES ('021802', 'Caceres del Peru', 'Santa', 'Ancash', '-9.0131', '-78.1403', '51');
INSERT INTO `ubigeo` VALUES ('021803', 'Coishco', 'Santa', 'Ancash', '-9.0239', '-78.6181', '51');
INSERT INTO `ubigeo` VALUES ('021804', 'Macate', 'Santa', 'Ancash', '-8.7603', '-78.0603', '51');
INSERT INTO `ubigeo` VALUES ('021805', 'Moro', 'Santa', 'Ancash', '-9.1378', '-78.1844', '51');
INSERT INTO `ubigeo` VALUES ('021806', 'Nepeña', 'Santa', 'Ancash', '-9.1731', '-78.3597', '51');
INSERT INTO `ubigeo` VALUES ('021807', 'Samanco', 'Santa', 'Ancash', '-8.9878', '-78.6161', '51');
INSERT INTO `ubigeo` VALUES ('021808', 'Santa', 'Santa', 'Ancash', '-9.1156', '-78.5314', '51');
INSERT INTO `ubigeo` VALUES ('021809', 'Nuevo Chimbote', 'Santa', 'Ancash', '-9.2606', '-78.4994', '51');
INSERT INTO `ubigeo` VALUES ('021901', 'Sihuas', 'Sihuas', 'Ancash', '-8.5556', '-77.6344', '51');
INSERT INTO `ubigeo` VALUES ('021902', 'Acobamba', 'Sihuas', 'Ancash', '-8.3264', '-77.585', '51');
INSERT INTO `ubigeo` VALUES ('021903', 'Alfonso Ugarte', 'Sihuas', 'Ancash', '-8.455', '-77.4292', '51');
INSERT INTO `ubigeo` VALUES ('021904', 'Cashapampa', 'Sihuas', 'Ancash', '-8.5617', '-77.6558', '51');
INSERT INTO `ubigeo` VALUES ('021905', 'Chingalpo', 'Sihuas', 'Ancash', '-8.3394', '-77.5992', '51');
INSERT INTO `ubigeo` VALUES ('021906', 'Huayllabamba', 'Sihuas', 'Ancash', '-8.535', '-77.5689', '51');
INSERT INTO `ubigeo` VALUES ('021907', 'Quiches', 'Sihuas', 'Ancash', '-8.3944', '-77.4933', '51');
INSERT INTO `ubigeo` VALUES ('021908', 'Ragash', 'Sihuas', 'Ancash', '-8.5308', '-77.6692', '51');
INSERT INTO `ubigeo` VALUES ('021909', 'San Juan', 'Sihuas', 'Ancash', '-8.6461', '-77.5808', '51');
INSERT INTO `ubigeo` VALUES ('021910', 'Sicsibamba', 'Sihuas', 'Ancash', '-8.6236', '-77.5367', '51');
INSERT INTO `ubigeo` VALUES ('022001', 'Yungay', 'Yungay', 'Ancash', '-9.1375', '-77.7475', '51');
INSERT INTO `ubigeo` VALUES ('022002', 'Cascapara', 'Yungay', 'Ancash', '-9.2261', '-77.7197', '51');
INSERT INTO `ubigeo` VALUES ('022003', 'Mancos', 'Yungay', 'Ancash', '-9.1911', '-77.7164', '51');
INSERT INTO `ubigeo` VALUES ('022004', 'Matacoto', 'Yungay', 'Ancash', '-9.1775', '-77.7494', '51');
INSERT INTO `ubigeo` VALUES ('022005', 'Quillo', 'Yungay', 'Ancash', '-9.3297', '-78.0431', '51');
INSERT INTO `ubigeo` VALUES ('022006', 'Ranrahirca', 'Yungay', 'Ancash', '-9.1725', '-77.725', '51');
INSERT INTO `ubigeo` VALUES ('022007', 'Shupluy', 'Yungay', 'Ancash', '-9.2183', '-77.6975', '51');
INSERT INTO `ubigeo` VALUES ('022008', 'Yanama', 'Yungay', 'Ancash', '-9.0222', '-77.4744', '51');
INSERT INTO `ubigeo` VALUES ('030101', 'Abancay', 'Abancay', 'Apurimac', '-13.6367', '-72.8792', '51');
INSERT INTO `ubigeo` VALUES ('030102', 'Chacoche', 'Abancay', 'Apurimac', '-13.9417', '-72.9897', '51');
INSERT INTO `ubigeo` VALUES ('030103', 'Circa', 'Abancay', 'Apurimac', '-13.8778', '-72.8736', '51');
INSERT INTO `ubigeo` VALUES ('030104', 'Curahuasi', 'Abancay', 'Apurimac', '-13.5417', '-72.6953', '51');
INSERT INTO `ubigeo` VALUES ('030105', 'Huanipaca', 'Abancay', 'Apurimac', '-13.4917', '-72.9397', '51');
INSERT INTO `ubigeo` VALUES ('030106', 'Lambrama', 'Abancay', 'Apurimac', '-13.8706', '-72.7728', '51');
INSERT INTO `ubigeo` VALUES ('030107', 'Pichirhua', 'Abancay', 'Apurimac', '-13.8606', '-73.0736', '51');
INSERT INTO `ubigeo` VALUES ('030108', 'San Pedro de Cachora', 'Abancay', 'Apurimac', '-13.5144', '-72.8161', '51');
INSERT INTO `ubigeo` VALUES ('030109', 'Tamburco', 'Abancay', 'Apurimac', '-13.6211', '-72.8725', '51');
INSERT INTO `ubigeo` VALUES ('030201', 'Andahuaylas', 'Andahuaylas', 'Apurimac', '-13.6561', '-73.3847', '51');
INSERT INTO `ubigeo` VALUES ('030202', 'Andarapa', 'Andahuaylas', 'Apurimac', '-13.5264', '-73.3681', '51');
INSERT INTO `ubigeo` VALUES ('030203', 'Chiara', 'Andahuaylas', 'Apurimac', '-13.8681', '-73.6681', '51');
INSERT INTO `ubigeo` VALUES ('030204', 'Huancarama', 'Andahuaylas', 'Apurimac', '-13.6467', '-73.0856', '51');
INSERT INTO `ubigeo` VALUES ('030205', 'Huancaray', 'Andahuaylas', 'Apurimac', '-13.7578', '-73.5275', '51');
INSERT INTO `ubigeo` VALUES ('030206', 'Huayana', 'Andahuaylas', 'Apurimac', '-14.0503', '-73.6097', '51');
INSERT INTO `ubigeo` VALUES ('030207', 'Kishuara', 'Andahuaylas', 'Apurimac', '-13.6914', '-73.1214', '51');
INSERT INTO `ubigeo` VALUES ('030208', 'Pacobamba', 'Andahuaylas', 'Apurimac', '-13.6167', '-73.0872', '51');
INSERT INTO `ubigeo` VALUES ('030209', 'Pacucha', 'Andahuaylas', 'Apurimac', '-13.6089', '-73.3442', '51');
INSERT INTO `ubigeo` VALUES ('030210', 'Pampachiri', 'Andahuaylas', 'Apurimac', '-14.1861', '-73.5436', '51');
INSERT INTO `ubigeo` VALUES ('030211', 'Pomacocha', 'Andahuaylas', 'Apurimac', '-14.085', '-73.5911', '51');
INSERT INTO `ubigeo` VALUES ('030212', 'San Antonio de Cachi', 'Andahuaylas', 'Apurimac', '-13.7733', '-73.6036', '51');
INSERT INTO `ubigeo` VALUES ('030213', 'San Jeronimo', 'Andahuaylas', 'Apurimac', '-13.6506', '-73.3656', '51');
INSERT INTO `ubigeo` VALUES ('030214', 'San Miguel de Chaccrampa', 'Andahuaylas', 'Apurimac', '-13.9594', '-73.6086', '51');
INSERT INTO `ubigeo` VALUES ('030215', 'Santa Maria de Chicmo', 'Andahuaylas', 'Apurimac', '-13.6578', '-73.4931', '51');
INSERT INTO `ubigeo` VALUES ('030216', 'Talavera', 'Andahuaylas', 'Apurimac', '-13.6536', '-73.4278', '51');
INSERT INTO `ubigeo` VALUES ('030217', 'Tumay Huaraca', 'Andahuaylas', 'Apurimac', '-14.0539', '-73.5689', '51');
INSERT INTO `ubigeo` VALUES ('030218', 'Turpo', 'Andahuaylas', 'Apurimac', '-13.7856', '-73.4728', '51');
INSERT INTO `ubigeo` VALUES ('030219', 'Kaquiabamba', 'Andahuaylas', 'Apurimac', '-13.5369', '-73.2878', '51');
INSERT INTO `ubigeo` VALUES ('030220', 'José María Arguedas', 'Andahuaylas', 'Apurimac', '-13.7336', '-73.3503', '51');
INSERT INTO `ubigeo` VALUES ('030301', 'Antabamba', 'Antabamba', 'Apurimac', '-14.3653', '-72.8778', '51');
INSERT INTO `ubigeo` VALUES ('030302', 'El Oro', 'Antabamba', 'Apurimac', '-14.2092', '-73.0583', '51');
INSERT INTO `ubigeo` VALUES ('030303', 'Huaquirca', 'Antabamba', 'Apurimac', '-14.3369', '-72.8936', '51');
INSERT INTO `ubigeo` VALUES ('030304', 'Juan Espinoza Medrano', 'Antabamba', 'Apurimac', '-14.4286', '-72.9147', '51');
INSERT INTO `ubigeo` VALUES ('030305', 'Oropesa', 'Antabamba', 'Apurimac', '-14.2628', '-72.5639', '51');
INSERT INTO `ubigeo` VALUES ('030306', 'Pachaconas', 'Antabamba', 'Apurimac', '-14.2244', '-73.0147', '51');
INSERT INTO `ubigeo` VALUES ('030307', 'Sabaino', 'Antabamba', 'Apurimac', '-14.3122', '-72.9442', '51');
INSERT INTO `ubigeo` VALUES ('030401', 'Chalhuanca', 'Aymaraes', 'Apurimac', '-14.295', '-73.2431', '51');
INSERT INTO `ubigeo` VALUES ('030402', 'Capaya', 'Aymaraes', 'Apurimac', '-14.1181', '-73.3217', '51');
INSERT INTO `ubigeo` VALUES ('030403', 'Caraybamba', 'Aymaraes', 'Apurimac', '-14.3783', '-73.1608', '51');
INSERT INTO `ubigeo` VALUES ('030404', 'Chapimarca', 'Aymaraes', 'Apurimac', '-13.9747', '-73.0644', '51');
INSERT INTO `ubigeo` VALUES ('030405', 'Colcabamba', 'Aymaraes', 'Apurimac', '-14.005', '-73.2519', '51');
INSERT INTO `ubigeo` VALUES ('030406', 'Cotaruse', 'Aymaraes', 'Apurimac', '-14.4164', '-73.2053', '51');
INSERT INTO `ubigeo` VALUES ('030407', 'Huayllo', 'Aymaraes', 'Apurimac', '-14.1331', '-73.2686', '51');
INSERT INTO `ubigeo` VALUES ('030408', 'Justo Apu Sahuaraura', 'Aymaraes', 'Apurimac', '-14.1489', '-73.1758', '51');
INSERT INTO `ubigeo` VALUES ('030409', 'Lucre', 'Aymaraes', 'Apurimac', '-13.9506', '-73.2253', '51');
INSERT INTO `ubigeo` VALUES ('030410', 'Pocohuanca', 'Aymaraes', 'Apurimac', '-14.22', '-73.0881', '51');
INSERT INTO `ubigeo` VALUES ('030411', 'San Juan de Chacña', 'Aymaraes', 'Apurimac', '-13.9239', '-73.1828', '51');
INSERT INTO `ubigeo` VALUES ('030412', 'Sañayca', 'Aymaraes', 'Apurimac', '-14.2036', '-73.3461', '51');
INSERT INTO `ubigeo` VALUES ('030413', 'Soraya', 'Aymaraes', 'Apurimac', '-14.1656', '-73.3139', '51');
INSERT INTO `ubigeo` VALUES ('030414', 'Tapairihua', 'Aymaraes', 'Apurimac', '-14.1408', '-73.1431', '51');
INSERT INTO `ubigeo` VALUES ('030415', 'Tintay', 'Aymaraes', 'Apurimac', '-13.9592', '-73.1867', '51');
INSERT INTO `ubigeo` VALUES ('030416', 'Toraya', 'Aymaraes', 'Apurimac', '-14.0522', '-73.2958', '51');
INSERT INTO `ubigeo` VALUES ('030417', 'Yanaca', 'Aymaraes', 'Apurimac', '-14.225', '-73.1589', '51');
INSERT INTO `ubigeo` VALUES ('030501', 'Tambobamba', 'Cotabambas', 'Apurimac', '-13.945', '-72.1769', '51');
INSERT INTO `ubigeo` VALUES ('030502', 'Cotabambas', 'Cotabambas', 'Apurimac', '-13.7458', '-72.3567', '51');
INSERT INTO `ubigeo` VALUES ('030503', 'Coyllurqui', 'Cotabambas', 'Apurimac', '-13.8367', '-72.4339', '51');
INSERT INTO `ubigeo` VALUES ('030504', 'Haquira', 'Cotabambas', 'Apurimac', '-14.2153', '-72.1903', '51');
INSERT INTO `ubigeo` VALUES ('030505', 'Mara', 'Cotabambas', 'Apurimac', '-14.0864', '-72.1025', '51');
INSERT INTO `ubigeo` VALUES ('030506', 'Challhuahuacho', 'Cotabambas', 'Apurimac', '-14.1192', '-72.2486', '51');
INSERT INTO `ubigeo` VALUES ('030601', 'Chincheros', 'Chincheros', 'Apurimac', '-13.5175', '-73.7222', '51');
INSERT INTO `ubigeo` VALUES ('030602', 'Anco_Huallo', 'Chincheros', 'Apurimac', '-13.5328', '-73.6769', '51');
INSERT INTO `ubigeo` VALUES ('030603', 'Cocharcas', 'Chincheros', 'Apurimac', '-13.61', '-73.7408', '51');
INSERT INTO `ubigeo` VALUES ('030604', 'Huaccana', 'Chincheros', 'Apurimac', '-13.3872', '-73.69', '51');
INSERT INTO `ubigeo` VALUES ('030605', 'Ocobamba', 'Chincheros', 'Apurimac', '-13.4828', '-73.5617', '51');
INSERT INTO `ubigeo` VALUES ('030606', 'Ongoy', 'Chincheros', 'Apurimac', '-13.4031', '-73.6697', '51');
INSERT INTO `ubigeo` VALUES ('030607', 'Uranmarca', 'Chincheros', 'Apurimac', '-13.6728', '-73.6686', '51');
INSERT INTO `ubigeo` VALUES ('030608', 'Ranracancha', 'Chincheros', 'Apurimac', '-13.5322', '-73.6056', '51');
INSERT INTO `ubigeo` VALUES ('030609', 'Rocchacc', 'Chincheros', 'Apurimac', '-13.44', '-73.5997', '51');
INSERT INTO `ubigeo` VALUES ('030610', 'El Porvenir', 'Chincheros', 'Apurimac', '-13.3975', '-73.595', '51');
INSERT INTO `ubigeo` VALUES ('030611', 'Los Chankas', 'Chincheros', 'Apurimac', '-13.4353', '-73.8219', '51');
INSERT INTO `ubigeo` VALUES ('030701', 'Chuquibambilla', 'Grau', 'Apurimac', '-14.1042', '-72.7086', '51');
INSERT INTO `ubigeo` VALUES ('030702', 'Curpahuasi', 'Grau', 'Apurimac', '-14.0631', '-72.6714', '51');
INSERT INTO `ubigeo` VALUES ('030703', 'Gamarra', 'Grau', 'Apurimac', '-13.8728', '-72.5122', '51');
INSERT INTO `ubigeo` VALUES ('030704', 'Huayllati', 'Grau', 'Apurimac', '-13.9283', '-72.4847', '51');
INSERT INTO `ubigeo` VALUES ('030705', 'Mamara', 'Grau', 'Apurimac', '-14.2275', '-72.5906', '51');
INSERT INTO `ubigeo` VALUES ('030706', 'Micaela Bastidas', 'Grau', 'Apurimac', '-14.115', '-72.6136', '51');
INSERT INTO `ubigeo` VALUES ('030707', 'Pataypampa', 'Grau', 'Apurimac', '-14.1775', '-72.6706', '51');
INSERT INTO `ubigeo` VALUES ('030708', 'Progreso', 'Grau', 'Apurimac', '-14.0742', '-72.4744', '51');
INSERT INTO `ubigeo` VALUES ('030709', 'San Antonio', 'Grau', 'Apurimac', '-14.1689', '-72.6233', '51');
INSERT INTO `ubigeo` VALUES ('030710', 'Santa Rosa', 'Grau', 'Apurimac', '-14.1408', '-72.6586', '51');
INSERT INTO `ubigeo` VALUES ('030711', 'Turpay', 'Grau', 'Apurimac', '-14.2283', '-72.6253', '51');
INSERT INTO `ubigeo` VALUES ('030712', 'Vilcabamba', 'Grau', 'Apurimac', '-14.0758', '-72.625', '51');
INSERT INTO `ubigeo` VALUES ('030713', 'Virundo', 'Grau', 'Apurimac', '-14.2506', '-72.6811', '51');
INSERT INTO `ubigeo` VALUES ('030714', 'Curasco', 'Grau', 'Apurimac', '-14.0606', '-72.5672', '51');
INSERT INTO `ubigeo` VALUES ('040101', 'Arequipa', 'Arequipa', 'Arequipa', '-16.4008', '-71.5378', '51');
INSERT INTO `ubigeo` VALUES ('040102', 'Alto Selva Alegre', 'Arequipa', 'Arequipa', '-16.3706', '-71.5272', '51');
INSERT INTO `ubigeo` VALUES ('040103', 'Cayma', 'Arequipa', 'Arequipa', '-16.3881', '-71.5492', '51');
INSERT INTO `ubigeo` VALUES ('040104', 'Cerro Colorado', 'Arequipa', 'Arequipa', '-16.375', '-71.5611', '51');
INSERT INTO `ubigeo` VALUES ('040105', 'Characato', 'Arequipa', 'Arequipa', '-16.4706', '-71.4897', '51');
INSERT INTO `ubigeo` VALUES ('040106', 'Chiguata', 'Arequipa', 'Arequipa', '-16.4025', '-71.3939', '51');
INSERT INTO `ubigeo` VALUES ('040107', 'Jacobo Hunter', 'Arequipa', 'Arequipa', '-16.4467', '-71.5556', '51');
INSERT INTO `ubigeo` VALUES ('040108', 'La Joya', 'Arequipa', 'Arequipa', '-16.4239', '-71.8206', '51');
INSERT INTO `ubigeo` VALUES ('040109', 'Mariano Melgar', 'Arequipa', 'Arequipa', '-16.4058', '-71.5117', '51');
INSERT INTO `ubigeo` VALUES ('040110', 'Miraflores', 'Arequipa', 'Arequipa', '-16.395', '-71.5211', '51');
INSERT INTO `ubigeo` VALUES ('040111', 'Mollebaya', 'Arequipa', 'Arequipa', '-16.4883', '-71.4686', '51');
INSERT INTO `ubigeo` VALUES ('040112', 'Paucarpata', 'Arequipa', 'Arequipa', '-16.4233', '-71.5083', '51');
INSERT INTO `ubigeo` VALUES ('040113', 'Pocsi', 'Arequipa', 'Arequipa', '-16.5172', '-71.3925', '51');
INSERT INTO `ubigeo` VALUES ('040114', 'Polobaya', 'Arequipa', 'Arequipa', '-16.5606', '-71.3747', '51');
INSERT INTO `ubigeo` VALUES ('040115', 'Quequeña', 'Arequipa', 'Arequipa', '-16.5586', '-71.4544', '51');
INSERT INTO `ubigeo` VALUES ('040116', 'Sabandia', 'Arequipa', 'Arequipa', '-16.4561', '-71.495', '51');
INSERT INTO `ubigeo` VALUES ('040117', 'Sachaca', 'Arequipa', 'Arequipa', '-16.4286', '-71.5678', '51');
INSERT INTO `ubigeo` VALUES ('040118', 'San Juan de Siguas', 'Arequipa', 'Arequipa', '-16.3461', '-72.1314', '51');
INSERT INTO `ubigeo` VALUES ('040119', 'San Juan de Tarucani', 'Arequipa', 'Arequipa', '-16.1839', '-71.0656', '51');
INSERT INTO `ubigeo` VALUES ('040120', 'Santa Isabel de Siguas', 'Arequipa', 'Arequipa', '-16.3197', '-72.1028', '51');
INSERT INTO `ubigeo` VALUES ('040121', 'Santa Rita de Siguas', 'Arequipa', 'Arequipa', '-16.4928', '-72.0944', '51');
INSERT INTO `ubigeo` VALUES ('040122', 'Socabaya', 'Arequipa', 'Arequipa', '-16.4522', '-71.5308', '51');
INSERT INTO `ubigeo` VALUES ('040123', 'Tiabaya', 'Arequipa', 'Arequipa', '-16.4489', '-71.5908', '51');
INSERT INTO `ubigeo` VALUES ('040124', 'Uchumayo', 'Arequipa', 'Arequipa', '-16.425', '-71.6722', '51');
INSERT INTO `ubigeo` VALUES ('040125', 'Vitor', 'Arequipa', 'Arequipa', '-16.4658', '-71.9389', '51');
INSERT INTO `ubigeo` VALUES ('040126', 'Yanahuara', 'Arequipa', 'Arequipa', '-16.395', '-71.5539', '51');
INSERT INTO `ubigeo` VALUES ('040127', 'Yarabamba', 'Arequipa', 'Arequipa', '-16.5481', '-71.4775', '51');
INSERT INTO `ubigeo` VALUES ('040128', 'Yura', 'Arequipa', 'Arequipa', '-16.245', '-71.6931', '51');
INSERT INTO `ubigeo` VALUES ('040129', 'Jose Luis Bustamante y Rivero', 'Arequipa', 'Arequipa', '-16.4344', '-71.5175', '51');
INSERT INTO `ubigeo` VALUES ('040201', 'Camana', 'Camana', 'Arequipa', '-16.6236', '-72.7114', '51');
INSERT INTO `ubigeo` VALUES ('040202', 'Jose Maria Quimper', 'Camana', 'Arequipa', '-16.6031', '-72.7275', '51');
INSERT INTO `ubigeo` VALUES ('040203', 'Mariano Nicolas Valcarcel', 'Camana', 'Arequipa', '-16.0303', '-73.1625', '51');
INSERT INTO `ubigeo` VALUES ('040204', 'Mariscal Caceres', 'Camana', 'Arequipa', '-16.6183', '-72.7361', '51');
INSERT INTO `ubigeo` VALUES ('040205', 'Nicolas de Pierola', 'Camana', 'Arequipa', '-16.5717', '-72.7147', '51');
INSERT INTO `ubigeo` VALUES ('040206', 'Ocoña', 'Camana', 'Arequipa', '-16.4328', '-73.1081', '51');
INSERT INTO `ubigeo` VALUES ('040207', 'Quilca', 'Camana', 'Arequipa', '-16.7164', '-72.4275', '51');
INSERT INTO `ubigeo` VALUES ('040208', 'Samuel Pastor', 'Camana', 'Arequipa', '-16.615', '-72.6989', '51');
INSERT INTO `ubigeo` VALUES ('040301', 'Caraveli', 'Caraveli', 'Arequipa', '-15.7728', '-73.3681', '51');
INSERT INTO `ubigeo` VALUES ('040302', 'Acari', 'Caraveli', 'Arequipa', '-15.4325', '-74.6172', '51');
INSERT INTO `ubigeo` VALUES ('040303', 'Atico', 'Caraveli', 'Arequipa', '-16.2089', '-73.6258', '51');
INSERT INTO `ubigeo` VALUES ('040304', 'Atiquipa', 'Caraveli', 'Arequipa', '-15.7956', '-74.3658', '51');
INSERT INTO `ubigeo` VALUES ('040305', 'Bella Union', 'Caraveli', 'Arequipa', '-15.4519', '-74.6622', '51');
INSERT INTO `ubigeo` VALUES ('040306', 'Cahuacho', 'Caraveli', 'Arequipa', '-15.5042', '-73.4817', '51');
INSERT INTO `ubigeo` VALUES ('040307', 'Chala', 'Caraveli', 'Arequipa', '-15.8667', '-74.2472', '51');
INSERT INTO `ubigeo` VALUES ('040308', 'Chaparra', 'Caraveli', 'Arequipa', '-15.8058', '-73.9672', '51');
INSERT INTO `ubigeo` VALUES ('040309', 'Huanuhuanu', 'Caraveli', 'Arequipa', '-15.6592', '-74.0936', '51');
INSERT INTO `ubigeo` VALUES ('040310', 'Jaqui', 'Caraveli', 'Arequipa', '-15.4753', '-74.4414', '51');
INSERT INTO `ubigeo` VALUES ('040311', 'Lomas', 'Caraveli', 'Arequipa', '-15.5719', '-74.8533', '51');
INSERT INTO `ubigeo` VALUES ('040312', 'Quicacha', 'Caraveli', 'Arequipa', '-15.6253', '-73.7978', '51');
INSERT INTO `ubigeo` VALUES ('040313', 'Yauca', 'Caraveli', 'Arequipa', '-15.6606', '-74.5269', '51');
INSERT INTO `ubigeo` VALUES ('040401', 'Aplao', 'Castilla', 'Arequipa', '-16.0761', '-72.4925', '51');
INSERT INTO `ubigeo` VALUES ('040402', 'Andagua', 'Castilla', 'Arequipa', '-15.4975', '-72.355', '51');
INSERT INTO `ubigeo` VALUES ('040403', 'Ayo', 'Castilla', 'Arequipa', '-15.6836', '-72.2744', '51');
INSERT INTO `ubigeo` VALUES ('040404', 'Chachas', 'Castilla', 'Arequipa', '-15.5017', '-72.2719', '51');
INSERT INTO `ubigeo` VALUES ('040405', 'Chilcaymarca', 'Castilla', 'Arequipa', '-15.2867', '-72.3794', '51');
INSERT INTO `ubigeo` VALUES ('040406', 'Choco', 'Castilla', 'Arequipa', '-15.5761', '-72.1331', '51');
INSERT INTO `ubigeo` VALUES ('040407', 'Huancarqui', 'Castilla', 'Arequipa', '-16.0969', '-72.4722', '51');
INSERT INTO `ubigeo` VALUES ('040408', 'Machaguay', 'Castilla', 'Arequipa', '-15.6486', '-72.5056', '51');
INSERT INTO `ubigeo` VALUES ('040409', 'Orcopampa', 'Castilla', 'Arequipa', '-15.2661', '-72.3431', '51');
INSERT INTO `ubigeo` VALUES ('040410', 'Pampacolca', 'Castilla', 'Arequipa', '-15.7131', '-72.5728', '51');
INSERT INTO `ubigeo` VALUES ('040411', 'Tipan', 'Castilla', 'Arequipa', '-15.7272', '-72.5053', '51');
INSERT INTO `ubigeo` VALUES ('040412', 'Uñon', 'Castilla', 'Arequipa', '-15.7275', '-72.4317', '51');
INSERT INTO `ubigeo` VALUES ('040413', 'Uraca', 'Castilla', 'Arequipa', '-16.2231', '-72.4733', '51');
INSERT INTO `ubigeo` VALUES ('040414', 'Viraco', 'Castilla', 'Arequipa', '-15.6547', '-72.5247', '51');
INSERT INTO `ubigeo` VALUES ('040501', 'Chivay', 'Caylloma', 'Arequipa', '-15.64', '-71.6033', '51');
INSERT INTO `ubigeo` VALUES ('040502', 'Achoma', 'Caylloma', 'Arequipa', '-15.6611', '-71.7017', '51');
INSERT INTO `ubigeo` VALUES ('040503', 'Cabanaconde', 'Caylloma', 'Arequipa', '-15.6214', '-71.9797', '51');
INSERT INTO `ubigeo` VALUES ('040504', 'Callalli', 'Caylloma', 'Arequipa', '-15.5067', '-71.4483', '51');
INSERT INTO `ubigeo` VALUES ('040505', 'Caylloma', 'Caylloma', 'Arequipa', '-15.1872', '-71.7725', '51');
INSERT INTO `ubigeo` VALUES ('040506', 'Coporaque', 'Caylloma', 'Arequipa', '-15.6275', '-71.6483', '51');
INSERT INTO `ubigeo` VALUES ('040507', 'Huambo', 'Caylloma', 'Arequipa', '-15.7297', '-72.1072', '51');
INSERT INTO `ubigeo` VALUES ('040508', 'Huanca', 'Caylloma', 'Arequipa', '-16.0311', '-71.8736', '51');
INSERT INTO `ubigeo` VALUES ('040509', 'Ichupampa', 'Caylloma', 'Arequipa', '-15.6503', '-71.6892', '51');
INSERT INTO `ubigeo` VALUES ('040510', 'Lari', 'Caylloma', 'Arequipa', '-15.6217', '-71.7692', '51');
INSERT INTO `ubigeo` VALUES ('040511', 'Lluta', 'Caylloma', 'Arequipa', '-16.0156', '-72.0161', '51');
INSERT INTO `ubigeo` VALUES ('040512', 'Maca', 'Caylloma', 'Arequipa', '-15.6417', '-71.7711', '51');
INSERT INTO `ubigeo` VALUES ('040513', 'Madrigal', 'Caylloma', 'Arequipa', '-15.6086', '-71.8103', '51');
INSERT INTO `ubigeo` VALUES ('040514', 'San Antonio de Chuca', 'Caylloma', 'Arequipa', '-15.8403', '-71.0903', '51');
INSERT INTO `ubigeo` VALUES ('040515', 'Sibayo', 'Caylloma', 'Arequipa', '-15.4858', '-71.4586', '51');
INSERT INTO `ubigeo` VALUES ('040516', 'Tapay', 'Caylloma', 'Arequipa', '-15.5789', '-71.9414', '51');
INSERT INTO `ubigeo` VALUES ('040517', 'Tisco', 'Caylloma', 'Arequipa', '-15.3469', '-71.4492', '51');
INSERT INTO `ubigeo` VALUES ('040518', 'Tuti', 'Caylloma', 'Arequipa', '-15.5325', '-71.5511', '51');
INSERT INTO `ubigeo` VALUES ('040519', 'Yanque', 'Caylloma', 'Arequipa', '-15.65', '-71.6614', '51');
INSERT INTO `ubigeo` VALUES ('040520', 'Majes', 'Caylloma', 'Arequipa', '-16.3586', '-72.1908', '51');
INSERT INTO `ubigeo` VALUES ('040601', 'Chuquibamba', 'Condesuyos', 'Arequipa', '-15.8397', '-72.6542', '51');
INSERT INTO `ubigeo` VALUES ('040602', 'Andaray', 'Condesuyos', 'Arequipa', '-15.7961', '-72.8597', '51');
INSERT INTO `ubigeo` VALUES ('040603', 'Cayarani', 'Condesuyos', 'Arequipa', '-14.6731', '-72.0231', '51');
INSERT INTO `ubigeo` VALUES ('040604', 'Chichas', 'Condesuyos', 'Arequipa', '-15.5469', '-72.9183', '51');
INSERT INTO `ubigeo` VALUES ('040605', 'Iray', 'Condesuyos', 'Arequipa', '-15.8564', '-72.625', '51');
INSERT INTO `ubigeo` VALUES ('040606', 'Rio Grande', 'Condesuyos', 'Arequipa', '-15.9411', '-73.1308', '51');
INSERT INTO `ubigeo` VALUES ('040607', 'Salamanca', 'Condesuyos', 'Arequipa', '-15.5042', '-72.8333', '51');
INSERT INTO `ubigeo` VALUES ('040608', 'Yanaquihua', 'Condesuyos', 'Arequipa', '-15.7747', '-72.8758', '51');
INSERT INTO `ubigeo` VALUES ('040701', 'Mollendo', 'Islay', 'Arequipa', '-17.025', '-72.0181', '51');
INSERT INTO `ubigeo` VALUES ('040702', 'Cocachacra', 'Islay', 'Arequipa', '-17.0942', '-71.7711', '51');
INSERT INTO `ubigeo` VALUES ('040703', 'Dean Valdivia', 'Islay', 'Arequipa', '-17.145', '-71.8239', '51');
INSERT INTO `ubigeo` VALUES ('040704', 'Islay', 'Islay', 'Arequipa', '-17', '-72.1017', '51');
INSERT INTO `ubigeo` VALUES ('040705', 'Mejia', 'Islay', 'Arequipa', '-17.1028', '-71.9086', '51');
INSERT INTO `ubigeo` VALUES ('040706', 'Punta de Bombon', 'Islay', 'Arequipa', '-17.1728', '-71.7928', '51');
INSERT INTO `ubigeo` VALUES ('040801', 'Cotahuasi', 'La Union', 'Arequipa', '-15.2111', '-72.8911', '51');
INSERT INTO `ubigeo` VALUES ('040802', 'Alca', 'La Union', 'Arequipa', '-15.1342', '-72.7647', '51');
INSERT INTO `ubigeo` VALUES ('040803', 'Charcana', 'La Union', 'Arequipa', '-15.2411', '-73.0697', '51');
INSERT INTO `ubigeo` VALUES ('040804', 'Huaynacotas', 'La Union', 'Arequipa', '-15.1744', '-72.8514', '51');
INSERT INTO `ubigeo` VALUES ('040805', 'Pampamarca', 'La Union', 'Arequipa', '-15.185', '-72.9072', '51');
INSERT INTO `ubigeo` VALUES ('040806', 'Puyca', 'La Union', 'Arequipa', '-15.0589', '-72.6908', '51');
INSERT INTO `ubigeo` VALUES ('040807', 'Quechualla', 'La Union', 'Arequipa', '-15.2758', '-73.0233', '51');
INSERT INTO `ubigeo` VALUES ('040808', 'Sayla', 'La Union', 'Arequipa', '-15.3211', '-73.2214', '51');
INSERT INTO `ubigeo` VALUES ('040809', 'Tauria', 'La Union', 'Arequipa', '-15.3553', '-73.2319', '51');
INSERT INTO `ubigeo` VALUES ('040810', 'Tomepampa', 'La Union', 'Arequipa', '-15.1728', '-72.8297', '51');
INSERT INTO `ubigeo` VALUES ('040811', 'Toro', 'La Union', 'Arequipa', '-15.2642', '-72.9275', '51');
INSERT INTO `ubigeo` VALUES ('050101', 'Ayacucho', 'Huamanga', 'Ayacucho', '-13.1542', '-74.2228', '51');
INSERT INTO `ubigeo` VALUES ('050102', 'Acocro', 'Huamanga', 'Ayacucho', '-13.2183', '-74.0411', '51');
INSERT INTO `ubigeo` VALUES ('050103', 'Acos Vinchos', 'Huamanga', 'Ayacucho', '-13.1125', '-74.1017', '51');
INSERT INTO `ubigeo` VALUES ('050104', 'Carmen Alto', 'Huamanga', 'Ayacucho', '-13.1722', '-74.2242', '51');
INSERT INTO `ubigeo` VALUES ('050105', 'Chiara', 'Huamanga', 'Ayacucho', '-13.2733', '-74.2053', '51');
INSERT INTO `ubigeo` VALUES ('050106', 'Ocros', 'Huamanga', 'Ayacucho', '-13.3917', '-73.9164', '51');
INSERT INTO `ubigeo` VALUES ('050107', 'Pacaycasa', 'Huamanga', 'Ayacucho', '-13.0564', '-74.2142', '51');
INSERT INTO `ubigeo` VALUES ('050108', 'Quinua', 'Huamanga', 'Ayacucho', '-13.0497', '-74.1397', '51');
INSERT INTO `ubigeo` VALUES ('050109', 'San Jose de Ticllas', 'Huamanga', 'Ayacucho', '-13.1328', '-74.3331', '51');
INSERT INTO `ubigeo` VALUES ('050110', 'San Juan Bautista', 'Huamanga', 'Ayacucho', '-13.1658', '-74.2222', '51');
INSERT INTO `ubigeo` VALUES ('050111', 'Santiago de Pischa', 'Huamanga', 'Ayacucho', '-13.085', '-74.3911', '51');
INSERT INTO `ubigeo` VALUES ('050112', 'Socos', 'Huamanga', 'Ayacucho', '-13.215', '-74.2894', '51');
INSERT INTO `ubigeo` VALUES ('050113', 'Tambillo', 'Huamanga', 'Ayacucho', '-13.1922', '-74.1097', '51');
INSERT INTO `ubigeo` VALUES ('050114', 'Vinchos', 'Huamanga', 'Ayacucho', '-13.2417', '-74.3536', '51');
INSERT INTO `ubigeo` VALUES ('050115', 'Jesus Nazareno', 'Huamanga', 'Ayacucho', '-13.1531', '-74.2114', '51');
INSERT INTO `ubigeo` VALUES ('050116', 'Andrés Avelino Cáceres Dorregaray', 'Huamanga', 'Ayacucho', '-13.1617', '-74.2106', '51');
INSERT INTO `ubigeo` VALUES ('050201', 'Cangallo', 'Cangallo', 'Ayacucho', '-13.6281', '-74.1442', '51');
INSERT INTO `ubigeo` VALUES ('050202', 'Chuschi', 'Cangallo', 'Ayacucho', '-13.5831', '-74.3536', '51');
INSERT INTO `ubigeo` VALUES ('050203', 'Los Morochucos', 'Cangallo', 'Ayacucho', '-13.5572', '-74.1947', '51');
INSERT INTO `ubigeo` VALUES ('050204', 'Maria Parado de Bellido', 'Cangallo', 'Ayacucho', '-13.6039', '-74.2347', '51');
INSERT INTO `ubigeo` VALUES ('050205', 'Paras', 'Cangallo', 'Ayacucho', '-13.5517', '-74.6272', '51');
INSERT INTO `ubigeo` VALUES ('050206', 'Totos', 'Cangallo', 'Ayacucho', '-13.5681', '-74.5242', '51');
INSERT INTO `ubigeo` VALUES ('050301', 'Sancos', 'Huanca Sancos', 'Ayacucho', '-13.9192', '-74.3339', '51');
INSERT INTO `ubigeo` VALUES ('050302', 'Carapo', 'Huanca Sancos', 'Ayacucho', '-13.8375', '-74.3147', '51');
INSERT INTO `ubigeo` VALUES ('050303', 'Sacsamarca', 'Huanca Sancos', 'Ayacucho', '-13.9464', '-74.315', '51');
INSERT INTO `ubigeo` VALUES ('050304', 'Santiago de Lucanamarca', 'Huanca Sancos', 'Ayacucho', '-13.8433', '-74.3722', '51');
INSERT INTO `ubigeo` VALUES ('050401', 'Huanta', 'Huanta', 'Ayacucho', '-12.9386', '-74.2486', '51');
INSERT INTO `ubigeo` VALUES ('050402', 'Ayahuanco', 'Huanta', 'Ayacucho', '-12.5981', '-74.3231', '51');
INSERT INTO `ubigeo` VALUES ('050403', 'Huamanguilla', 'Huanta', 'Ayacucho', '-13.0108', '-74.1731', '51');
INSERT INTO `ubigeo` VALUES ('050404', 'Iguain', 'Huanta', 'Ayacucho', '-12.9919', '-74.2083', '51');
INSERT INTO `ubigeo` VALUES ('050405', 'Luricocha', 'Huanta', 'Ayacucho', '-12.8981', '-74.2711', '51');
INSERT INTO `ubigeo` VALUES ('050406', 'Santillana', 'Huanta', 'Ayacucho', '-12.7656', '-74.2528', '51');
INSERT INTO `ubigeo` VALUES ('050407', 'Sivia', 'Huanta', 'Ayacucho', '-12.5119', '-73.8578', '51');
INSERT INTO `ubigeo` VALUES ('050408', 'Llochegua', 'Huanta', 'Ayacucho', '-12.4114', '-73.9097', '51');
INSERT INTO `ubigeo` VALUES ('050409', 'Canayre', 'Huanta', 'Ayacucho', '-12.2822', '-74.0228', '51');
INSERT INTO `ubigeo` VALUES ('050410', 'Uchuraccay', 'Huanta', 'Ayacucho', '-12.7622', '-74.1464', '51');
INSERT INTO `ubigeo` VALUES ('050411', 'Pucacolpa', 'Huanta', 'Ayacucho', '-15.255', '-73.4136', '51');
INSERT INTO `ubigeo` VALUES ('050412', 'Chaca', 'Huanta', 'Ayacucho', '-12.7836', '-74.2069', '51');
INSERT INTO `ubigeo` VALUES ('050501', 'San Miguel', 'La Mar', 'Ayacucho', '-13.0117', '-73.9789', '51');
INSERT INTO `ubigeo` VALUES ('050502', 'Anco', 'La Mar', 'Ayacucho', '-13.0592', '-73.7072', '51');
INSERT INTO `ubigeo` VALUES ('050503', 'Ayna', 'La Mar', 'Ayacucho', '-12.6244', '-73.79', '51');
INSERT INTO `ubigeo` VALUES ('050504', 'Chilcas', 'La Mar', 'Ayacucho', '-13.1722', '-73.9083', '51');
INSERT INTO `ubigeo` VALUES ('050505', 'Chungui', 'La Mar', 'Ayacucho', '-13.2222', '-73.6242', '51');
INSERT INTO `ubigeo` VALUES ('050506', 'Luis Carranza', 'La Mar', 'Ayacucho', '-13.2283', '-73.8925', '51');
INSERT INTO `ubigeo` VALUES ('050507', 'Santa Rosa', 'La Mar', 'Ayacucho', '-12.6894', '-73.735', '51');
INSERT INTO `ubigeo` VALUES ('050508', 'Tambo', 'La Mar', 'Ayacucho', '-12.9506', '-74.0233', '51');
INSERT INTO `ubigeo` VALUES ('050509', 'Samugari', 'La Mar', 'Ayacucho', '-12.7908', '-73.6414', '51');
INSERT INTO `ubigeo` VALUES ('050510', 'Anchihuay', 'La Mar', 'Ayacucho', '-12.8633', '-73.5817', '51');
INSERT INTO `ubigeo` VALUES ('050511', 'Oronccoy', 'La Mar', 'Ayacucho', '-13.3808', '-73.4358', '51');
INSERT INTO `ubigeo` VALUES ('050601', 'Puquio', 'Lucanas', 'Ayacucho', '-14.6914', '-74.1283', '51');
INSERT INTO `ubigeo` VALUES ('050602', 'Aucara', 'Lucanas', 'Ayacucho', '-14.2681', '-73.9703', '51');
INSERT INTO `ubigeo` VALUES ('050603', 'Cabana', 'Lucanas', 'Ayacucho', '-14.2897', '-73.9667', '51');
INSERT INTO `ubigeo` VALUES ('050604', 'Carmen Salcedo', 'Lucanas', 'Ayacucho', '-14.3875', '-73.9625', '51');
INSERT INTO `ubigeo` VALUES ('050605', 'Chaviña', 'Lucanas', 'Ayacucho', '-14.9778', '-73.8364', '51');
INSERT INTO `ubigeo` VALUES ('050606', 'Chipao', 'Lucanas', 'Ayacucho', '-14.3661', '-73.8786', '51');
INSERT INTO `ubigeo` VALUES ('050607', 'Huac-Huas', 'Lucanas', 'Ayacucho', '-14.1308', '-74.9419', '51');
INSERT INTO `ubigeo` VALUES ('050608', 'Laramate', 'Lucanas', 'Ayacucho', '-14.2858', '-74.8425', '51');
INSERT INTO `ubigeo` VALUES ('050609', 'Leoncio Prado', 'Lucanas', 'Ayacucho', '-14.7278', '-74.67', '51');
INSERT INTO `ubigeo` VALUES ('050610', 'Llauta', 'Lucanas', 'Ayacucho', '-14.2439', '-74.9192', '51');
INSERT INTO `ubigeo` VALUES ('050611', 'Lucanas', 'Lucanas', 'Ayacucho', '-14.6222', '-74.2328', '51');
INSERT INTO `ubigeo` VALUES ('050612', 'Ocaña', 'Lucanas', 'Ayacucho', '-14.3983', '-74.8219', '51');
INSERT INTO `ubigeo` VALUES ('050613', 'Otoca', 'Lucanas', 'Ayacucho', '-14.4894', '-74.6892', '51');
INSERT INTO `ubigeo` VALUES ('050614', 'Saisa', 'Lucanas', 'Ayacucho', '-14.9383', '-74.4183', '51');
INSERT INTO `ubigeo` VALUES ('050615', 'San Cristobal', 'Lucanas', 'Ayacucho', '-14.7425', '-74.2217', '51');
INSERT INTO `ubigeo` VALUES ('050616', 'San Juan', 'Lucanas', 'Ayacucho', '-14.66', '-74.2011', '51');
INSERT INTO `ubigeo` VALUES ('050617', 'San Pedro', 'Lucanas', 'Ayacucho', '-14.7708', '-74.0972', '51');
INSERT INTO `ubigeo` VALUES ('050618', 'San Pedro de Palco', 'Lucanas', 'Ayacucho', '-14.4139', '-74.65', '51');
INSERT INTO `ubigeo` VALUES ('050619', 'Sancos', 'Lucanas', 'Ayacucho', '-15.0619', '-73.9511', '51');
INSERT INTO `ubigeo` VALUES ('050620', 'Santa Ana de Huaycahuacho', 'Lucanas', 'Ayacucho', '-14.2281', '-73.955', '51');
INSERT INTO `ubigeo` VALUES ('050621', 'Santa Lucia', 'Lucanas', 'Ayacucho', '-14.9786', '-74.5233', '51');
INSERT INTO `ubigeo` VALUES ('050701', 'Coracora', 'Parinacochas', 'Ayacucho', '-15.0161', '-73.7819', '51');
INSERT INTO `ubigeo` VALUES ('050702', 'Chumpi', 'Parinacochas', 'Ayacucho', '-15.0944', '-73.7478', '51');
INSERT INTO `ubigeo` VALUES ('050703', 'Coronel Castañeda', 'Parinacochas', 'Ayacucho', '-14.81', '-73.2886', '51');
INSERT INTO `ubigeo` VALUES ('050704', 'Pacapausa', 'Parinacochas', 'Ayacucho', '-14.9492', '-73.3678', '51');
INSERT INTO `ubigeo` VALUES ('050705', 'Pullo', 'Parinacochas', 'Ayacucho', '-15.2092', '-73.8294', '51');
INSERT INTO `ubigeo` VALUES ('050706', 'Puyusca', 'Parinacochas', 'Ayacucho', '-15.2492', '-73.5703', '51');
INSERT INTO `ubigeo` VALUES ('050707', 'San Francisco de Ravacayco', 'Parinacochas', 'Ayacucho', '-14.9975', '-73.3556', '51');
INSERT INTO `ubigeo` VALUES ('050708', 'Upahuacho', 'Parinacochas', 'Ayacucho', '-14.9075', '-73.3972', '51');
INSERT INTO `ubigeo` VALUES ('050801', 'Pausa', 'Paucar del Sara Sara', 'Ayacucho', '-15.2806', '-73.3433', '51');
INSERT INTO `ubigeo` VALUES ('050802', 'Colta', 'Paucar del Sara Sara', 'Ayacucho', '-15.1631', '-73.2939', '51');
INSERT INTO `ubigeo` VALUES ('050803', 'Corculla', 'Paucar del Sara Sara', 'Ayacucho', '-15.2617', '-73.2', '51');
INSERT INTO `ubigeo` VALUES ('050804', 'Lampa', 'Paucar del Sara Sara', 'Ayacucho', '-15.1847', '-73.3472', '51');
INSERT INTO `ubigeo` VALUES ('050805', 'Marcabamba', 'Paucar del Sara Sara', 'Ayacucho', '-15.1492', '-73.3436', '51');
INSERT INTO `ubigeo` VALUES ('050806', 'Oyolo', 'Paucar del Sara Sara', 'Ayacucho', '-15.1797', '-73.1881', '51');
INSERT INTO `ubigeo` VALUES ('050807', 'Pararca', 'Paucar del Sara Sara', 'Ayacucho', '-15.2169', '-73.4653', '51');
INSERT INTO `ubigeo` VALUES ('050808', 'San Javier de Alpabamba', 'Paucar del Sara Sara', 'Ayacucho', '-15.0539', '-73.3103', '51');
INSERT INTO `ubigeo` VALUES ('050809', 'San Jose de Ushua', 'Paucar del Sara Sara', 'Ayacucho', '-15.2242', '-73.2258', '51');
INSERT INTO `ubigeo` VALUES ('050810', 'Sara Sara', 'Paucar del Sara Sara', 'Ayacucho', '-15.2458', '-73.4514', '51');
INSERT INTO `ubigeo` VALUES ('050901', 'Querobamba', 'Sucre', 'Ayacucho', '-14.0136', '-73.8408', '51');
INSERT INTO `ubigeo` VALUES ('050902', 'Belen', 'Sucre', 'Ayacucho', '-13.8094', '-73.7578', '51');
INSERT INTO `ubigeo` VALUES ('050903', 'Chalcos', 'Sucre', 'Ayacucho', '-13.8478', '-73.7533', '51');
INSERT INTO `ubigeo` VALUES ('050904', 'Chilcayoc', 'Sucre', 'Ayacucho', '-13.8825', '-73.7275', '51');
INSERT INTO `ubigeo` VALUES ('050905', 'Huacaña', 'Sucre', 'Ayacucho', '-14.1728', '-73.8864', '51');
INSERT INTO `ubigeo` VALUES ('050906', 'Morcolla', 'Sucre', 'Ayacucho', '-14.1097', '-73.8736', '51');
INSERT INTO `ubigeo` VALUES ('050907', 'Paico', 'Sucre', 'Ayacucho', '-14.0386', '-73.6433', '51');
INSERT INTO `ubigeo` VALUES ('050908', 'San Pedro de Larcay', 'Sucre', 'Ayacucho', '-14.1697', '-73.5758', '51');
INSERT INTO `ubigeo` VALUES ('050909', 'San Salvador de Quije', 'Sucre', 'Ayacucho', '-13.9703', '-73.7314', '51');
INSERT INTO `ubigeo` VALUES ('050910', 'Santiago de Paucaray', 'Sucre', 'Ayacucho', '-14.0444', '-73.6372', '51');
INSERT INTO `ubigeo` VALUES ('050911', 'Soras', 'Sucre', 'Ayacucho', '-14.1153', '-73.6056', '51');
INSERT INTO `ubigeo` VALUES ('051001', 'Huancapi', 'Victor Fajardo', 'Ayacucho', '-13.7528', '-74.0669', '51');
INSERT INTO `ubigeo` VALUES ('051002', 'Alcamenca', 'Victor Fajardo', 'Ayacucho', '-13.6578', '-74.1467', '51');
INSERT INTO `ubigeo` VALUES ('051003', 'Apongo', 'Victor Fajardo', 'Ayacucho', '-14.0147', '-73.9342', '51');
INSERT INTO `ubigeo` VALUES ('051004', 'Asquipata', 'Victor Fajardo', 'Ayacucho', '-14.0536', '-73.9094', '51');
INSERT INTO `ubigeo` VALUES ('051005', 'Canaria', 'Victor Fajardo', 'Ayacucho', '-13.9231', '-73.9053', '51');
INSERT INTO `ubigeo` VALUES ('051006', 'Cayara', 'Victor Fajardo', 'Ayacucho', '-13.7953', '-73.9906', '51');
INSERT INTO `ubigeo` VALUES ('051007', 'Colca', 'Victor Fajardo', 'Ayacucho', '-13.7125', '-74.0342', '51');
INSERT INTO `ubigeo` VALUES ('051008', 'Huamanquiquia', 'Victor Fajardo', 'Ayacucho', '-13.7283', '-74.2731', '51');
INSERT INTO `ubigeo` VALUES ('051009', 'Huancaraylla', 'Victor Fajardo', 'Ayacucho', '-13.7175', '-74.1028', '51');
INSERT INTO `ubigeo` VALUES ('051010', 'Huaya', 'Victor Fajardo', 'Ayacucho', '-13.8492', '-73.9536', '51');
INSERT INTO `ubigeo` VALUES ('051011', 'Sarhua', 'Victor Fajardo', 'Ayacucho', '-13.6714', '-74.3208', '51');
INSERT INTO `ubigeo` VALUES ('051012', 'Vilcanchos', 'Victor Fajardo', 'Ayacucho', '-13.6122', '-74.5339', '51');
INSERT INTO `ubigeo` VALUES ('051101', 'Vilcas Huaman', 'Vilcas Huaman', 'Ayacucho', '-13.6533', '-73.9528', '51');
INSERT INTO `ubigeo` VALUES ('051102', 'Accomarca', 'Vilcas Huaman', 'Ayacucho', '-13.8003', '-73.9033', '51');
INSERT INTO `ubigeo` VALUES ('051103', 'Carhuanca', 'Vilcas Huaman', 'Ayacucho', '-13.7425', '-73.7892', '51');
INSERT INTO `ubigeo` VALUES ('051104', 'Concepcion', 'Vilcas Huaman', 'Ayacucho', '-13.5322', '-73.875', '51');
INSERT INTO `ubigeo` VALUES ('051105', 'Huambalpa', 'Vilcas Huaman', 'Ayacucho', '-13.7494', '-73.9339', '51');
INSERT INTO `ubigeo` VALUES ('051106', 'Independencia', 'Vilcas Huaman', 'Ayacucho', '-13.8581', '-73.8878', '51');
INSERT INTO `ubigeo` VALUES ('051107', 'Saurama', 'Vilcas Huaman', 'Ayacucho', '-13.695', '-73.7622', '51');
INSERT INTO `ubigeo` VALUES ('051108', 'Vischongo', 'Vilcas Huaman', 'Ayacucho', '-13.5881', '-73.9983', '51');
INSERT INTO `ubigeo` VALUES ('060101', 'Cajamarca', 'Cajamarca', 'Cajamarca', '-7.1564', '-78.5153', '51');
INSERT INTO `ubigeo` VALUES ('060102', 'Asuncion', 'Cajamarca', 'Cajamarca', '-7.3233', '-78.5203', '51');
INSERT INTO `ubigeo` VALUES ('060103', 'Chetilla', 'Cajamarca', 'Cajamarca', '-7.1461', '-78.6714', '51');
INSERT INTO `ubigeo` VALUES ('060104', 'Cospan', 'Cajamarca', 'Cajamarca', '-7.4264', '-78.5433', '51');
INSERT INTO `ubigeo` VALUES ('060105', 'Encañada', 'Cajamarca', 'Cajamarca', '-7.0864', '-78.3447', '51');
INSERT INTO `ubigeo` VALUES ('060106', 'Jesus', 'Cajamarca', 'Cajamarca', '-7.2456', '-78.3778', '51');
INSERT INTO `ubigeo` VALUES ('060107', 'Llacanora', 'Cajamarca', 'Cajamarca', '-7.1928', '-78.4269', '51');
INSERT INTO `ubigeo` VALUES ('060108', 'Los Baños del Inca', 'Cajamarca', 'Cajamarca', '-7.1617', '-78.4633', '51');
INSERT INTO `ubigeo` VALUES ('060109', 'Magdalena', 'Cajamarca', 'Cajamarca', '-7.2508', '-78.6564', '51');
INSERT INTO `ubigeo` VALUES ('060110', 'Matara', 'Cajamarca', 'Cajamarca', '-7.2564', '-78.2636', '51');
INSERT INTO `ubigeo` VALUES ('060111', 'Namora', 'Cajamarca', 'Cajamarca', '-7.2017', '-78.3247', '51');
INSERT INTO `ubigeo` VALUES ('060112', 'San Juan', 'Cajamarca', 'Cajamarca', '-7.2903', '-78.4992', '51');
INSERT INTO `ubigeo` VALUES ('060201', 'Cajabamba', 'Cajabamba', 'Cajamarca', '-7.6222', '-78.0472', '51');
INSERT INTO `ubigeo` VALUES ('060202', 'Cachachi', 'Cajabamba', 'Cajamarca', '-7.4494', '-78.2703', '51');
INSERT INTO `ubigeo` VALUES ('060203', 'Condebamba', 'Cajabamba', 'Cajamarca', '-7.5736', '-78.07', '51');
INSERT INTO `ubigeo` VALUES ('060204', 'Sitacocha', 'Cajabamba', 'Cajamarca', '-7.5211', '-77.9714', '51');
INSERT INTO `ubigeo` VALUES ('060301', 'Celendin', 'Celendin', 'Cajamarca', '-6.8681', '-78.1489', '51');
INSERT INTO `ubigeo` VALUES ('060302', 'Chumuch', 'Celendin', 'Cajamarca', '-6.6033', '-78.2033', '51');
INSERT INTO `ubigeo` VALUES ('060303', 'Cortegana', 'Celendin', 'Cajamarca', '-6.4906', '-78.3036', '51');
INSERT INTO `ubigeo` VALUES ('060304', 'Huasmin', 'Celendin', 'Cajamarca', '-6.8386', '-78.2431', '51');
INSERT INTO `ubigeo` VALUES ('060305', 'Jorge Chavez', 'Celendin', 'Cajamarca', '-6.9414', '-78.0914', '51');
INSERT INTO `ubigeo` VALUES ('060306', 'Jose Galvez', 'Celendin', 'Cajamarca', '-6.9253', '-78.1328', '51');
INSERT INTO `ubigeo` VALUES ('060307', 'Miguel Iglesias', 'Celendin', 'Cajamarca', '-6.6439', '-78.2381', '51');
INSERT INTO `ubigeo` VALUES ('060308', 'Oxamarca', 'Celendin', 'Cajamarca', '-7.0397', '-78.0725', '51');
INSERT INTO `ubigeo` VALUES ('060309', 'Sorochuco', 'Celendin', 'Cajamarca', '-6.9103', '-78.2553', '51');
INSERT INTO `ubigeo` VALUES ('060310', 'Sucre', 'Celendin', 'Cajamarca', '-6.9408', '-78.1369', '51');
INSERT INTO `ubigeo` VALUES ('060311', 'Utco', 'Celendin', 'Cajamarca', '-6.8964', '-78.0639', '51');
INSERT INTO `ubigeo` VALUES ('060312', 'La Libertad de Pallan', 'Celendin', 'Cajamarca', '-6.7269', '-78.2908', '51');
INSERT INTO `ubigeo` VALUES ('060401', 'Chota', 'Chota', 'Cajamarca', '-6.5631', '-78.6508', '51');
INSERT INTO `ubigeo` VALUES ('060402', 'Anguia', 'Chota', 'Cajamarca', '-6.3422', '-78.605', '51');
INSERT INTO `ubigeo` VALUES ('060403', 'Chadin', 'Chota', 'Cajamarca', '-6.4731', '-78.4197', '51');
INSERT INTO `ubigeo` VALUES ('060404', 'Chiguirip', 'Chota', 'Cajamarca', '-6.4286', '-78.7192', '51');
INSERT INTO `ubigeo` VALUES ('060405', 'Chimban', 'Chota', 'Cajamarca', '-6.2567', '-78.4786', '51');
INSERT INTO `ubigeo` VALUES ('060406', 'Choropampa', 'Chota', 'Cajamarca', '-6.4372', '-78.3503', '51');
INSERT INTO `ubigeo` VALUES ('060407', 'Cochabamba', 'Chota', 'Cajamarca', '-6.4731', '-78.8878', '51');
INSERT INTO `ubigeo` VALUES ('060408', 'Conchan', 'Chota', 'Cajamarca', '-6.4444', '-78.6572', '51');
INSERT INTO `ubigeo` VALUES ('060409', 'Huambos', 'Chota', 'Cajamarca', '-6.4522', '-78.9639', '51');
INSERT INTO `ubigeo` VALUES ('060410', 'Lajas', 'Chota', 'Cajamarca', '-6.5617', '-78.7389', '51');
INSERT INTO `ubigeo` VALUES ('060411', 'Llama', 'Chota', 'Cajamarca', '-6.5144', '-79.1197', '51');
INSERT INTO `ubigeo` VALUES ('060412', 'Miracosta', 'Chota', 'Cajamarca', '-6.4053', '-79.2831', '51');
INSERT INTO `ubigeo` VALUES ('060413', 'Paccha', 'Chota', 'Cajamarca', '-6.5022', '-78.4211', '51');
INSERT INTO `ubigeo` VALUES ('060414', 'Pion', 'Chota', 'Cajamarca', '-6.1783', '-78.4817', '51');
INSERT INTO `ubigeo` VALUES ('060415', 'Querocoto', 'Chota', 'Cajamarca', '-6.3586', '-79.0356', '51');
INSERT INTO `ubigeo` VALUES ('060416', 'San Juan de Licupis', 'Chota', 'Cajamarca', '-6.4244', '-79.2414', '51');
INSERT INTO `ubigeo` VALUES ('060417', 'Tacabamba', 'Chota', 'Cajamarca', '-6.3931', '-78.6125', '51');
INSERT INTO `ubigeo` VALUES ('060418', 'Tocmoche', 'Chota', 'Cajamarca', '-6.4125', '-79.3606', '51');
INSERT INTO `ubigeo` VALUES ('060419', 'Chalamarca', 'Chota', 'Cajamarca', '-6.4889', '-78.4689', '51');
INSERT INTO `ubigeo` VALUES ('060501', 'Contumaza', 'Contumaza', 'Cajamarca', '-7.3653', '-78.8064', '51');
INSERT INTO `ubigeo` VALUES ('060502', 'Chilete', 'Contumaza', 'Cajamarca', '-7.2222', '-78.8406', '51');
INSERT INTO `ubigeo` VALUES ('060503', 'Cupisnique', 'Contumaza', 'Cajamarca', '-7.3492', '-79.0297', '51');
INSERT INTO `ubigeo` VALUES ('060504', 'Guzmango', 'Contumaza', 'Cajamarca', '-7.3842', '-78.8981', '51');
INSERT INTO `ubigeo` VALUES ('060505', 'San Benito', 'Contumaza', 'Cajamarca', '-7.4247', '-78.9292', '51');
INSERT INTO `ubigeo` VALUES ('060506', 'Santa Cruz de Toled', 'Contumaza', 'Cajamarca', '-7.3436', '-78.8403', '51');
INSERT INTO `ubigeo` VALUES ('060507', 'Tantarica', 'Contumaza', 'Cajamarca', '-7.3006', '-78.9353', '51');
INSERT INTO `ubigeo` VALUES ('060508', 'Yonan', 'Contumaza', 'Cajamarca', '-7.2536', '-79.13', '51');
INSERT INTO `ubigeo` VALUES ('060601', 'Cutervo', 'Cutervo', 'Cajamarca', '-6.3794', '-78.8206', '51');
INSERT INTO `ubigeo` VALUES ('060602', 'Callayuc', 'Cutervo', 'Cajamarca', '-6.1764', '-78.9047', '51');
INSERT INTO `ubigeo` VALUES ('060603', 'Choros', 'Cutervo', 'Cajamarca', '-5.9008', '-78.6967', '51');
INSERT INTO `ubigeo` VALUES ('060604', 'Cujillo', 'Cutervo', 'Cajamarca', '-6.1072', '-78.5725', '51');
INSERT INTO `ubigeo` VALUES ('060605', 'La Ramada', 'Cutervo', 'Cajamarca', '-6.2172', '-78.5547', '51');
INSERT INTO `ubigeo` VALUES ('060606', 'Pimpingos', 'Cutervo', 'Cajamarca', '-6.0622', '-78.7575', '51');
INSERT INTO `ubigeo` VALUES ('060607', 'Querocotillo', 'Cutervo', 'Cajamarca', '-6.2747', '-79.0369', '51');
INSERT INTO `ubigeo` VALUES ('060608', 'San Andres de Cutervo', 'Cutervo', 'Cajamarca', '-6.2364', '-78.7111', '51');
INSERT INTO `ubigeo` VALUES ('060609', 'San Juan de Cutervo', 'Cutervo', 'Cajamarca', '-6.1747', '-78.6011', '51');
INSERT INTO `ubigeo` VALUES ('060610', 'San Luis de Lucma', 'Cutervo', 'Cajamarca', '-6.2956', '-78.6056', '51');
INSERT INTO `ubigeo` VALUES ('060611', 'Santa Cruz', 'Cutervo', 'Cajamarca', '-6.0964', '-78.8547', '51');
INSERT INTO `ubigeo` VALUES ('060612', 'Santo Domingo de La Capilla', 'Cutervo', 'Cajamarca', '-6.245', '-78.8578', '51');
INSERT INTO `ubigeo` VALUES ('060613', 'Santo Tomas', 'Cutervo', 'Cajamarca', '-6.1544', '-78.6908', '51');
INSERT INTO `ubigeo` VALUES ('060614', 'Socota', 'Cutervo', 'Cajamarca', '-6.3158', '-78.7014', '51');
INSERT INTO `ubigeo` VALUES ('060615', 'Toribio Casanova', 'Cutervo', 'Cajamarca', '-6.0069', '-78.6997', '51');
INSERT INTO `ubigeo` VALUES ('060701', 'Bambamarca', 'Hualgayoc', 'Cajamarca', '-6.6786', '-78.5242', '51');
INSERT INTO `ubigeo` VALUES ('060702', 'Chugur', 'Hualgayoc', 'Cajamarca', '-6.6711', '-78.7397', '51');
INSERT INTO `ubigeo` VALUES ('060703', 'Hualgayoc', 'Hualgayoc', 'Cajamarca', '-6.7656', '-78.6119', '51');
INSERT INTO `ubigeo` VALUES ('060801', 'Jaen', 'Jaen', 'Cajamarca', '-5.7106', '-78.8117', '51');
INSERT INTO `ubigeo` VALUES ('060802', 'Bellavista', 'Jaen', 'Cajamarca', '-5.6664', '-78.6786', '51');
INSERT INTO `ubigeo` VALUES ('060803', 'Chontali', 'Jaen', 'Cajamarca', '-5.6458', '-79.0878', '51');
INSERT INTO `ubigeo` VALUES ('060804', 'Colasay', 'Jaen', 'Cajamarca', '-5.9786', '-79.0689', '51');
INSERT INTO `ubigeo` VALUES ('060805', 'Huabal', 'Jaen', 'Cajamarca', '-5.6133', '-78.9122', '51');
INSERT INTO `ubigeo` VALUES ('060806', 'Las Pirias', 'Jaen', 'Cajamarca', '-5.6269', '-78.8533', '51');
INSERT INTO `ubigeo` VALUES ('060807', 'Pomahuaca', 'Jaen', 'Cajamarca', '-5.9322', '-79.2289', '51');
INSERT INTO `ubigeo` VALUES ('060808', 'Pucara', 'Jaen', 'Cajamarca', '-6.0414', '-79.1283', '51');
INSERT INTO `ubigeo` VALUES ('060809', 'Sallique', 'Jaen', 'Cajamarca', '-5.6569', '-79.315', '51');
INSERT INTO `ubigeo` VALUES ('060810', 'San Felipe', 'Jaen', 'Cajamarca', '-5.7697', '-79.3136', '51');
INSERT INTO `ubigeo` VALUES ('060811', 'San Jose del Alto', 'Jaen', 'Cajamarca', '-5.3908', '-79.0539', '51');
INSERT INTO `ubigeo` VALUES ('060812', 'Santa Rosa', 'Jaen', 'Cajamarca', '-5.4358', '-78.5644', '51');
INSERT INTO `ubigeo` VALUES ('060901', 'San Ignacio', 'San Ignacio', 'Cajamarca', '-5.1403', '-79.0003', '51');
INSERT INTO `ubigeo` VALUES ('060902', 'Chirinos', 'San Ignacio', 'Cajamarca', '-5.3028', '-78.8983', '51');
INSERT INTO `ubigeo` VALUES ('060903', 'Huarango', 'San Ignacio', 'Cajamarca', '-5.2706', '-78.7753', '51');
INSERT INTO `ubigeo` VALUES ('060904', 'La Coipa', 'San Ignacio', 'Cajamarca', '-5.3933', '-78.9044', '51');
INSERT INTO `ubigeo` VALUES ('060905', 'Namballe', 'San Ignacio', 'Cajamarca', '-5.0089', '-79.0856', '51');
INSERT INTO `ubigeo` VALUES ('060906', 'San Jose de Lourdes', 'San Ignacio', 'Cajamarca', '-5.1025', '-78.9139', '51');
INSERT INTO `ubigeo` VALUES ('060907', 'Tabaconas', 'San Ignacio', 'Cajamarca', '-5.3164', '-79.2833', '51');
INSERT INTO `ubigeo` VALUES ('061001', 'Pedro Galvez', 'San Marcos', 'Cajamarca', '-7.3361', '-78.1728', '51');
INSERT INTO `ubigeo` VALUES ('061002', 'Chancay', 'San Marcos', 'Cajamarca', '-7.3858', '-78.1264', '51');
INSERT INTO `ubigeo` VALUES ('061003', 'Eduardo Villanueva', 'San Marcos', 'Cajamarca', '-7.4636', '-78.1297', '51');
INSERT INTO `ubigeo` VALUES ('061004', 'Gregorio Pita', 'San Marcos', 'Cajamarca', '-7.2725', '-78.1594', '51');
INSERT INTO `ubigeo` VALUES ('061005', 'Ichocan', 'San Marcos', 'Cajamarca', '-7.3669', '-78.1283', '51');
INSERT INTO `ubigeo` VALUES ('061006', 'Jose Manuel Quiroz', 'San Marcos', 'Cajamarca', '-7.3472', '-78.0467', '51');
INSERT INTO `ubigeo` VALUES ('061007', 'Jose Sabogal', 'San Marcos', 'Cajamarca', '-7.2833', '-78.0167', '51');
INSERT INTO `ubigeo` VALUES ('061101', 'San Miguel', 'San Miguel', 'Cajamarca', '-6.9997', '-78.8536', '51');
INSERT INTO `ubigeo` VALUES ('061102', 'Bolivar', 'San Miguel', 'Cajamarca', '-6.9772', '-79.1789', '51');
INSERT INTO `ubigeo` VALUES ('061103', 'Calquis', 'San Miguel', 'Cajamarca', '-6.9797', '-78.8522', '51');
INSERT INTO `ubigeo` VALUES ('061104', 'Catilluc', 'San Miguel', 'Cajamarca', '-6.7994', '-78.7906', '51');
INSERT INTO `ubigeo` VALUES ('061105', 'El Prado', 'San Miguel', 'Cajamarca', '-7.0339', '-79.0111', '51');
INSERT INTO `ubigeo` VALUES ('061106', 'La Florida', 'San Miguel', 'Cajamarca', '-6.8683', '-79.1231', '51');
INSERT INTO `ubigeo` VALUES ('061107', 'Llapa', 'San Miguel', 'Cajamarca', '-6.9786', '-78.8072', '51');
INSERT INTO `ubigeo` VALUES ('061108', 'Nanchoc', 'San Miguel', 'Cajamarca', '-6.9583', '-79.2419', '51');
INSERT INTO `ubigeo` VALUES ('061109', 'Niepos', 'San Miguel', 'Cajamarca', '-6.9272', '-79.1283', '51');
INSERT INTO `ubigeo` VALUES ('061110', 'San Gregorio', 'San Miguel', 'Cajamarca', '-7.0575', '-79.0956', '51');
INSERT INTO `ubigeo` VALUES ('061111', 'San Silvestre de Cochan', 'San Miguel', 'Cajamarca', '-6.9778', '-78.775', '51');
INSERT INTO `ubigeo` VALUES ('061112', 'Tongod', 'San Miguel', 'Cajamarca', '-6.7631', '-78.8236', '51');
INSERT INTO `ubigeo` VALUES ('061113', 'Union Agua Blanca', 'San Miguel', 'Cajamarca', '-7.0447', '-79.06', '51');
INSERT INTO `ubigeo` VALUES ('061201', 'San Pablo', 'San Pablo', 'Cajamarca', '-7.1181', '-78.8231', '51');
INSERT INTO `ubigeo` VALUES ('061202', 'San Bernardino', 'San Pablo', 'Cajamarca', '-7.1681', '-78.8311', '51');
INSERT INTO `ubigeo` VALUES ('061203', 'San Luis', 'San Pablo', 'Cajamarca', '-7.1583', '-78.87', '51');
INSERT INTO `ubigeo` VALUES ('061204', 'Tumbaden', 'San Pablo', 'Cajamarca', '-7.0203', '-78.7403', '51');
INSERT INTO `ubigeo` VALUES ('061301', 'Santa Cruz', 'Santa Cruz', 'Cajamarca', '-6.6267', '-78.9464', '51');
INSERT INTO `ubigeo` VALUES ('061302', 'Andabamba', 'Santa Cruz', 'Cajamarca', '-6.6628', '-78.8194', '51');
INSERT INTO `ubigeo` VALUES ('061303', 'Catache', 'Santa Cruz', 'Cajamarca', '-6.6753', '-79.0325', '51');
INSERT INTO `ubigeo` VALUES ('061304', 'Chancaybaños', 'Santa Cruz', 'Cajamarca', '-6.5764', '-78.8681', '51');
INSERT INTO `ubigeo` VALUES ('061305', 'La Esperanza', 'Santa Cruz', 'Cajamarca', '-6.5931', '-78.895', '51');
INSERT INTO `ubigeo` VALUES ('061306', 'Ninabamba', 'Santa Cruz', 'Cajamarca', '-6.6497', '-78.7894', '51');
INSERT INTO `ubigeo` VALUES ('061307', 'Pulan', 'Santa Cruz', 'Cajamarca', '-6.7397', '-78.9231', '51');
INSERT INTO `ubigeo` VALUES ('061308', 'Saucepampa', 'Santa Cruz', 'Cajamarca', '-6.6928', '-78.9183', '51');
INSERT INTO `ubigeo` VALUES ('061309', 'Sexi', 'Santa Cruz', 'Cajamarca', '-6.5636', '-79.0514', '51');
INSERT INTO `ubigeo` VALUES ('061310', 'Uticyacu', 'Santa Cruz', 'Cajamarca', '-6.6064', '-78.7972', '51');
INSERT INTO `ubigeo` VALUES ('061311', 'Yauyucan', 'Santa Cruz', 'Cajamarca', '-6.6783', '-78.82', '51');
INSERT INTO `ubigeo` VALUES ('070101', 'Callao', 'Callao', 'Callao', '-12.0603', '-77.1492', '51');
INSERT INTO `ubigeo` VALUES ('070102', 'Bellavista', 'Callao', 'Callao', '-12.0625', '-77.1317', '51');
INSERT INTO `ubigeo` VALUES ('070103', 'Carmen de La Legua', 'Callao', 'Callao', '-12.0461', '-77.0969', '51');
INSERT INTO `ubigeo` VALUES ('070104', 'La Perla', 'Callao', 'Callao', '-12.0711', '-77.1211', '51');
INSERT INTO `ubigeo` VALUES ('070105', 'La Punta', 'Callao', 'Callao', '-12.0717', '-77.1692', '51');
INSERT INTO `ubigeo` VALUES ('070106', 'Ventanilla', 'Callao', 'Callao', '-11.8989', '-77.1422', '51');
INSERT INTO `ubigeo` VALUES ('070107', 'Mi Peru', 'Callao', 'Callao', '-11.855', '-77.125', '51');
INSERT INTO `ubigeo` VALUES ('080101', 'Cusco', 'Cusco', 'Cusco', '-13.5153', '-71.98', '51');
INSERT INTO `ubigeo` VALUES ('080102', 'Ccorca', 'Cusco', 'Cusco', '-13.5842', '-72.0594', '51');
INSERT INTO `ubigeo` VALUES ('080103', 'Poroy', 'Cusco', 'Cusco', '-13.4969', '-72.0425', '51');
INSERT INTO `ubigeo` VALUES ('080104', 'San Jeronimo', 'Cusco', 'Cusco', '-13.5439', '-71.8872', '51');
INSERT INTO `ubigeo` VALUES ('080105', 'San Sebastian', 'Cusco', 'Cusco', '-13.5311', '-71.9333', '51');
INSERT INTO `ubigeo` VALUES ('080106', 'Santiago', 'Cusco', 'Cusco', '-13.5272', '-71.9842', '51');
INSERT INTO `ubigeo` VALUES ('080107', 'Saylla', 'Cusco', 'Cusco', '-13.5703', '-71.8264', '51');
INSERT INTO `ubigeo` VALUES ('080108', 'Wanchaq', 'Cusco', 'Cusco', '-13.5253', '-71.9656', '51');
INSERT INTO `ubigeo` VALUES ('080201', 'Acomayo', 'Acomayo', 'Cusco', '-13.9189', '-71.685', '51');
INSERT INTO `ubigeo` VALUES ('080202', 'Acopia', 'Acomayo', 'Cusco', '-14.0581', '-71.4931', '51');
INSERT INTO `ubigeo` VALUES ('080203', 'Acos', 'Acomayo', 'Cusco', '-13.9506', '-71.7383', '51');
INSERT INTO `ubigeo` VALUES ('080204', 'Mosoc Llacta', 'Acomayo', 'Cusco', '-14.1203', '-71.4733', '51');
INSERT INTO `ubigeo` VALUES ('080205', 'Pomacanchi', 'Acomayo', 'Cusco', '-14.035', '-71.5714', '51');
INSERT INTO `ubigeo` VALUES ('080206', 'Rondocan', 'Acomayo', 'Cusco', '-13.7786', '-71.7822', '51');
INSERT INTO `ubigeo` VALUES ('080207', 'Sangarara', 'Acomayo', 'Cusco', '-13.9475', '-71.6031', '51');
INSERT INTO `ubigeo` VALUES ('080301', 'Anta', 'Anta', 'Cusco', '-13.4636', '-72.1469', '51');
INSERT INTO `ubigeo` VALUES ('080302', 'Ancahuasi', 'Anta', 'Cusco', '-13.4575', '-72.2944', '51');
INSERT INTO `ubigeo` VALUES ('080303', 'Cachimayo', 'Anta', 'Cusco', '-13.4775', '-72.0728', '51');
INSERT INTO `ubigeo` VALUES ('080304', 'Chinchaypujio', 'Anta', 'Cusco', '-13.6294', '-72.2339', '51');
INSERT INTO `ubigeo` VALUES ('080305', 'Huarocondo', 'Anta', 'Cusco', '-13.4131', '-72.2086', '51');
INSERT INTO `ubigeo` VALUES ('080306', 'Limatambo', 'Anta', 'Cusco', '-13.4808', '-72.4458', '51');
INSERT INTO `ubigeo` VALUES ('080307', 'Mollepata', 'Anta', 'Cusco', '-13.5078', '-72.5353', '51');
INSERT INTO `ubigeo` VALUES ('080308', 'Pucyura', 'Anta', 'Cusco', '-13.4803', '-72.1119', '51');
INSERT INTO `ubigeo` VALUES ('080309', 'Zurite', 'Anta', 'Cusco', '-13.4556', '-72.2558', '51');
INSERT INTO `ubigeo` VALUES ('080401', 'Calca', 'Calca', 'Cusco', '-13.3231', '-71.9578', '51');
INSERT INTO `ubigeo` VALUES ('080402', 'Coya', 'Calca', 'Cusco', '-13.3867', '-71.9011', '51');
INSERT INTO `ubigeo` VALUES ('080403', 'Lamay', 'Calca', 'Cusco', '-13.3642', '-71.9228', '51');
INSERT INTO `ubigeo` VALUES ('080404', 'Lares', 'Calca', 'Cusco', '-13.1058', '-72.0472', '51');
INSERT INTO `ubigeo` VALUES ('080405', 'Pisac', 'Calca', 'Cusco', '-13.4217', '-71.85', '51');
INSERT INTO `ubigeo` VALUES ('080406', 'San Salvador', 'Calca', 'Cusco', '-13.4936', '-71.78', '51');
INSERT INTO `ubigeo` VALUES ('080407', 'Taray', 'Calca', 'Cusco', '-13.4278', '-71.8689', '51');
INSERT INTO `ubigeo` VALUES ('080408', 'Yanatile', 'Calca', 'Cusco', '-12.7008', '-72.2322', '51');
INSERT INTO `ubigeo` VALUES ('080501', 'Yanaoca', 'Canas', 'Cusco', '-14.22', '-71.4317', '51');
INSERT INTO `ubigeo` VALUES ('080502', 'Checca', 'Canas', 'Cusco', '-14.4733', '-71.3964', '51');
INSERT INTO `ubigeo` VALUES ('080503', 'Kunturkanki', 'Canas', 'Cusco', '-14.5331', '-71.3064', '51');
INSERT INTO `ubigeo` VALUES ('080504', 'Langui', 'Canas', 'Cusco', '-14.4317', '-71.2744', '51');
INSERT INTO `ubigeo` VALUES ('080505', 'Layo', 'Canas', 'Cusco', '-14.4942', '-71.1556', '51');
INSERT INTO `ubigeo` VALUES ('080506', 'Pampamarca', 'Canas', 'Cusco', '-14.1453', '-71.4603', '51');
INSERT INTO `ubigeo` VALUES ('080507', 'Quehue', 'Canas', 'Cusco', '-14.38', '-71.455', '51');
INSERT INTO `ubigeo` VALUES ('080508', 'Tupac Amaru', 'Canas', 'Cusco', '-14.165', '-71.4794', '51');
INSERT INTO `ubigeo` VALUES ('080601', 'Sicuani', 'Canchis', 'Cusco', '-14.2711', '-71.2289', '51');
INSERT INTO `ubigeo` VALUES ('080602', 'Checacupe', 'Canchis', 'Cusco', '-14.0267', '-71.4533', '51');
INSERT INTO `ubigeo` VALUES ('080603', 'Combapata', 'Canchis', 'Cusco', '-14.1008', '-71.4308', '51');
INSERT INTO `ubigeo` VALUES ('080604', 'Marangani', 'Canchis', 'Cusco', '-14.3564', '-71.1683', '51');
INSERT INTO `ubigeo` VALUES ('080605', 'Pitumarca', 'Canchis', 'Cusco', '-13.9778', '-71.4147', '51');
INSERT INTO `ubigeo` VALUES ('080606', 'San Pablo', 'Canchis', 'Cusco', '-14.2033', '-71.3178', '51');
INSERT INTO `ubigeo` VALUES ('080607', 'San Pedro', 'Canchis', 'Cusco', '-14.1867', '-71.3422', '51');
INSERT INTO `ubigeo` VALUES ('080608', 'Tinta', 'Canchis', 'Cusco', '-14.1447', '-71.4067', '51');
INSERT INTO `ubigeo` VALUES ('080701', 'Santo Tomas', 'Chumbivilcas', 'Cusco', '-14.4503', '-72.0833', '51');
INSERT INTO `ubigeo` VALUES ('080702', 'Capacmarca', 'Chumbivilcas', 'Cusco', '-14.0078', '-72.0008', '51');
INSERT INTO `ubigeo` VALUES ('080703', 'Chamaca', 'Chumbivilcas', 'Cusco', '-14.3028', '-71.855', '51');
INSERT INTO `ubigeo` VALUES ('080704', 'Colquemarca', 'Chumbivilcas', 'Cusco', '-14.2839', '-72.0411', '51');
INSERT INTO `ubigeo` VALUES ('080705', 'Livitaca', 'Chumbivilcas', 'Cusco', '-14.3131', '-71.6892', '51');
INSERT INTO `ubigeo` VALUES ('080706', 'Llusco', 'Chumbivilcas', 'Cusco', '-14.3383', '-72.1144', '51');
INSERT INTO `ubigeo` VALUES ('080707', 'Quiñota', 'Chumbivilcas', 'Cusco', '-14.3114', '-72.1389', '51');
INSERT INTO `ubigeo` VALUES ('080708', 'Velille', 'Chumbivilcas', 'Cusco', '-14.5106', '-71.8864', '51');
INSERT INTO `ubigeo` VALUES ('080801', 'Espinar', 'Espinar', 'Cusco', '-14.7931', '-71.4133', '51');
INSERT INTO `ubigeo` VALUES ('080802', 'Condoroma', 'Espinar', 'Cusco', '-15.3075', '-71.1319', '51');
INSERT INTO `ubigeo` VALUES ('080803', 'Coporaque', 'Espinar', 'Cusco', '-14.7972', '-71.5311', '51');
INSERT INTO `ubigeo` VALUES ('080804', 'Ocoruro', 'Espinar', 'Cusco', '-15.0522', '-71.1292', '51');
INSERT INTO `ubigeo` VALUES ('080805', 'Pallpata', 'Espinar', 'Cusco', '-14.8894', '-71.2103', '51');
INSERT INTO `ubigeo` VALUES ('080806', 'Pichigua', 'Espinar', 'Cusco', '-14.6786', '-71.41', '51');
INSERT INTO `ubigeo` VALUES ('080807', 'Suyckutambo', 'Espinar', 'Cusco', '-15.0025', '-71.6397', '51');
INSERT INTO `ubigeo` VALUES ('080808', 'Alto Pichigua', 'Espinar', 'Cusco', '-14.7789', '-71.2542', '51');
INSERT INTO `ubigeo` VALUES ('080901', 'Santa Ana', 'La Convencion', 'Cusco', '-12.865', '-72.6936', '51');
INSERT INTO `ubigeo` VALUES ('080902', 'Echarate', 'La Convencion', 'Cusco', '-12.7675', '-72.5936', '51');
INSERT INTO `ubigeo` VALUES ('080903', 'Huayopata', 'La Convencion', 'Cusco', '-13.0075', '-72.5569', '51');
INSERT INTO `ubigeo` VALUES ('080904', 'Maranura', 'La Convencion', 'Cusco', '-12.9619', '-72.6653', '51');
INSERT INTO `ubigeo` VALUES ('080905', 'Ocobamba', 'La Convencion', 'Cusco', '-12.8706', '-72.4489', '51');
INSERT INTO `ubigeo` VALUES ('080906', 'Quellouno', 'La Convencion', 'Cusco', '-12.6325', '-72.5517', '51');
INSERT INTO `ubigeo` VALUES ('080907', 'Kimbiri', 'La Convencion', 'Cusco', '-12.6097', '-73.7811', '51');
INSERT INTO `ubigeo` VALUES ('080908', 'Santa Teresa', 'La Convencion', 'Cusco', '-13.1297', '-72.5986', '51');
INSERT INTO `ubigeo` VALUES ('080909', 'Vilcabamba', 'La Convencion', 'Cusco', '-13.0514', '-72.9436', '51');
INSERT INTO `ubigeo` VALUES ('080910', 'Pichari', 'La Convencion', 'Cusco', '-12.5158', '-73.8269', '51');
INSERT INTO `ubigeo` VALUES ('080911', 'Inkawasi', 'La Convencion', 'Cusco', '-13.00354', '-72.51822', '51');
INSERT INTO `ubigeo` VALUES ('080912', 'Villa Virgen', 'La Convencion', 'Cusco', '-13.0031', '-73.5167', '51');
INSERT INTO `ubigeo` VALUES ('080913', 'Villa Kintiarina', 'La Convencion', 'Cusco', '-12.9186', '-73.5306', '51');
INSERT INTO `ubigeo` VALUES ('080914', 'Megantoni', 'La Convencion', 'Cusco', '-11.8047', '-72.8594', '51');
INSERT INTO `ubigeo` VALUES ('081001', 'Paruro', 'Paruro', 'Cusco', '-13.7617', '-71.8478', '51');
INSERT INTO `ubigeo` VALUES ('081002', 'Accha', 'Paruro', 'Cusco', '-13.9681', '-71.8322', '51');
INSERT INTO `ubigeo` VALUES ('081003', 'Ccapi', 'Paruro', 'Cusco', '-13.8533', '-72.0803', '51');
INSERT INTO `ubigeo` VALUES ('081004', 'Colcha', 'Paruro', 'Cusco', '-13.8511', '-71.8028', '51');
INSERT INTO `ubigeo` VALUES ('081005', 'Huanoquite', 'Paruro', 'Cusco', '-13.6828', '-72.0147', '51');
INSERT INTO `ubigeo` VALUES ('081006', 'Omacha', 'Paruro', 'Cusco', '-14.0706', '-71.7386', '51');
INSERT INTO `ubigeo` VALUES ('081007', 'Paccaritambo', 'Paruro', 'Cusco', '-13.7558', '-71.9564', '51');
INSERT INTO `ubigeo` VALUES ('081008', 'Pillpinto', 'Paruro', 'Cusco', '-13.9531', '-71.7619', '51');
INSERT INTO `ubigeo` VALUES ('081009', 'Yaurisque', 'Paruro', 'Cusco', '-13.6639', '-71.9214', '51');
INSERT INTO `ubigeo` VALUES ('081101', 'Paucartambo', 'Paucartambo', 'Cusco', '-13.3189', '-71.5997', '51');
INSERT INTO `ubigeo` VALUES ('081102', 'Caicay', 'Paucartambo', 'Cusco', '-13.5969', '-71.6961', '51');
INSERT INTO `ubigeo` VALUES ('081103', 'Challabamba', 'Paucartambo', 'Cusco', '-13.2114', '-71.6531', '51');
INSERT INTO `ubigeo` VALUES ('081104', 'Colquepata', 'Paucartambo', 'Cusco', '-13.3594', '-71.6731', '51');
INSERT INTO `ubigeo` VALUES ('081105', 'Huancarani', 'Paucartambo', 'Cusco', '-13.5033', '-71.6539', '51');
INSERT INTO `ubigeo` VALUES ('081106', 'Kosñipata', 'Paucartambo', 'Cusco', '-13.0025', '-71.4225', '51');
INSERT INTO `ubigeo` VALUES ('081201', 'Urcos', 'Quispicanchi', 'Cusco', '-13.6883', '-71.6258', '51');
INSERT INTO `ubigeo` VALUES ('081202', 'Andahuaylillas', 'Quispicanchi', 'Cusco', '-13.6733', '-71.6767', '51');
INSERT INTO `ubigeo` VALUES ('081203', 'Camanti', 'Quispicanchi', 'Cusco', '-13.1936', '-70.7478', '51');
INSERT INTO `ubigeo` VALUES ('081204', 'Ccarhuayo', 'Quispicanchi', 'Cusco', '-13.5947', '-71.3994', '51');
INSERT INTO `ubigeo` VALUES ('081205', 'Ccatca', 'Quispicanchi', 'Cusco', '-13.6053', '-71.5619', '51');
INSERT INTO `ubigeo` VALUES ('081206', 'Cusipata', 'Quispicanchi', 'Cusco', '-13.9083', '-71.5', '51');
INSERT INTO `ubigeo` VALUES ('081207', 'Huaro', 'Quispicanchi', 'Cusco', '-13.6903', '-71.6406', '51');
INSERT INTO `ubigeo` VALUES ('081208', 'Lucre', 'Quispicanchi', 'Cusco', '-13.6356', '-71.7378', '51');
INSERT INTO `ubigeo` VALUES ('081209', 'Marcapata', 'Quispicanchi', 'Cusco', '-13.515', '-70.9458', '51');
INSERT INTO `ubigeo` VALUES ('081210', 'Ocongate', 'Quispicanchi', 'Cusco', '-13.6286', '-71.3864', '51');
INSERT INTO `ubigeo` VALUES ('081211', 'Oropesa', 'Quispicanchi', 'Cusco', '-13.5958', '-71.7642', '51');
INSERT INTO `ubigeo` VALUES ('081212', 'Quiquijana', 'Quispicanchi', 'Cusco', '-13.8222', '-71.5317', '51');
INSERT INTO `ubigeo` VALUES ('081301', 'Urubamba', 'Urubamba', 'Cusco', '-13.3061', '-72.1161', '51');
INSERT INTO `ubigeo` VALUES ('081302', 'Chinchero', 'Urubamba', 'Cusco', '-13.3933', '-72.0472', '51');
INSERT INTO `ubigeo` VALUES ('081303', 'Huayllabamba', 'Urubamba', 'Cusco', '-13.3386', '-72.0644', '51');
INSERT INTO `ubigeo` VALUES ('081304', 'Machupicchu', 'Urubamba', 'Cusco', '-13.1533', '-72.5242', '51');
INSERT INTO `ubigeo` VALUES ('081305', 'Maras', 'Urubamba', 'Cusco', '-13.3367', '-72.1572', '51');
INSERT INTO `ubigeo` VALUES ('081306', 'Ollantaytambo', 'Urubamba', 'Cusco', '-13.2581', '-72.2631', '51');
INSERT INTO `ubigeo` VALUES ('081307', 'Yucay', 'Urubamba', 'Cusco', '-13.3194', '-72.0861', '51');
INSERT INTO `ubigeo` VALUES ('090101', 'Huancavelica', 'Huancavelica', 'Huancavelica', '-12.7869', '-74.9756', '51');
INSERT INTO `ubigeo` VALUES ('090102', 'Acobambilla', 'Huancavelica', 'Huancavelica', '-12.6675', '-75.3239', '51');
INSERT INTO `ubigeo` VALUES ('090103', 'Acoria', 'Huancavelica', 'Huancavelica', '-12.6433', '-74.8664', '51');
INSERT INTO `ubigeo` VALUES ('090104', 'Conayca', 'Huancavelica', 'Huancavelica', '-12.5194', '-75.0078', '51');
INSERT INTO `ubigeo` VALUES ('090105', 'Cuenca', 'Huancavelica', 'Huancavelica', '-12.4344', '-75.0394', '51');
INSERT INTO `ubigeo` VALUES ('090106', 'Huachocolpa', 'Huancavelica', 'Huancavelica', '-13.0319', '-74.9497', '51');
INSERT INTO `ubigeo` VALUES ('090107', 'Huayllahuara', 'Huancavelica', 'Huancavelica', '-12.4072', '-75.1797', '51');
INSERT INTO `ubigeo` VALUES ('090108', 'Izcuchaca', 'Huancavelica', 'Huancavelica', '-12.5011', '-74.9961', '51');
INSERT INTO `ubigeo` VALUES ('090109', 'Laria', 'Huancavelica', 'Huancavelica', '-12.5611', '-75.0372', '51');
INSERT INTO `ubigeo` VALUES ('090110', 'Manta', 'Huancavelica', 'Huancavelica', '-12.6217', '-75.2122', '51');
INSERT INTO `ubigeo` VALUES ('090111', 'Mariscal Caceres', 'Huancavelica', 'Huancavelica', '-12.5356', '-74.9336', '51');
INSERT INTO `ubigeo` VALUES ('090112', 'Moya', 'Huancavelica', 'Huancavelica', '-12.4231', '-75.1539', '51');
INSERT INTO `ubigeo` VALUES ('090113', 'Nuevo Occoro', 'Huancavelica', 'Huancavelica', '-12.595', '-75.02', '51');
INSERT INTO `ubigeo` VALUES ('090114', 'Palca', 'Huancavelica', 'Huancavelica', '-12.6589', '-74.9833', '51');
INSERT INTO `ubigeo` VALUES ('090115', 'Pilchaca', 'Huancavelica', 'Huancavelica', '-12.4019', '-75.0839', '51');
INSERT INTO `ubigeo` VALUES ('090116', 'Vilca', 'Huancavelica', 'Huancavelica', '-12.4786', '-75.1867', '51');
INSERT INTO `ubigeo` VALUES ('090117', 'Yauli', 'Huancavelica', 'Huancavelica', '-12.7731', '-74.8506', '51');
INSERT INTO `ubigeo` VALUES ('090118', 'Ascension', 'Huancavelica', 'Huancavelica', '-12.7842', '-74.9806', '51');
INSERT INTO `ubigeo` VALUES ('090119', 'Huando', 'Huancavelica', 'Huancavelica', '-12.5653', '-74.9469', '51');
INSERT INTO `ubigeo` VALUES ('090201', 'Acobamba', 'Acobamba', 'Huancavelica', '-12.8406', '-74.5692', '51');
INSERT INTO `ubigeo` VALUES ('090202', 'Andabamba', 'Acobamba', 'Huancavelica', '-12.6953', '-74.6242', '51');
INSERT INTO `ubigeo` VALUES ('090203', 'Anta', 'Acobamba', 'Huancavelica', '-12.8139', '-74.6364', '51');
INSERT INTO `ubigeo` VALUES ('090204', 'Caja', 'Acobamba', 'Huancavelica', '-12.9183', '-74.465', '51');
INSERT INTO `ubigeo` VALUES ('090205', 'Marcas', 'Acobamba', 'Huancavelica', '-12.8894', '-74.3994', '51');
INSERT INTO `ubigeo` VALUES ('090206', 'Paucara', 'Acobamba', 'Huancavelica', '-12.7303', '-74.6694', '51');
INSERT INTO `ubigeo` VALUES ('090207', 'Pomacocha', 'Acobamba', 'Huancavelica', '-12.8733', '-74.5306', '51');
INSERT INTO `ubigeo` VALUES ('090208', 'Rosario', 'Acobamba', 'Huancavelica', '-12.7214', '-74.5811', '51');
INSERT INTO `ubigeo` VALUES ('090301', 'Lircay', 'Angaraes', 'Huancavelica', '-12.9842', '-74.7203', '51');
INSERT INTO `ubigeo` VALUES ('090302', 'Anchonga', 'Angaraes', 'Huancavelica', '-12.9122', '-74.6922', '51');
INSERT INTO `ubigeo` VALUES ('090303', 'Callanmarca', 'Angaraes', 'Huancavelica', '-12.8678', '-74.6228', '51');
INSERT INTO `ubigeo` VALUES ('090304', 'Ccochaccasa', 'Angaraes', 'Huancavelica', '-12.9311', '-74.7697', '51');
INSERT INTO `ubigeo` VALUES ('090305', 'Chincho', 'Angaraes', 'Huancavelica', '-12.9783', '-74.3689', '51');
INSERT INTO `ubigeo` VALUES ('090306', 'Congalla', 'Angaraes', 'Huancavelica', '-12.9564', '-74.4928', '51');
INSERT INTO `ubigeo` VALUES ('090307', 'Huanca-Huanca', 'Angaraes', 'Huancavelica', '-12.9172', '-74.6106', '51');
INSERT INTO `ubigeo` VALUES ('090308', 'Huayllay Grande', 'Angaraes', 'Huancavelica', '-12.9417', '-74.7011', '51');
INSERT INTO `ubigeo` VALUES ('090309', 'Julcamarca', 'Angaraes', 'Huancavelica', '-13.015', '-74.4453', '51');
INSERT INTO `ubigeo` VALUES ('090310', 'San Antonio de Antaparco', 'Angaraes', 'Huancavelica', '-13.0775', '-74.4119', '51');
INSERT INTO `ubigeo` VALUES ('090311', 'Santo Tomas de Pata', 'Angaraes', 'Huancavelica', '-13.1136', '-74.4233', '51');
INSERT INTO `ubigeo` VALUES ('090312', 'Secclla', 'Angaraes', 'Huancavelica', '-13.0533', '-74.4833', '51');
INSERT INTO `ubigeo` VALUES ('090401', 'Castrovirreyna', 'Castrovirreyna', 'Huancavelica', '-13.2825', '-75.3175', '51');
INSERT INTO `ubigeo` VALUES ('090402', 'Arma', 'Castrovirreyna', 'Huancavelica', '-13.1256', '-75.5419', '51');
INSERT INTO `ubigeo` VALUES ('090403', 'Aurahua', 'Castrovirreyna', 'Huancavelica', '-13.035', '-75.5708', '51');
INSERT INTO `ubigeo` VALUES ('090404', 'Capillas', 'Castrovirreyna', 'Huancavelica', '-13.2931', '-75.5425', '51');
INSERT INTO `ubigeo` VALUES ('090405', 'Chupamarca', 'Castrovirreyna', 'Huancavelica', '-13.0383', '-75.6097', '51');
INSERT INTO `ubigeo` VALUES ('090406', 'Cocas', 'Castrovirreyna', 'Huancavelica', '-13.2758', '-75.3733', '51');
INSERT INTO `ubigeo` VALUES ('090407', 'Huachos', 'Castrovirreyna', 'Huancavelica', '-13.22', '-75.5328', '51');
INSERT INTO `ubigeo` VALUES ('090408', 'Huamatambo', 'Castrovirreyna', 'Huancavelica', '-13.0961', '-75.6806', '51');
INSERT INTO `ubigeo` VALUES ('090409', 'Mollepampa', 'Castrovirreyna', 'Huancavelica', '-13.31', '-75.4092', '51');
INSERT INTO `ubigeo` VALUES ('090410', 'San Juan', 'Castrovirreyna', 'Huancavelica', '-13.2039', '-75.6342', '51');
INSERT INTO `ubigeo` VALUES ('090411', 'Santa Ana', 'Castrovirreyna', 'Huancavelica', '-13.0719', '-75.1403', '51');
INSERT INTO `ubigeo` VALUES ('090412', 'Tantara', 'Castrovirreyna', 'Huancavelica', '-13.0756', '-75.6475', '51');
INSERT INTO `ubigeo` VALUES ('090413', 'Ticrapo', 'Castrovirreyna', 'Huancavelica', '-13.3844', '-75.4319', '51');
INSERT INTO `ubigeo` VALUES ('090501', 'Churcampa', 'Churcampa', 'Huancavelica', '-12.7403', '-74.3869', '51');
INSERT INTO `ubigeo` VALUES ('090502', 'Anco', 'Churcampa', 'Huancavelica', '-12.6864', '-74.5872', '51');
INSERT INTO `ubigeo` VALUES ('090503', 'Chinchihuasi', 'Churcampa', 'Huancavelica', '-12.5172', '-74.5458', '51');
INSERT INTO `ubigeo` VALUES ('090504', 'El Carmen', 'Churcampa', 'Huancavelica', '-12.7347', '-74.4792', '51');
INSERT INTO `ubigeo` VALUES ('090505', 'La Merced', 'Churcampa', 'Huancavelica', '-12.79', '-74.3633', '51');
INSERT INTO `ubigeo` VALUES ('090506', 'Locroja', 'Churcampa', 'Huancavelica', '-12.7389', '-74.4419', '51');
INSERT INTO `ubigeo` VALUES ('090507', 'Paucarbamba', 'Churcampa', 'Huancavelica', '-12.5542', '-74.5314', '51');
INSERT INTO `ubigeo` VALUES ('090508', 'San Miguel de Mayocc', 'Churcampa', 'Huancavelica', '-12.805', '-74.3922', '51');
INSERT INTO `ubigeo` VALUES ('090509', 'San Pedro de Coris', 'Churcampa', 'Huancavelica', '-12.5786', '-74.4103', '51');
INSERT INTO `ubigeo` VALUES ('090510', 'Pachamarca', 'Churcampa', 'Huancavelica', '-12.5161', '-74.5261', '51');
INSERT INTO `ubigeo` VALUES ('090511', 'Cosme', 'Churcampa', 'Huancavelica', '-12.5731', '-74.6581', '51');
INSERT INTO `ubigeo` VALUES ('090601', 'Huaytara', 'Huaytara', 'Huancavelica', '-13.605', '-75.3525', '51');
INSERT INTO `ubigeo` VALUES ('090602', 'Ayavi', 'Huaytara', 'Huancavelica', '-13.7031', '-75.3539', '51');
INSERT INTO `ubigeo` VALUES ('090603', 'Cordova', 'Huaytara', 'Huancavelica', '-14.04', '-75.1833', '51');
INSERT INTO `ubigeo` VALUES ('090604', 'Huayacundo Arma', 'Huaytara', 'Huancavelica', '-13.5339', '-75.3111', '51');
INSERT INTO `ubigeo` VALUES ('090605', 'Laramarca', 'Huaytara', 'Huancavelica', '-13.9494', '-75.0375', '51');
INSERT INTO `ubigeo` VALUES ('090606', 'Ocoyo', 'Huaytara', 'Huancavelica', '-14.0086', '-75.0225', '51');
INSERT INTO `ubigeo` VALUES ('090607', 'Pilpichaca', 'Huaytara', 'Huancavelica', '-13.3278', '-75.0017', '51');
INSERT INTO `ubigeo` VALUES ('090608', 'Querco', 'Huaytara', 'Huancavelica', '-13.9803', '-74.9764', '51');
INSERT INTO `ubigeo` VALUES ('090609', 'Quito-Arma', 'Huaytara', 'Huancavelica', '-13.5289', '-75.3294', '51');
INSERT INTO `ubigeo` VALUES ('090610', 'San Antonio de Cusicancha', 'Huaytara', 'Huancavelica', '-13.5003', '-75.2944', '51');
INSERT INTO `ubigeo` VALUES ('090611', 'San Francisco de Sangayaico', 'Huaytara', 'Huancavelica', '-13.7956', '-75.25', '51');
INSERT INTO `ubigeo` VALUES ('090612', 'San Isidro', 'Huaytara', 'Huancavelica', '-13.9569', '-75.24', '51');
INSERT INTO `ubigeo` VALUES ('090613', 'Santiago de Chocorvos', 'Huaytara', 'Huancavelica', '-13.8272', '-75.2578', '51');
INSERT INTO `ubigeo` VALUES ('090614', 'Santiago de Quirahuara', 'Huaytara', 'Huancavelica', '-14.0547', '-74.9783', '51');
INSERT INTO `ubigeo` VALUES ('090615', 'Santo Domingo de Capillas', 'Huaytara', 'Huancavelica', '-13.7356', '-75.245', '51');
INSERT INTO `ubigeo` VALUES ('090616', 'Tambo', 'Huaytara', 'Huancavelica', '-13.6894', '-75.2758', '51');
INSERT INTO `ubigeo` VALUES ('090701', 'Pampas', 'Tayacaja', 'Huancavelica', '-12.3956', '-74.8672', '51');
INSERT INTO `ubigeo` VALUES ('090702', 'Acostambo', 'Tayacaja', 'Huancavelica', '-12.3653', '-75.0572', '51');
INSERT INTO `ubigeo` VALUES ('090703', 'Acraquia', 'Tayacaja', 'Huancavelica', '-12.4097', '-74.9031', '51');
INSERT INTO `ubigeo` VALUES ('090704', 'Ahuaycha', 'Tayacaja', 'Huancavelica', '-12.4081', '-74.8919', '51');
INSERT INTO `ubigeo` VALUES ('090705', 'Colcabamba', 'Tayacaja', 'Huancavelica', '-12.4114', '-74.6814', '51');
INSERT INTO `ubigeo` VALUES ('090706', 'Daniel Hernandez', 'Tayacaja', 'Huancavelica', '-12.3936', '-74.8625', '51');
INSERT INTO `ubigeo` VALUES ('090707', 'Huachocolpa', 'Tayacaja', 'Huancavelica', '-12.0486', '-74.5953', '51');
INSERT INTO `ubigeo` VALUES ('090709', 'Huaribamba', 'Tayacaja', 'Huancavelica', '-12.2794', '-74.9406', '51');
INSERT INTO `ubigeo` VALUES ('090710', 'Ñahuimpuquio', 'Tayacaja', 'Huancavelica', '-12.3322', '-75.0708', '51');
INSERT INTO `ubigeo` VALUES ('090711', 'Pazos', 'Tayacaja', 'Huancavelica', '-12.2589', '-75.07', '51');
INSERT INTO `ubigeo` VALUES ('090713', 'Quishuar', 'Tayacaja', 'Huancavelica', '-12.2408', '-74.7792', '51');
INSERT INTO `ubigeo` VALUES ('090714', 'Salcabamba', 'Tayacaja', 'Huancavelica', '-12.2011', '-74.7825', '51');
INSERT INTO `ubigeo` VALUES ('090715', 'Salcahuasi', 'Tayacaja', 'Huancavelica', '-12.1031', '-74.7508', '51');
INSERT INTO `ubigeo` VALUES ('090716', 'San Marcos de Rocchac', 'Tayacaja', 'Huancavelica', '-12.0939', '-74.8656', '51');
INSERT INTO `ubigeo` VALUES ('090717', 'Surcubamba', 'Tayacaja', 'Huancavelica', '-12.1169', '-74.63', '51');
INSERT INTO `ubigeo` VALUES ('090718', 'Tintay Puncu', 'Tayacaja', 'Huancavelica', '-12.1531', '-74.5456', '51');
INSERT INTO `ubigeo` VALUES ('090719', 'Quichuas', 'Tayacaja', 'Huancavelica', '-12.4681', '-74.7847', '51');
INSERT INTO `ubigeo` VALUES ('090720', 'Andaymarca', 'Tayacaja', 'Huancavelica', '-12.3147', '-74.6364', '51');
INSERT INTO `ubigeo` VALUES ('090721', 'Roble', 'Tayacaja', 'Huancavelica', '-12.2169', '-74.49', '51');
INSERT INTO `ubigeo` VALUES ('090722', 'Pichos', 'Tayacaja', 'Huancavelica', '-12.2347', '-74.9444', '51');
INSERT INTO `ubigeo` VALUES ('090723', 'Santiago de Túcuma', 'Tayacaja', 'Huancavelica', '-12.3122', '-74.9169', '51');
INSERT INTO `ubigeo` VALUES ('100101', 'Huanuco', 'Huanuco', 'Huanuco', '-9.9269', '-76.2403', '51');
INSERT INTO `ubigeo` VALUES ('100102', 'Amarilis', 'Huanuco', 'Huanuco', '-9.9456', '-76.2417', '51');
INSERT INTO `ubigeo` VALUES ('100103', 'Chinchao', 'Huanuco', 'Huanuco', '-9.8019', '-76.0689', '51');
INSERT INTO `ubigeo` VALUES ('100104', 'Churubamba', 'Huanuco', 'Huanuco', '-9.8258', '-76.1375', '51');
INSERT INTO `ubigeo` VALUES ('100105', 'Margos', 'Huanuco', 'Huanuco', '-10.0061', '-76.5214', '51');
INSERT INTO `ubigeo` VALUES ('100106', 'Quisqui', 'Huanuco', 'Huanuco', '-9.9231', '-76.3561', '51');
INSERT INTO `ubigeo` VALUES ('100107', 'San Francisco de Cayran', 'Huanuco', 'Huanuco', '-9.9822', '-76.2847', '51');
INSERT INTO `ubigeo` VALUES ('100108', 'San Pedro de Chaulan', 'Huanuco', 'Huanuco', '-10.0581', '-76.4822', '51');
INSERT INTO `ubigeo` VALUES ('100109', 'Santa Maria del Valle', 'Huanuco', 'Huanuco', '-9.8628', '-76.1703', '51');
INSERT INTO `ubigeo` VALUES ('100110', 'Yarumayo', 'Huanuco', 'Huanuco', '-10.0022', '-76.4683', '51');
INSERT INTO `ubigeo` VALUES ('100111', 'Pillco Marca', 'Huanuco', 'Huanuco', '-9.9578', '-76.2492', '51');
INSERT INTO `ubigeo` VALUES ('100112', 'Yacus', 'Huanuco', 'Huanuco', '-9.9858', '-76.5044', '51');
INSERT INTO `ubigeo` VALUES ('100113', 'San Pablo de Pillao', 'Huanuco', 'Huanuco', '-9.7894', '-75.9986', '51');
INSERT INTO `ubigeo` VALUES ('100201', 'Ambo', 'Ambo', 'Huanuco', '-10.1294', '-76.2047', '51');
INSERT INTO `ubigeo` VALUES ('100202', 'Cayna', 'Ambo', 'Huanuco', '-10.2717', '-76.3872', '51');
INSERT INTO `ubigeo` VALUES ('100203', 'Colpas', 'Ambo', 'Huanuco', '-10.2672', '-76.4144', '51');
INSERT INTO `ubigeo` VALUES ('100204', 'Conchamarca', 'Ambo', 'Huanuco', '-10.0367', '-76.2156', '51');
INSERT INTO `ubigeo` VALUES ('100205', 'Huacar', 'Ambo', 'Huanuco', '-10.1614', '-76.2356', '51');
INSERT INTO `ubigeo` VALUES ('100206', 'San Francisco', 'Ambo', 'Huanuco', '-10.3419', '-76.2914', '51');
INSERT INTO `ubigeo` VALUES ('100207', 'San Rafael', 'Ambo', 'Huanuco', '-10.3403', '-76.1828', '51');
INSERT INTO `ubigeo` VALUES ('100208', 'Tomay Kichwa', 'Ambo', 'Huanuco', '-10.0789', '-76.2131', '51');
INSERT INTO `ubigeo` VALUES ('100301', 'La Union', 'Dos de Mayo', 'Huanuco', '-9.8278', '-76.8003', '51');
INSERT INTO `ubigeo` VALUES ('100307', 'Chuquis', 'Dos de Mayo', 'Huanuco', '-9.6775', '-76.7033', '51');
INSERT INTO `ubigeo` VALUES ('100311', 'Marias', 'Dos de Mayo', 'Huanuco', '-9.6061', '-76.705', '51');
INSERT INTO `ubigeo` VALUES ('100313', 'Pachas', 'Dos de Mayo', 'Huanuco', '-9.7061', '-76.7722', '51');
INSERT INTO `ubigeo` VALUES ('100316', 'Quivilla', 'Dos de Mayo', 'Huanuco', '-9.5967', '-76.7253', '51');
INSERT INTO `ubigeo` VALUES ('100317', 'Ripan', 'Dos de Mayo', 'Huanuco', '-9.8261', '-76.8033', '51');
INSERT INTO `ubigeo` VALUES ('100321', 'Shunqui', 'Dos de Mayo', 'Huanuco', '-9.7311', '-76.7833', '51');
INSERT INTO `ubigeo` VALUES ('100322', 'Sillapata', 'Dos de Mayo', 'Huanuco', '-9.7581', '-76.7742', '51');
INSERT INTO `ubigeo` VALUES ('100323', 'Yanas', 'Dos de Mayo', 'Huanuco', '-9.7144', '-76.7489', '51');
INSERT INTO `ubigeo` VALUES ('100401', 'Huacaybamba', 'Huacaybamba', 'Huanuco', '-9.0372', '-76.9519', '51');
INSERT INTO `ubigeo` VALUES ('100402', 'Canchabamba', 'Huacaybamba', 'Huanuco', '-8.8836', '-77.1228', '51');
INSERT INTO `ubigeo` VALUES ('100403', 'Cochabamba', 'Huacaybamba', 'Huanuco', '-9.0922', '-76.835', '51');
INSERT INTO `ubigeo` VALUES ('100404', 'Pinra', 'Huacaybamba', 'Huanuco', '-8.9239', '-77.0125', '51');
INSERT INTO `ubigeo` VALUES ('100501', 'Llata', 'Huamalies', 'Huanuco', '-9.5506', '-76.8156', '51');
INSERT INTO `ubigeo` VALUES ('100502', 'Arancay', 'Huamalies', 'Huanuco', '-9.1708', '-76.7483', '51');
INSERT INTO `ubigeo` VALUES ('100503', 'Chavin de Pariarca', 'Huamalies', 'Huanuco', '-9.4231', '-76.7692', '51');
INSERT INTO `ubigeo` VALUES ('100504', 'Jacas Grande', 'Huamalies', 'Huanuco', '-9.5397', '-76.7358', '51');
INSERT INTO `ubigeo` VALUES ('100505', 'Jircan', 'Huamalies', 'Huanuco', '-9.2472', '-76.7161', '51');
INSERT INTO `ubigeo` VALUES ('100506', 'Miraflores', 'Huamalies', 'Huanuco', '-9.4928', '-76.8189', '51');
INSERT INTO `ubigeo` VALUES ('100507', 'Monzon', 'Huamalies', 'Huanuco', '-9.2842', '-76.3978', '51');
INSERT INTO `ubigeo` VALUES ('100508', 'Punchao', 'Huamalies', 'Huanuco', '-9.4614', '-76.8192', '51');
INSERT INTO `ubigeo` VALUES ('100509', 'Puños', 'Huamalies', 'Huanuco', '-9.5', '-76.885', '51');
INSERT INTO `ubigeo` VALUES ('100510', 'Singa', 'Huamalies', 'Huanuco', '-9.3881', '-76.8125', '51');
INSERT INTO `ubigeo` VALUES ('100511', 'Tantamayo', 'Huamalies', 'Huanuco', '-9.3928', '-76.7183', '51');
INSERT INTO `ubigeo` VALUES ('100601', 'Rupa-Rupa', 'Leoncio Prado', 'Huanuco', '-9.2944', '-75.9969', '51');
INSERT INTO `ubigeo` VALUES ('100602', 'Daniel Alomias Robles', 'Leoncio Prado', 'Huanuco', '-9.1839', '-75.9406', '51');
INSERT INTO `ubigeo` VALUES ('100603', 'Hermilio Valdizan', 'Leoncio Prado', 'Huanuco', '-9.1525', '-75.8261', '51');
INSERT INTO `ubigeo` VALUES ('100604', 'Jose Crespo y Castillo', 'Leoncio Prado', 'Huanuco', '-8.9319', '-76.1147', '51');
INSERT INTO `ubigeo` VALUES ('100605', 'Luyando', 'Leoncio Prado', 'Huanuco', '-9.2469', '-75.9919', '51');
INSERT INTO `ubigeo` VALUES ('100606', 'Mariano Damaso Beraun', 'Leoncio Prado', 'Huanuco', '-9.4164', '-75.9661', '51');
INSERT INTO `ubigeo` VALUES ('100607', 'Pucayacu', 'Leoncio Prado', 'Huanuco', '-8.7492', '-76.1253', '51');
INSERT INTO `ubigeo` VALUES ('100608', 'Castillo Grande', 'Leoncio Prado', 'Huanuco', '-9.2792', '-76.0117', '51');
INSERT INTO `ubigeo` VALUES ('100609', 'Pueblo Nuevo', 'Leoncio Prado', 'Huanuco', '-9.0089', '-76.0714', '51');
INSERT INTO `ubigeo` VALUES ('100610', 'Santo Domingo de Anda', 'Leoncio Prado', 'Huanuco', '-9.0089', '-76.0714', '51');
INSERT INTO `ubigeo` VALUES ('100701', 'Huacrachuco', 'Marañon', 'Huanuco', '-8.6044', '-77.1489', '51');
INSERT INTO `ubigeo` VALUES ('100702', 'Cholon', 'Marañon', 'Huanuco', '-8.6594', '-76.8481', '51');
INSERT INTO `ubigeo` VALUES ('100703', 'San Buenaventura', 'Marañon', 'Huanuco', '-8.7681', '-77.1867', '51');
INSERT INTO `ubigeo` VALUES ('100704', 'La Morada', 'Marañon', 'Huanuco', '-8.7933', '-76.2497', '51');
INSERT INTO `ubigeo` VALUES ('100705', 'Santa Rosa de Alto Yanajanca', 'Marañon', 'Huanuco', '-8.6364', '-76.3439', '51');
INSERT INTO `ubigeo` VALUES ('100801', 'Panao', 'Pachitea', 'Huanuco', '-9.8956', '-75.9769', '51');
INSERT INTO `ubigeo` VALUES ('100802', 'Chaglla', 'Pachitea', 'Huanuco', '-9.8281', '-75.9064', '51');
INSERT INTO `ubigeo` VALUES ('100803', 'Molino', 'Pachitea', 'Huanuco', '-9.9119', '-76.0175', '51');
INSERT INTO `ubigeo` VALUES ('100804', 'Umari', 'Pachitea', 'Huanuco', '-9.8614', '-76.0422', '51');
INSERT INTO `ubigeo` VALUES ('100901', 'Puerto Inca', 'Puerto Inca', 'Huanuco', '-9.3775', '-74.9733', '51');
INSERT INTO `ubigeo` VALUES ('100902', 'Codo del Pozuzo', 'Puerto Inca', 'Huanuco', '-9.6758', '-75.4533', '51');
INSERT INTO `ubigeo` VALUES ('100903', 'Honoria', 'Puerto Inca', 'Huanuco', '-8.7694', '-74.7089', '51');
INSERT INTO `ubigeo` VALUES ('100904', 'Tournavista', 'Puerto Inca', 'Huanuco', '-8.9289', '-74.7053', '51');
INSERT INTO `ubigeo` VALUES ('100905', 'Yuyapichis', 'Puerto Inca', 'Huanuco', '-9.6297', '-74.9744', '51');
INSERT INTO `ubigeo` VALUES ('101001', 'Jesus', 'Lauricocha', 'Huanuco', '-10.0803', '-76.6303', '51');
INSERT INTO `ubigeo` VALUES ('101002', 'Baños', 'Lauricocha', 'Huanuco', '-10.0769', '-76.7356', '51');
INSERT INTO `ubigeo` VALUES ('101003', 'Jivia', 'Lauricocha', 'Huanuco', '-10.0236', '-76.6811', '51');
INSERT INTO `ubigeo` VALUES ('101004', 'Queropalca', 'Lauricocha', 'Huanuco', '-10.1811', '-76.8042', '51');
INSERT INTO `ubigeo` VALUES ('101005', 'Rondos', 'Lauricocha', 'Huanuco', '-9.9836', '-76.6889', '51');
INSERT INTO `ubigeo` VALUES ('101006', 'San Francisco de Asis', 'Lauricocha', 'Huanuco', '-9.9772', '-76.6758', '51');
INSERT INTO `ubigeo` VALUES ('101007', 'San Miguel de Cauri', 'Lauricocha', 'Huanuco', '-10.1431', '-76.625', '51');
INSERT INTO `ubigeo` VALUES ('101101', 'Chavinillo', 'Yarowilca', 'Huanuco', '-9.8447', '-76.6236', '51');
INSERT INTO `ubigeo` VALUES ('101102', 'Cahuac', 'Yarowilca', 'Huanuco', '-9.8494', '-76.6319', '51');
INSERT INTO `ubigeo` VALUES ('101103', 'Chacabamba', 'Yarowilca', 'Huanuco', '-9.9014', '-76.6097', '51');
INSERT INTO `ubigeo` VALUES ('101104', 'Aparicio Pomares', 'Yarowilca', 'Huanuco', '-9.7486', '-76.6478', '51');
INSERT INTO `ubigeo` VALUES ('101105', 'Jacas Chico', 'Yarowilca', 'Huanuco', '-9.8872', '-76.5017', '51');
INSERT INTO `ubigeo` VALUES ('101106', 'Obas', 'Yarowilca', 'Huanuco', '-9.7953', '-76.6658', '51');
INSERT INTO `ubigeo` VALUES ('101107', 'Pampamarca', 'Yarowilca', 'Huanuco', '-9.7061', '-76.7028', '51');
INSERT INTO `ubigeo` VALUES ('101108', 'Choras', 'Yarowilca', 'Huanuco', '-9.9108', '-76.6036', '51');
INSERT INTO `ubigeo` VALUES ('110101', 'Ica', 'Ica', 'Ica', '-14.0678', '-75.7319', '51');
INSERT INTO `ubigeo` VALUES ('110102', 'La Tinguiña', 'Ica', 'Ica', '-14.035', '-75.7092', '51');
INSERT INTO `ubigeo` VALUES ('110103', 'Los Aquijes', 'Ica', 'Ica', '-14.0978', '-75.6911', '51');
INSERT INTO `ubigeo` VALUES ('110104', 'Ocucaje', 'Ica', 'Ica', '-14.3433', '-75.6608', '51');
INSERT INTO `ubigeo` VALUES ('110105', 'Pachacutec', 'Ica', 'Ica', '-14.1528', '-75.6925', '51');
INSERT INTO `ubigeo` VALUES ('110106', 'Parcona', 'Ica', 'Ica', '-14.0453', '-75.7058', '51');
INSERT INTO `ubigeo` VALUES ('110107', 'Pueblo Nuevo', 'Ica', 'Ica', '-14.1275', '-75.7031', '51');
INSERT INTO `ubigeo` VALUES ('110108', 'Salas', 'Ica', 'Ica', '-13.9861', '-75.7733', '51');
INSERT INTO `ubigeo` VALUES ('110109', 'San Jose de los Molinos', 'Ica', 'Ica', '-13.9283', '-75.6669', '51');
INSERT INTO `ubigeo` VALUES ('110110', 'San Juan Bautista', 'Ica', 'Ica', '-14.0114', '-75.7372', '51');
INSERT INTO `ubigeo` VALUES ('110111', 'Santiago', 'Ica', 'Ica', '-14.1922', '-75.7142', '51');
INSERT INTO `ubigeo` VALUES ('110112', 'Subtanjalla', 'Ica', 'Ica', '-14.0194', '-75.7597', '51');
INSERT INTO `ubigeo` VALUES ('110113', 'Tate', 'Ica', 'Ica', '-14.1528', '-75.7092', '51');
INSERT INTO `ubigeo` VALUES ('110114', 'Yauca del Rosario', 'Ica', 'Ica', '-14.1014', '-75.4783', '51');
INSERT INTO `ubigeo` VALUES ('110201', 'Chincha Alta', 'Chincha', 'Ica', '-13.42', '-76.1356', '51');
INSERT INTO `ubigeo` VALUES ('110202', 'Alto Laran', 'Chincha', 'Ica', '-13.4444', '-76.1067', '51');
INSERT INTO `ubigeo` VALUES ('110203', 'Chavin', 'Chincha', 'Ica', '-13.0789', '-75.9119', '51');
INSERT INTO `ubigeo` VALUES ('110204', 'Chincha Baja', 'Chincha', 'Ica', '-13.4597', '-76.1647', '51');
INSERT INTO `ubigeo` VALUES ('110205', 'El Carmen', 'Chincha', 'Ica', '-13.5019', '-76.0536', '51');
INSERT INTO `ubigeo` VALUES ('110206', 'Grocio Prado', 'Chincha', 'Ica', '-13.3986', '-76.1592', '51');
INSERT INTO `ubigeo` VALUES ('110207', 'Pueblo Nuevo', 'Chincha', 'Ica', '-13.4019', '-76.1269', '51');
INSERT INTO `ubigeo` VALUES ('110208', 'San Juan de Yanac', 'Chincha', 'Ica', '-13.2108', '-75.7861', '51');
INSERT INTO `ubigeo` VALUES ('110209', 'San Pedro de Huacarpana', 'Chincha', 'Ica', '-13.0492', '-75.6483', '51');
INSERT INTO `ubigeo` VALUES ('110210', 'Sunampe', 'Chincha', 'Ica', '-13.4269', '-76.1647', '51');
INSERT INTO `ubigeo` VALUES ('110211', 'Tambo de Mora', 'Chincha', 'Ica', '-13.4592', '-76.1839', '51');
INSERT INTO `ubigeo` VALUES ('110301', 'Nazca', 'Nazca', 'Ica', '-14.8328', '-74.9361', '51');
INSERT INTO `ubigeo` VALUES ('110302', 'Changuillo', 'Nazca', 'Ica', '-14.6653', '-75.2253', '51');
INSERT INTO `ubigeo` VALUES ('110303', 'El Ingenio', 'Nazca', 'Ica', '-14.6464', '-75.06', '51');
INSERT INTO `ubigeo` VALUES ('110304', 'Marcona', 'Nazca', 'Ica', '-15.3619', '-75.1681', '51');
INSERT INTO `ubigeo` VALUES ('110305', 'Vista Alegre', 'Nazca', 'Ica', '-14.8453', '-74.9469', '51');
INSERT INTO `ubigeo` VALUES ('110401', 'Palpa', 'Palpa', 'Ica', '-14.5339', '-75.1839', '51');
INSERT INTO `ubigeo` VALUES ('110402', 'Llipata', 'Palpa', 'Ica', '-14.5636', '-75.2078', '51');
INSERT INTO `ubigeo` VALUES ('110403', 'Rio Grande', 'Palpa', 'Ica', '-14.5194', '-75.2006', '51');
INSERT INTO `ubigeo` VALUES ('110404', 'Santa Cruz', 'Palpa', 'Ica', '-14.4914', '-75.2639', '51');
INSERT INTO `ubigeo` VALUES ('110405', 'Tibillo', 'Palpa', 'Ica', '-14.0931', '-75.1728', '51');
INSERT INTO `ubigeo` VALUES ('110501', 'Pisco', 'Pisco', 'Ica', '-13.7086', '-76.2075', '51');
INSERT INTO `ubigeo` VALUES ('110502', 'Huancano', 'Pisco', 'Ica', '-13.5992', '-75.6203', '51');
INSERT INTO `ubigeo` VALUES ('110503', 'Humay', 'Pisco', 'Ica', '-13.7222', '-75.885', '51');
INSERT INTO `ubigeo` VALUES ('110504', 'Independencia', 'Pisco', 'Ica', '-13.6939', '-76.0256', '51');
INSERT INTO `ubigeo` VALUES ('110505', 'Paracas', 'Pisco', 'Ica', '-13.8428', '-76.2503', '51');
INSERT INTO `ubigeo` VALUES ('110506', 'San Andres', 'Pisco', 'Ica', '-13.7311', '-76.2211', '51');
INSERT INTO `ubigeo` VALUES ('110507', 'San Clemente', 'Pisco', 'Ica', '-13.6839', '-76.1592', '51');
INSERT INTO `ubigeo` VALUES ('110508', 'Tupac Amaru Inca', 'Pisco', 'Ica', '-13.7119', '-76.1492', '51');
INSERT INTO `ubigeo` VALUES ('120101', 'Huancayo', 'Huancayo', 'Junin', '-12.0703', '-75.2139', '51');
INSERT INTO `ubigeo` VALUES ('120104', 'Carhuacallanga', 'Huancayo', 'Junin', '-12.3544', '-75.2033', '51');
INSERT INTO `ubigeo` VALUES ('120105', 'Chacapampa', 'Huancayo', 'Junin', '-12.3444', '-75.2472', '51');
INSERT INTO `ubigeo` VALUES ('120106', 'Chicche', 'Huancayo', 'Junin', '-12.2961', '-75.2964', '51');
INSERT INTO `ubigeo` VALUES ('120107', 'Chilca', 'Huancayo', 'Junin', '-12.0817', '-75.2028', '51');
INSERT INTO `ubigeo` VALUES ('120108', 'Chongos Alto', 'Huancayo', 'Junin', '-12.3128', '-75.2925', '51');
INSERT INTO `ubigeo` VALUES ('120111', 'Chupuro', 'Huancayo', 'Junin', '-12.1561', '-75.245', '51');
INSERT INTO `ubigeo` VALUES ('120112', 'Colca', 'Huancayo', 'Junin', '-12.3169', '-75.2258', '51');
INSERT INTO `ubigeo` VALUES ('120113', 'Cullhuas', 'Huancayo', 'Junin', '-12.2233', '-75.1747', '51');
INSERT INTO `ubigeo` VALUES ('120114', 'El Tambo', 'Huancayo', 'Junin', '-12.055', '-75.2206', '51');
INSERT INTO `ubigeo` VALUES ('120116', 'Huacrapuquio', 'Huancayo', 'Junin', '-12.1725', '-75.2236', '51');
INSERT INTO `ubigeo` VALUES ('120117', 'Hualhuas', 'Huancayo', 'Junin', '-11.9692', '-75.2536', '51');
INSERT INTO `ubigeo` VALUES ('120119', 'Huancan', 'Huancayo', 'Junin', '-12.1064', '-75.2186', '51');
INSERT INTO `ubigeo` VALUES ('120120', 'Huasicancha', 'Huancayo', 'Junin', '-12.3331', '-75.2844', '51');
INSERT INTO `ubigeo` VALUES ('120121', 'Huayucachi', 'Huancayo', 'Junin', '-12.1367', '-75.2247', '51');
INSERT INTO `ubigeo` VALUES ('120122', 'Ingenio', 'Huancayo', 'Junin', '-11.8903', '-75.2686', '51');
INSERT INTO `ubigeo` VALUES ('120124', 'Pariahuanca', 'Huancayo', 'Junin', '-11.9792', '-74.8967', '51');
INSERT INTO `ubigeo` VALUES ('120125', 'Pilcomayo', 'Huancayo', 'Junin', '-12.0497', '-75.2528', '51');
INSERT INTO `ubigeo` VALUES ('120126', 'Pucara', 'Huancayo', 'Junin', '-12.1719', '-75.1475', '51');
INSERT INTO `ubigeo` VALUES ('120127', 'Quichuay', 'Huancayo', 'Junin', '-11.8875', '-75.2872', '51');
INSERT INTO `ubigeo` VALUES ('120128', 'Quilcas', 'Huancayo', 'Junin', '-11.9383', '-75.2611', '51');
INSERT INTO `ubigeo` VALUES ('120129', 'San Agustin', 'Huancayo', 'Junin', '-11.9914', '-75.2481', '51');
INSERT INTO `ubigeo` VALUES ('120130', 'San Jeronimo de Tunan', 'Huancayo', 'Junin', '-11.9483', '-75.2856', '51');
INSERT INTO `ubigeo` VALUES ('120132', 'Saño', 'Huancayo', 'Junin', '-11.955', '-75.2606', '51');
INSERT INTO `ubigeo` VALUES ('120133', 'Sapallanga', 'Huancayo', 'Junin', '-12.1403', '-75.1597', '51');
INSERT INTO `ubigeo` VALUES ('120134', 'Sicaya', 'Huancayo', 'Junin', '-12.0125', '-75.2833', '51');
INSERT INTO `ubigeo` VALUES ('120135', 'Santo Domingo de Acobamba', 'Huancayo', 'Junin', '-11.7689', '-74.7953', '51');
INSERT INTO `ubigeo` VALUES ('120136', 'Viques', 'Huancayo', 'Junin', '-12.1603', '-75.2342', '51');
INSERT INTO `ubigeo` VALUES ('120201', 'Concepcion', 'Concepcion', 'Junin', '-11.9181', '-75.3161', '51');
INSERT INTO `ubigeo` VALUES ('120202', 'Aco', 'Concepcion', 'Junin', '-11.9594', '-75.3636', '51');
INSERT INTO `ubigeo` VALUES ('120203', 'Andamarca', 'Concepcion', 'Junin', '-11.7319', '-74.8058', '51');
INSERT INTO `ubigeo` VALUES ('120204', 'Chambara', 'Concepcion', 'Junin', '-12.0286', '-75.3783', '51');
INSERT INTO `ubigeo` VALUES ('120205', 'Cochas', 'Concepcion', 'Junin', '-11.6597', '-75.1033', '51');
INSERT INTO `ubigeo` VALUES ('120206', 'Comas', 'Concepcion', 'Junin', '-11.7183', '-75.0839', '51');
INSERT INTO `ubigeo` VALUES ('120207', 'Heroinas Toledo', 'Concepcion', 'Junin', '-11.8353', '-75.2911', '51');
INSERT INTO `ubigeo` VALUES ('120208', 'Manzanares', 'Concepcion', 'Junin', '-12.0217', '-75.3489', '51');
INSERT INTO `ubigeo` VALUES ('120209', 'Mariscal Castilla', 'Concepcion', 'Junin', '-11.6158', '-75.0942', '51');
INSERT INTO `ubigeo` VALUES ('120210', 'Matahuasi', 'Concepcion', 'Junin', '-11.8917', '-75.3539', '51');
INSERT INTO `ubigeo` VALUES ('120211', 'Mito', 'Concepcion', 'Junin', '-11.9375', '-75.3417', '51');
INSERT INTO `ubigeo` VALUES ('120212', 'Nueve de Julio', 'Concepcion', 'Junin', '-11.9019', '-75.3217', '51');
INSERT INTO `ubigeo` VALUES ('120213', 'Orcotuna', 'Concepcion', 'Junin', '-11.9681', '-75.3131', '51');
INSERT INTO `ubigeo` VALUES ('120214', 'San Jose de Quero', 'Concepcion', 'Junin', '-12.0856', '-75.5383', '51');
INSERT INTO `ubigeo` VALUES ('120215', 'Santa Rosa de Ocopa', 'Concepcion', 'Junin', '-11.8769', '-75.2944', '51');
INSERT INTO `ubigeo` VALUES ('120301', 'Chanchamayo', 'Chanchamayo', 'Junin', '-11.0558', '-75.3292', '51');
INSERT INTO `ubigeo` VALUES ('120302', 'Perene', 'Chanchamayo', 'Junin', '-10.9522', '-75.2244', '51');
INSERT INTO `ubigeo` VALUES ('120303', 'Pichanaqui', 'Chanchamayo', 'Junin', '-10.9303', '-74.8728', '51');
INSERT INTO `ubigeo` VALUES ('120304', 'San Luis de Shuaro', 'Chanchamayo', 'Junin', '-10.8894', '-75.2911', '51');
INSERT INTO `ubigeo` VALUES ('120305', 'San Ramon', 'Chanchamayo', 'Junin', '-11.1214', '-75.3528', '51');
INSERT INTO `ubigeo` VALUES ('120306', 'Vitoc', 'Chanchamayo', 'Junin', '-11.2083', '-75.3372', '51');
INSERT INTO `ubigeo` VALUES ('120401', 'Jauja', 'Jauja', 'Junin', '-11.7761', '-75.4992', '51');
INSERT INTO `ubigeo` VALUES ('120402', 'Acolla', 'Jauja', 'Junin', '-11.7317', '-75.5489', '51');
INSERT INTO `ubigeo` VALUES ('120403', 'Apata', 'Jauja', 'Junin', '-11.8558', '-75.3569', '51');
INSERT INTO `ubigeo` VALUES ('120404', 'Ataura', 'Jauja', 'Junin', '-11.8022', '-75.4411', '51');
INSERT INTO `ubigeo` VALUES ('120405', 'Canchayllo', 'Jauja', 'Junin', '-11.8011', '-75.72', '51');
INSERT INTO `ubigeo` VALUES ('120406', 'Curicaca', 'Jauja', 'Junin', '-11.7842', '-75.6781', '51');
INSERT INTO `ubigeo` VALUES ('120407', 'El Mantaro', 'Jauja', 'Junin', '-11.8222', '-75.3942', '51');
INSERT INTO `ubigeo` VALUES ('120408', 'Huamali', 'Jauja', 'Junin', '-11.8083', '-75.4269', '51');
INSERT INTO `ubigeo` VALUES ('120409', 'Huaripampa', 'Jauja', 'Junin', '-11.8086', '-75.4739', '51');
INSERT INTO `ubigeo` VALUES ('120410', 'Huertas', 'Jauja', 'Junin', '-11.7686', '-75.4769', '51');
INSERT INTO `ubigeo` VALUES ('120411', 'Janjaillo', 'Jauja', 'Junin', '-11.7658', '-75.6275', '51');
INSERT INTO `ubigeo` VALUES ('120412', 'Julcan', 'Jauja', 'Junin', '-11.7608', '-75.4392', '51');
INSERT INTO `ubigeo` VALUES ('120413', 'Leonor Ordoñez', 'Jauja', 'Junin', '-11.8633', '-75.4169', '51');
INSERT INTO `ubigeo` VALUES ('120414', 'Llocllapampa', 'Jauja', 'Junin', '-11.8189', '-75.6261', '51');
INSERT INTO `ubigeo` VALUES ('120415', 'Marco', 'Jauja', 'Junin', '-11.7419', '-75.5639', '51');
INSERT INTO `ubigeo` VALUES ('120416', 'Masma', 'Jauja', 'Junin', '-11.7867', '-75.4289', '51');
INSERT INTO `ubigeo` VALUES ('120417', 'Masma Chicche', 'Jauja', 'Junin', '-11.7864', '-75.38', '51');
INSERT INTO `ubigeo` VALUES ('120418', 'Molinos', 'Jauja', 'Junin', '-11.7378', '-75.4467', '51');
INSERT INTO `ubigeo` VALUES ('120419', 'Monobamba', 'Jauja', 'Junin', '-11.3606', '-75.3278', '51');
INSERT INTO `ubigeo` VALUES ('120420', 'Muqui', 'Jauja', 'Junin', '-11.8342', '-75.4369', '51');
INSERT INTO `ubigeo` VALUES ('120421', 'Muquiyauyo', 'Jauja', 'Junin', '-11.8147', '-75.4581', '51');
INSERT INTO `ubigeo` VALUES ('120422', 'Paca', 'Jauja', 'Junin', '-11.7117', '-75.5189', '51');
INSERT INTO `ubigeo` VALUES ('120423', 'Paccha', 'Jauja', 'Junin', '-11.8553', '-75.5111', '51');
INSERT INTO `ubigeo` VALUES ('120424', 'Pancan', 'Jauja', 'Junin', '-11.7503', '-75.4883', '51');
INSERT INTO `ubigeo` VALUES ('120425', 'Parco', 'Jauja', 'Junin', '-11.8022', '-75.5469', '51');
INSERT INTO `ubigeo` VALUES ('120426', 'Pomacancha', 'Jauja', 'Junin', '-11.7381', '-75.6264', '51');
INSERT INTO `ubigeo` VALUES ('120427', 'Ricran', 'Jauja', 'Junin', '-11.5411', '-75.5289', '51');
INSERT INTO `ubigeo` VALUES ('120428', 'San Lorenzo', 'Jauja', 'Junin', '-11.8472', '-75.3842', '51');
INSERT INTO `ubigeo` VALUES ('120429', 'San Pedro de Chunan', 'Jauja', 'Junin', '-11.7247', '-75.4894', '51');
INSERT INTO `ubigeo` VALUES ('120430', 'Sausa', 'Jauja', 'Junin', '-11.7939', '-75.4872', '51');
INSERT INTO `ubigeo` VALUES ('120431', 'Sincos', 'Jauja', 'Junin', '-11.8917', '-75.3903', '51');
INSERT INTO `ubigeo` VALUES ('120432', 'Tunan Marca', 'Jauja', 'Junin', '-11.7269', '-75.5731', '51');
INSERT INTO `ubigeo` VALUES ('120433', 'Yauli', 'Jauja', 'Junin', '-11.7117', '-75.4725', '51');
INSERT INTO `ubigeo` VALUES ('120434', 'Yauyos', 'Jauja', 'Junin', '-11.7822', '-75.4989', '51');
INSERT INTO `ubigeo` VALUES ('120501', 'Junin', 'Junin', 'Junin', '-11.1597', '-75.9956', '51');
INSERT INTO `ubigeo` VALUES ('120502', 'Carhuamayo', 'Junin', 'Junin', '-10.9233', '-76.0569', '51');
INSERT INTO `ubigeo` VALUES ('120503', 'Ondores', 'Junin', 'Junin', '-11.0878', '-76.1486', '51');
INSERT INTO `ubigeo` VALUES ('120504', 'Ulcumayo', 'Junin', 'Junin', '-10.9689', '-75.8778', '51');
INSERT INTO `ubigeo` VALUES ('120601', 'Satipo', 'Satipo', 'Junin', '-11.2531', '-74.6372', '51');
INSERT INTO `ubigeo` VALUES ('120602', 'Coviriali', 'Satipo', 'Junin', '-11.2906', '-74.6283', '51');
INSERT INTO `ubigeo` VALUES ('120603', 'Llaylla', 'Satipo', 'Junin', '-11.3808', '-74.5906', '51');
INSERT INTO `ubigeo` VALUES ('120604', 'Mazamari', 'Satipo', 'Junin', '-11.4056', '-74.7519', '51');
INSERT INTO `ubigeo` VALUES ('120605', 'Pampa Hermosa', 'Satipo', 'Junin', '-11.4056', '-74.7519', '51');
INSERT INTO `ubigeo` VALUES ('120606', 'Pangoa', 'Satipo', 'Junin', '-11.2086', '-74.6597', '51');
INSERT INTO `ubigeo` VALUES ('120607', 'Rio Negro', 'Satipo', 'Junin', '-11.1469', '-74.31', '51');
INSERT INTO `ubigeo` VALUES ('120608', 'Rio Tambo', 'Satipo', 'Junin', '-11.2531', '-74.6372', '51');
INSERT INTO `ubigeo` VALUES ('120609', 'Vizcatán del Ene', 'Satipo', 'Junin', '-12.2153', '-74.0158', '51');
INSERT INTO `ubigeo` VALUES ('120701', 'Tarma', 'Tarma', 'Junin', '-11.4206', '-75.6908', '51');
INSERT INTO `ubigeo` VALUES ('120702', 'Acobamba', 'Tarma', 'Junin', '-11.3528', '-75.6592', '51');
INSERT INTO `ubigeo` VALUES ('120703', 'Huaricolca', 'Tarma', 'Junin', '-11.5089', '-75.6514', '51');
INSERT INTO `ubigeo` VALUES ('120704', 'Huasahuasi', 'Tarma', 'Junin', '-11.2667', '-75.6522', '51');
INSERT INTO `ubigeo` VALUES ('120705', 'La Union', 'Tarma', 'Junin', '-11.3756', '-75.7547', '51');
INSERT INTO `ubigeo` VALUES ('120706', 'Palca', 'Tarma', 'Junin', '-11.3469', '-75.5681', '51');
INSERT INTO `ubigeo` VALUES ('120707', 'Palcamayo', 'Tarma', 'Junin', '-11.2956', '-75.7731', '51');
INSERT INTO `ubigeo` VALUES ('120708', 'San Pedro de Cajas', 'Tarma', 'Junin', '-11.2503', '-75.8647', '51');
INSERT INTO `ubigeo` VALUES ('120709', 'Tapo', 'Tarma', 'Junin', '-11.3903', '-75.5636', '51');
INSERT INTO `ubigeo` VALUES ('120801', 'La Oroya', 'Yauli', 'Junin', '-11.5206', '-75.9014', '51');
INSERT INTO `ubigeo` VALUES ('120802', 'Chacapalpa', 'Yauli', 'Junin', '-11.7328', '-75.7556', '51');
INSERT INTO `ubigeo` VALUES ('120803', 'Huay-Huay', 'Yauli', 'Junin', '-11.7219', '-75.9042', '51');
INSERT INTO `ubigeo` VALUES ('120804', 'Marcapomacocha', 'Yauli', 'Junin', '-11.4056', '-76.3364', '51');
INSERT INTO `ubigeo` VALUES ('120805', 'Morococha', 'Yauli', 'Junin', '-11.5972', '-76.14', '51');
INSERT INTO `ubigeo` VALUES ('120806', 'Paccha', 'Yauli', 'Junin', '-11.4794', '-75.9669', '51');
INSERT INTO `ubigeo` VALUES ('120807', 'Santa Barbara de Carhuacayan', 'Yauli', 'Junin', '-11.2008', '-76.2883', '51');
INSERT INTO `ubigeo` VALUES ('120808', 'Santa Rosa de Sacco', 'Yauli', 'Junin', '-11.5617', '-75.95', '51');
INSERT INTO `ubigeo` VALUES ('120809', 'Suitucancha', 'Yauli', 'Junin', '-11.7875', '-75.9358', '51');
INSERT INTO `ubigeo` VALUES ('120810', 'Yauli', 'Yauli', 'Junin', '-11.6672', '-76.0883', '51');
INSERT INTO `ubigeo` VALUES ('120901', 'Chupaca', 'Chupaca', 'Junin', '-12.0625', '-75.2897', '51');
INSERT INTO `ubigeo` VALUES ('120902', 'Ahuac', 'Chupaca', 'Junin', '-12.0789', '-75.3197', '51');
INSERT INTO `ubigeo` VALUES ('120903', 'Chongos Bajo', 'Chupaca', 'Junin', '-12.1361', '-75.2681', '51');
INSERT INTO `ubigeo` VALUES ('120904', 'Huachac', 'Chupaca', 'Junin', '-12.0225', '-75.3436', '51');
INSERT INTO `ubigeo` VALUES ('120905', 'Huamancaca Chico', 'Chupaca', 'Junin', '-12.0797', '-75.245', '51');
INSERT INTO `ubigeo` VALUES ('120906', 'San Juan de Yscos', 'Chupaca', 'Junin', '-12.1014', '-75.2922', '51');
INSERT INTO `ubigeo` VALUES ('120907', 'San Juan de Jarpa', 'Chupaca', 'Junin', '-12.1239', '-75.44', '51');
INSERT INTO `ubigeo` VALUES ('120908', 'Tres de Diciembre', 'Chupaca', 'Junin', '-12.1108', '-75.2547', '51');
INSERT INTO `ubigeo` VALUES ('120909', 'Yanacancha', 'Chupaca', 'Junin', '-12.2008', '-75.3864', '51');
INSERT INTO `ubigeo` VALUES ('130101', 'Trujillo', 'Trujillo', 'La Libertad', '-8.1094', '-79.0333', '51');
INSERT INTO `ubigeo` VALUES ('130102', 'El Porvenir', 'Trujillo', 'La Libertad', '-8.0819', '-79.0025', '51');
INSERT INTO `ubigeo` VALUES ('130103', 'Florencia de Mora', 'Trujillo', 'La Libertad', '-8.0808', '-79.0236', '51');
INSERT INTO `ubigeo` VALUES ('130104', 'Huanchaco', 'Trujillo', 'La Libertad', '-8.0814', '-79.1214', '51');
INSERT INTO `ubigeo` VALUES ('130105', 'La Esperanza', 'Trujillo', 'La Libertad', '-8.0781', '-79.0453', '51');
INSERT INTO `ubigeo` VALUES ('130106', 'Laredo', 'Trujillo', 'La Libertad', '-8.0911', '-78.9611', '51');
INSERT INTO `ubigeo` VALUES ('130107', 'Moche', 'Trujillo', 'La Libertad', '-8.1722', '-79.0111', '51');
INSERT INTO `ubigeo` VALUES ('130108', 'Poroto', 'Trujillo', 'La Libertad', '-8.0114', '-78.7697', '51');
INSERT INTO `ubigeo` VALUES ('130109', 'Salaverry', 'Trujillo', 'La Libertad', '-8.2231', '-78.9781', '51');
INSERT INTO `ubigeo` VALUES ('130110', 'Simbal', 'Trujillo', 'La Libertad', '-7.9767', '-78.8147', '51');
INSERT INTO `ubigeo` VALUES ('130111', 'Victor Larco Herrera', 'Trujillo', 'La Libertad', '-8.1439', '-79.0558', '51');
INSERT INTO `ubigeo` VALUES ('130201', 'Ascope', 'Ascope', 'La Libertad', '-7.7131', '-79.1156', '51');
INSERT INTO `ubigeo` VALUES ('130202', 'Chicama', 'Ascope', 'La Libertad', '-7.8442', '-79.1461', '51');
INSERT INTO `ubigeo` VALUES ('130203', 'Chocope', 'Ascope', 'La Libertad', '-7.7914', '-79.2225', '51');
INSERT INTO `ubigeo` VALUES ('130204', 'Magdalena de Cao', 'Ascope', 'La Libertad', '-7.8767', '-79.2947', '51');
INSERT INTO `ubigeo` VALUES ('130205', 'Paijan', 'Ascope', 'La Libertad', '-7.7319', '-79.3019', '51');
INSERT INTO `ubigeo` VALUES ('130206', 'Razuri', 'Ascope', 'La Libertad', '-7.7025', '-79.4406', '51');
INSERT INTO `ubigeo` VALUES ('130207', 'Santiago de Cao', 'Ascope', 'La Libertad', '-7.9608', '-79.2392', '51');
INSERT INTO `ubigeo` VALUES ('130208', 'Casa Grande', 'Ascope', 'La Libertad', '-7.7442', '-79.1869', '51');
INSERT INTO `ubigeo` VALUES ('130301', 'Bolivar', 'Bolivar', 'La Libertad', '-7.1547', '-77.7044', '51');
INSERT INTO `ubigeo` VALUES ('130302', 'Bambamarca', 'Bolivar', 'La Libertad', '-7.4414', '-77.6947', '51');
INSERT INTO `ubigeo` VALUES ('130303', 'Condormarca', 'Bolivar', 'La Libertad', '-7.5556', '-77.5981', '51');
INSERT INTO `ubigeo` VALUES ('130304', 'Longotea', 'Bolivar', 'La Libertad', '-7.0428', '-77.8744', '51');
INSERT INTO `ubigeo` VALUES ('130305', 'Uchumarca', 'Bolivar', 'La Libertad', '-7.0481', '-77.8078', '51');
INSERT INTO `ubigeo` VALUES ('130306', 'Ucuncha', 'Bolivar', 'La Libertad', '-7.1656', '-77.8617', '51');
INSERT INTO `ubigeo` VALUES ('130401', 'Chepen', 'Chepen', 'La Libertad', '-7.2267', '-79.4292', '51');
INSERT INTO `ubigeo` VALUES ('130402', 'Pacanga', 'Chepen', 'La Libertad', '-7.1731', '-79.4867', '51');
INSERT INTO `ubigeo` VALUES ('130403', 'Pueblo Nuevo', 'Chepen', 'La Libertad', '-7.1883', '-79.5142', '51');
INSERT INTO `ubigeo` VALUES ('130501', 'Julcan', 'Julcan', 'La Libertad', '-8.0439', '-78.4881', '51');
INSERT INTO `ubigeo` VALUES ('130502', 'Calamarca', 'Julcan', 'La Libertad', '-8.1644', '-78.4153', '51');
INSERT INTO `ubigeo` VALUES ('130503', 'Carabamba', 'Julcan', 'La Libertad', '-8.1108', '-78.6092', '51');
INSERT INTO `ubigeo` VALUES ('130504', 'Huaso', 'Julcan', 'La Libertad', '-8.2233', '-78.4158', '51');
INSERT INTO `ubigeo` VALUES ('130601', 'Otuzco', 'Otuzco', 'La Libertad', '-7.9022', '-78.5669', '51');
INSERT INTO `ubigeo` VALUES ('130602', 'Agallpampa', 'Otuzco', 'La Libertad', '-7.9853', '-78.5481', '51');
INSERT INTO `ubigeo` VALUES ('130604', 'Charat', 'Otuzco', 'La Libertad', '-7.8247', '-78.4506', '51');
INSERT INTO `ubigeo` VALUES ('130605', 'Huaranchal', 'Otuzco', 'La Libertad', '-7.6908', '-78.4444', '51');
INSERT INTO `ubigeo` VALUES ('130606', 'La Cuesta', 'Otuzco', 'La Libertad', '-7.9189', '-78.7081', '51');
INSERT INTO `ubigeo` VALUES ('130608', 'Mache', 'Otuzco', 'La Libertad', '-8.0303', '-78.5367', '51');
INSERT INTO `ubigeo` VALUES ('130610', 'Paranday', 'Otuzco', 'La Libertad', '-7.8847', '-78.7119', '51');
INSERT INTO `ubigeo` VALUES ('130611', 'Salpo', 'Otuzco', 'La Libertad', '-8.0053', '-78.6064', '51');
INSERT INTO `ubigeo` VALUES ('130613', 'Sinsicap', 'Otuzco', 'La Libertad', '-7.8517', '-78.7561', '51');
INSERT INTO `ubigeo` VALUES ('130614', 'Usquil', 'Otuzco', 'La Libertad', '-7.8156', '-78.4192', '51');
INSERT INTO `ubigeo` VALUES ('130701', 'San Pedro de Lloc', 'Pacasmayo', 'La Libertad', '-7.4278', '-79.5036', '51');
INSERT INTO `ubigeo` VALUES ('130702', 'Guadalupe', 'Pacasmayo', 'La Libertad', '-7.2428', '-79.4717', '51');
INSERT INTO `ubigeo` VALUES ('130703', 'Jequetepeque', 'Pacasmayo', 'La Libertad', '-7.3369', '-79.5628', '51');
INSERT INTO `ubigeo` VALUES ('130704', 'Pacasmayo', 'Pacasmayo', 'La Libertad', '-7.4006', '-79.5686', '51');
INSERT INTO `ubigeo` VALUES ('130705', 'San Jose', 'Pacasmayo', 'La Libertad', '-7.3494', '-79.4569', '51');
INSERT INTO `ubigeo` VALUES ('130801', 'Tayabamba', 'Pataz', 'La Libertad', '-8.2769', '-77.2986', '51');
INSERT INTO `ubigeo` VALUES ('130802', 'Buldibuyo', 'Pataz', 'La Libertad', '-8.1281', '-77.3981', '51');
INSERT INTO `ubigeo` VALUES ('130803', 'Chillia', 'Pataz', 'La Libertad', '-8.1258', '-77.5169', '51');
INSERT INTO `ubigeo` VALUES ('130804', 'Huancaspata', 'Pataz', 'La Libertad', '-8.4575', '-77.3011', '51');
INSERT INTO `ubigeo` VALUES ('130805', 'Huaylillas', 'Pataz', 'La Libertad', '-8.1867', '-77.3447', '51');
INSERT INTO `ubigeo` VALUES ('130806', 'Huayo', 'Pataz', 'La Libertad', '-8.0053', '-77.5936', '51');
INSERT INTO `ubigeo` VALUES ('130807', 'Ongon', 'Pataz', 'La Libertad', '-8.1689', '-76.9664', '51');
INSERT INTO `ubigeo` VALUES ('130808', 'Parcoy', 'Pataz', 'La Libertad', '-8.035', '-77.4817', '51');
INSERT INTO `ubigeo` VALUES ('130809', 'Pataz', 'Pataz', 'La Libertad', '-7.7856', '-77.5942', '51');
INSERT INTO `ubigeo` VALUES ('130810', 'Pias', 'Pataz', 'La Libertad', '-7.8728', '-77.5494', '51');
INSERT INTO `ubigeo` VALUES ('130811', 'Santiago de Challas', 'Pataz', 'La Libertad', '-8.4389', '-77.3239', '51');
INSERT INTO `ubigeo` VALUES ('130812', 'Taurija', 'Pataz', 'La Libertad', '-8.3083', '-77.425', '51');
INSERT INTO `ubigeo` VALUES ('130813', 'Urpay', 'Pataz', 'La Libertad', '-8.3478', '-77.3917', '51');
INSERT INTO `ubigeo` VALUES ('130901', 'Huamachuco', 'Sanchez Carrion', 'La Libertad', '-7.8153', '-78.0525', '51');
INSERT INTO `ubigeo` VALUES ('130902', 'Chugay', 'Sanchez Carrion', 'La Libertad', '-7.7825', '-77.8694', '51');
INSERT INTO `ubigeo` VALUES ('130903', 'Cochorco', 'Sanchez Carrion', 'La Libertad', '-7.8058', '-77.72', '51');
INSERT INTO `ubigeo` VALUES ('130904', 'Curgos', 'Sanchez Carrion', 'La Libertad', '-7.8592', '-77.9431', '51');
INSERT INTO `ubigeo` VALUES ('130905', 'Marcabal', 'Sanchez Carrion', 'La Libertad', '-7.7053', '-78.0306', '51');
INSERT INTO `ubigeo` VALUES ('130906', 'Sanagoran', 'Sanchez Carrion', 'La Libertad', '-7.7856', '-78.1411', '51');
INSERT INTO `ubigeo` VALUES ('130907', 'Sarin', 'Sanchez Carrion', 'La Libertad', '-7.9122', '-77.9044', '51');
INSERT INTO `ubigeo` VALUES ('130908', 'Sartimbamba', 'Sanchez Carrion', 'La Libertad', '-7.6994', '-77.7411', '51');
INSERT INTO `ubigeo` VALUES ('131001', 'Santiago de Chuco', 'Santiago de Chuco', 'La Libertad', '-8.1456', '-78.1753', '51');
INSERT INTO `ubigeo` VALUES ('131002', 'Angasmarca', 'Santiago de Chuco', 'La Libertad', '-8.1331', '-78.0547', '51');
INSERT INTO `ubigeo` VALUES ('131003', 'Cachicadan', 'Santiago de Chuco', 'La Libertad', '-8.0917', '-78.1467', '51');
INSERT INTO `ubigeo` VALUES ('131004', 'Mollebamba', 'Santiago de Chuco', 'La Libertad', '-8.1706', '-77.9764', '51');
INSERT INTO `ubigeo` VALUES ('131005', 'Mollepata', 'Santiago de Chuco', 'La Libertad', '-8.1908', '-77.9558', '51');
INSERT INTO `ubigeo` VALUES ('131006', 'Quiruvilca', 'Santiago de Chuco', 'La Libertad', '-8.0025', '-78.3108', '51');
INSERT INTO `ubigeo` VALUES ('131007', 'Santa Cruz de Chuca', 'Santiago de Chuco', 'La Libertad', '-8.1194', '-78.1411', '51');
INSERT INTO `ubigeo` VALUES ('131008', 'Sitabamba', 'Santiago de Chuco', 'La Libertad', '-8.0231', '-77.7314', '51');
INSERT INTO `ubigeo` VALUES ('131101', 'Cascas', 'Gran Chimu', 'La Libertad', '-7.4803', '-78.8167', '51');
INSERT INTO `ubigeo` VALUES ('131102', 'Lucma', 'Gran Chimu', 'La Libertad', '-7.6406', '-78.5511', '51');
INSERT INTO `ubigeo` VALUES ('131103', 'Compin', 'Gran Chimu', 'La Libertad', '-7.6981', '-78.6256', '51');
INSERT INTO `ubigeo` VALUES ('131104', 'Sayapullo', 'Gran Chimu', 'La Libertad', '-7.5964', '-78.4681', '51');
INSERT INTO `ubigeo` VALUES ('131201', 'Viru', 'Viru', 'La Libertad', '-8.4156', '-78.7511', '51');
INSERT INTO `ubigeo` VALUES ('131202', 'Chao', 'Viru', 'La Libertad', '-8.5394', '-78.6825', '51');
INSERT INTO `ubigeo` VALUES ('131203', 'Guadalupito', 'Viru', 'La Libertad', '-8.9519', '-78.6258', '51');
INSERT INTO `ubigeo` VALUES ('140101', 'Chiclayo', 'Chiclayo', 'Lambayeque', '-6.7736', '-79.8397', '51');
INSERT INTO `ubigeo` VALUES ('140102', 'Chongoyape', 'Chiclayo', 'Lambayeque', '-6.6428', '-79.3842', '51');
INSERT INTO `ubigeo` VALUES ('140103', 'Eten', 'Chiclayo', 'Lambayeque', '-6.9072', '-79.8644', '51');
INSERT INTO `ubigeo` VALUES ('140104', 'Eten Puerto', 'Chiclayo', 'Lambayeque', '-6.9269', '-79.8664', '51');
INSERT INTO `ubigeo` VALUES ('140105', 'Jose Leonardo Ortiz', 'Chiclayo', 'Lambayeque', '-6.7592', '-79.8408', '51');
INSERT INTO `ubigeo` VALUES ('140106', 'La Victoria', 'Chiclayo', 'Lambayeque', '-6.7883', '-79.8367', '51');
INSERT INTO `ubigeo` VALUES ('140107', 'Lagunas', 'Chiclayo', 'Lambayeque', '-6.9911', '-79.6244', '51');
INSERT INTO `ubigeo` VALUES ('140108', 'Monsefu', 'Chiclayo', 'Lambayeque', '-6.8786', '-79.8714', '51');
INSERT INTO `ubigeo` VALUES ('140109', 'Nueva Arica', 'Chiclayo', 'Lambayeque', '-6.8731', '-79.3386', '51');
INSERT INTO `ubigeo` VALUES ('140110', 'Oyotun', 'Chiclayo', 'Lambayeque', '-6.8458', '-79.2981', '51');
INSERT INTO `ubigeo` VALUES ('140111', 'Picsi', 'Chiclayo', 'Lambayeque', '-6.7186', '-79.7708', '51');
INSERT INTO `ubigeo` VALUES ('140112', 'Pimentel', 'Chiclayo', 'Lambayeque', '-6.8369', '-79.9361', '51');
INSERT INTO `ubigeo` VALUES ('140113', 'Reque', 'Chiclayo', 'Lambayeque', '-6.8644', '-79.8181', '51');
INSERT INTO `ubigeo` VALUES ('140114', 'Santa Rosa', 'Chiclayo', 'Lambayeque', '-6.88', '-79.9231', '51');
INSERT INTO `ubigeo` VALUES ('140115', 'Saña', 'Chiclayo', 'Lambayeque', '-6.9233', '-79.5839', '51');
INSERT INTO `ubigeo` VALUES ('140116', 'Cayalti', 'Chiclayo', 'Lambayeque', '-6.8917', '-79.5617', '51');
INSERT INTO `ubigeo` VALUES ('140117', 'Patapo', 'Chiclayo', 'Lambayeque', '-6.7386', '-79.6406', '51');
INSERT INTO `ubigeo` VALUES ('140118', 'Pomalca', 'Chiclayo', 'Lambayeque', '-6.7667', '-79.7728', '51');
INSERT INTO `ubigeo` VALUES ('140119', 'Pucala', 'Chiclayo', 'Lambayeque', '-6.78', '-79.6122', '51');
INSERT INTO `ubigeo` VALUES ('140120', 'Tuman', 'Chiclayo', 'Lambayeque', '-6.7478', '-79.7017', '51');
INSERT INTO `ubigeo` VALUES ('140201', 'Ferreñafe', 'Ferreñafe', 'Lambayeque', '-6.6394', '-79.7911', '51');
INSERT INTO `ubigeo` VALUES ('140202', 'Cañaris', 'Ferreñafe', 'Lambayeque', '-6.0447', '-79.2647', '51');
INSERT INTO `ubigeo` VALUES ('140203', 'Incahuasi', 'Ferreñafe', 'Lambayeque', '-6.2372', '-79.315', '51');
INSERT INTO `ubigeo` VALUES ('140204', 'Manuel Antonio Mesones Muro', 'Ferreñafe', 'Lambayeque', '-6.6456', '-79.7361', '51');
INSERT INTO `ubigeo` VALUES ('140205', 'Pitipo', 'Ferreñafe', 'Lambayeque', '-6.5664', '-79.7808', '51');
INSERT INTO `ubigeo` VALUES ('140206', 'Pueblo Nuevo', 'Ferreñafe', 'Lambayeque', '-6.6367', '-79.7947', '51');
INSERT INTO `ubigeo` VALUES ('140301', 'Lambayeque', 'Lambayeque', 'Lambayeque', '-6.7006', '-79.9072', '51');
INSERT INTO `ubigeo` VALUES ('140302', 'Chochope', 'Lambayeque', 'Lambayeque', '-6.1586', '-79.6469', '51');
INSERT INTO `ubigeo` VALUES ('140303', 'Illimo', 'Lambayeque', 'Lambayeque', '-6.4733', '-79.8531', '51');
INSERT INTO `ubigeo` VALUES ('140304', 'Jayanca', 'Lambayeque', 'Lambayeque', '-6.3881', '-79.8211', '51');
INSERT INTO `ubigeo` VALUES ('140305', 'Mochumi', 'Lambayeque', 'Lambayeque', '-6.5467', '-79.8647', '51');
INSERT INTO `ubigeo` VALUES ('140306', 'Morrope', 'Lambayeque', 'Lambayeque', '-6.54', '-80.0128', '51');
INSERT INTO `ubigeo` VALUES ('140307', 'Motupe', 'Lambayeque', 'Lambayeque', '-6.1536', '-79.7153', '51');
INSERT INTO `ubigeo` VALUES ('140308', 'Olmos', 'Lambayeque', 'Lambayeque', '-5.9883', '-79.75', '51');
INSERT INTO `ubigeo` VALUES ('140309', 'Pacora', 'Lambayeque', 'Lambayeque', '-6.4275', '-79.84', '51');
INSERT INTO `ubigeo` VALUES ('140310', 'Salas', 'Lambayeque', 'Lambayeque', '-6.2736', '-79.6044', '51');
INSERT INTO `ubigeo` VALUES ('140311', 'San Jose', 'Lambayeque', 'Lambayeque', '-6.7703', '-79.9686', '51');
INSERT INTO `ubigeo` VALUES ('140312', 'Tucume', 'Lambayeque', 'Lambayeque', '-6.5097', '-79.8594', '51');
INSERT INTO `ubigeo` VALUES ('150101', 'Lima', 'Lima', 'Lima', '-12.0467', '-77.0322', '51');
INSERT INTO `ubigeo` VALUES ('150102', 'Ancon', 'Lima', 'Lima', '-11.7764', '-77.1703', '51');
INSERT INTO `ubigeo` VALUES ('150103', 'Ate', 'Lima', 'Lima', '-12.0256', '-76.9242', '51');
INSERT INTO `ubigeo` VALUES ('150104', 'Barranco', 'Lima', 'Lima', '-12.1494', '-77.0247', '51');
INSERT INTO `ubigeo` VALUES ('150105', 'Breña', 'Lima', 'Lima', '-12.0567', '-77.0536', '51');
INSERT INTO `ubigeo` VALUES ('150106', 'Carabayllo', 'Lima', 'Lima', '-11.8583', '-77.0419', '51');
INSERT INTO `ubigeo` VALUES ('150107', 'Chaclacayo', 'Lima', 'Lima', '-11.9783', '-76.7642', '51');
INSERT INTO `ubigeo` VALUES ('150108', 'Chorrillos', 'Lima', 'Lima', '-12.1742', '-77.0247', '51');
INSERT INTO `ubigeo` VALUES ('150109', 'Cieneguilla', 'Lima', 'Lima', '-12.1178', '-76.8125', '51');
INSERT INTO `ubigeo` VALUES ('150110', 'Comas', 'Lima', 'Lima', '-11.95', '-77.05', '51');
INSERT INTO `ubigeo` VALUES ('150111', 'El Agustino', 'Lima', 'Lima', '-12.0433', '-76.9986', '51');
INSERT INTO `ubigeo` VALUES ('150112', 'Independencia', 'Lima', 'Lima', '-12.0008', '-77.0522', '51');
INSERT INTO `ubigeo` VALUES ('150113', 'Jesus Maria', 'Lima', 'Lima', '-12.0697', '-77.045', '51');
INSERT INTO `ubigeo` VALUES ('150114', 'La Molina', 'Lima', 'Lima', '-12.0875', '-76.9339', '51');
INSERT INTO `ubigeo` VALUES ('150115', 'La Victoria', 'Lima', 'Lima', '-12.0653', '-77.0308', '51');
INSERT INTO `ubigeo` VALUES ('150116', 'Lince', 'Lima', 'Lima', '-12.0811', '-77.0306', '51');
INSERT INTO `ubigeo` VALUES ('150117', 'Los Olivos', 'Lima', 'Lima', '-11.9828', '-77.0694', '51');
INSERT INTO `ubigeo` VALUES ('150118', 'Lurigancho', 'Lima', 'Lima', '-11.9372', '-76.7036', '51');
INSERT INTO `ubigeo` VALUES ('150119', 'Lurin', 'Lima', 'Lima', '-12.2686', '-76.8847', '51');
INSERT INTO `ubigeo` VALUES ('150120', 'Magdalena del Mar', 'Lima', 'Lima', '-12.0967', '-77.0747', '51');
INSERT INTO `ubigeo` VALUES ('150121', 'Pueblo Libre', 'Lima', 'Lima', '-12.0733', '-77.0631', '51');
INSERT INTO `ubigeo` VALUES ('150122', 'Miraflores', 'Lima', 'Lima', '-12.1175', '-77.0453', '51');
INSERT INTO `ubigeo` VALUES ('150123', 'Pachacamac', 'Lima', 'Lima', '-12.2286', '-76.8597', '51');
INSERT INTO `ubigeo` VALUES ('150124', 'Pucusana', 'Lima', 'Lima', '-12.4825', '-76.7964', '51');
INSERT INTO `ubigeo` VALUES ('150125', 'Puente Piedra', 'Lima', 'Lima', '-11.8464', '-77.1058', '51');
INSERT INTO `ubigeo` VALUES ('150126', 'Punta Hermosa', 'Lima', 'Lima', '-12.3375', '-76.8258', '51');
INSERT INTO `ubigeo` VALUES ('150127', 'Punta Negra', 'Lima', 'Lima', '-12.3661', '-76.7947', '51');
INSERT INTO `ubigeo` VALUES ('150128', 'Rimac', 'Lima', 'Lima', '-12.0294', '-77.0436', '51');
INSERT INTO `ubigeo` VALUES ('150129', 'San Bartolo', 'Lima', 'Lima', '-12.3883', '-76.7806', '51');
INSERT INTO `ubigeo` VALUES ('150130', 'San Borja', 'Lima', 'Lima', '-12.1078', '-76.9989', '51');
INSERT INTO `ubigeo` VALUES ('150131', 'San Isidro', 'Lima', 'Lima', '-12.0989', '-77.0344', '51');
INSERT INTO `ubigeo` VALUES ('150132', 'San Juan de Lurigancho', 'Lima', 'Lima', '-12.0244', '-77.0025', '51');
INSERT INTO `ubigeo` VALUES ('150133', 'San Juan de Miraflores', 'Lima', 'Lima', '-12.1589', '-76.9722', '51');
INSERT INTO `ubigeo` VALUES ('150134', 'San Luis', 'Lima', 'Lima', '-12.0728', '-76.9975', '51');
INSERT INTO `ubigeo` VALUES ('150135', 'San Martin de Porres', 'Lima', 'Lima', '-12.0303', '-77.0469', '51');
INSERT INTO `ubigeo` VALUES ('150136', 'San Miguel', 'Lima', 'Lima', '-12.09', '-77.0864', '51');
INSERT INTO `ubigeo` VALUES ('150137', 'Santa Anita', 'Lima', 'Lima', '-12.0433', '-76.985', '51');
INSERT INTO `ubigeo` VALUES ('150138', 'Santa Maria del Mar', 'Lima', 'Lima', '-12.4092', '-76.7758', '51');
INSERT INTO `ubigeo` VALUES ('150139', 'Santa Rosa', 'Lima', 'Lima', '-11.7983', '-77.1775', '51');
INSERT INTO `ubigeo` VALUES ('150140', 'Santiago de Surco', 'Lima', 'Lima', '-12.1506', '-77.0078', '51');
INSERT INTO `ubigeo` VALUES ('150141', 'Surquillo', 'Lima', 'Lima', '-12.1136', '-77.0081', '51');
INSERT INTO `ubigeo` VALUES ('150142', 'Villa El Salvador', 'Lima', 'Lima', '-12.2164', '-76.9433', '51');
INSERT INTO `ubigeo` VALUES ('150143', 'Villa Maria del Triunfo', 'Lima', 'Lima', '-12.1572', '-76.9528', '51');
INSERT INTO `ubigeo` VALUES ('150201', 'Barranca', 'Barranca', 'Lima', '-10.7564', '-77.7603', '51');
INSERT INTO `ubigeo` VALUES ('150202', 'Paramonga', 'Barranca', 'Lima', '-10.6742', '-77.8197', '51');
INSERT INTO `ubigeo` VALUES ('150203', 'Pativilca', 'Barranca', 'Lima', '-10.6961', '-77.7792', '51');
INSERT INTO `ubigeo` VALUES ('150204', 'Supe', 'Barranca', 'Lima', '-10.7992', '-77.7133', '51');
INSERT INTO `ubigeo` VALUES ('150205', 'Supe Puerto', 'Barranca', 'Lima', '-10.8003', '-77.7447', '51');
INSERT INTO `ubigeo` VALUES ('150301', 'Cajatambo', 'Cajatambo', 'Lima', '-10.4722', '-76.9939', '51');
INSERT INTO `ubigeo` VALUES ('150302', 'Copa', 'Cajatambo', 'Lima', '-10.3856', '-77.0789', '51');
INSERT INTO `ubigeo` VALUES ('150303', 'Gorgor', 'Cajatambo', 'Lima', '-10.6214', '-77.0389', '51');
INSERT INTO `ubigeo` VALUES ('150304', 'Huancapon', 'Cajatambo', 'Lima', '-10.5483', '-77.1128', '51');
INSERT INTO `ubigeo` VALUES ('150305', 'Manas', 'Cajatambo', 'Lima', '-10.5953', '-77.1669', '51');
INSERT INTO `ubigeo` VALUES ('150401', 'Canta', 'Canta', 'Lima', '-11.4675', '-76.6231', '51');
INSERT INTO `ubigeo` VALUES ('150402', 'Arahuay', 'Canta', 'Lima', '-11.6222', '-76.6731', '51');
INSERT INTO `ubigeo` VALUES ('150403', 'Huamantanga', 'Canta', 'Lima', '-11.4997', '-76.7489', '51');
INSERT INTO `ubigeo` VALUES ('150404', 'Huaros', 'Canta', 'Lima', '-11.4058', '-76.5761', '51');
INSERT INTO `ubigeo` VALUES ('150405', 'Lachaqui', 'Canta', 'Lima', '-11.5567', '-76.6244', '51');
INSERT INTO `ubigeo` VALUES ('150406', 'San Buenaventura', 'Canta', 'Lima', '-11.4897', '-76.6631', '51');
INSERT INTO `ubigeo` VALUES ('150407', 'Santa Rosa de Quives', 'Canta', 'Lima', '-11.6928', '-76.8444', '51');
INSERT INTO `ubigeo` VALUES ('150501', 'San Vicente de Cañete', 'Cañete', 'Lima', '-13.0825', '-76.3883', '51');
INSERT INTO `ubigeo` VALUES ('150502', 'Asia', 'Cañete', 'Lima', '-12.7789', '-76.5572', '51');
INSERT INTO `ubigeo` VALUES ('150503', 'Calango', 'Cañete', 'Lima', '-12.5256', '-76.5433', '51');
INSERT INTO `ubigeo` VALUES ('150504', 'Cerro Azul', 'Cañete', 'Lima', '-13.0267', '-76.4794', '51');
INSERT INTO `ubigeo` VALUES ('150505', 'Chilca', 'Cañete', 'Lima', '-12.5172', '-76.7361', '51');
INSERT INTO `ubigeo` VALUES ('150506', 'Coayllo', 'Cañete', 'Lima', '-12.7258', '-76.4606', '51');
INSERT INTO `ubigeo` VALUES ('150507', 'Imperial', 'Cañete', 'Lima', '-13.0608', '-76.35', '51');
INSERT INTO `ubigeo` VALUES ('150508', 'Lunahuana', 'Cañete', 'Lima', '-12.9597', '-76.1392', '51');
INSERT INTO `ubigeo` VALUES ('150509', 'Mala', 'Cañete', 'Lima', '-12.6553', '-76.63', '51');
INSERT INTO `ubigeo` VALUES ('150510', 'Nuevo Imperial', 'Cañete', 'Lima', '-13.0742', '-76.3158', '51');
INSERT INTO `ubigeo` VALUES ('150511', 'Pacaran', 'Cañete', 'Lima', '-12.8636', '-76.0519', '51');
INSERT INTO `ubigeo` VALUES ('150512', 'Quilmana', 'Cañete', 'Lima', '-12.95', '-76.3828', '51');
INSERT INTO `ubigeo` VALUES ('150513', 'San Antonio', 'Cañete', 'Lima', '-12.6431', '-76.65', '51');
INSERT INTO `ubigeo` VALUES ('150514', 'San Luis', 'Cañete', 'Lima', '-13.0508', '-76.4294', '51');
INSERT INTO `ubigeo` VALUES ('150515', 'Santa Cruz de Flores', 'Cañete', 'Lima', '-12.6194', '-76.6397', '51');
INSERT INTO `ubigeo` VALUES ('150516', 'Zuñiga', 'Cañete', 'Lima', '-12.8581', '-76.0225', '51');
INSERT INTO `ubigeo` VALUES ('150601', 'Huaral', 'Huaral', 'Lima', '-11.4914', '-77.2053', '51');
INSERT INTO `ubigeo` VALUES ('150602', 'Atavillos Alto', 'Huaral', 'Lima', '-11.2331', '-76.6561', '51');
INSERT INTO `ubigeo` VALUES ('150603', 'Atavillos Bajo', 'Huaral', 'Lima', '-11.3533', '-76.8231', '51');
INSERT INTO `ubigeo` VALUES ('150604', 'Aucallama', 'Huaral', 'Lima', '-11.5592', '-77.1744', '51');
INSERT INTO `ubigeo` VALUES ('150605', 'Chancay', 'Huaral', 'Lima', '-11.5669', '-77.2658', '51');
INSERT INTO `ubigeo` VALUES ('150606', 'Ihuari', 'Huaral', 'Lima', '-11.1889', '-76.9519', '51');
INSERT INTO `ubigeo` VALUES ('150607', 'Lampian', 'Huaral', 'Lima', '-11.2369', '-76.8386', '51');
INSERT INTO `ubigeo` VALUES ('150608', 'Pacaraos', 'Huaral', 'Lima', '-11.1833', '-76.6464', '51');
INSERT INTO `ubigeo` VALUES ('150609', 'San Miguel de Acos', 'Huaral', 'Lima', '-11.2736', '-76.8214', '51');
INSERT INTO `ubigeo` VALUES ('150610', 'Santa Cruz de Andamarca', 'Huaral', 'Lima', '-11.1947', '-76.6336', '51');
INSERT INTO `ubigeo` VALUES ('150611', 'Sumbilca', 'Huaral', 'Lima', '-11.4072', '-76.8194', '51');
INSERT INTO `ubigeo` VALUES ('150612', 'Veintisiete de Noviembre', 'Huaral', 'Lima', '-11.1919', '-76.7786', '51');
INSERT INTO `ubigeo` VALUES ('150701', 'Matucana', 'Huarochiri', 'Lima', '-11.8458', '-76.3878', '51');
INSERT INTO `ubigeo` VALUES ('150702', 'Antioquia', 'Huarochiri', 'Lima', '-12.0814', '-76.5133', '51');
INSERT INTO `ubigeo` VALUES ('150703', 'Callahuanca', 'Huarochiri', 'Lima', '-11.8275', '-76.6203', '51');
INSERT INTO `ubigeo` VALUES ('150704', 'Carampoma', 'Huarochiri', 'Lima', '-11.6561', '-76.5181', '51');
INSERT INTO `ubigeo` VALUES ('150705', 'Chicla', 'Huarochiri', 'Lima', '-11.7078', '-76.2711', '51');
INSERT INTO `ubigeo` VALUES ('150706', 'Cuenca', 'Huarochiri', 'Lima', '-12.1336', '-76.4378', '51');
INSERT INTO `ubigeo` VALUES ('150707', 'Huachupampa', 'Huarochiri', 'Lima', '-11.7228', '-76.59', '51');
INSERT INTO `ubigeo` VALUES ('150708', 'Huanza', 'Huarochiri', 'Lima', '-11.6561', '-76.5069', '51');
INSERT INTO `ubigeo` VALUES ('150709', 'Huarochiri', 'Huarochiri', 'Lima', '-12.1381', '-76.2344', '51');
INSERT INTO `ubigeo` VALUES ('150710', 'Lahuaytambo', 'Huarochiri', 'Lima', '-12.0969', '-76.3911', '51');
INSERT INTO `ubigeo` VALUES ('150711', 'Langa', 'Huarochiri', 'Lima', '-12.1253', '-76.4233', '51');
INSERT INTO `ubigeo` VALUES ('150712', 'Laraos', 'Huarochiri', 'Lima', '-11.6647', '-76.5422', '51');
INSERT INTO `ubigeo` VALUES ('150713', 'Mariatana', 'Huarochiri', 'Lima', '-12.2378', '-76.3261', '51');
INSERT INTO `ubigeo` VALUES ('150714', 'Ricardo Palma', 'Huarochiri', 'Lima', '-11.925', '-76.6617', '51');
INSERT INTO `ubigeo` VALUES ('150715', 'San Andres de Tupicocha', 'Huarochiri', 'Lima', '-12.0008', '-76.4778', '51');
INSERT INTO `ubigeo` VALUES ('150716', 'San Antonio', 'Huarochiri', 'Lima', '-11.7439', '-76.6519', '51');
INSERT INTO `ubigeo` VALUES ('150717', 'San Bartolome', 'Huarochiri', 'Lima', '-11.9114', '-76.5275', '51');
INSERT INTO `ubigeo` VALUES ('150718', 'San Damian', 'Huarochiri', 'Lima', '-12.0178', '-76.3936', '51');
INSERT INTO `ubigeo` VALUES ('150719', 'San Juan de Iris', 'Huarochiri', 'Lima', '-11.6847', '-76.5275', '51');
INSERT INTO `ubigeo` VALUES ('150720', 'San Juan de Tantaranche', 'Huarochiri', 'Lima', '-12.1136', '-76.185', '51');
INSERT INTO `ubigeo` VALUES ('150721', 'San Lorenzo de Quinti', 'Huarochiri', 'Lima', '-12.1453', '-76.2133', '51');
INSERT INTO `ubigeo` VALUES ('150722', 'San Mateo', 'Huarochiri', 'Lima', '-11.7589', '-76.3031', '51');
INSERT INTO `ubigeo` VALUES ('150723', 'San Mateo de Otao', 'Huarochiri', 'Lima', '-11.8686', '-76.5475', '51');
INSERT INTO `ubigeo` VALUES ('150724', 'San Pedro de Casta', 'Huarochiri', 'Lima', '-11.7583', '-76.5989', '51');
INSERT INTO `ubigeo` VALUES ('150725', 'San Pedro de Huancayre', 'Huarochiri', 'Lima', '-12.1311', '-76.2186', '51');
INSERT INTO `ubigeo` VALUES ('150726', 'Sangallaya', 'Huarochiri', 'Lima', '-12.1606', '-76.2297', '51');
INSERT INTO `ubigeo` VALUES ('150727', 'Santa Cruz de Cocachacra', 'Huarochiri', 'Lima', '-11.9108', '-76.5406', '51');
INSERT INTO `ubigeo` VALUES ('150728', 'Santa Eulalia', 'Huarochiri', 'Lima', '-11.9106', '-76.6656', '51');
INSERT INTO `ubigeo` VALUES ('150729', 'Santiago de Anchucaya', 'Huarochiri', 'Lima', '-12.0961', '-76.2325', '51');
INSERT INTO `ubigeo` VALUES ('150730', 'Santiago de Tuna', 'Huarochiri', 'Lima', '-11.985', '-76.5275', '51');
INSERT INTO `ubigeo` VALUES ('150731', 'Santo Domingo de los Olleros', 'Huarochiri', 'Lima', '-12.2203', '-76.5161', '51');
INSERT INTO `ubigeo` VALUES ('150732', 'Surco', 'Huarochiri', 'Lima', '-11.885', '-76.4425', '51');
INSERT INTO `ubigeo` VALUES ('150801', 'Huacho', 'Huaura', 'Lima', '-11.1069', '-77.61', '51');
INSERT INTO `ubigeo` VALUES ('150802', 'Ambar', 'Huaura', 'Lima', '-10.7572', '-77.2694', '51');
INSERT INTO `ubigeo` VALUES ('150803', 'Caleta de Carquin', 'Huaura', 'Lima', '-11.0917', '-77.6278', '51');
INSERT INTO `ubigeo` VALUES ('150804', 'Checras', 'Huaura', 'Lima', '-10.935', '-76.8336', '51');
INSERT INTO `ubigeo` VALUES ('150805', 'Hualmay', 'Huaura', 'Lima', '-11.1014', '-77.61', '51');
INSERT INTO `ubigeo` VALUES ('150806', 'Huaura', 'Huaura', 'Lima', '-11.0692', '-77.6003', '51');
INSERT INTO `ubigeo` VALUES ('150807', 'Leoncio Prado', 'Huaura', 'Lima', '-11.0586', '-76.9308', '51');
INSERT INTO `ubigeo` VALUES ('150808', 'Paccho', 'Huaura', 'Lima', '-10.9567', '-76.9336', '51');
INSERT INTO `ubigeo` VALUES ('150809', 'Santa Leonor', 'Huaura', 'Lima', '-10.9483', '-76.7447', '51');
INSERT INTO `ubigeo` VALUES ('150810', 'Santa Maria', 'Huaura', 'Lima', '-11.0883', '-77.5883', '51');
INSERT INTO `ubigeo` VALUES ('150811', 'Sayan', 'Huaura', 'Lima', '-11.1364', '-77.1917', '51');
INSERT INTO `ubigeo` VALUES ('150812', 'Vegueta', 'Huaura', 'Lima', '-11.0225', '-77.6425', '51');
INSERT INTO `ubigeo` VALUES ('150901', 'Oyon', 'Oyon', 'Lima', '-10.6692', '-76.7728', '51');
INSERT INTO `ubigeo` VALUES ('150902', 'Andajes', 'Oyon', 'Lima', '-10.7914', '-76.91', '51');
INSERT INTO `ubigeo` VALUES ('150903', 'Caujul', 'Oyon', 'Lima', '-10.8053', '-76.9786', '51');
INSERT INTO `ubigeo` VALUES ('150904', 'Cochamarca', 'Oyon', 'Lima', '-10.8617', '-77.1278', '51');
INSERT INTO `ubigeo` VALUES ('150905', 'Navan', 'Oyon', 'Lima', '-10.8353', '-77.0122', '51');
INSERT INTO `ubigeo` VALUES ('150906', 'Pachangara', 'Oyon', 'Lima', '-10.8125', '-76.8744', '51');
INSERT INTO `ubigeo` VALUES ('151001', 'Yauyos', 'Yauyos', 'Lima', '-12.46', '-75.9217', '51');
INSERT INTO `ubigeo` VALUES ('151002', 'Alis', 'Yauyos', 'Lima', '-12.2803', '-75.7864', '51');
INSERT INTO `ubigeo` VALUES ('151003', 'Ayauca', 'Yauyos', 'Lima', '-12.5922', '-76.0367', '51');
INSERT INTO `ubigeo` VALUES ('151004', 'Ayaviri', 'Yauyos', 'Lima', '-12.3825', '-76.1389', '51');
INSERT INTO `ubigeo` VALUES ('151005', 'Azangaro', 'Yauyos', 'Lima', '-12.9994', '-75.8367', '51');
INSERT INTO `ubigeo` VALUES ('151006', 'Cacra', 'Yauyos', 'Lima', '-12.8119', '-75.7828', '51');
INSERT INTO `ubigeo` VALUES ('151007', 'Carania', 'Yauyos', 'Lima', '-12.3444', '-75.8717', '51');
INSERT INTO `ubigeo` VALUES ('151008', 'Catahuasi', 'Yauyos', 'Lima', '-12.8003', '-75.8911', '51');
INSERT INTO `ubigeo` VALUES ('151009', 'Chocos', 'Yauyos', 'Lima', '-12.9133', '-75.8631', '51');
INSERT INTO `ubigeo` VALUES ('151010', 'Cochas', 'Yauyos', 'Lima', '-12.2964', '-76.1589', '51');
INSERT INTO `ubigeo` VALUES ('151011', 'Colonia', 'Yauyos', 'Lima', '-12.6319', '-75.8906', '51');
INSERT INTO `ubigeo` VALUES ('151012', 'Hongos', 'Yauyos', 'Lima', '-12.8108', '-75.7647', '51');
INSERT INTO `ubigeo` VALUES ('151013', 'Huampara', 'Yauyos', 'Lima', '-12.3608', '-76.1661', '51');
INSERT INTO `ubigeo` VALUES ('151014', 'Huancaya', 'Yauyos', 'Lima', '-12.2028', '-75.7992', '51');
INSERT INTO `ubigeo` VALUES ('151015', 'Huangascar', 'Yauyos', 'Lima', '-12.8997', '-75.8311', '51');
INSERT INTO `ubigeo` VALUES ('151016', 'Huantan', 'Yauyos', 'Lima', '-12.4572', '-75.8106', '51');
INSERT INTO `ubigeo` VALUES ('151017', 'Huañec', 'Yauyos', 'Lima', '-12.2939', '-76.1386', '51');
INSERT INTO `ubigeo` VALUES ('151018', 'Laraos', 'Yauyos', 'Lima', '-12.3456', '-75.7856', '51');
INSERT INTO `ubigeo` VALUES ('151019', 'Lincha', 'Yauyos', 'Lima', '-12.8', '-75.6658', '51');
INSERT INTO `ubigeo` VALUES ('151020', 'Madean', 'Yauyos', 'Lima', '-12.945', '-75.7775', '51');
INSERT INTO `ubigeo` VALUES ('151021', 'Miraflores', 'Yauyos', 'Lima', '-12.2747', '-75.8536', '51');
INSERT INTO `ubigeo` VALUES ('151022', 'Omas', 'Yauyos', 'Lima', '-12.5172', '-76.2903', '51');
INSERT INTO `ubigeo` VALUES ('151023', 'Putinza', 'Yauyos', 'Lima', '-12.6689', '-75.9494', '51');
INSERT INTO `ubigeo` VALUES ('151024', 'Quinches', 'Yauyos', 'Lima', '-12.3075', '-76.1422', '51');
INSERT INTO `ubigeo` VALUES ('151025', 'Quinocay', 'Yauyos', 'Lima', '-12.3642', '-76.2264', '51');
INSERT INTO `ubigeo` VALUES ('151026', 'San Joaquin', 'Yauyos', 'Lima', '-12.2844', '-76.1464', '51');
INSERT INTO `ubigeo` VALUES ('151027', 'San Pedro de Pilas', 'Yauyos', 'Lima', '-12.4544', '-76.2267', '51');
INSERT INTO `ubigeo` VALUES ('151028', 'Tanta', 'Yauyos', 'Lima', '-12.1214', '-76.0122', '51');
INSERT INTO `ubigeo` VALUES ('151029', 'Tauripampa', 'Yauyos', 'Lima', '-12.6156', '-76.16', '51');
INSERT INTO `ubigeo` VALUES ('151030', 'Tomas', 'Yauyos', 'Lima', '-12.2372', '-75.7461', '51');
INSERT INTO `ubigeo` VALUES ('151031', 'Tupe', 'Yauyos', 'Lima', '-12.7403', '-75.8089', '51');
INSERT INTO `ubigeo` VALUES ('151032', 'Viñac', 'Yauyos', 'Lima', '-12.9311', '-75.7794', '51');
INSERT INTO `ubigeo` VALUES ('151033', 'Vitis', 'Yauyos', 'Lima', '-12.2236', '-75.8069', '51');
INSERT INTO `ubigeo` VALUES ('160101', 'Iquitos', 'Maynas', 'Loreto', '-3.7497', '-73.2619', '51');
INSERT INTO `ubigeo` VALUES ('160102', 'Alto Nanay', 'Maynas', 'Loreto', '-3.8869', '-73.7003', '51');
INSERT INTO `ubigeo` VALUES ('160103', 'Fernando Lores', 'Maynas', 'Loreto', '-4.0064', '-73.1525', '51');
INSERT INTO `ubigeo` VALUES ('160104', 'Indiana', 'Maynas', 'Loreto', '-3.4983', '-73.0444', '51');
INSERT INTO `ubigeo` VALUES ('160105', 'Las Amazonas', 'Maynas', 'Loreto', '-3.4136', '-72.7689', '51');
INSERT INTO `ubigeo` VALUES ('160106', 'Mazan', 'Maynas', 'Loreto', '-3.4978', '-73.1142', '51');
INSERT INTO `ubigeo` VALUES ('160107', 'Napo', 'Maynas', 'Loreto', '-2.4936', '-73.6806', '51');
INSERT INTO `ubigeo` VALUES ('160108', 'Punchana', 'Maynas', 'Loreto', '-3.7289', '-73.2447', '51');
INSERT INTO `ubigeo` VALUES ('160110', 'Torres Causana', 'Maynas', 'Loreto', '-0.9642', '-75.1814', '51');
INSERT INTO `ubigeo` VALUES ('160112', 'Belen', 'Maynas', 'Loreto', '-3.7644', '-73.2444', '51');
INSERT INTO `ubigeo` VALUES ('160113', 'San Juan Bautista', 'Maynas', 'Loreto', '-3.7742', '-73.2864', '51');
INSERT INTO `ubigeo` VALUES ('160201', 'Yurimaguas', 'Alto Amazonas', 'Loreto', '-5.8944', '-76.1094', '51');
INSERT INTO `ubigeo` VALUES ('160202', 'Balsapuerto', 'Alto Amazonas', 'Loreto', '-5.8314', '-76.5597', '51');
INSERT INTO `ubigeo` VALUES ('160205', 'Jeberos', 'Alto Amazonas', 'Loreto', '-5.2939', '-76.2836', '51');
INSERT INTO `ubigeo` VALUES ('160206', 'Lagunas', 'Alto Amazonas', 'Loreto', '-5.23', '-75.6775', '51');
INSERT INTO `ubigeo` VALUES ('160210', 'Santa Cruz', 'Alto Amazonas', 'Loreto', '-5.5125', '-75.8572', '51');
INSERT INTO `ubigeo` VALUES ('160211', 'Teniente Cesar Lopez Rojas', 'Alto Amazonas', 'Loreto', '-6.0272', '-75.8742', '51');
INSERT INTO `ubigeo` VALUES ('160301', 'Nauta', 'Loreto', 'Loreto', '-4.4567', '-73.5261', '51');
INSERT INTO `ubigeo` VALUES ('160302', 'Parinari', 'Loreto', 'Loreto', '-4.56', '-74.4844', '51');
INSERT INTO `ubigeo` VALUES ('160303', 'Tigre', 'Loreto', 'Loreto', '-3.5503', '-74.6903', '51');
INSERT INTO `ubigeo` VALUES ('160304', 'Trompeteros', 'Loreto', 'Loreto', '-3.8028', '-75.0597', '51');
INSERT INTO `ubigeo` VALUES ('160305', 'Urarinas', 'Loreto', 'Loreto', '-4.5333', '-74.7597', '51');
INSERT INTO `ubigeo` VALUES ('160401', 'Ramon Castilla', 'Mariscal Ramon Castilla', 'Loreto', '-3.9078', '-70.5178', '51');
INSERT INTO `ubigeo` VALUES ('160402', 'Pebas', 'Mariscal Ramon Castilla', 'Loreto', '-3.3192', '-71.8631', '51');
INSERT INTO `ubigeo` VALUES ('160403', 'Yavari', 'Mariscal Ramon Castilla', 'Loreto', '-4.3567', '-70.0408', '51');
INSERT INTO `ubigeo` VALUES ('160404', 'San Pablo', 'Mariscal Ramon Castilla', 'Loreto', '-4.0164', '-71.1022', '51');
INSERT INTO `ubigeo` VALUES ('160501', 'Requena', 'Requena', 'Loreto', '-5.0589', '-73.8525', '51');
INSERT INTO `ubigeo` VALUES ('160502', 'Alto Tapiche', 'Requena', 'Loreto', '-6.0256', '-74.0908', '51');
INSERT INTO `ubigeo` VALUES ('160503', 'Capelo', 'Requena', 'Loreto', '-5.4072', '-74.1592', '51');
INSERT INTO `ubigeo` VALUES ('160504', 'Emilio San Martin', 'Requena', 'Loreto', '-5.7936', '-74.2864', '51');
INSERT INTO `ubigeo` VALUES ('160505', 'Maquia', 'Requena', 'Loreto', '-5.7892', '-74.5503', '51');
INSERT INTO `ubigeo` VALUES ('160506', 'Puinahua', 'Requena', 'Loreto', '-5.2533', '-74.3433', '51');
INSERT INTO `ubigeo` VALUES ('160507', 'Saquena', 'Requena', 'Loreto', '-4.7261', '-73.5333', '51');
INSERT INTO `ubigeo` VALUES ('160508', 'Soplin', 'Requena', 'Loreto', '-6.005', '-73.6911', '51');
INSERT INTO `ubigeo` VALUES ('160509', 'Tapiche', 'Requena', 'Loreto', '-5.6644', '-74.1886', '51');
INSERT INTO `ubigeo` VALUES ('160510', 'Jenaro Herrera', 'Requena', 'Loreto', '-4.9053', '-73.6728', '51');
INSERT INTO `ubigeo` VALUES ('160511', 'Yaquerana', 'Requena', 'Loreto', '-5.1494', '-72.8761', '51');
INSERT INTO `ubigeo` VALUES ('160601', 'Contamana', 'Ucayali', 'Loreto', '-7.325', '-75.0414', '51');
INSERT INTO `ubigeo` VALUES ('160602', 'Inahuaya', 'Ucayali', 'Loreto', '-7.1164', '-75.2667', '51');
INSERT INTO `ubigeo` VALUES ('160603', 'Padre Marquez', 'Ucayali', 'Loreto', '-7.9444', '-74.8403', '51');
INSERT INTO `ubigeo` VALUES ('160604', 'Pampa Hermosa', 'Ucayali', 'Loreto', '-7.195', '-75.2969', '51');
INSERT INTO `ubigeo` VALUES ('160605', 'Sarayacu', 'Ucayali', 'Loreto', '-6.3958', '-75.1178', '51');
INSERT INTO `ubigeo` VALUES ('160606', 'Vargas Guerra', 'Ucayali', 'Loreto', '-6.9094', '-75.1594', '51');
INSERT INTO `ubigeo` VALUES ('160701', 'Barranca', 'Datem del Marañon', 'Loreto', '-4.8219', '-76.5642', '51');
INSERT INTO `ubigeo` VALUES ('160702', 'Cahuapanas', 'Datem del Marañon', 'Loreto', '-5.2711', '-76.9858', '51');
INSERT INTO `ubigeo` VALUES ('160703', 'Manseriche', 'Datem del Marañon', 'Loreto', '-4.565', '-77.4183', '51');
INSERT INTO `ubigeo` VALUES ('160704', 'Morona', 'Datem del Marañon', 'Loreto', '-4.3247', '-77.2147', '51');
INSERT INTO `ubigeo` VALUES ('160705', 'Pastaza', 'Datem del Marañon', 'Loreto', '-4.6442', '-76.5981', '51');
INSERT INTO `ubigeo` VALUES ('160706', 'Andoas', 'Datem del Marañon', 'Loreto', '-3.475', '-76.4344', '51');
INSERT INTO `ubigeo` VALUES ('160801', 'Putumayo', 'Maynas', 'Loreto', '-2.4497', '-72.6556', '51');
INSERT INTO `ubigeo` VALUES ('160802', 'Rosa Panduro', 'Maynas', 'Loreto', '-1.7964', '-73.4078', '51');
INSERT INTO `ubigeo` VALUES ('160803', 'Teniente Manuel Clavero', 'Maynas', 'Loreto', '-0.3783', '-74.6753', '51');
INSERT INTO `ubigeo` VALUES ('160804', 'Yaguas', 'Maynas', 'Loreto', '-2.4114', '-71.1836', '51');
INSERT INTO `ubigeo` VALUES ('170101', 'Tambopata', 'Tambopata', 'Madre de Dios', '-12.5972', '-69.1875', '51');
INSERT INTO `ubigeo` VALUES ('170102', 'Inambari', 'Tambopata', 'Madre de Dios', '-13.1', '-70.3678', '51');
INSERT INTO `ubigeo` VALUES ('170103', 'Las Piedras', 'Tambopata', 'Madre de Dios', '-12.2781', '-69.1536', '51');
INSERT INTO `ubigeo` VALUES ('170104', 'Laberinto', 'Tambopata', 'Madre de Dios', '-12.7172', '-69.59', '51');
INSERT INTO `ubigeo` VALUES ('170201', 'Manu', 'Manu', 'Madre de Dios', '-12.8381', '-71.3633', '51');
INSERT INTO `ubigeo` VALUES ('170202', 'Fitzcarrald', 'Manu', 'Madre de Dios', '-12.2678', '-70.9336', '51');
INSERT INTO `ubigeo` VALUES ('170203', 'Madre de Dios', 'Manu', 'Madre de Dios', '-12.6181', '-70.3936', '51');
INSERT INTO `ubigeo` VALUES ('170204', 'Huepetuhe', 'Manu', 'Madre de Dios', '-12.9975', '-70.5336', '51');
INSERT INTO `ubigeo` VALUES ('170301', 'Iñapari', 'Tahuamanu', 'Madre de Dios', '-10.9544', '-69.5814', '51');
INSERT INTO `ubigeo` VALUES ('170302', 'Iberia', 'Tahuamanu', 'Madre de Dios', '-11.4072', '-69.4889', '51');
INSERT INTO `ubigeo` VALUES ('170303', 'Tahuamanu', 'Tahuamanu', 'Madre de Dios', '-11.455', '-69.3214', '51');
INSERT INTO `ubigeo` VALUES ('180101', 'Moquegua', 'Mariscal Nieto', 'Moquegua', '-17.195', '-70.9369', '51');
INSERT INTO `ubigeo` VALUES ('180102', 'Carumas', 'Mariscal Nieto', 'Moquegua', '-16.8106', '-70.6953', '51');
INSERT INTO `ubigeo` VALUES ('180103', 'Cuchumbaya', 'Mariscal Nieto', 'Moquegua', '-16.7525', '-70.6878', '51');
INSERT INTO `ubigeo` VALUES ('180104', 'Samegua', 'Mariscal Nieto', 'Moquegua', '-17.1797', '-70.9008', '51');
INSERT INTO `ubigeo` VALUES ('180105', 'San Cristobal', 'Mariscal Nieto', 'Moquegua', '-16.7406', '-70.6831', '51');
INSERT INTO `ubigeo` VALUES ('180106', 'Torata', 'Mariscal Nieto', 'Moquegua', '-17.0767', '-70.8442', '51');
INSERT INTO `ubigeo` VALUES ('180201', 'Omate', 'General Sanchez Cerr', 'Moquegua', '-16.6739', '-70.9719', '51');
INSERT INTO `ubigeo` VALUES ('180202', 'Chojata', 'General Sanchez Cerr', 'Moquegua', '-16.3894', '-70.7286', '51');
INSERT INTO `ubigeo` VALUES ('180203', 'Coalaque', 'General Sanchez Cerr', 'Moquegua', '-16.6486', '-71.0239', '51');
INSERT INTO `ubigeo` VALUES ('180204', 'Ichuña', 'General Sanchez Cerr', 'Moquegua', '-16.1411', '-70.5392', '51');
INSERT INTO `ubigeo` VALUES ('180205', 'La Capilla', 'General Sanchez Cerr', 'Moquegua', '-16.7581', '-71.1767', '51');
INSERT INTO `ubigeo` VALUES ('180206', 'Lloque', 'General Sanchez Cerr', 'Moquegua', '-16.3239', '-70.7381', '51');
INSERT INTO `ubigeo` VALUES ('180207', 'Matalaque', 'General Sanchez Cerr', 'Moquegua', '-16.4819', '-70.8278', '51');
INSERT INTO `ubigeo` VALUES ('180208', 'Puquina', 'General Sanchez Cerr', 'Moquegua', '-16.6211', '-71.1842', '51');
INSERT INTO `ubigeo` VALUES ('180209', 'Quinistaquillas', 'General Sanchez Cerr', 'Moquegua', '-16.7486', '-70.8808', '51');
INSERT INTO `ubigeo` VALUES ('180210', 'Ubinas', 'General Sanchez Cerr', 'Moquegua', '-16.3856', '-70.8581', '51');
INSERT INTO `ubigeo` VALUES ('180211', 'Yunga', 'General Sanchez Cerr', 'Moquegua', '-16.1964', '-70.6814', '51');
INSERT INTO `ubigeo` VALUES ('180301', 'Ilo', 'Ilo', 'Moquegua', '-17.6444', '-71.345', '51');
INSERT INTO `ubigeo` VALUES ('180302', 'El Algarrobal', 'Ilo', 'Moquegua', '-17.6228', '-71.2703', '51');
INSERT INTO `ubigeo` VALUES ('180303', 'Pacocha', 'Ilo', 'Moquegua', '-17.6161', '-71.34', '51');
INSERT INTO `ubigeo` VALUES ('190101', 'Chaupimarca', 'Pasco', 'Pasco', '-10.6828', '-76.2556', '51');
INSERT INTO `ubigeo` VALUES ('190102', 'Huachon', 'Pasco', 'Pasco', '-10.6378', '-75.9522', '51');
INSERT INTO `ubigeo` VALUES ('190103', 'Huariaca', 'Pasco', 'Pasco', '-10.4428', '-76.1889', '51');
INSERT INTO `ubigeo` VALUES ('190104', 'Huayllay', 'Pasco', 'Pasco', '-11.0044', '-76.3681', '51');
INSERT INTO `ubigeo` VALUES ('190105', 'Ninacaca', 'Pasco', 'Pasco', '-10.8617', '-76.1131', '51');
INSERT INTO `ubigeo` VALUES ('190106', 'Pallanchacra', 'Pasco', 'Pasco', '-10.4147', '-76.2356', '51');
INSERT INTO `ubigeo` VALUES ('190107', 'Paucartambo', 'Pasco', 'Pasco', '-10.7731', '-75.8128', '51');
INSERT INTO `ubigeo` VALUES ('190108', 'San Francisco de Asis de Yarusyacan', 'Pasco', 'Pasco', '-10.4914', '-76.1964', '51');
INSERT INTO `ubigeo` VALUES ('190109', 'Simon Bolivar', 'Pasco', 'Pasco', '-10.6897', '-76.3175', '51');
INSERT INTO `ubigeo` VALUES ('190110', 'Ticlacayan', 'Pasco', 'Pasco', '-10.5344', '-76.1625', '51');
INSERT INTO `ubigeo` VALUES ('190111', 'Tinyahuarco', 'Pasco', 'Pasco', '-10.7689', '-76.2733', '51');
INSERT INTO `ubigeo` VALUES ('190112', 'Vicco', 'Pasco', 'Pasco', '-10.8414', '-76.2375', '51');
INSERT INTO `ubigeo` VALUES ('190113', 'Yanacancha', 'Pasco', 'Pasco', '-10.6689', '-76.2556', '51');
INSERT INTO `ubigeo` VALUES ('190201', 'Yanahuanca', 'Daniel Alcides Carri', 'Pasco', '-10.4925', '-76.5169', '51');
INSERT INTO `ubigeo` VALUES ('190202', 'Chacayan', 'Daniel Alcides Carri', 'Pasco', '-10.435', '-76.4383', '51');
INSERT INTO `ubigeo` VALUES ('190203', 'Goyllarisquizga', 'Daniel Alcides Carri', 'Pasco', '-10.4733', '-76.4078', '51');
INSERT INTO `ubigeo` VALUES ('190204', 'Paucar', 'Daniel Alcides Carri', 'Pasco', '-10.3697', '-76.445', '51');
INSERT INTO `ubigeo` VALUES ('190205', 'San Pedro de Pillao', 'Daniel Alcides Carri', 'Pasco', '-10.4392', '-76.4972', '51');
INSERT INTO `ubigeo` VALUES ('190206', 'Santa Ana de Tusi', 'Daniel Alcides Carri', 'Pasco', '-10.4719', '-76.3547', '51');
INSERT INTO `ubigeo` VALUES ('190207', 'Tapuc', 'Daniel Alcides Carri', 'Pasco', '-10.4558', '-76.4617', '51');
INSERT INTO `ubigeo` VALUES ('190208', 'Vilcabamba', 'Daniel Alcides Carri', 'Pasco', '-10.4789', '-76.4492', '51');
INSERT INTO `ubigeo` VALUES ('190301', 'Oxapampa', 'Oxapampa', 'Pasco', '-10.5728', '-75.4039', '51');
INSERT INTO `ubigeo` VALUES ('190302', 'Chontabamba', 'Oxapampa', 'Pasco', '-10.6044', '-75.4633', '51');
INSERT INTO `ubigeo` VALUES ('190303', 'Huancabamba', 'Oxapampa', 'Pasco', '-10.4261', '-75.5131', '51');
INSERT INTO `ubigeo` VALUES ('190304', 'Palcazu', 'Oxapampa', 'Pasco', '-10.1878', '-75.1458', '51');
INSERT INTO `ubigeo` VALUES ('190305', 'Pozuzo', 'Oxapampa', 'Pasco', '-10.0653', '-75.5569', '51');
INSERT INTO `ubigeo` VALUES ('190306', 'Puerto Bermudez', 'Oxapampa', 'Pasco', '-10.2964', '-74.9358', '51');
INSERT INTO `ubigeo` VALUES ('190307', 'Villa Rica', 'Oxapampa', 'Pasco', '-10.7364', '-75.2722', '51');
INSERT INTO `ubigeo` VALUES ('190308', 'Constitución', 'Oxapampa', 'Pasco', '-9.8458', '-74.9986', '51');
INSERT INTO `ubigeo` VALUES ('200101', 'Piura', 'Piura', 'Piura', '-5.1942', '-80.6289', '51');
INSERT INTO `ubigeo` VALUES ('200104', 'Castilla', 'Piura', 'Piura', '-5.2006', '-80.6211', '51');
INSERT INTO `ubigeo` VALUES ('200105', 'Catacaos', 'Piura', 'Piura', '-5.2697', '-80.6764', '51');
INSERT INTO `ubigeo` VALUES ('200107', 'Cura Mori', 'Piura', 'Piura', '-5.325', '-80.6656', '51');
INSERT INTO `ubigeo` VALUES ('200108', 'El Tallan', 'Piura', 'Piura', '-5.4128', '-80.68', '51');
INSERT INTO `ubigeo` VALUES ('200109', 'La Arena', 'Piura', 'Piura', '-5.3464', '-80.7108', '51');
INSERT INTO `ubigeo` VALUES ('200110', 'La Union', 'Piura', 'Piura', '-5.4031', '-80.7433', '51');
INSERT INTO `ubigeo` VALUES ('200111', 'Las Lomas', 'Piura', 'Piura', '-4.6578', '-80.2442', '51');
INSERT INTO `ubigeo` VALUES ('200114', 'Tambo Grande', 'Piura', 'Piura', '-4.9331', '-80.3414', '51');
INSERT INTO `ubigeo` VALUES ('200115', '26 de Octubre', 'Piura', 'Piura', '-5.1847', '-80.6703', '51');
INSERT INTO `ubigeo` VALUES ('200201', 'Ayabaca', 'Ayabaca', 'Piura', '-4.6392', '-79.7161', '51');
INSERT INTO `ubigeo` VALUES ('200202', 'Frias', 'Ayabaca', 'Piura', '-4.9342', '-79.9431', '51');
INSERT INTO `ubigeo` VALUES ('200203', 'Jilili', 'Ayabaca', 'Piura', '-4.5839', '-79.7989', '51');
INSERT INTO `ubigeo` VALUES ('200204', 'Lagunas', 'Ayabaca', 'Piura', '-4.79', '-79.8456', '51');
INSERT INTO `ubigeo` VALUES ('200205', 'Montero', 'Ayabaca', 'Piura', '-4.6303', '-79.8275', '51');
INSERT INTO `ubigeo` VALUES ('200206', 'Pacaipampa', 'Ayabaca', 'Piura', '-4.9953', '-79.67', '51');
INSERT INTO `ubigeo` VALUES ('200207', 'Paimas', 'Ayabaca', 'Piura', '-4.6269', '-79.9453', '51');
INSERT INTO `ubigeo` VALUES ('200208', 'Sapillica', 'Ayabaca', 'Piura', '-4.7786', '-79.9831', '51');
INSERT INTO `ubigeo` VALUES ('200209', 'Sicchez', 'Ayabaca', 'Piura', '-4.5703', '-79.765', '51');
INSERT INTO `ubigeo` VALUES ('200210', 'Suyo', 'Ayabaca', 'Piura', '-4.5139', '-80.0031', '51');
INSERT INTO `ubigeo` VALUES ('200301', 'Huancabamba', 'Huancabamba', 'Piura', '-5.2394', '-79.4508', '51');
INSERT INTO `ubigeo` VALUES ('200302', 'Canchaque', 'Huancabamba', 'Piura', '-5.3758', '-79.6097', '51');
INSERT INTO `ubigeo` VALUES ('200303', 'El Carmen de La Frontera', 'Huancabamba', 'Piura', '-5.1481', '-79.4347', '51');
INSERT INTO `ubigeo` VALUES ('200304', 'Huarmaca', 'Huancabamba', 'Piura', '-5.5683', '-79.5247', '51');
INSERT INTO `ubigeo` VALUES ('200305', 'Lalaquiz', 'Huancabamba', 'Piura', '-5.2128', '-79.6783', '51');
INSERT INTO `ubigeo` VALUES ('200306', 'San Miguel de El Faique', 'Huancabamba', 'Piura', '-5.4022', '-79.6053', '51');
INSERT INTO `ubigeo` VALUES ('200307', 'Sondor', 'Huancabamba', 'Piura', '-5.315', '-79.4106', '51');
INSERT INTO `ubigeo` VALUES ('200308', 'Sondorillo', 'Huancabamba', 'Piura', '-5.3394', '-79.43', '51');
INSERT INTO `ubigeo` VALUES ('200401', 'Chulucanas', 'Morropon', 'Piura', '-5.0969', '-80.1642', '51');
INSERT INTO `ubigeo` VALUES ('200402', 'Buenos Aires', 'Morropon', 'Piura', '-5.2678', '-79.9708', '51');
INSERT INTO `ubigeo` VALUES ('200403', 'Chalaco', 'Morropon', 'Piura', '-5.0417', '-79.7958', '51');
INSERT INTO `ubigeo` VALUES ('200404', 'La Matanza', 'Morropon', 'Piura', '-5.2114', '-80.0906', '51');
INSERT INTO `ubigeo` VALUES ('200405', 'Morropon', 'Morropon', 'Piura', '-5.1861', '-79.9717', '51');
INSERT INTO `ubigeo` VALUES ('200406', 'Salitral', 'Morropon', 'Piura', '-5.3419', '-79.8319', '51');
INSERT INTO `ubigeo` VALUES ('200407', 'San Juan de Bigote', 'Morropon', 'Piura', '-5.3189', '-79.7875', '51');
INSERT INTO `ubigeo` VALUES ('200408', 'Santa Catalina de Mossa', 'Morropon', 'Piura', '-5.1031', '-79.8872', '51');
INSERT INTO `ubigeo` VALUES ('200409', 'Santo Domingo', 'Morropon', 'Piura', '-5.0292', '-79.8756', '51');
INSERT INTO `ubigeo` VALUES ('200410', 'Yamango', 'Morropon', 'Piura', '-5.1814', '-79.7528', '51');
INSERT INTO `ubigeo` VALUES ('200501', 'Paita', 'Paita', 'Piura', '-5.0883', '-81.1164', '51');
INSERT INTO `ubigeo` VALUES ('200502', 'Amotape', 'Paita', 'Piura', '-4.8822', '-81.0178', '51');
INSERT INTO `ubigeo` VALUES ('200503', 'Arenal', 'Paita', 'Piura', '-4.8842', '-81.0269', '51');
INSERT INTO `ubigeo` VALUES ('200504', 'Colan', 'Paita', 'Piura', '-4.9092', '-81.0572', '51');
INSERT INTO `ubigeo` VALUES ('200505', 'La Huaca', 'Paita', 'Piura', '-4.9117', '-80.9608', '51');
INSERT INTO `ubigeo` VALUES ('200506', 'Tamarindo', 'Paita', 'Piura', '-4.8792', '-80.9739', '51');
INSERT INTO `ubigeo` VALUES ('200507', 'Vichayal', 'Paita', 'Piura', '-4.8653', '-81.0719', '51');
INSERT INTO `ubigeo` VALUES ('200601', 'Sullana', 'Sullana', 'Piura', '-4.9044', '-80.7047', '51');
INSERT INTO `ubigeo` VALUES ('200602', 'Bellavista', 'Sullana', 'Piura', '-4.8908', '-80.6808', '51');
INSERT INTO `ubigeo` VALUES ('200603', 'Ignacio Escudero', 'Sullana', 'Piura', '-4.8458', '-80.8747', '51');
INSERT INTO `ubigeo` VALUES ('200604', 'Lancones', 'Sullana', 'Piura', '-4.5767', '-80.4778', '51');
INSERT INTO `ubigeo` VALUES ('200605', 'Marcavelica', 'Sullana', 'Piura', '-4.8814', '-80.7061', '51');
INSERT INTO `ubigeo` VALUES ('200606', 'Miguel Checa', 'Sullana', 'Piura', '-4.9025', '-80.8169', '51');
INSERT INTO `ubigeo` VALUES ('200607', 'Querecotillo', 'Sullana', 'Piura', '-4.84', '-80.6519', '51');
INSERT INTO `ubigeo` VALUES ('200608', 'Salitral', 'Sullana', 'Piura', '-4.8583', '-80.6794', '51');
INSERT INTO `ubigeo` VALUES ('200701', 'Pariñas', 'Talara', 'Piura', '-4.5811', '-81.2747', '51');
INSERT INTO `ubigeo` VALUES ('200702', 'El Alto', 'Talara', 'Piura', '-4.2697', '-81.2239', '51');
INSERT INTO `ubigeo` VALUES ('200703', 'La Brea', 'Talara', 'Piura', '-4.6564', '-81.3069', '51');
INSERT INTO `ubigeo` VALUES ('200704', 'Lobitos', 'Talara', 'Piura', '-4.4531', '-81.2783', '51');
INSERT INTO `ubigeo` VALUES ('200705', 'Los Organos', 'Talara', 'Piura', '-4.1789', '-81.1322', '51');
INSERT INTO `ubigeo` VALUES ('200706', 'Mancora', 'Talara', 'Piura', '-4.1083', '-81.0556', '51');
INSERT INTO `ubigeo` VALUES ('200801', 'Sechura', 'Sechura', 'Piura', '-5.5567', '-80.8217', '51');
INSERT INTO `ubigeo` VALUES ('200802', 'Bellavista de La Union', 'Sechura', 'Piura', '-5.4394', '-80.7547', '51');
INSERT INTO `ubigeo` VALUES ('200803', 'Bernal', 'Sechura', 'Piura', '-5.4608', '-80.7422', '51');
INSERT INTO `ubigeo` VALUES ('200804', 'Cristo Nos Valga', 'Sechura', 'Piura', '-5.4939', '-80.7414', '51');
INSERT INTO `ubigeo` VALUES ('200805', 'Vice', 'Sechura', 'Piura', '-5.4231', '-80.7767', '51');
INSERT INTO `ubigeo` VALUES ('200806', 'Rinconada Llicuar', 'Sechura', 'Piura', '-5.4572', '-80.7614', '51');
INSERT INTO `ubigeo` VALUES ('210101', 'Puno', 'Puno', 'Puno', '-15.8406', '-70.0278', '51');
INSERT INTO `ubigeo` VALUES ('210102', 'Acora', 'Puno', 'Puno', '-15.9736', '-69.7978', '51');
INSERT INTO `ubigeo` VALUES ('210103', 'Amantani', 'Puno', 'Puno', '-15.6572', '-69.7194', '51');
INSERT INTO `ubigeo` VALUES ('210104', 'Atuncolla', 'Puno', 'Puno', '-15.6878', '-70.1436', '51');
INSERT INTO `ubigeo` VALUES ('210105', 'Capachica', 'Puno', 'Puno', '-15.6431', '-69.8303', '51');
INSERT INTO `ubigeo` VALUES ('210106', 'Chucuito', 'Puno', 'Puno', '-15.8947', '-69.8922', '51');
INSERT INTO `ubigeo` VALUES ('210107', 'Coata', 'Puno', 'Puno', '-15.5711', '-69.9503', '51');
INSERT INTO `ubigeo` VALUES ('210108', 'Huata', 'Puno', 'Puno', '-15.6144', '-69.9722', '51');
INSERT INTO `ubigeo` VALUES ('210109', 'Mañazo', 'Puno', 'Puno', '-15.7992', '-70.3458', '51');
INSERT INTO `ubigeo` VALUES ('210110', 'Paucarcolla', 'Puno', 'Puno', '-15.7461', '-70.0556', '51');
INSERT INTO `ubigeo` VALUES ('210111', 'Pichacani', 'Puno', 'Puno', '-16.1508', '-70.0642', '51');
INSERT INTO `ubigeo` VALUES ('210112', 'Plateria', 'Puno', 'Puno', '-15.9475', '-69.8356', '51');
INSERT INTO `ubigeo` VALUES ('210113', 'San Antonio', 'Puno', 'Puno', '-16.1414', '-70.3458', '51');
INSERT INTO `ubigeo` VALUES ('210114', 'Tiquillaca', 'Puno', 'Puno', '-15.7978', '-70.1872', '51');
INSERT INTO `ubigeo` VALUES ('210115', 'Vilque', 'Puno', 'Puno', '-15.7661', '-70.2594', '51');
INSERT INTO `ubigeo` VALUES ('210201', 'Azangaro', 'Azangaro', 'Puno', '-14.9083', '-70.1969', '51');
INSERT INTO `ubigeo` VALUES ('210202', 'Achaya', 'Azangaro', 'Puno', '-15.2847', '-70.1608', '51');
INSERT INTO `ubigeo` VALUES ('210203', 'Arapa', 'Azangaro', 'Puno', '-15.1411', '-70.1117', '51');
INSERT INTO `ubigeo` VALUES ('210204', 'Asillo', 'Azangaro', 'Puno', '-14.7864', '-70.3544', '51');
INSERT INTO `ubigeo` VALUES ('210205', 'Caminaca', 'Azangaro', 'Puno', '-15.3239', '-70.0747', '51');
INSERT INTO `ubigeo` VALUES ('210206', 'Chupa', 'Azangaro', 'Puno', '-15.1069', '-69.9861', '51');
INSERT INTO `ubigeo` VALUES ('210207', 'Jose Domingo Choquehuanca', 'Azangaro', 'Puno', '-15.0336', '-70.3381', '51');
INSERT INTO `ubigeo` VALUES ('210208', 'Muñani', 'Azangaro', 'Puno', '-14.7689', '-69.9528', '51');
INSERT INTO `ubigeo` VALUES ('210209', 'Potoni', 'Azangaro', 'Puno', '-14.3944', '-70.1136', '51');
INSERT INTO `ubigeo` VALUES ('210210', 'Saman', 'Azangaro', 'Puno', '-15.2917', '-70.0169', '51');
INSERT INTO `ubigeo` VALUES ('210211', 'San Anton', 'Azangaro', 'Puno', '-14.5922', '-70.3125', '51');
INSERT INTO `ubigeo` VALUES ('210212', 'San Jose', 'Azangaro', 'Puno', '-14.6817', '-70.1606', '51');
INSERT INTO `ubigeo` VALUES ('210213', 'San Juan de Salinas', 'Azangaro', 'Puno', '-14.9911', '-70.1056', '51');
INSERT INTO `ubigeo` VALUES ('210214', 'Santiago de Pupuja', 'Azangaro', 'Puno', '-15.0547', '-70.2792', '51');
INSERT INTO `ubigeo` VALUES ('210215', 'Tirapata', 'Azangaro', 'Puno', '-14.9544', '-70.4028', '51');
INSERT INTO `ubigeo` VALUES ('210301', 'Macusani', 'Carabaya', 'Puno', '-14.0686', '-70.4308', '51');
INSERT INTO `ubigeo` VALUES ('210302', 'Ajoyani', 'Carabaya', 'Puno', '-14.2294', '-70.2264', '51');
INSERT INTO `ubigeo` VALUES ('210303', 'Ayapata', 'Carabaya', 'Puno', '-13.7781', '-70.325', '51');
INSERT INTO `ubigeo` VALUES ('210304', 'Coasa', 'Carabaya', 'Puno', '-13.9853', '-70.0197', '51');
INSERT INTO `ubigeo` VALUES ('210305', 'Corani', 'Carabaya', 'Puno', '-13.8686', '-70.6042', '51');
INSERT INTO `ubigeo` VALUES ('210306', 'Crucero', 'Carabaya', 'Puno', '-14.3619', '-70.025', '51');
INSERT INTO `ubigeo` VALUES ('210307', 'Ituata', 'Carabaya', 'Puno', '-13.8761', '-70.2178', '51');
INSERT INTO `ubigeo` VALUES ('210308', 'Ollachea', 'Carabaya', 'Puno', '-13.7944', '-70.4756', '51');
INSERT INTO `ubigeo` VALUES ('210309', 'San Gaban', 'Carabaya', 'Puno', '-13.4333', '-70.3889', '51');
INSERT INTO `ubigeo` VALUES ('210310', 'Usicayos', 'Carabaya', 'Puno', '-14.1256', '-69.9672', '51');
INSERT INTO `ubigeo` VALUES ('210401', 'Juli', 'Chucuito', 'Puno', '-16.215', '-69.4619', '51');
INSERT INTO `ubigeo` VALUES ('210402', 'Desaguadero', 'Chucuito', 'Puno', '-16.5653', '-69.0433', '51');
INSERT INTO `ubigeo` VALUES ('210403', 'Huacullani', 'Chucuito', 'Puno', '-16.6292', '-69.325', '51');
INSERT INTO `ubigeo` VALUES ('210404', 'Kelluyo', 'Chucuito', 'Puno', '-16.7208', '-69.2492', '51');
INSERT INTO `ubigeo` VALUES ('210405', 'Pisacoma', 'Chucuito', 'Puno', '-16.9092', '-69.3736', '51');
INSERT INTO `ubigeo` VALUES ('210406', 'Pomata', 'Chucuito', 'Puno', '-16.2728', '-69.2933', '51');
INSERT INTO `ubigeo` VALUES ('210407', 'Zepita', 'Chucuito', 'Puno', '-16.4964', '-69.105', '51');
INSERT INTO `ubigeo` VALUES ('210501', 'Ilave', 'El Collao', 'Puno', '-16.0867', '-69.6386', '51');
INSERT INTO `ubigeo` VALUES ('210502', 'Capazo', 'El Collao', 'Puno', '-17.1828', '-69.7439', '51');
INSERT INTO `ubigeo` VALUES ('210503', 'Pilcuyo', 'El Collao', 'Puno', '-16.11', '-69.5547', '51');
INSERT INTO `ubigeo` VALUES ('210504', 'Santa Rosa', 'El Collao', 'Puno', '-16.7414', '-69.7175', '51');
INSERT INTO `ubigeo` VALUES ('210505', 'Conduriri', 'El Collao', 'Puno', '-16.6156', '-69.7025', '51');
INSERT INTO `ubigeo` VALUES ('210601', 'Huancane', 'Huancane', 'Puno', '-15.2017', '-69.7614', '51');
INSERT INTO `ubigeo` VALUES ('210602', 'Cojata', 'Huancane', 'Puno', '-15.0161', '-69.3647', '51');
INSERT INTO `ubigeo` VALUES ('210603', 'Huatasani', 'Huancane', 'Puno', '-15.0589', '-69.8042', '51');
INSERT INTO `ubigeo` VALUES ('210604', 'Inchupalla', 'Huancane', 'Puno', '-15.0089', '-69.6822', '51');
INSERT INTO `ubigeo` VALUES ('210605', 'Pusi', 'Huancane', 'Puno', '-15.4419', '-69.9294', '51');
INSERT INTO `ubigeo` VALUES ('210606', 'Rosaspata', 'Huancane', 'Puno', '-15.2347', '-69.5303', '51');
INSERT INTO `ubigeo` VALUES ('210607', 'Taraco', 'Huancane', 'Puno', '-15.2978', '-69.9792', '51');
INSERT INTO `ubigeo` VALUES ('210608', 'Vilque Chico', 'Huancane', 'Puno', '-15.2144', '-69.6886', '51');
INSERT INTO `ubigeo` VALUES ('210701', 'Lampa', 'Lampa', 'Puno', '-15.3636', '-70.3653', '51');
INSERT INTO `ubigeo` VALUES ('210702', 'Cabanilla', 'Lampa', 'Puno', '-15.6194', '-70.3489', '51');
INSERT INTO `ubigeo` VALUES ('210703', 'Calapuja', 'Lampa', 'Puno', '-15.31', '-70.2217', '51');
INSERT INTO `ubigeo` VALUES ('210704', 'Nicasio', 'Lampa', 'Puno', '-15.2361', '-70.2622', '51');
INSERT INTO `ubigeo` VALUES ('210705', 'Ocuviri', 'Lampa', 'Puno', '-15.1128', '-70.9117', '51');
INSERT INTO `ubigeo` VALUES ('210706', 'Palca', 'Lampa', 'Puno', '-15.235', '-70.5992', '51');
INSERT INTO `ubigeo` VALUES ('210707', 'Paratia', 'Lampa', 'Puno', '-15.4539', '-70.6008', '51');
INSERT INTO `ubigeo` VALUES ('210708', 'Pucara', 'Lampa', 'Puno', '-15.0419', '-70.3689', '51');
INSERT INTO `ubigeo` VALUES ('210709', 'Santa Lucia', 'Lampa', 'Puno', '-15.6986', '-70.6061', '51');
INSERT INTO `ubigeo` VALUES ('210710', 'Vilavila', 'Lampa', 'Puno', '-15.1883', '-70.6606', '51');
INSERT INTO `ubigeo` VALUES ('210801', 'Ayaviri', 'Melgar', 'Puno', '-14.8811', '-70.5897', '51');
INSERT INTO `ubigeo` VALUES ('210802', 'Antauta', 'Melgar', 'Puno', '-14.3', '-70.295', '51');
INSERT INTO `ubigeo` VALUES ('210803', 'Cupi', 'Melgar', 'Puno', '-14.9058', '-70.8683', '51');
INSERT INTO `ubigeo` VALUES ('210804', 'Llalli', 'Melgar', 'Puno', '-14.9339', '-70.8792', '51');
INSERT INTO `ubigeo` VALUES ('210805', 'Macari', 'Melgar', 'Puno', '-14.7706', '-70.9033', '51');
INSERT INTO `ubigeo` VALUES ('210806', 'Nuñoa', 'Melgar', 'Puno', '-14.4767', '-70.6372', '51');
INSERT INTO `ubigeo` VALUES ('210807', 'Orurillo', 'Melgar', 'Puno', '-14.7261', '-70.5133', '51');
INSERT INTO `ubigeo` VALUES ('210808', 'Santa Rosa', 'Melgar', 'Puno', '-14.6072', '-70.7872', '51');
INSERT INTO `ubigeo` VALUES ('210809', 'Umachiri', 'Melgar', 'Puno', '-14.8497', '-70.7494', '51');
INSERT INTO `ubigeo` VALUES ('210901', 'Moho', 'Moho', 'Puno', '-15.36', '-69.5', '51');
INSERT INTO `ubigeo` VALUES ('210902', 'Conima', 'Moho', 'Puno', '-15.4572', '-69.4375', '51');
INSERT INTO `ubigeo` VALUES ('210903', 'Huayrapata', 'Moho', 'Puno', '-15.3211', '-69.3494', '51');
INSERT INTO `ubigeo` VALUES ('210904', 'Tilali', 'Moho', 'Puno', '-15.5192', '-69.3456', '51');
INSERT INTO `ubigeo` VALUES ('211001', 'Putina', 'San Antonio de Putin', 'Puno', '-14.9003', '-69.8619', '51');
INSERT INTO `ubigeo` VALUES ('211002', 'Ananea', 'San Antonio de Putin', 'Puno', '-14.6786', '-69.5333', '51');
INSERT INTO `ubigeo` VALUES ('211003', 'Pedro Vilca Apaza', 'San Antonio de Putin', 'Puno', '-15.0592', '-69.8897', '51');
INSERT INTO `ubigeo` VALUES ('211004', 'Quilcapuncu', 'San Antonio de Putin', 'Puno', '-14.8964', '-69.7344', '51');
INSERT INTO `ubigeo` VALUES ('211005', 'Sina', 'San Antonio de Putin', 'Puno', '-14.49', '-69.2817', '51');
INSERT INTO `ubigeo` VALUES ('211101', 'Juliaca', 'San Roman', 'Puno', '-15.4939', '-70.1356', '51');
INSERT INTO `ubigeo` VALUES ('211102', 'Cabana', 'San Roman', 'Puno', '-15.65', '-70.3211', '51');
INSERT INTO `ubigeo` VALUES ('211103', 'Cabanillas', 'San Roman', 'Puno', '-15.6425', '-70.3503', '51');
INSERT INTO `ubigeo` VALUES ('211104', 'Caracoto', 'San Roman', 'Puno', '-15.5683', '-70.1022', '51');
INSERT INTO `ubigeo` VALUES ('211105', 'San Miguel', 'San Roman', 'Puno', '-15.4097', '-70.0958', '51');
INSERT INTO `ubigeo` VALUES ('211201', 'Sandia', 'Sandia', 'Puno', '-14.3231', '-69.4667', '51');
INSERT INTO `ubigeo` VALUES ('211202', 'Cuyocuyo', 'Sandia', 'Puno', '-14.4717', '-69.54', '51');
INSERT INTO `ubigeo` VALUES ('211203', 'Limbani', 'Sandia', 'Puno', '-14.1458', '-69.6897', '51');
INSERT INTO `ubigeo` VALUES ('211204', 'Patambuco', 'Sandia', 'Puno', '-14.3594', '-69.6222', '51');
INSERT INTO `ubigeo` VALUES ('211205', 'Phara', 'Sandia', 'Puno', '-14.1511', '-69.6642', '51');
INSERT INTO `ubigeo` VALUES ('211206', 'Quiaca', 'Sandia', 'Puno', '-14.4253', '-69.3417', '51');
INSERT INTO `ubigeo` VALUES ('211207', 'San Juan del Oro', 'Sandia', 'Puno', '-14.2211', '-69.1528', '51');
INSERT INTO `ubigeo` VALUES ('211208', 'Yanahuaya', 'Sandia', 'Puno', '-14.2822', '-69.1844', '51');
INSERT INTO `ubigeo` VALUES ('211209', 'Alto Inambari', 'Sandia', 'Puno', '-14.0897', '-69.2442', '51');
INSERT INTO `ubigeo` VALUES ('211210', 'San Pedro de Putina Punco', 'Sandia', 'Puno', '-14.1119', '-69.0467', '51');
INSERT INTO `ubigeo` VALUES ('211301', 'Yunguyo', 'Yunguyo', 'Puno', '-16.2469', '-69.095', '51');
INSERT INTO `ubigeo` VALUES ('211302', 'Anapia', 'Yunguyo', 'Puno', '-16.3133', '-68.8539', '51');
INSERT INTO `ubigeo` VALUES ('211303', 'Copani', 'Yunguyo', 'Puno', '-16.3989', '-69.0439', '51');
INSERT INTO `ubigeo` VALUES ('211304', 'Cuturapi', 'Yunguyo', 'Puno', '-16.2706', '-69.1781', '51');
INSERT INTO `ubigeo` VALUES ('211305', 'Ollaraya', 'Yunguyo', 'Puno', '-16.2308', '-68.9981', '51');
INSERT INTO `ubigeo` VALUES ('211306', 'Tinicachi', 'Yunguyo', 'Puno', '-16.1967', '-68.9603', '51');
INSERT INTO `ubigeo` VALUES ('211307', 'Unicachi', 'Yunguyo', 'Puno', '-16.2239', '-68.9761', '51');
INSERT INTO `ubigeo` VALUES ('220101', 'Moyobamba', 'Moyobamba', 'San Martin', '-6.0283', '-76.9719', '51');
INSERT INTO `ubigeo` VALUES ('220102', 'Calzada', 'Moyobamba', 'San Martin', '-6.0319', '-77.0675', '51');
INSERT INTO `ubigeo` VALUES ('220103', 'Habana', 'Moyobamba', 'San Martin', '-6.0808', '-77.0928', '51');
INSERT INTO `ubigeo` VALUES ('220104', 'Jepelacio', 'Moyobamba', 'San Martin', '-6.1081', '-76.9161', '51');
INSERT INTO `ubigeo` VALUES ('220105', 'Soritor', 'Moyobamba', 'San Martin', '-6.1408', '-77.105', '51');
INSERT INTO `ubigeo` VALUES ('220106', 'Yantalo', 'Moyobamba', 'San Martin', '-5.9747', '-77.0225', '51');
INSERT INTO `ubigeo` VALUES ('220201', 'Bellavista', 'Bellavista', 'San Martin', '-7.0653', '-76.5883', '51');
INSERT INTO `ubigeo` VALUES ('220202', 'Alto Biavo', 'Bellavista', 'San Martin', '-7.2936', '-76.4544', '51');
INSERT INTO `ubigeo` VALUES ('220203', 'Bajo Biavo', 'Bellavista', 'San Martin', '-7.1011', '-76.4867', '51');
INSERT INTO `ubigeo` VALUES ('220204', 'Huallaga', 'Bellavista', 'San Martin', '-7.1292', '-76.6489', '51');
INSERT INTO `ubigeo` VALUES ('220205', 'San Pablo', 'Bellavista', 'San Martin', '-6.8081', '-76.5731', '51');
INSERT INTO `ubigeo` VALUES ('220206', 'San Rafael', 'Bellavista', 'San Martin', '-7.0308', '-76.4764', '51');
INSERT INTO `ubigeo` VALUES ('220301', 'San Jose de Sisa', 'El Dorado', 'San Martin', '-6.6136', '-76.6931', '51');
INSERT INTO `ubigeo` VALUES ('220302', 'Agua Blanca', 'El Dorado', 'San Martin', '-6.7289', '-76.6975', '51');
INSERT INTO `ubigeo` VALUES ('220303', 'San Martin', 'El Dorado', 'San Martin', '-6.5147', '-76.7425', '51');
INSERT INTO `ubigeo` VALUES ('220304', 'Santa Rosa', 'El Dorado', 'San Martin', '-6.7456', '-76.6264', '51');
INSERT INTO `ubigeo` VALUES ('220305', 'Shatoja', 'El Dorado', 'San Martin', '-6.5283', '-76.7211', '51');
INSERT INTO `ubigeo` VALUES ('220401', 'Saposoa', 'Huallaga', 'San Martin', '-6.9339', '-76.7733', '51');
INSERT INTO `ubigeo` VALUES ('220402', 'Alto Saposoa', 'Huallaga', 'San Martin', '-6.7658', '-76.8139', '51');
INSERT INTO `ubigeo` VALUES ('220403', 'El Eslabon', 'Huallaga', 'San Martin', '-7.0031', '-76.7436', '51');
INSERT INTO `ubigeo` VALUES ('220404', 'Piscoyacu', 'Huallaga', 'San Martin', '-6.9831', '-76.7647', '51');
INSERT INTO `ubigeo` VALUES ('220405', 'Sacanche', 'Huallaga', 'San Martin', '-7.07', '-76.7136', '51');
INSERT INTO `ubigeo` VALUES ('220406', 'Tingo de Saposoa', 'Huallaga', 'San Martin', '-7.0936', '-76.6417', '51');
INSERT INTO `ubigeo` VALUES ('220501', 'Lamas', 'Lamas', 'San Martin', '-6.4217', '-76.5211', '51');
INSERT INTO `ubigeo` VALUES ('220502', 'Alonso de Alvarado', 'Lamas', 'San Martin', '-6.35', '-76.77', '51');
INSERT INTO `ubigeo` VALUES ('220503', 'Barranquita', 'Lamas', 'San Martin', '-6.2517', '-76.0331', '51');
INSERT INTO `ubigeo` VALUES ('220504', 'Caynarachi', 'Lamas', 'San Martin', '-6.3306', '-76.2836', '51');
INSERT INTO `ubigeo` VALUES ('220505', 'Cuñumbuqui', 'Lamas', 'San Martin', '-6.5089', '-76.4803', '51');
INSERT INTO `ubigeo` VALUES ('220506', 'Pinto Recodo', 'Lamas', 'San Martin', '-6.3794', '-76.6033', '51');
INSERT INTO `ubigeo` VALUES ('220507', 'Rumisapa', 'Lamas', 'San Martin', '-6.4486', '-76.4722', '51');
INSERT INTO `ubigeo` VALUES ('220508', 'San Roque de Cumbaza', 'Lamas', 'San Martin', '-6.3864', '-76.4419', '51');
INSERT INTO `ubigeo` VALUES ('220509', 'Shanao', 'Lamas', 'San Martin', '-6.41', '-76.5939', '51');
INSERT INTO `ubigeo` VALUES ('220510', 'Tabalosos', 'Lamas', 'San Martin', '-6.3856', '-76.6333', '51');
INSERT INTO `ubigeo` VALUES ('220511', 'Zapatero', 'Lamas', 'San Martin', '-6.5308', '-76.4911', '51');
INSERT INTO `ubigeo` VALUES ('220601', 'Juanjui', 'Mariscal Caceres', 'San Martin', '-7.1819', '-76.7317', '51');
INSERT INTO `ubigeo` VALUES ('220602', 'Campanilla', 'Mariscal Caceres', 'San Martin', '-7.4814', '-76.6528', '51');
INSERT INTO `ubigeo` VALUES ('220603', 'Huicungo', 'Mariscal Caceres', 'San Martin', '-7.3272', '-76.7783', '51');
INSERT INTO `ubigeo` VALUES ('220604', 'Pachiza', 'Mariscal Caceres', 'San Martin', '-7.2975', '-76.7739', '51');
INSERT INTO `ubigeo` VALUES ('220605', 'Pajarillo', 'Mariscal Caceres', 'San Martin', '-7.1789', '-76.6881', '51');
INSERT INTO `ubigeo` VALUES ('220701', 'Picota', 'Picota', 'San Martin', '-6.9194', '-76.3317', '51');
INSERT INTO `ubigeo` VALUES ('220702', 'Buenos Aires', 'Picota', 'San Martin', '-6.7939', '-76.3269', '51');
INSERT INTO `ubigeo` VALUES ('220703', 'Caspisapa', 'Picota', 'San Martin', '-6.9589', '-76.4189', '51');
INSERT INTO `ubigeo` VALUES ('220704', 'Pilluana', 'Picota', 'San Martin', '-6.7781', '-76.2931', '51');
INSERT INTO `ubigeo` VALUES ('220705', 'Pucacaca', 'Picota', 'San Martin', '-6.8506', '-76.3417', '51');
INSERT INTO `ubigeo` VALUES ('220706', 'San Cristobal', 'Picota', 'San Martin', '-6.9925', '-76.4186', '51');
INSERT INTO `ubigeo` VALUES ('220707', 'San Hilarion', 'Picota', 'San Martin', '-7.0022', '-76.4428', '51');
INSERT INTO `ubigeo` VALUES ('220708', 'Shamboyacu', 'Picota', 'San Martin', '-7.0425', '-76.1119', '51');
INSERT INTO `ubigeo` VALUES ('220709', 'Tingo de Ponasa', 'Picota', 'San Martin', '-6.9356', '-76.2511', '51');
INSERT INTO `ubigeo` VALUES ('220710', 'Tres Unidos', 'Picota', 'San Martin', '-6.8064', '-76.2311', '51');
INSERT INTO `ubigeo` VALUES ('220801', 'Rioja', 'Rioja', 'San Martin', '-6.0589', '-77.1669', '51');
INSERT INTO `ubigeo` VALUES ('220802', 'Awajun', 'Rioja', 'San Martin', '-5.8139', '-77.3822', '51');
INSERT INTO `ubigeo` VALUES ('220803', 'Elias Soplin Vargas', 'Rioja', 'San Martin', '-5.9908', '-77.2781', '51');
INSERT INTO `ubigeo` VALUES ('220804', 'Nueva Cajamarca', 'Rioja', 'San Martin', '-5.94', '-77.3083', '51');
INSERT INTO `ubigeo` VALUES ('220805', 'Pardo Miguel', 'Rioja', 'San Martin', '-5.7381', '-77.5025', '51');
INSERT INTO `ubigeo` VALUES ('220806', 'Posic', 'Rioja', 'San Martin', '-6.0139', '-77.1636', '51');
INSERT INTO `ubigeo` VALUES ('220807', 'San Fernando', 'Rioja', 'San Martin', '-5.9019', '-77.27', '51');
INSERT INTO `ubigeo` VALUES ('220808', 'Yorongos', 'Rioja', 'San Martin', '-6.1356', '-77.1447', '51');
INSERT INTO `ubigeo` VALUES ('220809', 'Yuracyacu', 'Rioja', 'San Martin', '-5.9278', '-77.2269', '51');
INSERT INTO `ubigeo` VALUES ('220901', 'Tarapoto', 'San Martin', 'San Martin', '-6.4969', '-76.3664', '51');
INSERT INTO `ubigeo` VALUES ('220902', 'Alberto Leveau', 'San Martin', 'San Martin', '-6.6633', '-76.2878', '51');
INSERT INTO `ubigeo` VALUES ('220903', 'Cacatachi', 'San Martin', 'San Martin', '-6.4619', '-76.4514', '51');
INSERT INTO `ubigeo` VALUES ('220904', 'Chazuta', 'San Martin', 'San Martin', '-6.5739', '-76.0931', '51');
INSERT INTO `ubigeo` VALUES ('220905', 'Chipurana', 'San Martin', 'San Martin', '-6.3539', '-75.7411', '51');
INSERT INTO `ubigeo` VALUES ('220906', 'El Porvenir', 'San Martin', 'San Martin', '-6.215', '-75.7867', '51');
INSERT INTO `ubigeo` VALUES ('220907', 'Huimbayoc', 'San Martin', 'San Martin', '-6.4167', '-75.7658', '51');
INSERT INTO `ubigeo` VALUES ('220908', 'Juan Guerra', 'San Martin', 'San Martin', '-6.5833', '-76.3336', '51');
INSERT INTO `ubigeo` VALUES ('220909', 'La Banda de Shilcayo', 'San Martin', 'San Martin', '-6.5033', '-76.3514', '51');
INSERT INTO `ubigeo` VALUES ('220910', 'Morales', 'San Martin', 'San Martin', '-6.4797', '-76.3828', '51');
INSERT INTO `ubigeo` VALUES ('220911', 'Papaplaya', 'San Martin', 'San Martin', '-6.245', '-75.7903', '51');
INSERT INTO `ubigeo` VALUES ('220912', 'San Antonio', 'San Martin', 'San Martin', '-6.42', '-76.4044', '51');
INSERT INTO `ubigeo` VALUES ('220913', 'Sauce', 'San Martin', 'San Martin', '-6.6914', '-76.2183', '51');
INSERT INTO `ubigeo` VALUES ('220914', 'Shapaja', 'San Martin', 'San Martin', '-6.58', '-76.2653', '51');
INSERT INTO `ubigeo` VALUES ('221001', 'Tocache', 'Tocache', 'San Martin', '-8.1883', '-76.5153', '51');
INSERT INTO `ubigeo` VALUES ('221002', 'Nuevo Progreso', 'Tocache', 'San Martin', '-8.45', '-76.3253', '51');
INSERT INTO `ubigeo` VALUES ('221003', 'Polvora', 'Tocache', 'San Martin', '-7.9075', '-76.6706', '51');
INSERT INTO `ubigeo` VALUES ('221004', 'Shunte', 'Tocache', 'San Martin', '-8.35', '-76.7231', '51');
INSERT INTO `ubigeo` VALUES ('221005', 'Uchiza', 'Tocache', 'San Martin', '-8.4558', '-76.46', '51');
INSERT INTO `ubigeo` VALUES ('230101', 'Tacna', 'Tacna', 'Tacna', '-18.01', '-70.2478', '51');
INSERT INTO `ubigeo` VALUES ('230102', 'Alto de La Alianza', 'Tacna', 'Tacna', '-17.9908', '-70.2475', '51');
INSERT INTO `ubigeo` VALUES ('230103', 'Calana', 'Tacna', 'Tacna', '-17.9406', '-70.1825', '51');
INSERT INTO `ubigeo` VALUES ('230104', 'Ciudad Nueva', 'Tacna', 'Tacna', '-17.985', '-70.2378', '51');
INSERT INTO `ubigeo` VALUES ('230105', 'Inclan', 'Tacna', 'Tacna', '-17.795', '-70.4919', '51');
INSERT INTO `ubigeo` VALUES ('230106', 'Pachia', 'Tacna', 'Tacna', '-17.8972', '-70.1528', '51');
INSERT INTO `ubigeo` VALUES ('230107', 'Palca', 'Tacna', 'Tacna', '-17.7733', '-69.9583', '51');
INSERT INTO `ubigeo` VALUES ('230108', 'Pocollay', 'Tacna', 'Tacna', '-17.9964', '-70.2197', '51');
INSERT INTO `ubigeo` VALUES ('230109', 'Sama', 'Tacna', 'Tacna', '-17.8586', '-70.5731', '51');
INSERT INTO `ubigeo` VALUES ('230110', 'Coronel Gregorio Albarracin Lanchipa', 'Tacna', 'Tacna', '-18.0408', '-70.2542', '51');
INSERT INTO `ubigeo` VALUES ('230111', 'La Yarada-Los Palos', 'Tacna', 'Tacna', '-18.2292', '-70.4769', '51');
INSERT INTO `ubigeo` VALUES ('230201', 'Candarave', 'Candarave', 'Tacna', '-17.2669', '-70.2497', '51');
INSERT INTO `ubigeo` VALUES ('230202', 'Cairani', 'Candarave', 'Tacna', '-17.2861', '-70.3628', '51');
INSERT INTO `ubigeo` VALUES ('230203', 'Camilaca', 'Candarave', 'Tacna', '-17.2669', '-70.3833', '51');
INSERT INTO `ubigeo` VALUES ('230204', 'Curibaya', 'Candarave', 'Tacna', '-17.3822', '-70.3353', '51');
INSERT INTO `ubigeo` VALUES ('230205', 'Huanuara', 'Candarave', 'Tacna', '-17.3133', '-70.3217', '51');
INSERT INTO `ubigeo` VALUES ('230206', 'Quilahuani', 'Candarave', 'Tacna', '-17.3175', '-70.2583', '51');
INSERT INTO `ubigeo` VALUES ('230301', 'Locumba', 'Jorge Basadre', 'Tacna', '-17.6133', '-70.7611', '51');
INSERT INTO `ubigeo` VALUES ('230302', 'Ilabaya', 'Jorge Basadre', 'Tacna', '-17.4214', '-70.5122', '51');
INSERT INTO `ubigeo` VALUES ('230303', 'Ite', 'Jorge Basadre', 'Tacna', '-17.8617', '-70.965', '51');
INSERT INTO `ubigeo` VALUES ('230401', 'Tarata', 'Tarata', 'Tacna', '-17.4772', '-70.0306', '51');
INSERT INTO `ubigeo` VALUES ('230402', 'Heroes Albarracin', 'Tarata', 'Tacna', '-17.4817', '-70.1211', '51');
INSERT INTO `ubigeo` VALUES ('230403', 'Estique', 'Tarata', 'Tacna', '-17.5428', '-70.0206', '51');
INSERT INTO `ubigeo` VALUES ('230404', 'Estique-Pampa', 'Tarata', 'Tacna', '-17.5372', '-70.0344', '51');
INSERT INTO `ubigeo` VALUES ('230405', 'Sitajara', 'Tarata', 'Tacna', '-17.3747', '-70.1342', '51');
INSERT INTO `ubigeo` VALUES ('230406', 'Susapaya', 'Tarata', 'Tacna', '-17.3528', '-70.1311', '51');
INSERT INTO `ubigeo` VALUES ('230407', 'Tarucachi', 'Tarata', 'Tacna', '-17.5253', '-70.0292', '51');
INSERT INTO `ubigeo` VALUES ('230408', 'Ticaco', 'Tarata', 'Tacna', '-17.4506', '-70.0456', '51');
INSERT INTO `ubigeo` VALUES ('240101', 'Tumbes', 'Tumbes', 'Tumbes', '-3.5647', '-80.4536', '51');
INSERT INTO `ubigeo` VALUES ('240102', 'Corrales', 'Tumbes', 'Tumbes', '-3.6022', '-80.4797', '51');
INSERT INTO `ubigeo` VALUES ('240103', 'La Cruz', 'Tumbes', 'Tumbes', '-3.6378', '-80.5925', '51');
INSERT INTO `ubigeo` VALUES ('240104', 'Pampas de Hospital', 'Tumbes', 'Tumbes', '-3.6956', '-80.4358', '51');
INSERT INTO `ubigeo` VALUES ('240105', 'San Jacinto', 'Tumbes', 'Tumbes', '-3.6431', '-80.4511', '51');
INSERT INTO `ubigeo` VALUES ('240106', 'San Juan de La Virgen', 'Tumbes', 'Tumbes', '-3.6275', '-80.4336', '51');
INSERT INTO `ubigeo` VALUES ('240201', 'Zorritos', 'Contralmirante Villa', 'Tumbes', '-3.6806', '-80.6783', '51');
INSERT INTO `ubigeo` VALUES ('240202', 'Casitas', 'Contralmirante Villa', 'Tumbes', '-3.9406', '-80.6519', '51');
INSERT INTO `ubigeo` VALUES ('240203', 'Canoas de Punta Sal', 'Contralmirante Villa', 'Tumbes', '-3.9467', '-80.9428', '51');
INSERT INTO `ubigeo` VALUES ('240301', 'Zarumilla', 'Zarumilla', 'Tumbes', '-3.5011', '-80.275', '51');
INSERT INTO `ubigeo` VALUES ('240302', 'Aguas Verdes', 'Zarumilla', 'Tumbes', '-3.4814', '-80.2461', '51');
INSERT INTO `ubigeo` VALUES ('240303', 'Matapalo', 'Zarumilla', 'Tumbes', '-3.6839', '-80.1997', '51');
INSERT INTO `ubigeo` VALUES ('240304', 'Papayal', 'Zarumilla', 'Tumbes', '-3.5736', '-80.2333', '51');
INSERT INTO `ubigeo` VALUES ('250101', 'Calleria', 'Coronel Portillo', 'Ucayali', '-8.3828', '-74.5322', '51');
INSERT INTO `ubigeo` VALUES ('250102', 'Campoverde', 'Coronel Portillo', 'Ucayali', '-8.4761', '-74.8072', '51');
INSERT INTO `ubigeo` VALUES ('250103', 'Iparia', 'Coronel Portillo', 'Ucayali', '-9.3064', '-74.4378', '51');
INSERT INTO `ubigeo` VALUES ('250104', 'Masisea', 'Coronel Portillo', 'Ucayali', '-8.6025', '-74.3097', '51');
INSERT INTO `ubigeo` VALUES ('250105', 'Yarinacocha', 'Coronel Portillo', 'Ucayali', '-8.355', '-74.5769', '51');
INSERT INTO `ubigeo` VALUES ('250106', 'Nueva Requena', 'Coronel Portillo', 'Ucayali', '-8.3061', '-74.8653', '51');
INSERT INTO `ubigeo` VALUES ('250107', 'Manantay', 'Coronel Portillo', 'Ucayali', '-8.3981', '-74.5378', '51');
INSERT INTO `ubigeo` VALUES ('250201', 'Raymondi', 'Atalaya', 'Ucayali', '-10.7278', '-73.7592', '51');
INSERT INTO `ubigeo` VALUES ('250202', 'Sepahua', 'Atalaya', 'Ucayali', '-11.1464', '-73.0475', '51');
INSERT INTO `ubigeo` VALUES ('250203', 'Tahuania', 'Atalaya', 'Ucayali', '-10.1033', '-73.9808', '51');
INSERT INTO `ubigeo` VALUES ('250204', 'Yurua', 'Atalaya', 'Ucayali', '-9.5281', '-72.7622', '51');
INSERT INTO `ubigeo` VALUES ('250301', 'Padre Abad', 'Padre Abad', 'Ucayali', '-9.0375', '-75.5128', '51');
INSERT INTO `ubigeo` VALUES ('250302', 'Irazola', 'Padre Abad', 'Ucayali', '-8.8289', '-75.2139', '51');
INSERT INTO `ubigeo` VALUES ('250303', 'Curimana', 'Padre Abad', 'Ucayali', '-8.4353', '-75.1597', '51');
INSERT INTO `ubigeo` VALUES ('250304', 'Neshuya', 'Padre Abad', 'Ucayali', '-8.6392', '-74.9644', '51');
INSERT INTO `ubigeo` VALUES ('250305', 'Alexander von Humboldt', 'Padre Abad', 'Ucayali', '-8.8264', '-75.0522', '51');
INSERT INTO `ubigeo` VALUES ('250401', 'Purus', 'Purus', 'Ucayali', '-9.7703', '-70.7122', '51');

-- ----------------------------
-- Table structure for unidades
-- ----------------------------
DROP TABLE IF EXISTS `unidades`;
CREATE TABLE `unidades`  (
  `id_unidad` bigint NOT NULL AUTO_INCREMENT,
  `nombre_unidad` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `estatus_unidad` tinyint(1) NULL DEFAULT 1,
  `abreviatura` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `presentacion` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`id_unidad`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of unidades
-- ----------------------------
INSERT INTO `unidades` VALUES (1, 'UNIDAD', 1, 'UND', 1);

-- ----------------------------
-- Table structure for unidades_has_precio
-- ----------------------------
DROP TABLE IF EXISTS `unidades_has_precio`;
CREATE TABLE `unidades_has_precio`  (
  `id_precio` bigint NOT NULL,
  `id_unidad` bigint NOT NULL,
  `id_producto` bigint NOT NULL,
  `precio` decimal(18, 2) NULL DEFAULT 0.00,
  `precio_dolar` decimal(18, 2) NULL DEFAULT 0.00,
  PRIMARY KEY (`id_precio`, `id_unidad`, `id_producto`) USING BTREE,
  INDEX `fk_precios_has_unidades_has_producto_unidades_has_producto1_idx`(`id_unidad` ASC) USING BTREE,
  INDEX `fk_precios_has_unidades_has_producto_precios1_idx`(`id_precio` ASC) USING BTREE,
  INDEX `fk_precios_has_unidades_has_producto_unidades_has_producto3_idx`(`id_producto` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of unidades_has_precio
-- ----------------------------
INSERT INTO `unidades_has_precio` VALUES (1, 1, 1, 1.00, 0.00);
INSERT INTO `unidades_has_precio` VALUES (1, 1, 2, 2.00, 0.00);
INSERT INTO `unidades_has_precio` VALUES (1, 1, 3, 4.00, 0.00);
INSERT INTO `unidades_has_precio` VALUES (3, 1, 1, 1.00, 0.00);
INSERT INTO `unidades_has_precio` VALUES (3, 1, 2, 2.00, 0.00);
INSERT INTO `unidades_has_precio` VALUES (3, 1, 3, 4.00, 0.00);

-- ----------------------------
-- Table structure for unidades_has_producto
-- ----------------------------
DROP TABLE IF EXISTS `unidades_has_producto`;
CREATE TABLE `unidades_has_producto`  (
  `id_unidad` bigint NOT NULL,
  `producto_id` bigint NOT NULL,
  `unidades` float NULL DEFAULT NULL,
  `orden` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_unidad`, `producto_id`) USING BTREE,
  INDEX `fk_unidades_has_producto_producto1_idx`(`producto_id` ASC) USING BTREE,
  INDEX `fk_unidades_has_producto_unidades1_idx`(`id_unidad` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of unidades_has_producto
-- ----------------------------
INSERT INTO `unidades_has_producto` VALUES (1, 1, 1, 1);
INSERT INTO `unidades_has_producto` VALUES (1, 2, 1, 1);
INSERT INTO `unidades_has_producto` VALUES (1, 3, 1, 1);

-- ----------------------------
-- Table structure for usuario
-- ----------------------------
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario`  (
  `nUsuCodigo` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(18) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `var_usuario_clave` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `nombre` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `grupo` bigint NULL DEFAULT NULL,
  `id_local` bigint NULL DEFAULT NULL,
  `deleted` tinyint(1) NULL DEFAULT 0,
  `identificacion` int NULL DEFAULT NULL,
  `esSuper` int NULL DEFAULT NULL,
  `porcentaje_comision` decimal(18, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`nUsuCodigo`) USING BTREE,
  INDEX `grupo`(`grupo` ASC) USING BTREE,
  INDEX `id_local`(`id_local` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of usuario
-- ----------------------------
INSERT INTO `usuario` VALUES (1, 'superadmin', '05b4e91880c4f9980f168044f6e07643', 1, 'SuperAdmin', 2, 2, 0, 0, 1, 0.00);
INSERT INTO `usuario` VALUES (2, 'admin', 'e10adc3949ba59abbe56e057f20f883e', 1, 'Admin', 2, 1, 0, 13246578, 0, 0.00);
INSERT INTO `usuario` VALUES (3, 'ventas', 'e10adc3949ba59abbe56e057f20f883e', 1, 'Usuario de Ventas', 8, 1, 0, 13246578, 0, 0.00);
INSERT INTO `usuario` VALUES (4, 'contador', '2c568fd1dcd24b9766888693d71af519', 1, 'contador', 11, 1, 0, 11111111, 0, 0.00);

-- ----------------------------
-- Table structure for usuario_almacen
-- ----------------------------
DROP TABLE IF EXISTS `usuario_almacen`;
CREATE TABLE `usuario_almacen`  (
  `usuario_id` int NOT NULL,
  `local_id` int NOT NULL,
  PRIMARY KEY (`usuario_id`, `local_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of usuario_almacen
-- ----------------------------
INSERT INTO `usuario_almacen` VALUES (1, 1);
INSERT INTO `usuario_almacen` VALUES (2, 1);
INSERT INTO `usuario_almacen` VALUES (2, 2);
INSERT INTO `usuario_almacen` VALUES (3, 1);
INSERT INTO `usuario_almacen` VALUES (4, 1);

-- ----------------------------
-- Table structure for usuario_facturador
-- ----------------------------
DROP TABLE IF EXISTS `usuario_facturador`;
CREATE TABLE `usuario_facturador`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `username` varchar(18) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `var_usuario_clave` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `id_local` bigint NULL DEFAULT NULL,
  `deleted` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of usuario_facturador
-- ----------------------------
INSERT INTO `usuario_facturador` VALUES (1, 'Facturador', 'facturador', 'b867d9cd482834bbf35e785855f416d5', 1, 1, 0);

-- ----------------------------
-- Table structure for v_consulta_pagospendientes_venta
-- ----------------------------
DROP TABLE IF EXISTS `v_consulta_pagospendientes_venta`;
CREATE TABLE `v_consulta_pagospendientes_venta`  (
  `Venta_id` int NULL DEFAULT NULL,
  `Cliente_Id` int NULL DEFAULT NULL,
  `Cliente` int NULL DEFAULT NULL,
  `Personal` int NULL DEFAULT NULL,
  `FechaReg` int NULL DEFAULT NULL,
  `FechaVenc` int NULL DEFAULT NULL,
  `MontoTotal` int NULL DEFAULT NULL,
  `MontoCancelado` int NULL DEFAULT NULL,
  `SaldoPendiente` int NULL DEFAULT NULL,
  `NroVenta` int NULL DEFAULT NULL,
  `TipoDocumento` int NULL DEFAULT NULL,
  `Estado` int NULL DEFAULT NULL,
  `Simbolo` int NULL DEFAULT NULL,
  `FormaPago` int NULL DEFAULT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of v_consulta_pagospendientes_venta
-- ----------------------------

-- ----------------------------
-- Table structure for v_cronogramapago
-- ----------------------------
DROP TABLE IF EXISTS `v_cronogramapago`;
CREATE TABLE `v_cronogramapago`  (
  `nCPagoCodigo` bigint NULL DEFAULT NULL,
  `int_cronpago_nrocuota` int NULL DEFAULT NULL,
  `dat_cronpago_fecinicio` date NULL DEFAULT NULL,
  `dat_cronpago_fecpago` date NULL DEFAULT NULL,
  `dec_cronpago_pagocuota` decimal(18, 2) NULL DEFAULT NULL,
  `dec_cronpago_pagorecibido` decimal(18, 2) NULL DEFAULT NULL,
  `nVenCodigo` bigint NULL DEFAULT NULL,
  `id_moneda` int NULL DEFAULT NULL,
  `simbolo` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tasa_soles` decimal(4, 2) NULL DEFAULT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of v_cronogramapago
-- ----------------------------

-- ----------------------------
-- Table structure for v_lista_productos_principal
-- ----------------------------
DROP TABLE IF EXISTS `v_lista_productos_principal`;
CREATE TABLE `v_lista_productos_principal`  (
  `nombre` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `producto_id` bigint NULL DEFAULT NULL,
  `producto_codigo_barra` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `producto_nombre` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `producto_descripcion` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `producto_marca` bigint NULL DEFAULT NULL,
  `producto_linea` bigint NULL DEFAULT NULL,
  `producto_familia` bigint NULL DEFAULT NULL,
  `produto_grupo` bigint NULL DEFAULT NULL,
  `producto_proveedor` bigint NULL DEFAULT NULL,
  `producto_stockminimo` decimal(18, 2) NULL DEFAULT NULL,
  `producto_impuesto` bigint NULL DEFAULT NULL,
  `producto_estatus` tinyint(1) NULL DEFAULT NULL,
  `producto_largo` float NULL DEFAULT NULL,
  `producto_ancho` float NULL DEFAULT NULL,
  `producto_alto` float NULL DEFAULT NULL,
  `producto_peso` float NULL DEFAULT NULL,
  `producto_nota` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `producto_cualidad` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `producto_estado` tinyint(1) NULL DEFAULT NULL,
  `producto_costo_unitario` float(20, 2) NULL DEFAULT NULL,
  `producto_modelo` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_unidad` bigint NULL DEFAULT NULL,
  `nombre_unidad` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_local` int NULL DEFAULT NULL,
  `cantidad` int NULL DEFAULT NULL,
  `fraccion` int NULL DEFAULT NULL,
  `nombre_linea` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nombre_marca` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nombre_familia` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nombre_grupo` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `proveedor_nombre` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nombre_impuesto` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_grupo` bigint NULL DEFAULT NULL,
  `nombre_fraccion` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of v_lista_productos_principal
-- ----------------------------

-- ----------------------------
-- Table structure for v_usuario_almacen
-- ----------------------------
DROP TABLE IF EXISTS `v_usuario_almacen`;
CREATE TABLE `v_usuario_almacen`  (
  `int_local_id` bigint NULL DEFAULT NULL,
  `local_nombre` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `usuario_id` int NULL DEFAULT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of v_usuario_almacen
-- ----------------------------

-- ----------------------------
-- Table structure for vendedor
-- ----------------------------
DROP TABLE IF EXISTS `vendedor`;
CREATE TABLE `vendedor`  (
  `id_vendedor` bigint NOT NULL AUTO_INCREMENT,
  `nombre_vendedor` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_usuario` bigint NULL DEFAULT NULL,
  `activo` smallint NULL DEFAULT NULL,
  PRIMARY KEY (`id_vendedor`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of vendedor
-- ----------------------------

-- ----------------------------
-- Table structure for vendedor_has_sucursal
-- ----------------------------
DROP TABLE IF EXISTS `vendedor_has_sucursal`;
CREATE TABLE `vendedor_has_sucursal`  (
  `id_vhs` bigint NOT NULL AUTO_INCREMENT,
  `id_vendedor` bigint NOT NULL,
  `id_sucursal` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id_vhs`, `id_vendedor`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of vendedor_has_sucursal
-- ----------------------------

-- ----------------------------
-- Table structure for venta
-- ----------------------------
DROP TABLE IF EXISTS `venta`;
CREATE TABLE `venta`  (
  `venta_id` bigint NOT NULL AUTO_INCREMENT,
  `id_cliente` bigint NOT NULL,
  `nombre_cliente` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_vendedor` bigint NULL DEFAULT NULL,
  `fecha` datetime NULL DEFAULT NULL,
  `fecha_facturacion` datetime NULL DEFAULT NULL,
  `serie` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `numero` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `factura_impresa` tinyint NULL DEFAULT 0,
  `venta_status` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `condicion_pago` bigint NULL DEFAULT NULL,
  `local_id` bigint NULL DEFAULT NULL,
  `subtotal` decimal(18, 2) NULL DEFAULT NULL,
  `total_impuesto` decimal(18, 2) NULL DEFAULT NULL,
  `total_bolsas` decimal(18, 2) NOT NULL DEFAULT 0.00,
  `total` decimal(18, 2) NULL DEFAULT NULL,
  `pagado` decimal(18, 2) NULL DEFAULT 0.00,
  `vuelto` decimal(18, 2) NULL DEFAULT 0.00,
  `id_moneda` int NULL DEFAULT NULL,
  `tasa_cambio` decimal(4, 2) NULL DEFAULT NULL,
  `id_documento` int NOT NULL,
  `correlativo` bigint NULL DEFAULT NULL,
  `dni_garante` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tipo_impuesto` tinyint(1) NULL DEFAULT NULL,
  `comprobante_id` int NULL DEFAULT 0,
  `nota` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `nro_guia` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT 'Correlativo de la guia de remision',
  `guia_id` int NULL DEFAULT NULL,
  `fecha_entrega` datetime NULL DEFAULT NULL,
  `dir_entrega` int NULL DEFAULT NULL,
  `inicial` decimal(18, 2) NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp,
  `nota_facturada` int NULL DEFAULT 0,
  `latitud` varchar(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT 'Latitud de donde se registro la venta',
  `longitud` varchar(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT 'Longitud de donde se registro la venta',
  `plataforma` int NULL DEFAULT NULL COMMENT 'Campo para identificar donde se realiza la venta 0 = web; 1 = app',
  `motivo` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nro_compra` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `cliente_direccion` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nombre_persona_entrega` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `numero_documento_entrega` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tipo_documento_entrega` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`venta_id`) USING BTREE,
  INDEX `venta_tipodocumento_idx`(`factura_impresa` ASC) USING BTREE,
  INDEX `ventafklocal_idx`(`local_id` ASC) USING BTREE,
  INDEX `ventafkpersonal_idx`(`id_vendedor` ASC) USING BTREE,
  INDEX `ventacondicionpagofk_idx`(`condicion_pago` ASC) USING BTREE,
  INDEX `ventaclientefk_idx`(`id_cliente` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of venta
-- ----------------------------
INSERT INTO `venta` VALUES (1, 2, '', 2, '2023-02-14 14:06:56', '2023-02-14 14:06:56', '001', '1', 0, 'COMPLETADO', 1, 1, 0.85, 0.15, 0.00, 1.00, 1.00, 0.00, 1029, 0.00, 3, NULL, '', 1, 0, '', '', 0, '2023-02-14 14:06:56', 0, NULL, '2023-02-14 14:06:56', 0, NULL, NULL, NULL, NULL, '', NULL, '', '', 0);
INSERT INTO `venta` VALUES (2, 3, '', 1, '2023-02-14 14:34:58', '2023-02-14 14:34:58', '001', '41', 0, 'COMPLETADO', 1, 1, 0.85, 0.15, 0.00, 1.00, 1.00, 0.00, 1029, 0.00, 3, NULL, '', 1, 0, '', '', 0, '2023-02-14 14:34:58', 0, NULL, '2023-02-14 14:34:58', 0, NULL, NULL, NULL, NULL, '', NULL, '', '', 0);
INSERT INTO `venta` VALUES (3, 3, '', 1, '2023-02-14 16:33:59', '2023-02-14 16:33:59', '001', '42', 0, 'ANULADO', 1, 1, 1.69, 0.31, 0.00, 2.00, 2.00, 0.00, 1029, 0.00, 3, NULL, '', 1, 0, '', '', 0, '2023-02-14 16:33:59', 0, NULL, '2023-02-14 16:33:59', 0, NULL, NULL, NULL, 'ERROR', '', NULL, '', '', 0);
INSERT INTO `venta` VALUES (4, 4, '', 1, '2023-02-15 09:50:57', '2023-02-15 09:50:57', '001', '1', 0, 'COMPLETADO', 1, 1, 2.54, 0.46, 0.00, 3.00, 3.00, 0.00, 1029, 0.00, 1, NULL, '', 1, 0, '', '', 0, '2023-02-15 09:50:57', 0, NULL, '2023-02-15 09:50:57', 0, NULL, NULL, NULL, NULL, '', 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', '', '', 0);
INSERT INTO `venta` VALUES (5, 4, '', 1, '2023-02-15 10:22:00', '2023-02-15 10:22:00', '001', '2', 0, 'COMPLETADO', 1, 1, 0.85, 0.15, 0.00, 1.00, 1.00, 0.00, 1029, 0.00, 1, NULL, '', 1, 0, '', '', 0, '2023-02-15 10:22:00', 0, NULL, '2023-02-15 10:22:00', 0, NULL, NULL, NULL, NULL, '', 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', '', '', 0);
INSERT INTO `venta` VALUES (6, 4, '', 1, '2023-02-15 10:27:27', '2023-02-15 10:27:27', '001', '3', 0, 'ANULADO', 1, 1, 3.39, 0.61, 0.00, 4.00, 4.00, 0.00, 1029, 0.00, 1, NULL, '', 1, 0, '', '', 0, '2023-02-15 10:27:27', 0, NULL, '2023-02-15 10:27:27', 0, NULL, NULL, NULL, 'PRUEBA DE ANULACION', '', 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', '', '', 0);
INSERT INTO `venta` VALUES (7, 1, '', 1, '2023-02-15 15:46:18', '2023-02-15 15:46:18', '001', '43', 0, 'COMPLETADO', 1, 1, 4.24, 0.76, 0.00, 5.00, 5.00, 0.00, 1029, 0.00, 3, NULL, '', 1, 0, '', '', 0, '2023-02-15 15:46:18', 0, NULL, '2023-02-15 15:46:18', 0, NULL, NULL, NULL, NULL, '', NULL, '', '', 0);
INSERT INTO `venta` VALUES (8, 1, '', 1, '2023-02-16 10:30:18', '2023-02-16 10:30:18', '001', '44', 0, 'COMPLETADO', 1, 1, 0.85, 0.15, 0.00, 1.00, 1.00, 0.00, 1029, 0.00, 3, NULL, '', 1, 0, '', '', 0, '2023-02-16 10:30:18', 0, NULL, '2023-02-16 10:30:18', 0, NULL, NULL, NULL, NULL, '', NULL, '', '', 0);
INSERT INTO `venta` VALUES (9, 3, '', 1, '2023-02-16 11:00:24', '2023-02-16 11:00:24', '001', '45', 0, 'COMPLETADO', 1, 1, 0.85, 0.15, 0.00, 1.00, 1.00, 0.00, 1029, 0.00, 3, NULL, '', 1, 0, '', '', 0, '2023-02-16 11:00:24', 0, NULL, '2023-02-16 11:00:24', 0, NULL, NULL, NULL, NULL, '', NULL, '', '', 0);
INSERT INTO `venta` VALUES (10, 4, '', 1, '2023-02-16 11:09:30', '2023-02-16 11:09:30', '001', '4', 0, 'COMPLETADO', 1, 1, 2.54, 0.46, 0.00, 3.00, 3.00, 0.00, 1029, 0.00, 1, NULL, '', 1, 0, '', '', 0, '2023-02-16 11:09:30', 0, NULL, '2023-02-16 11:09:30', 0, NULL, NULL, NULL, NULL, '', 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', '', '', 0);
INSERT INTO `venta` VALUES (11, 4, '', 1, '2023-02-16 14:42:56', '2023-02-16 14:42:56', '001', '8', 0, 'ANULADO', 1, 1, 1440.68, 259.32, 0.00, 1700.00, 1700.00, 0.00, 1029, 0.00, 1, NULL, '', 1, 0, '', '', 0, '2023-02-16 14:42:56', 0, NULL, '2023-02-16 14:42:56', 1, NULL, NULL, NULL, 'VENTA RECHAZADA', '', NULL, '', '', 0);
INSERT INTO `venta` VALUES (12, 4, '', 1, '2023-02-17 09:43:39', '2023-02-17 09:43:39', '001', '663', 0, 'ANULADO', 1, 1, 1.69, 0.31, 0.00, 2.00, 2.00, 0.00, 1029, 0.00, 1, NULL, '', 1, 0, '', '', 0, '2023-02-17 09:43:39', 0, NULL, '2023-02-17 09:43:39', 0, NULL, NULL, NULL, 'ERROR DE DIGITACION', '', 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', '', '', 0);
INSERT INTO `venta` VALUES (13, 4, '', 1, '2023-02-20 12:10:06', '2023-02-20 12:10:06', '001', '664', 0, 'COMPLETADO', 1, 1, 1.69, 0.31, 0.00, 2.00, 2.00, 0.00, 1029, 0.00, 1, NULL, '', 1, 0, '', '', 0, '2023-02-20 12:10:06', 0, NULL, '2023-02-20 12:10:06', 0, NULL, NULL, NULL, NULL, '', 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', '', '', 0);
INSERT INTO `venta` VALUES (14, 4, '', 1, '2023-02-21 14:39:22', '2023-02-21 14:39:22', '001', '9', 0, 'COMPLETADO', 1, 1, 1.69, 0.31, 0.00, 2.00, 2.00, 0.00, 1029, 0.00, 1, NULL, '', 1, 0, '', '', 0, '2023-02-21 14:39:22', 0, NULL, '2023-02-21 14:39:22', 1, NULL, NULL, NULL, NULL, '', 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', '', '', 0);
INSERT INTO `venta` VALUES (15, 3, '', 1, '2023-02-21 16:20:15', '2023-02-21 16:20:15', '001', '46', 0, 'COMPLETADO', 1, 1, 2.54, 0.46, 0.00, 3.00, 3.00, 0.00, 1029, 0.00, 3, NULL, '', 1, 0, '', '', 0, '2023-02-21 16:20:15', 0, NULL, '2023-02-21 16:20:15', 0, NULL, NULL, NULL, NULL, '', NULL, '', '', 0);
INSERT INTO `venta` VALUES (16, 4, '', 1, '2023-02-21 16:22:43', '2023-02-21 16:22:43', '001', '10', 0, 'COMPLETADO', 1, 1, 5.08, 0.92, 0.00, 6.00, 6.00, 0.00, 1029, 0.00, 1, NULL, '', 1, 0, '', '', 0, '2023-02-21 16:22:43', 0, NULL, '2023-02-21 16:22:43', 0, NULL, NULL, NULL, NULL, '', 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', '', '', 0);
INSERT INTO `venta` VALUES (17, 3, '', 1, '2023-02-22 12:44:22', '2023-02-22 12:44:22', '001', '47', 0, 'COMPLETADO', 1, 1, 3.39, 0.61, 0.00, 4.00, 4.00, 0.00, 1029, 0.00, 3, NULL, '', 1, 0, '', '', 0, '2023-02-22 12:44:22', 0, NULL, '2023-02-22 12:44:22', 0, NULL, NULL, NULL, NULL, '', NULL, '', '', 0);
INSERT INTO `venta` VALUES (18, 4, '', 1, '2023-02-23 09:19:47', '2023-02-23 09:19:47', '001', '11', 0, 'COMPLETADO', 1, 1, 10.17, 1.83, 0.00, 12.00, 12.00, 0.00, 1029, 0.00, 1, NULL, '', 1, 0, '', '', 0, '2023-02-23 09:19:47', 0, NULL, '2023-02-23 09:19:47', 0, NULL, NULL, NULL, NULL, '', 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', '', '', 0);
INSERT INTO `venta` VALUES (19, 1, '', 1, '2023-02-23 15:22:19', '2023-02-23 15:22:19', '001', '48', 0, 'ANULADO', 1, 1, 10.17, 1.83, 0.00, 12.00, 12.00, 0.00, 1029, 0.00, 3, NULL, '', 1, 0, '', '', 0, '2023-02-23 15:22:19', 0, NULL, '2023-02-23 15:22:19', 0, NULL, NULL, NULL, 'ERROR', '', NULL, '', '', 0);
INSERT INTO `venta` VALUES (20, 1, '', 1, '2023-02-23 17:23:23', '2023-02-23 17:23:23', '001', '49', 0, 'COMPLETADO', 1, 1, 6.78, 1.22, 0.00, 8.00, 8.00, 0.00, 1029, 0.00, 3, NULL, '', 1, 0, '', '', 0, '2023-02-23 17:23:23', 0, NULL, '2023-02-23 17:23:23', 0, NULL, NULL, NULL, NULL, '', NULL, '', '', 0);
INSERT INTO `venta` VALUES (21, 1, '', 1, '2023-02-24 11:39:26', '2023-02-24 11:39:26', '001', '50', 0, 'COMPLETADO', 1, 1, 3.39, 0.61, 0.00, 4.00, 4.00, 0.00, 1029, 0.00, 3, NULL, '', 1, 0, '', '', 0, '2023-02-24 11:39:26', 0, NULL, '2023-02-24 11:39:26', 0, NULL, NULL, NULL, NULL, '', NULL, '', '', 0);
INSERT INTO `venta` VALUES (22, 3, '', 1, '2023-02-23 12:01:52', NULL, NULL, NULL, 0, 'COMPLETADO', 2, 1, 6.78, 1.22, 0.00, 8.00, 0.00, 0.00, 1029, 0.00, 6, NULL, '', 1, 0, '', '', 0, '2023-02-24 12:01:52', 0, 0.00, '2023-02-24 12:01:52', 0, NULL, NULL, NULL, NULL, '', NULL, '', '', 0);
INSERT INTO `venta` VALUES (23, 1, '', 1, '2023-02-24 14:06:34', '2023-02-24 14:06:34', '001', '51', 0, 'COMPLETADO', 1, 1, 6.78, 1.22, 0.00, 8.00, 8.00, 0.00, 1029, 0.00, 3, NULL, '', 1, 0, '', '', 0, '2023-02-24 14:06:34', 0, NULL, '2023-02-24 14:06:34', 1, NULL, NULL, NULL, NULL, '', NULL, '', '', 0);
INSERT INTO `venta` VALUES (24, 4, '', 1, '2023-02-27 11:17:15', '2023-02-27 11:17:15', '001', '12', 0, 'COMPLETADO', 1, 1, 4237.29, 762.71, 0.00, 5000.00, 5000.00, 0.00, 1029, 0.00, 1, NULL, '', 1, 0, '', '', 0, '2023-02-27 11:17:15', 0, NULL, '2023-02-27 11:17:15', 1, NULL, NULL, NULL, NULL, '', 'AV. LIMA LT. 9 MZ. G8 URB. SEMI RURAL PACHACUTEC - AREQUIPA AREQUIPA CERRO COLORADO', '', '', 0);

-- ----------------------------
-- Table structure for venta_documento
-- ----------------------------
DROP TABLE IF EXISTS `venta_documento`;
CREATE TABLE `venta_documento`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `venta_id` bigint NOT NULL,
  `numero_documento` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of venta_documento
-- ----------------------------

-- ----------------------------
-- Table structure for venta_shadow
-- ----------------------------
DROP TABLE IF EXISTS `venta_shadow`;
CREATE TABLE `venta_shadow`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `venta_id` bigint NOT NULL,
  `id_factura` bigint NULL DEFAULT NULL,
  `local_id` bigint NULL DEFAULT NULL,
  `id_documento` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_cliente` bigint NOT NULL,
  `id_vendedor` bigint NULL DEFAULT NULL,
  `condicion_pago` bigint NULL DEFAULT NULL,
  `id_moneda` int NULL DEFAULT NULL,
  `venta_status` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fecha` datetime NULL DEFAULT NULL,
  `fecha_facturacion` datetime NULL DEFAULT NULL,
  `serie` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `numero` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `factura_impresa` tinyint NULL DEFAULT 0,
  `subtotal` decimal(18, 2) NULL DEFAULT NULL,
  `total_impuesto` decimal(18, 2) NULL DEFAULT NULL,
  `total` decimal(18, 2) NULL DEFAULT NULL,
  `pagado` decimal(18, 2) NULL DEFAULT 0.00,
  `vuelto` decimal(18, 2) NULL DEFAULT 0.00,
  `tasa_cambio` decimal(4, 2) NULL DEFAULT NULL,
  `dni_garante` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tipo_impuesto` tinyint(1) NULL DEFAULT NULL,
  `comprobante_id` int NULL DEFAULT 0,
  `nota` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `nro_guia` int NULL DEFAULT NULL COMMENT 'Correlativo de la guia de remision',
  `inicial` decimal(6, 2) NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp,
  `nota_facturada` int NULL DEFAULT 0,
  `nro_compra` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `venta_id`(`venta_id` ASC) USING BTREE,
  INDEX `local_id`(`local_id` ASC) USING BTREE,
  INDEX `id_documento`(`id_documento` ASC) USING BTREE,
  INDEX `id_cliente`(`id_cliente` ASC) USING BTREE,
  INDEX `id_vendedor`(`id_vendedor` ASC) USING BTREE,
  INDEX `condicion_pago`(`condicion_pago` ASC) USING BTREE,
  INDEX `id_moneda`(`id_moneda` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of venta_shadow
-- ----------------------------

-- ----------------------------
-- Table structure for venta_shadow_detalle
-- ----------------------------
DROP TABLE IF EXISTS `venta_shadow_detalle`;
CREATE TABLE `venta_shadow_detalle`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `id_venta_shadow` bigint NULL DEFAULT NULL,
  `id_producto` bigint NULL DEFAULT NULL,
  `precio` decimal(18, 2) NULL DEFAULT NULL,
  `cantidad` decimal(18, 3) NOT NULL DEFAULT 0.000,
  `unidad_medida` bigint NULL DEFAULT NULL,
  `detalle_importe` decimal(18, 2) NULL DEFAULT NULL,
  `detalle_costo_promedio` decimal(18, 2) NULL DEFAULT 0.00,
  `detalle_costo_ultimo` decimal(18, 2) NULL DEFAULT 0.00,
  `detalle_utilidad` decimal(18, 2) NULL DEFAULT 0.00,
  `impuesto_id` int NULL DEFAULT NULL,
  `afectacion_impuesto` varchar(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `impuesto_porciento` decimal(18, 2) NULL DEFAULT NULL,
  `precio_venta` decimal(18, 2) NULL DEFAULT 0.00,
  `tipo_impuesto_compra` tinyint NULL DEFAULT NULL,
  `gratis` tinyint NULL DEFAULT 0,
  `descuento` decimal(18, 2) NULL DEFAULT 0.00,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id_producto`(`id_producto` ASC) USING BTREE,
  INDEX `id_venta_shadow`(`id_venta_shadow` ASC) USING BTREE,
  INDEX `unidad_medida`(`unidad_medida` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of venta_shadow_detalle
-- ----------------------------

-- ----------------------------
-- Table structure for venta_tarjeta
-- ----------------------------
DROP TABLE IF EXISTS `venta_tarjeta`;
CREATE TABLE `venta_tarjeta`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `venta_id` bigint NOT NULL,
  `tarjeta_pago_id` int NOT NULL,
  `numero` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of venta_tarjeta
-- ----------------------------

-- ----------------------------
-- Table structure for version
-- ----------------------------
DROP TABLE IF EXISTS `version`;
CREATE TABLE `version`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre_empresa` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ruta_logo1` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT 'IMAGEN PNG DEL LOGIN',
  `ruta_logo2` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT 'IMAGEN SVG DEL LOGIN',
  `ruta_logo3` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT 'IMAGEN LOGO DE LA PAGINA PRINCIPAL',
  `color_fondo` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT 'COLOR FONDO PANEL IZQUIERDO DEL LOGIN',
  `color_boton` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL COMMENT 'COLOR DE BOTON PANEL IZQUIERDO DEL LOGIN',
  `version` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `build` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `codCliente` int NULL DEFAULT NULL COMMENT 'Codigo interno unico del cliente [Empresa];[Periodo];[correlativo]',
  `estado` int NULL DEFAULT NULL COMMENT '0 = Inactivo / 1 = activo / 2 = suspendido',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of version
-- ----------------------------
INSERT INTO `version` VALUES (1, 'SIGA', 'logo.png', 'logo_svg_white.svg', 'punto_de_venta_v2.jpg', '#37669A', '#ffcf00', '2.16', '101', NULL, 1);

-- ----------------------------
-- Table structure for vw_rep_mov_cajas
-- ----------------------------
DROP TABLE IF EXISTS `vw_rep_mov_cajas`;
CREATE TABLE `vw_rep_mov_cajas`  (
  `id_caja` int NULL DEFAULT NULL,
  `caja` int NULL DEFAULT NULL,
  `moneda` int NULL DEFAULT NULL,
  `tasa_cambio` int NULL DEFAULT NULL,
  `fecha` int NULL DEFAULT NULL,
  `monto` int NULL DEFAULT NULL,
  `username` int NULL DEFAULT NULL,
  `tipomov` int NULL DEFAULT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of vw_rep_mov_cajas
-- ----------------------------

-- ----------------------------
-- Table structure for zona
-- ----------------------------
DROP TABLE IF EXISTS `zona`;
CREATE TABLE `zona`  (
  `id_zona` bigint NOT NULL AUTO_INCREMENT,
  `nombre_zona` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status_zona` smallint NULL DEFAULT NULL,
  PRIMARY KEY (`id_zona`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of zona
-- ----------------------------

-- ----------------------------
-- Table structure for zona_dias
-- ----------------------------
DROP TABLE IF EXISTS `zona_dias`;
CREATE TABLE `zona_dias`  (
  `id_zds` bigint NOT NULL AUTO_INCREMENT,
  `id_zona` bigint NOT NULL,
  `dia_semana` smallint NULL DEFAULT NULL,
  PRIMARY KEY (`id_zds`, `id_zona`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of zona_dias
-- ----------------------------

-- ----------------------------
-- Table structure for zona_has_distritos
-- ----------------------------
DROP TABLE IF EXISTS `zona_has_distritos`;
CREATE TABLE `zona_has_distritos`  (
  `id_zhd` bigint NOT NULL AUTO_INCREMENT,
  `id_zona` bigint NULL DEFAULT NULL,
  `id_distrito` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id_zhd`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of zona_has_distritos
-- ----------------------------

-- ----------------------------
-- View structure for vw_monedas_cajas
-- ----------------------------
DROP VIEW IF EXISTS `vw_monedas_cajas`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vw_monedas_cajas` AS SELECT `m`.`id_moneda` AS `id_moneda`, `m`.`nombre` AS `nombre`, `m`.`tasa_soles` AS `tasa_soles`, `m`.`ope_tasa` AS `ope_tasa`, `m`.`pais` AS `pais`, `m`.`simbolo` AS `simbolo` FROM `moneda` AS `m` WHERE `m`.`status_moneda` = 1 ;

-- ----------------------------
-- View structure for v_lista_precios
-- ----------------------------
DROP VIEW IF EXISTS `v_lista_precios`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_lista_precios` AS SELECT `producto`.`producto_id` AS `producto_id`, `producto`.`producto_nombre` AS `producto_nombre`, `producto`.`producto_codigo_barra` AS `producto_codigo_barra`, `producto`.`producto_codigo_interno` AS `producto_codigo_interno`, `producto`.`producto_stockminimo` AS `stock_min`, `marcas`.`id_marca` AS `marca_id`, `grupos`.`id_grupo` AS `grupo_id`, `familia`.`id_familia` AS `familia_id`, `lineas`.`id_linea` AS `linea_id`, `proveedor`.`id_proveedor` AS `proveedor_id`, concat('Marca: ',ifnull(`marcas`.`nombre_marca`,'-'),', Grupo: ',ifnull(`grupos`.`nombre_grupo`,'-'),'<br/>','Familia: ',ifnull(`familia`.`nombre_familia`,'-'),', Linea: ',ifnull(`lineas`.`nombre_linea`,'-')) AS `descripcion`, concat(`producto`.`producto_nombre`,' ',ifnull(`grupos`.`nombre_grupo`,''),' ',ifnull(`proveedor`.`proveedor_nombre`,''),' ',ifnull(`marcas`.`nombre_marca`,''),' ',ifnull(`lineas`.`nombre_linea`,''),' ',ifnull(`familia`.`nombre_familia`,'')) AS `criterio` FROM (((((`producto` left join `marcas` on(`producto`.`producto_marca` = `marcas`.`id_marca`)) left join `lineas` on(`producto`.`producto_linea` = `lineas`.`id_linea`)) left join `familia` on(`producto`.`producto_familia` = `familia`.`id_familia`)) left join `grupos` on(`producto`.`produto_grupo` = `grupos`.`id_grupo`)) left join `proveedor` on(`producto`.`producto_proveedor` = `proveedor`.`id_proveedor`)) WHERE `producto`.`producto_estatus` = '1' ORDER BY `producto`.`producto_id` ASC, `producto`.`producto_nombre` DESC ;

-- ----------------------------
-- Procedure structure for GET_GUIA_REMISION
-- ----------------------------
DROP PROCEDURE IF EXISTS `GET_GUIA_REMISION`;
delimiter ;;
CREATE PROCEDURE `GET_GUIA_REMISION`(IN  TIPO_OPERACION VARCHAR(200),
	IN  ID_OPERACION INT,
	IN  ID_REMISION INT)
BEGIN
	IF STRCMP (TIPO_OPERACION , "default") = 0 and ID_REMISION>0 THEN
		SELECT gr.tipo_operacion INTO TIPO_OPERACION 
		FROM guia_remision gr
		WHERE gr.id = ID_REMISION;
	END IF;
	--  SET NOCOUNT ON;
	IF ID_REMISION > 0 AND TIPO_OPERACION='venta' THEN
		SELECT
			gr.id as id_remision,
			gr.id_documento as id_documento,
			v.id_documento as id_documento_operacion,
			TIPO_OPERACION as tipo_operacion,
			gr.tipo_operacion_remision_id as tipo_operacion_remision_id,
			v.id_moneda as id_moneda,
			gr.serie as serie,
			gr.numero as numero,
			v.serie as serie_operacion,
			v.numero as numero_operacion,
			gr.local_id as local_id,
			gr.punto_partida as punto_partida,
			gr.ubigeo_punto_partida as ubigeo_punto_partida,
			dipart.nombre as ubigeo_nombre_partida,
			gr.id_cliente as id_cliente,
			c.identificacion as identificacion,
			c.razon_social as razon_social,
			gr.fecha_emision as fecha_emision,
			gr.fecha_inicio_traslado as fecha_inicio_traslado,
			gr.motivo_traslado_id as motivo_traslado_id,
			gr.otros_motivo as otros_motivo,
			mnd.simbolo as moneda_simbolo,
			gr.peso_total as peso_total,
			gr.nota as nota,
			gr.punto_llegada as punto_llegada,
			gr.ubigeo_punto_llegada as ubigeo_punto_llegada,
			dilleg.nombre as ubigeo_nombre_llegada,
			gr.nro_orden_compra as nro_orden_compra,
			gr.cantidad_total as cantidad_total,
			gr.total as total,
			gr.transportista_id as transportista_id,
			gr.tipo_transportista as tipo_transportista,
			gr.placa as placa,
			gr.ruc_transportista as ruc_transportista,
			gr.razon_social_transportista as razon_social_transportista,
			gr.tipo_documento_persona_id as tipo_documento_persona_id,
			gr.identificacion_conductor as identificacion_conductor,
			gr.nombre_conductor as nombre_conductor,
			tr.certificado as certificado_transportista,
			mot_desc.descripcion as motivo_nombre,
			gr.estado as estado
		FROM guia_remision as gr
			INNER JOIN cliente as c on c.id_cliente = gr.id_cliente
			INNER JOIN venta as v on v.venta_id = gr.tipo_operacion_remision_id
			INNER JOIN moneda as mnd on v.id_moneda= mnd.id_moneda
			INNER JOIN transportista as tr on tr.id_transportista = gr.transportista_id
			INNER JOIN motivos_descripcion as mot_desc on mot_desc.id = gr.motivo_traslado_id
			LEFT OUTER JOIN distrito as dipart on dipart.idUbigeo = gr.ubigeo_punto_partida
			LEFT OUTER JOIN distrito as dilleg on dilleg.idUbigeo = gr.ubigeo_punto_llegada
		where gr.id = ID_REMISION;
	ELSEIF ID_REMISION = -1 AND TIPO_OPERACION='venta' THEN
		SELECT
			null as id_remision,
			null as id_documento,
			venta.id_documento as id_documento_operacion,
			TIPO_OPERACION as tipo_operacion,
			venta.venta_id as tipo_operacion_remision_id,
			venta.id_moneda as id_moneda,
			NULL as serie,
			NULL as numero,
			venta.serie as serie_operacion,
			venta.numero as numero_operacion,
			-- origen
			venta.local_id as local_id,
			`local`.direccion as punto_partida,
			distrito.idUbigeo as ubigeo_punto_partida,
			distrito.nombre as ubigeo_nombre_partida,
			-- cliente datos
			venta.id_cliente as id_cliente,
			cliente.identificacion as identificacion,
			cliente.razon_social as razon_social,
			null as fecha_emision,
			null as fecha_inicio_traslado,
			null as motivo_traslado_id,
			null as otros_motivo,
			mnd.simbolo as moneda_simbolo,
			null as peso_total,
			null as nota,
			null as punto_llegada,
			null as ubigeo_punto_llegada,
			null as ubigeo_nombre_llegada,
			venta.nro_compra as nro_orden_compra,
			null as cantidad_total,
			null as total,
			null as transportista_id,
			null as tipo_transportista,
			null as placa,
			null as ruc_transportista,
			null as razon_social_transportista,
			null as tipo_documento_persona_id,
			null as identificacion_conductor,
			null as nombre_conductor,
			null as certificado_transportista,
			null as motivo_nombre,
			null as estado
		FROM venta
			LEFT OUTER JOIN `local` on `local`.int_local_id = venta.local_id
 			LEFT OUTER JOIN distrito on distrito.id = `local`.distrito_id
 			LEFT OUTER JOIN cliente on cliente.id_cliente = venta.id_cliente
			INNER JOIN moneda as mnd on venta.id_moneda= mnd.id_moneda
		WHERE ID_OPERACION = venta.venta_id;
	ELSEIF ID_REMISION > 0 AND TIPO_OPERACION='entradas_salidas' THEN
		SELECT
			gr.id as id_remision,
			gr.id_documento as id_documento,
			a.documento as id_documento_operacion,
			TIPO_OPERACION as tipo_operacion,
			gr.tipo_operacion_remision_id as tipo_operacion_remision_id,
			a.moneda_id as id_moneda,
			gr.serie as serie,
			gr.numero as numero,
			a.serie as serie_operacion,
			a.numero as numero_operacion,
			gr.local_id as local_id,
			gr.punto_partida as punto_partida,
			gr.ubigeo_punto_partida as ubigeo_punto_partida,
			dipart.nombre as ubigeo_nombre_partida,
			case when c.id_cliente is null then 1 else c.id_cliente end as id_cliente,
			-- gr.id_cliente as id_cliente,
			c.identificacion as identificacion,
			c.razon_social as razon_social,
			gr.fecha_emision as fecha_emision,
			gr.fecha_inicio_traslado as fecha_inicio_traslado,
			gr.motivo_traslado_id as motivo_traslado_id,
			gr.otros_motivo as otros_motivo,
			mnd.simbolo as moneda_simbolo,
			gr.peso_total as peso_total,
			gr.nota as nota,
			gr.punto_llegada as punto_llegada,
			gr.ubigeo_punto_llegada as ubigeo_punto_llegada,
			dilleg.nombre as ubigeo_nombre_llegada,
			gr.nro_orden_compra as nro_orden_compra,
			gr.cantidad_total as cantidad_total,
			gr.total as total,
			gr.transportista_id as transportista_id,
			gr.tipo_transportista as tipo_transportista,
			gr.placa as placa,
			gr.ruc_transportista as ruc_transportista,
			gr.razon_social_transportista as razon_social_transportista,
			gr.tipo_documento_persona_id as tipo_documento_persona_id,
			gr.identificacion_conductor as identificacion_conductor,
			gr.nombre_conductor as nombre_conductor,
			tr.certificado as certificado_transportista,
			mot_desc.descripcion as motivo_nombre,
			gr.estado as estado
		FROM guia_remision as gr
			-- LEFT OUTER JOIN configuraciones as conf on conf.config_key='EMPRESA_IDENTIFICACION'
			LEFT OUTER JOIN facturacion_emisor as facem on true
			LEFT OUTER JOIN cliente as c on 
							( !ISNULL(gr.id_cliente) and c.id_cliente = gr.id_cliente and gr.id_cliente != 1) OR 
							( ( ISNULL(gr.id_cliente) OR gr.id_cliente = 1) AND c.identificacion = facem.ruc)
			INNER JOIN ajuste as a on a.id = gr.tipo_operacion_remision_id
			INNER JOIN moneda as mnd on mnd.id_moneda = a.moneda_id
			INNER JOIN transportista as tr on tr.id_transportista = gr.transportista_id
			INNER JOIN motivos_descripcion as mot_desc on mot_desc.id = gr.motivo_traslado_id
			LEFT OUTER JOIN distrito as dipart on dipart.idUbigeo = gr.ubigeo_punto_partida
			LEFT OUTER JOIN distrito as dilleg on dilleg.idUbigeo = gr.ubigeo_punto_llegada
		where gr.id = ID_REMISION;
	ELSEIF ID_REMISION = -1 AND TIPO_OPERACION='entradas_salidas' THEN
		SELECT
			null as id_remision,
			null as id_documento,
			ajuste.documento as id_documento_operacion,
			TIPO_OPERACION as tipo_operacion,
			ajuste.id as tipo_operacion_remision_id,
			ajuste.moneda_id as id_moneda,
			NULL as serie,
			NULL as numero,
			ajuste.serie as serie_operacion,
			ajuste.numero as numero_operacion,
			-- origen
			ajuste.local_id as local_id,
			`local`.direccion as punto_partida,
			distrito.idUbigeo as ubigeo_punto_partida,
			distrito.nombre as ubigeo_nombre_partida,
			-- cliente datos
			case when cliente.id_cliente is null then 1 else cliente.id_cliente end as id_cliente,
			cliente.identificacion as identificacion,
			cliente.razon_social as razon_social,
			null as fecha_emision,
			null as fecha_inicio_traslado,
			null as motivo_traslado_id,
			null as otros_motivo,
			mnd.simbolo as moneda_simbolo,
			null as peso_total,
			null as nota,
			null as punto_llegada,
			null as ubigeo_punto_llegada,
			null as ubigeo_nombre_llegada,
			null as nro_orden_compra,
			null as cantidad_total,
			null as total,
			null as transportista_id,
			null as tipo_transportista,
			null as placa,
			null as ruc_transportista,
			null as razon_social_transportista,
			null as tipo_documento_persona_id,
			null as identificacion_conductor,
			null as nombre_conductor,
			null as certificado_transportista,
			null as motivo_nombre,
			null as estado
		FROM ajuste
			LEFT OUTER JOIN `local` on `local`.int_local_id = ajuste.local_id
 			LEFT OUTER JOIN distrito on distrito.id = `local`.distrito_id
			LEFT OUTER JOIN facturacion_emisor as facem on true
			-- LEFT OUTER JOIN configuraciones as conf on conf.config_key='EMPRESA_IDENTIFICACION'
 			LEFT OUTER JOIN cliente on cliente.identificacion = facem.ruc
			INNER JOIN moneda as mnd on mnd.id_moneda = ajuste.moneda_id
		WHERE ID_OPERACION = ajuste.id;
	ELSEIF ID_REMISION > 0 AND TIPO_OPERACION='traspaso' THEN
		SELECT
			gr.id as id_remision,
			gr.id_documento as id_documento,
			tr.documento as id_documento_operacion,
			TIPO_OPERACION as tipo_operacion,
			gr.tipo_operacion_remision_id as tipo_operacion_remision_id,
			mnd.id_moneda as id_moneda,
			gr.serie as serie,
			gr.numero as numero,
			NULL as serie_operacion,
			NULL as numero_operacion,
			gr.local_id as local_id,
			gr.punto_partida as punto_partida,
			gr.ubigeo_punto_partida as ubigeo_punto_partida,
			dipart.nombre as ubigeo_nombre_partida,
			case when c.id_cliente is null then 1 else c.id_cliente end as id_cliente,
			c.identificacion as identificacion,
			c.razon_social as razon_social,
			gr.fecha_emision as fecha_emision,
			gr.fecha_inicio_traslado as fecha_inicio_traslado,
			gr.motivo_traslado_id as motivo_traslado_id,
			mnd.simbolo as moneda_simbolo,
			gr.otros_motivo as otros_motivo,
			gr.peso_total as peso_total,
			gr.nota as nota,
			gr.punto_llegada as punto_llegada,
			gr.ubigeo_punto_llegada as ubigeo_punto_llegada,
			dilleg.nombre as ubigeo_nombre_llegada,
			gr.nro_orden_compra as nro_orden_compra,
			gr.cantidad_total as cantidad_total,
			gr.total as total,
			gr.transportista_id as transportista_id,
			gr.tipo_transportista as tipo_transportista,
			gr.placa as placa,
			gr.ruc_transportista as ruc_transportista,
			gr.razon_social_transportista as razon_social_transportista,
			gr.tipo_documento_persona_id as tipo_documento_persona_id,
			gr.identificacion_conductor as identificacion_conductor,
			gr.nombre_conductor as nombre_conductor,
			trns.certificado as certificado_transportista,
			mot_desc.descripcion as motivo_nombre,
			gr.estado as estado
		FROM guia_remision as gr
			INNER JOIN traspaso as tr on tr.id = gr.tipo_operacion_remision_id
			-- LEFT OUTER JOIN configuraciones as conf on conf.config_key='EMPRESA_IDENTIFICACION'
			LEFT OUTER JOIN facturacion_emisor as facem on true
			LEFT OUTER JOIN cliente as c on 
							( !ISNULL(gr.id_cliente) and c.id_cliente = gr.id_cliente and gr.id_cliente != 1) OR 
							( ( ISNULL(gr.id_cliente) OR gr.id_cliente = 1) AND c.identificacion = facem.ruc )
			INNER JOIN moneda as mnd on mnd.id_moneda = 1029
			INNER JOIN transportista as trns on trns.id_transportista = gr.transportista_id
			LEFT OUTER JOIN distrito as dipart on dipart.idUbigeo = gr.ubigeo_punto_partida
			LEFT OUTER JOIN distrito as dilleg on dilleg.idUbigeo = gr.ubigeo_punto_llegada
			INNER JOIN motivos_descripcion as mot_desc on mot_desc.id = gr.motivo_traslado_id
		where gr.id = ID_REMISION;
	ELSEIF ID_REMISION = -1 AND TIPO_OPERACION='traspaso' THEN
		SELECT
			null as id_remision,
			null as id_documento,
			traspaso.documento as id_documento_operacion,
			TIPO_OPERACION as tipo_operacion,
			traspaso.id as tipo_operacion_remision_id,
			mnd.id_moneda as id_moneda,
			NULL as serie,
			NULL as numero,
			NULL as serie_operacion,
			NULL as numero_operacion,
			-- origen
			traspaso.local_origen as local_id,
			lop.direccion as punto_partida,
			dipart.idUbigeo as ubigeo_punto_partida,
			dipart.nombre as ubigeo_nombre_partida,
			-- cliente datos
			case when cliente.id_cliente is null then 1 else cliente.id_cliente end as id_cliente,
			cliente.identificacion as identificacion,
			cliente.razon_social as razon_social,
			null as fecha_emision,
			null as fecha_inicio_traslado,
			5 as motivo_traslado_id, -- motivos_descripcion > 5	> TRASLADO ENTRE ESTABLECIMIENTO DE LA MISMA EMPRESA
			null as otros_motivo,
			mnd.simbolo as moneda_simbolo,
			null as peso_total,
			null as nota,
			loll.direccion as punto_llegada,
			dilleg.idUbigeo as ubigeo_punto_llegada,
			dilleg.nombre as ubigeo_nombre_llegada,
			null as nro_orden_compra,
			null as cantidad_total,
			null as total,
			null as transportista_id,
			null as tipo_transportista,
			null as placa,
			null as ruc_transportista,
			null as razon_social_transportista,
			null as tipo_documento_persona_id,
			null as identificacion_conductor,
			null as nombre_conductor,
			null as certificado_transportista,
			null as motivo_nombre,
			null as estado
		FROM traspaso
			LEFT OUTER JOIN `local` as lop on lop.int_local_id = traspaso.local_origen
 			LEFT OUTER JOIN distrito as dipart on dipart.id = lop.distrito_id
			LEFT OUTER JOIN `local` as loll on loll.int_local_id = traspaso.local_destino
 			LEFT OUTER JOIN distrito as dilleg on dilleg.id = loll.distrito_id
			-- LEFT OUTER JOIN configuraciones as conf on conf.config_key='EMPRESA_IDENTIFICACION'
			LEFT OUTER JOIN facturacion_emisor as facem on true
 			LEFT OUTER JOIN cliente on cliente.identificacion = facem.ruc
			INNER JOIN moneda as mnd on mnd.id_moneda = 1029
		WHERE ID_OPERACION = traspaso.id;
	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for GET_GUIA_REMISION_DETALLE
-- ----------------------------
DROP PROCEDURE IF EXISTS `GET_GUIA_REMISION_DETALLE`;
delimiter ;;
CREATE PROCEDURE `GET_GUIA_REMISION_DETALLE`(IN  TIPO_OPERACION VARCHAR(200),
	IN  ID_OPERACION INT,
	IN  ID_REMISION INT)
BEGIN
	-- 	caso de venta (pasandole el id de remision o el de venta en caso de crear uno nuevo
	IF STRCMP (TIPO_OPERACION , "default") = 0 and ID_REMISION>0 THEN
		SELECT gr.tipo_operacion INTO TIPO_OPERACION 
		FROM guia_remision gr
		WHERE gr.id = ID_REMISION;
	END IF;
	IF TIPO_OPERACION='venta' THEN
		SELECT 'venta' as tipo,
			grd.guia_remision_id as guia_remision_id,
			d.id_detalle as detalle_id,
			p.producto_id as producto_id,
			p.producto_codigo_interno as producto_codigo_interno,
			p.producto_nombre as nombre_producto,
			d.cantidad as cantidad_total,
			uv.nombre_unidad as unidad_operacion,
			uv.abreviatura as unidad_abr_operacion, -- no se guarda solo se muestra
			d.cantidad*up.unidades as cantidad_en_unidades,
			d.cantidad_parcial as cantidad_parcial,
		 	grd.cantidad_despachar as cantidad_despachar,
			um.abreviatura as unidad_abr,
			um.nombre_unidad as unidad,
			um.id_unidad as id_unidad,
			d.precio_venta as precio, -- no se guarda solo se muestra
			d.detalle_importe as sub_total, -- no se guarda solo se muestra
			case when ( grd.cantidad_despachar>0 ) 
				then d.detalle_importe/(d.cantidad*up.unidades)*grd.cantidad_despachar 
				else grd.importe 
			end as importe,
			d.detalle_importe/(d.cantidad*up.unidades) as precio_und_min
		FROM detalle_venta d
			LEFT OUTER JOIN producto p on p.producto_id = d.id_producto
			LEFT OUTER JOIN unidades_has_producto up on
				up.id_unidad=d.unidad_medida and up.producto_id=d.id_producto
			LEFT OUTER JOIN unidades uv on
				uv.id_unidad=d.unidad_medida
			LEFT OUTER JOIN unidades_has_producto ump on
				ump.unidades=1 and ump.producto_id=d.id_producto
			LEFT OUTER JOIN unidades um on
				um.id_unidad=ump.id_unidad
			LEFT OUTER JOIN guia_remision_detalle as grd on
				( grd.detalle_id = d.id_detalle and ID_REMISION != -1 and grd.guia_remision_id = ID_REMISION )
		WHERE (ID_REMISION != -1 and grd.guia_remision_id = ID_REMISION) OR
			( ID_REMISION = -1 AND d.id_venta = ID_OPERACION );
	ELSEIF TIPO_OPERACION='entradas_salidas' THEN
		SELECT 'entradas_salidas' as tipo,
			grd.guia_remision_id as guia_remision_id,
			s.id as detalle_id,
			p.producto_id as producto_id,
			p.producto_codigo_interno as producto_codigo_interno,
			p.producto_nombre as nombre_producto,
			s.cantidad as cantidad_total,
			uv.nombre_unidad as unidad_operacion,
			uv.abreviatura as unidad_abr_operacion, -- no se guarda solo se muestra
			s.cantidad*up.unidades as cantidad_en_unidades,
			s.cantidad_parcial as cantidad_parcial,
		 	grd.cantidad_despachar as cantidad_despachar,
			um.abreviatura as unidad_abr,
			um.nombre_unidad as unidad,
			um.id_unidad as id_unidad,
			s.costo_unitario as precio, -- no se guarda solo se muestra
			s.detalle_importe as sub_total, -- no se guarda solo se muestra
			case when ( grd.cantidad_despachar>0 ) 
				then s.detalle_importe/(s.cantidad*up.unidades)*grd.cantidad_despachar 
				else 0 
			end as importe,
			s.detalle_importe/(s.cantidad*up.unidades) as precio_und_min
		FROM ajuste_detalle s
			LEFT OUTER JOIN producto p on p.producto_id = s.producto_id
			LEFT OUTER JOIN unidades_has_producto up on
				up.id_unidad=s.unidad_id and up.producto_id=p.producto_id
			LEFT OUTER JOIN unidades uv on
				uv.id_unidad=s.unidad_id
			LEFT OUTER JOIN unidades_has_producto ump on
				ump.unidades=1 and ump.producto_id=p.producto_id
			LEFT OUTER JOIN unidades um on
				um.id_unidad=ump.id_unidad
			LEFT OUTER JOIN guia_remision_detalle as grd on
				( grd.detalle_id = s.id and ID_REMISION != -1 and grd.guia_remision_id = ID_REMISION )
		WHERE (ID_REMISION != -1 and grd.guia_remision_id = ID_REMISION) OR
			( ID_REMISION = -1 AND s.ajuste_id = ID_OPERACION );
	ELSEIF TIPO_OPERACION='traspaso' THEN
		SELECT 'traspaso' as tipo,
			grd.guia_remision_id as guia_remision_id,
			t.id as detalle_id,
			p.producto_id as producto_id,
			p.producto_codigo_interno as producto_codigo_interno,
			p.producto_nombre as nombre_producto,
			k.cantidad as cantidad_total,
			uv.nombre_unidad as unidad_operacion,
			uv.abreviatura as unidad_abr_operacion,
			k.cantidad*up.unidades as cantidad_en_unidades,
			t.cantidad_parcial as cantidad_parcial,
		 	grd.cantidad_despachar as cantidad_despachar,
			um.abreviatura as unidad_abr,
			um.nombre_unidad as unidad,
			um.id_unidad as id_unidad,
			k.costo as precio, -- no se guarda solo se muestra
			k.costo*k.cantidad as sub_total, -- no se guarda solo se muestra
			case when ( grd.cantidad_despachar>0 )
				then (k.costo/up.unidades*grd.cantidad_despachar)
				else 0 
			end as importe,
			k.costo/up.unidades as precio_und_min
		FROM traspaso_detalle t
			LEFT OUTER JOIN kardex   k on k.id = t.kardex_id
			LEFT OUTER JOIN producto p on p.producto_id = k.producto_id
			LEFT OUTER JOIN unidades_has_producto up on
				up.id_unidad=k.unidad_id and up.producto_id=p.producto_id
			LEFT OUTER JOIN unidades uv on
				uv.id_unidad=k.unidad_id
			LEFT OUTER JOIN unidades_has_producto ump on
				ump.unidades=1 and ump.producto_id=p.producto_id
			LEFT OUTER JOIN unidades um on
				um.id_unidad=ump.id_unidad
			LEFT OUTER JOIN guia_remision_detalle as grd on
				( grd.detalle_id = t.id and ID_REMISION != -1 and grd.guia_remision_id = ID_REMISION )
		WHERE (ID_REMISION != -1 and grd.guia_remision_id = ID_REMISION) OR
			( ID_REMISION = -1 AND t.traspaso_id = ID_OPERACION );
	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SELLAR_GUIA_REMISION
-- ----------------------------
DROP PROCEDURE IF EXISTS `SELLAR_GUIA_REMISION`;
delimiter ;;
CREATE PROCEDURE `SELLAR_GUIA_REMISION`(IN  ID_REMISION INT)
BEGIN
	DECLARE ID_DETALLE INTEGER;
	DECLARE Q_A_DESPACHAR FLOAT8;
	DECLARE Q_PARCIAL FLOAT8;
	DECLARE done INT DEFAULT FALSE;
	DECLARE TIPO_OPERACION VARCHAR(200);
	DECLARE ID_OPERACION INT;
 	DECLARE cursor_guia_detalle CURSOR FOR
 				SELECT detalle_id, cantidad_despachar,
 						cantidad_parcial
 				FROM guia_remision_detalle
 				WHERE guia_remision_id = ID_REMISION;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	SELECT gr.tipo_operacion, gr.tipo_operacion_remision_id into TIPO_OPERACION, ID_OPERACION
		FROM guia_remision gr
		WHERE gr.estado = 0 and gr.id = ID_REMISION -- 0 estado borrador - solo pueden ser sellados los de estado borrador
		LIMIT 1;
	OPEN cursor_guia_detalle;
		myloop: LOOP
		FETCH cursor_guia_detalle INTO ID_DETALLE, Q_A_DESPACHAR, Q_PARCIAL;		
		IF done THEN
			LEAVE myloop;
		END IF;
		IF TIPO_OPERACION = 'venta' THEN
				-- actualmente, cantidad_parcial en detalle_venta se inicializa como 0
				-- debe inicializarse igual que la cantidad total
			UPDATE detalle_venta SET cantidad_parcial = detalle_venta.cantidad_parcial - Q_A_DESPACHAR
			WHERE detalle_venta.id_detalle=ID_DETALLE and detalle_venta.id_venta=ID_OPERACION;
		ELSEIF TIPO_OPERACION = 'entradas_salidas' THEN
				-- actualmente, cantidad_parcial en detalle_venta se inicializa como 0
				-- debe inicializarse igual que la cantidad total
			UPDATE ajuste_detalle SET cantidad_parcial = ajuste_detalle.cantidad_parcial - Q_A_DESPACHAR
			WHERE ajuste_detalle.id=ID_DETALLE and ajuste_detalle.ajuste_id=ID_OPERACION;
		ELSEIF TIPO_OPERACION = 'traspaso' THEN
				-- actualmente, cantidad_parcial en detalle_venta se inicializa como 0
				-- debe inicializarse igual que la cantidad total
			UPDATE traspaso_detalle SET cantidad_parcial = traspaso_detalle.cantidad_parcial - Q_A_DESPACHAR
			WHERE traspaso_detalle.id=ID_DETALLE and traspaso_detalle.traspaso_id=ID_OPERACION;
		END IF;
	END LOOP;
 	CLOSE cursor_guia_detalle;
 	-- sella la guia de remision
	UPDATE guia_remision set estado = 1 -- ESTADO SELLADO
		WHERE id = ID_REMISION;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
