/********************************************I-DAT-RAC-SP-0-15/01/2013********************************************/


INSERT INTO segu.tsubsistema ("codigo", "nombre", "fecha_reg", "prefijo", "estado_reg", "nombre_carpeta", "id_subsis_orig")
VALUES   ( E'SIGEFO', E'Sistema de gestión de la formación', E'2017-04-26', E'SIGEFO', E'activo', E'formacion', NULL);

select pxp.f_insert_tgui (''SISTEMA DE GESTIÓN DE LA FORMACIÓN'', '''', ''SIGEFO'', ''si'', 1, '''', 1, '''', '''', ''SIGEFO'');
/********************************************F-DAT-RAC-SP-0-15/01/2013********************************************/