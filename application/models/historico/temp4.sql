SELECT `venta`.`venta_id` as `venta_id`, `venta`.`comprobante_id` as `comprobante_id`, `venta`.`fecha` as `venta_fecha`, 
	`venta`.`created_at` as `venta_creado`, `venta`.`fecha_entrega` as `venta_fecha_entrega`, `venta`.`pagado` as `venta_pagado`, 
	`venta`.`vuelto` as `venta_vuelto`, `venta`.`correlativo` as `correlativo`, `venta`.`local_id` as `local_id`, 
	`local`.`local_nombre` as `local_nombre`, `local`.`direccion` as `local_direccion`, `local`.`distrito_id` as `local_distrito`, 
	`venta`.`id_documento` as `documento_id`, `documentos`.`des_doc` as `documento_nombre`, `documentos`.`abr_doc` as `documento_abr`, 
	`venta`.`factura_impresa` as `factura_impresa`, `venta`.`id_cliente` as `cliente_id`, `cliente`.`razon_social` as `cliente_nombre`, 
	`cliente`.`identificacion` as `ruc`, `cliente`.`ruc` as `cliente_tipo_identificacion`, `cliente`.`direccion` as `cliente_direccion`, 
	`cliente`.`telefono1` as `cliente_telefono`, `venta`.`cliente_direccion` as `venta_direccion`, `venta`.`id_vendedor` as `vendedor_id`, 
	`usuario`.`username` as `vendedor_nombre`, `venta`.`condicion_pago` as `condicion_id`, `condiciones_pago`.`nombre_condiciones` as `condicion_nombre`, 
	`venta`.`venta_status` as `venta_estado`, `venta`.`id_moneda` as `moneda_id`, `venta`.`tasa_cambio` as `moneda_tasa`, `moneda`.`nombre` as `moneda_nombre`, 
	`moneda`.`simbolo` as `moneda_simbolo`, `venta`.`total` as `total`, `venta`.`inicial` AS `inicial`, `venta`.`total_impuesto` as `impuesto`, 
	`venta`.`total_bolsas` as `total_bolsas`, `venta`.`subtotal` as `subtotal`, `credito`.`dec_credito_montodebito` as `credito_pagado`, 
	`credito`.`dec_credito_montocuota` as `credito_pendiente`, `credito`.`var_credito_estado` as `credito_estado`, `credito`.`tasa_interes` as `tasa_interes`, 
	`credito`.`periodo_gracia` as `periodo_gracia`, `venta`.`serie` as `serie`, `venta`.`numero` as `numero`, `venta`.`fecha_facturacion` as `fecha_facturacion`, 
	`venta`.`nota` as `nota`, `venta`.`dni_garante` as `nombre_caja`, `venta`.`tipo_impuesto` as `tipo_impuesto`, `cliente`.`tipo_cliente` as `tipo_cliente`, 
	`cliente`.`direccion` as `direccion_cliente`, `venta`.`dni_garante` as `nombre_vd`, 
	(select SUM(detalle_venta.cantidad) from detalle_venta where detalle_venta.id_venta=venta.venta_id) as total_bultos,
	(select COUNT(id) from notas_credito where notas_credito.venta_id=venta.venta_id) as total_nota_credito,
	`venta`.`nro_guia` as `nro_guia`, `venta`.`nro_compra` as `nro_compra`, `venta`.`motivo` as `motivo`, 
	`facturacion`.`documento_tipo` as `tipo_documento`, `facturacion`.`documento_numero` as `serial`, IFNULL(dp.codigotipo, '') as cliente_codigo
FROM `venta`
	LEFT JOIN `facturacion` ON `facturacion`.`ref_id` = `venta`.`venta_id`
	JOIN `documentos` ON `venta`.`id_documento`=`documentos`.`id_doc`
	JOIN `condiciones_pago` ON `venta`.`condicion_pago`=`condiciones_pago`.`id_condiciones`
	JOIN `cliente` ON `venta`.`id_cliente`=`cliente`.`id_cliente`
	LEFT JOIN `tipo_documento_persona` `dp` ON `dp`.`id` = `cliente`.`tipo_cliente`
	JOIN `usuario` ON `venta`.`id_vendedor`=`usuario`.`nUsuCodigo`
	JOIN `moneda` ON `venta`.`id_moneda`=`moneda`.`id_moneda`
	JOIN `local` ON `venta`.`local_id`=`local`.`int_local_id`
	LEFT JOIN `credito` ON `venta`.`venta_id`=`credito`.`id_venta`
WHERE `venta`.`venta_id` = '815'
ORDER BY `venta`.`fecha` DESC