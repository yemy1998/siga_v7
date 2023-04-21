-- Campo ubigeo de cliente_sucursal debe ser texto
ALTER TABLE `cliente_sucursal` 
	CHANGE `ubigeo` `ubigeo` varchar(10)   NULL COMMENT 'codigo de ubigeo de la sucursal' after `direccion` ;

-- Cambios en guia_remision
ALTER TABLE `guia_remision` 
	ADD COLUMN `id_cliente` bigint(1)   NOT NULL after `id` , 
	CHANGE `destinatario` `destinatario` text  COLLATE latin1_swedish_ci NOT NULL after `id_cliente` , 
	CHANGE `tipo_operacion` `tipo_operacion` enum('cotizacion','venta','traslado','generico','guia_remision','traspaso','entradas_salidas')  COLLATE latin1_swedish_ci NOT NULL after `destinatario` , 
	ADD COLUMN `loca_id` int(11)   NULL after `tipo_operacion` , 
	ADD COLUMN `serie` varchar(20)  COLLATE latin1_swedish_ci NULL after `loca_id` , 
	ADD COLUMN `numero` varchar(45)  COLLATE latin1_swedish_ci NULL after `serie` , 
	CHANGE `tipo_operacion_id` `tipo_operacion_id` int(11)   NOT NULL after `numero` , 
	CHANGE `tipo_operacion_remision_id` `tipo_operacion_remision_id` int(11)   NOT NULL after `tipo_operacion_id` , 
	CHANGE `nro_orden_compra` `nro_orden_compra` int(11)   NOT NULL after `tipo_operacion_remision_id` , 
	CHANGE `fecha_emision` `fecha_emision` date   NOT NULL after `nro_orden_compra` , 
	CHANGE `fecha_inicio_traslado` `fecha_inicio_traslado` date   NOT NULL after `fecha_emision` , 
	CHANGE `motivo_traslado_id` `motivo_traslado_id` int(11)   NOT NULL after `fecha_inicio_traslado` , 
	CHANGE `otros_motivo` `otros_motivo` text  COLLATE latin1_swedish_ci NOT NULL after `motivo_traslado_id` , 
	CHANGE `punto_partida` `punto_partida` text  COLLATE latin1_swedish_ci NULL after `otros_motivo` , 
	ADD COLUMN `ubigeo_punto_partida` text  COLLATE latin1_swedish_ci NULL after `punto_partida` , 
	CHANGE `punto_llegada` `punto_llegada` text  COLLATE latin1_swedish_ci NULL after `ubigeo_punto_partida` , 
	ADD COLUMN `ubigeo_punto_llegada` text  COLLATE latin1_swedish_ci NULL after `punto_llegada` , 
	CHANGE `cantidad_total` `cantidad_total` int(8)   NOT NULL after `ubigeo_punto_llegada` , 
	CHANGE `cantidad_parcial` `cantidad_parcial` int(8)   NOT NULL after `cantidad_total` , 
	CHANGE `total` `total` decimal(8,2)   NOT NULL after `cantidad_parcial` , 
	ADD COLUMN `peso_total` int(8)   NULL after `total` , 
	ADD COLUMN `transportista_id` int(11)   NOT NULL after `peso_total` , 
	ADD COLUMN `tipo_transportista` tinyint(1)   NULL after `transportista_id` , 
	ADD COLUMN `placa` varchar(20)  COLLATE latin1_swedish_ci NULL DEFAULT '' after `tipo_transportista` , 
	ADD COLUMN `ruc_transportista` varchar(20)  COLLATE latin1_swedish_ci NULL after `placa` , 
	ADD COLUMN `razon_social_transportista` varchar(100)  COLLATE latin1_swedish_ci NULL after `ruc_transportista` , 
	ADD COLUMN `tipo_documento_persona_id` int(11)   NULL after `razon_social_transportista` , 
	ADD COLUMN `identificacion_conductor` varchar(20)  COLLATE latin1_swedish_ci NULL DEFAULT '' after `tipo_documento_persona_id` , 
	ADD COLUMN `nombre_conductor` varchar(100)  COLLATE latin1_swedish_ci NULL DEFAULT '' after `identificacion_conductor` , 
	CHANGE `nota` `nota` text  COLLATE latin1_swedish_ci NULL after `nombre_conductor` , 
	CHANGE `estado` `estado` tinyint(1)   NOT NULL after `nota` , 
	DROP COLUMN `conductor_id` , 
	DROP COLUMN `nro_guia_remision` , 
	DROP COLUMN `placa_vehiculo_id` , 
	DROP COLUMN `local_id` , 
	DROP COLUMN `transporte_id` ;

Tabla motivos de guía de remisión - Creación de columna codigo_sunat
ALTER TABLE `motivos_guiaremision_descripcion` 
	ADD COLUMN `codigo_sunat` varchar(20)  COLLATE latin1_swedish_ci NULL after `descripcion` ;

Tabla para mantenimiento de transportistas
CREATE TABLE `transportista`(
	`id_transportista` int(11) NOT NULL  auto_increment , 
	`descripcion` varchar(100) COLLATE latin1_swedish_ci NULL  , 
	`tipo_transportista` tinyint(1) NOT NULL  DEFAULT 0 , 
	`ruc` varchar(15) COLLATE latin1_swedish_ci NULL  , 
	`razon_social` varchar(100) COLLATE latin1_swedish_ci NULL  , 
	`tipo_documento_persona_id` int(11) NULL  , 
	`identificacion_conductor` varchar(20) COLLATE latin1_swedish_ci NULL  DEFAULT '' , 
	`nombre_conductor` varchar(100) COLLATE latin1_swedish_ci NULL  DEFAULT '' , 
	`placa` varchar(10) COLLATE latin1_swedish_ci NULL  , 
	PRIMARY KEY (`id_transportista`) 
) ENGINE=InnoDB DEFAULT CHARSET='latin1' COLLATE='latin1_swedish_ci';





Tabla para mantenimiento de vehículos
CREATE TABLE `camiones`(
	`placa` varchar(20) COLLATE latin1_swedish_ci NOT NULL  , 
	`metros_cubicos` int(20) NULL  , 
	`peso` int(20) NULL  , 
	PRIMARY KEY (`placa`) 
) ENGINE=InnoDB DEFAULT CHARSET='latin1' COLLATE='latin1_swedish_ci';



Eliminación de tablas
DROP TABLE `transporte_guiaremision`;
DROP TABLE `conductores`;
DROP TABLE `cliente_entrega`;
