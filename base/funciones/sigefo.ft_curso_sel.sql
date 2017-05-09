--------------- SQL ---------------

CREATE OR REPLACE FUNCTION sigefo.ft_curso_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de gestión de la formación
 FUNCION: 		sigefo.ft_curso_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'sigefo.tcurso'
 AUTOR: 		 (admin)
 FECHA:	        22-01-2017 15:35:03
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'sigefo.ft_curso_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SIGEFO_SCU_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		22-01-2017 15:35:03
	***********************************/

	if(p_transaccion='SIGEFO_SCU_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						scu.id_curso,
						scu.id_gestion,
						scu.id_lugar,
						scu.id_proveedor,
						scu.origen,
						scu.fecha_inicio,
						scu.objetivo,
						scu.estado_reg,
						scu.cod_tipo,
						scu.horas,
						scu.nombre_curso,
						scu.cod_clasificacion,
						scu.expositor,
						scu.contenido,
						scu.fecha_fin,
						scu.fecha_reg,
						scu.usuario_ai,
						scu.id_usuario_reg,
						scu.id_usuario_ai,
						scu.id_usuario_mod,
						scu.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        g.gestion,
                        l.nombre,
                        p.rotulo_comercial,
                        
                        (select array_to_string( array_agg( cc.id_competencia), '','' ) 
                        from sigefo.tcurso_competencia cc join sigefo.tcurso c on c.id_curso=cc.id_curso 
                        where cc.id_curso=scu.id_curso)::VARCHAR as id_competencias,
                        
                        (select array_to_string( array_agg( co.competencia), ''<br>'' ) 
                        from sigefo.tcurso_competencia cc join sigefo.tcurso c on c.id_curso=cc.id_curso 
                        join sigefo.tcompetencia co on co.id_competencia=cc.id_competencia
                        where cc.id_curso=scu.id_curso)::VARCHAR as competencias,
                        
                        (select array_to_string( array_agg( cp.id_planificacion), '','' ) 
                        from sigefo.tcurso_planificacion cp join sigefo.tcurso c on c.id_curso=cp.id_curso 
                        where cp.id_curso=scu.id_curso)::VARCHAR as id_planificaciones,
                        
                        (select array_to_string( array_agg( pl.nombre_planificacion), ''<br>'' ) 
                        from sigefo.tcurso_planificacion cp join sigefo.tcurso c on c.id_curso=cp.id_curso 
                        join sigefo.tplanificacion pl on pl.id_planificacion=cp.id_planificacion
                        where cp.id_curso=scu.id_curso)::VARCHAR as competencias,
                        
                        (select array_to_string( array_agg( cf.id_funcionario), '','' ) 
                        from sigefo.tcurso_funcionario cf join sigefo.tcurso c on c.id_curso=cf.id_curso 
                        where cf.id_curso=scu.id_curso)::VARCHAR as id_funcionarios,
                        
                        (select array_to_string( array_agg(PERSON.nombre_completo2), ''<br>'' ) 
                        from sigefo.tcurso_funcionario cf join sigefo.tcurso c on c.id_curso=cf.id_curso 
                        join orga.tfuncionario FUNCIO on FUNCIO.id_funcionario=cf.id_funcionario
                        join SEGU.vpersona PERSON ON PERSON.id_persona=FUNCIO.id_persona
                        where cf.id_curso=scu.id_curso)::VARCHAR as funcionarios
						from sigefo.tcurso scu
						inner join segu.tusuario usu1 on usu1.id_usuario = scu.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = scu.id_usuario_mod
                        join param.tgestion g on g.id_gestion=scu.id_gestion
                        join param.tlugar l on l.id_lugar=scu.id_lugar
                        join param.tproveedor p on p.id_proveedor= scu.id_proveedor
                        
                        
                        
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SIGEFO_SCU_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		22-01-2017 15:35:03
	***********************************/

	elsif(p_transaccion='SIGEFO_SCU_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_curso)
					    from sigefo.tcurso scu
					    inner join segu.tusuario usu1 on usu1.id_usuario = scu.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = scu.id_usuario_mod
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
					
	else
					     
		raise exception 'Transaccion inexistente';
					         
	end if;
					
EXCEPTION
					
	WHEN OTHERS THEN
			v_resp='';
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
			v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
			v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
			raise exception '%',v_resp;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;