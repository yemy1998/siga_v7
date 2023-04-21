/*
 Navicat Premium Data Transfer

 Source Server         : MYSQL_V7
 Source Server Type    : MySQL
 Source Server Version : 100427
 Source Host           : localhost:3306
 Source Schema         : sigaco6_env

 Target Server Type    : MySQL
 Target Server Version : 100427
 File Encoding         : 65001

 Date: 28/02/2023 09:12:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for clientes
-- ----------------------------
DROP TABLE IF EXISTS `clientes`;
CREATE TABLE `clientes`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigo_interno` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `database` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `base_url` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ruc` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1,
  `version_id` int NOT NULL,
  `create_at` datetime NULL DEFAULT NULL,
  `periodo` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'M' COMMENT 'M = mensual; A = anual',
  `fecha_inactivo` datetime NULL DEFAULT NULL,
  `facturacion` int NOT NULL DEFAULT 0,
  `sistema` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'RIF',
  `importe` decimal(19, 2) NOT NULL DEFAULT 0.00,
  `moneda` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'SOLES',
  `eliminado` tinyint(1) NOT NULL DEFAULT 0,
  `fecha_eliminado` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `codigo_interno`(`codigo_interno` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of clientes
-- ----------------------------

-- ----------------------------
-- Table structure for condiciones
-- ----------------------------
DROP TABLE IF EXISTS `condiciones`;
CREATE TABLE `condiciones`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigoCliente` varchar(155) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `aplazar` tinyint(1) NULL DEFAULT NULL COMMENT '0 = no / 1 = si',
  `maxNumeroMeses` int NULL DEFAULT NULL COMMENT 'Maximo cantidad de meses atrasados',
  `impuestos` int NULL DEFAULT NULL COMMENT '0 = no / 1 = si',
  `codigoDistribuidor` varchar(155) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `observacion` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of condiciones
-- ----------------------------

-- ----------------------------
-- Table structure for cronograma_pago
-- ----------------------------
DROP TABLE IF EXISTS `cronograma_pago`;
CREATE TABLE `cronograma_pago`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigoCliente` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nro_aviso` int NULL DEFAULT NULL,
  `periodo` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fecha_aviso` date NULL DEFAULT NULL,
  `fecha_vencimiento` date NULL DEFAULT NULL,
  `periodo_gracia` int NULL DEFAULT NULL,
  `moneda` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `total` int NULL DEFAULT NULL,
  `estado` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `partner` varchar(155) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cronograma_pago
-- ----------------------------

-- ----------------------------
-- Table structure for distribuidor
-- ----------------------------
DROP TABLE IF EXISTS `distribuidor`;
CREATE TABLE `distribuidor`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigoDistribuidor` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nombre` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `cuenta_cte_moneda_nacional` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `cuenta_cte_moneda_extranjera` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `cuenta_ahorros_moneda_nacional` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `cuenta_ahorros_moneda_extranjera` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `correoContacto` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `telefono` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of distribuidor
-- ----------------------------

-- ----------------------------
-- Table structure for formulario_contacto
-- ----------------------------
DROP TABLE IF EXISTS `formulario_contacto`;
CREATE TABLE `formulario_contacto`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `email` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `asunto` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `mensaje` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '' COMMENT 'NUEVO/EN PROCESO/CERRADO',
  `estado` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `create_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of formulario_contacto
-- ----------------------------

-- ----------------------------
-- Table structure for formulario_demo
-- ----------------------------
DROP TABLE IF EXISTS `formulario_demo`;
CREATE TABLE `formulario_demo`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `email` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `celular` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `producto_rif` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `create_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of formulario_demo
-- ----------------------------

-- ----------------------------
-- Table structure for historial_usuarios
-- ----------------------------
DROP TABLE IF EXISTS `historial_usuarios`;
CREATE TABLE `historial_usuarios`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL,
  `dominio` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `accion` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `usuario_nombre` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ref_id` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `user_agent` tinytext CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `fuente` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of historial_usuarios
-- ----------------------------

-- ----------------------------
-- Table structure for mensaje
-- ----------------------------
DROP TABLE IF EXISTS `mensaje`;
CREATE TABLE `mensaje`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `motivo` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `detalle` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mensaje
-- ----------------------------

-- ----------------------------
-- Table structure for prospectos
-- ----------------------------
DROP TABLE IF EXISTS `prospectos`;
CREATE TABLE `prospectos`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre_comercio` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `producto_rif` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `plan_rif` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nombre_contacto` varchar(35) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `apellido_contacto` varchar(35) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `email_contacto` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `celular_contacto` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `promocion` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `estado` int NULL DEFAULT NULL COMMENT '0=pendiente de confirmar / 1 = confirmado / 2 = expirado ',
  `token` varchar(300) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `create_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of prospectos
-- ----------------------------

-- ----------------------------
-- Table structure for requerimientos
-- ----------------------------
DROP TABLE IF EXISTS `requerimientos`;
CREATE TABLE `requerimientos`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL DEFAULT current_timestamp,
  `numerorequerimiento` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `colaborador` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sistema` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `cliente` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `opcion` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `caso` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `estado` tinyint NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of requerimientos
-- ----------------------------

-- ----------------------------
-- Table structure for resumen_envio_sunat
-- ----------------------------
DROP TABLE IF EXISTS `resumen_envio_sunat`;
CREATE TABLE `resumen_envio_sunat`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fact_ref_id` bigint NOT NULL,
  `cliente_id` bigint NOT NULL,
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
  `subtotal` decimal(18, 2) NOT NULL DEFAULT 0.00,
  `impuesto` decimal(18, 2) NOT NULL DEFAULT 0.00,
  `total` decimal(18, 2) NOT NULL DEFAULT 0.00,
  `estado` tinyint NOT NULL DEFAULT 0,
  `nota` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sunat_codigo` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hash_cpe` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hash_cdr` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ref_id` bigint NOT NULL,
  `descuento` decimal(18, 2) NULL DEFAULT 0.00,
  `estado_comprobante` tinyint NOT NULL DEFAULT 1 COMMENT '1 => Nuevo\n2 => Modificado\n3 => Anulado o dado de baja',
  `moneda_id` int NOT NULL DEFAULT 1029,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of resumen_envio_sunat
-- ----------------------------

-- ----------------------------
-- Table structure for temario
-- ----------------------------
DROP TABLE IF EXISTS `temario`;
CREATE TABLE `temario`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `opcionClase` bigint NULL DEFAULT NULL,
  `opcionIdentificador` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `opcionNombre` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `descripcionOpcion` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `tiempoVideo` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `codigoBusqueda` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'Por este valor se identificaran las ventanas del sistema',
  `linkVideo` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'link del video de youtube',
  `linkDocumento` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `estado` tinyint(1) NULL DEFAULT NULL,
  `create_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of temario
-- ----------------------------

-- ----------------------------
-- Table structure for versiones
-- ----------------------------
DROP TABLE IF EXISTS `versiones`;
CREATE TABLE `versiones`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `principal` tinyint NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp,
  `activo` tinyint NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of versiones
-- ----------------------------
INSERT INTO `versiones` VALUES (1, 'produccion', 1, '2020-04-24 15:34:08', 1);
INSERT INTO `versiones` VALUES (2, 'produccion', 1, '2020-04-24 15:34:12', 1);

SET FOREIGN_KEY_CHECKS = 1;
