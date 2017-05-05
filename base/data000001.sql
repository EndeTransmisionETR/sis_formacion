/********************************************I-DAT-RAC-SP-0-15/01/2013********************************************/


INSERT INTO segu.tsubsistema ("codigo", "nombre", "fecha_reg", "prefijo", "estado_reg", "nombre_carpeta", "id_subsis_orig")
VALUES   ( E'SIGEFO', E'Sistema de gestión de la formación', E'2017-04-26', E'SIGEFO', E'activo', E'formacion', NULL);

select pxp.f_insert_tgui ('SISTEMA DE GESTIÓN DE LA FORMACIÓN', '', 'SIGEFO', 'si', 1, '', 1, '', '', 'SIGEFO');

-- TODO: Falta colocar los datos del catalogo

/********************************************F-DAT-RAC-SP-0-15/01/2013********************************************/
/********************************************I-DAT-YAC-SP-0-05/05/2017********************************************/
select pxp.f_insert_tgui ('Planificación', 'Planificación', 'SIGEFOP', 'si', 1, 'sis_formacion/vista/planificacion/Planificacion.php', 2, '', 'Planificacion', 'SIGEFO');
select pxp.f_insert_tgui ('Competencias', 'Competencias', 'SIGEFOCO', 'si', 2, 'sis_formacion/vista/competencia/Competencia.php', 2, '', 'Competencia', 'SIGEFO');

/********************************************F-DAT-YAC-SP-0-05/05/2017********************************************/

/********************************************I-DAT-YAC-SP-1-05/05/2017********************************************/


select param.f_import_tcatalogo_tipo ('insert','tplanificacion_critico','SIGEFO','tplanificacion_critico');
select param.f_import_tcatalogo ('insert','SIGEFO','criterio 01','cri01','tplanificacion_critico');
select param.f_import_tcatalogo ('insert','SIGEFO','criterio 02','cri02','tplanificacion_critico');

select param.f_import_tcatalogo_tipo ('insert','tipocompetencia','SIGEFO','tcompetencia');
select param.f_import_tcatalogo ('insert','SIGEFO','Conocimiento','conocimiento','tipocompetencia');
select param.f_import_tcatalogo ('insert','SIGEFO','Cualidad','cualidad','tipocompetencia');
select param.f_import_tcatalogo ('insert','SIGEFO','Actitud','actitud','tipocompetencia');

/********************************************F-DAT-YAC-SP-1-05/05/2017********************************************/
