CREATE OR REPLACE FUNCTION "sigefo"."ft_planificacion_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Sistema de gestión de la formación
 FUNCION: 		sigefo.ft_planificacion_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'sigefo.tplanificacion'
 AUTOR: 		 (admin)
 FECHA:	        26-04-2017 20:37:24
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

	v_nombre_funcion = 'sigefo.ft_planificacion_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SIGEFO_SIGEFOP_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		26-04-2017 20:37:24
	***********************************/

	if(p_transaccion='SIGEFO_SIGEFOP_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						sigefop.id_planificacion,
						sigefop.id_gestion,
						sigefop.estado_reg,
						sigefop.cantidad_personas,
						sigefop.contenido_basico,
						sigefop.nombre_planificacion,
						sigefop.necesidad,
						sigefop.horas_previstas,
						sigefop.fecha_reg,
						sigefop.usuario_ai,
						sigefop.id_usuario_reg,
						sigefop.id_usuario_ai,
						sigefop.id_usuario_mod,
						sigefop.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from sigefo.tplanificacion sigefop
						inner join segu.tusuario usu1 on usu1.id_usuario = sigefop.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = sigefop.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SIGEFO_SIGEFOP_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		26-04-2017 20:37:24
	***********************************/

	elsif(p_transaccion='SIGEFO_SIGEFOP_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_planificacion)
					    from sigefo.tplanificacion sigefop
					    inner join segu.tusuario usu1 on usu1.id_usuario = sigefop.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = sigefop.id_usuario_mod
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
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "sigefo"."ft_planificacion_sel"(integer, integer, character varying, character varying) OWNER TO postgres;