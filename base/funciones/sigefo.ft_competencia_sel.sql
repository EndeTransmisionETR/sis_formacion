CREATE OR REPLACE FUNCTION "sigefo"."ft_competencia_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Sistema de gestión de la formación
 FUNCION: 		sigefo.ft_competencia_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'sigefo.tcompetencia'
 AUTOR: 		 (admin)
 FECHA:	        04-05-2017 19:30:13
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

	v_nombre_funcion = 'sigefo.ft_competencia_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SIGEFO_SIGEFOCO_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		04-05-2017 19:30:13
	***********************************/

	if(p_transaccion='SIGEFO_SIGEFOCO_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						sigefoco.id_competencia,
						tc.descripcion as tipo,
						sigefoco.estado_reg,
						sigefoco.competencia,
						sigefoco.id_usuario_ai,
						sigefoco.id_usuario_reg,
						sigefoco.fecha_reg,
						sigefoco.usuario_ai,
						sigefoco.id_usuario_mod,
						sigefoco.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from sigefo.tcompetencia sigefoco
						inner join segu.tusuario usu1 on usu1.id_usuario = sigefoco.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = sigefoco.id_usuario_mod
									left join param.tcatalogo tc on tc.codigo = sigefoco.tipo
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SIGEFO_SIGEFOCO_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		04-05-2017 19:30:13
	***********************************/

	elsif(p_transaccion='SIGEFO_SIGEFOCO_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_competencia)
					    from sigefo.tcompetencia sigefoco
					    inner join segu.tusuario usu1 on usu1.id_usuario = sigefoco.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = sigefoco.id_usuario_mod
									left join param.tcatalogo tc on tc.codigo = sigefoco.tipo
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
ALTER FUNCTION "sigefo"."ft_competencia_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
