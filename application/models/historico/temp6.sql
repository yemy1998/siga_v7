SELECT  
        v.id_cliente, /*id_cliente*/
        c.razon_social, /*destinatario*/
        1, /*tipo_operacion*/
        v.local_id, /*loca_id*/
				'T001', /*serie*/
        100, /*numero*/
        1, /*tipo_operacion_id*/
        v.venta_id, /*tipo_operacion_remision_id*/
        '222', /*nro_orden_compra*/
        '2019-11-29', /*fecha_emision*/
        '2019-11-29', /*fecha_inicio_traslado*/
        1, /*motivo_traslado_id*/
        '',/*otros_motivo*/
        'Calle Martial N 1511', /*punto_partida*/
        '060105', /*ubigeo_punto_partida*/
        'Calle Begonias N 15161', /*punto_llegada*/
        '010510', /*ubigeo_punto_llegada*/
        1, /*cantidad_total*/
        1, /*cantidad_parcial*/
        100, /*total*/
        35, /*total*/
        1, /*transportista_id*/
        1,/*tipo_transportista*/
        'A11511321', /*placa*/
        '', /*ruc_transportista*/
        '',        /*razon_social_transportista*/
				'1',/*tipo_documento_persona_id*/
        '45561111',        /*identificacion_coductor*/
        'Renzo Segura', /*nombre_conductor*/
        '',/*nota*/
        1 /*estado*/
FROM venta v 
left outer join cliente c on c.id_cliente=v.id_cliente 
where v.venta_id=125;
