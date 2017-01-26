--------------- SQL ---------------

CREATE OR REPLACE FUNCTION sigefo.ft_curso_competencia_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de gestión de la formación
 FUNCION: 		sigefo.ft_curso_competencia_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'sigefo.tcurso_competencia'
 AUTOR: 		 (admin)
 FECHA:	        22-01-2017 20:25:54
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

	v_nombre_funcion = 'sigefo.ft_curso_competencia_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SIGEFO_CUCO_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		22-01-2017 20:25:54
	***********************************/

	if(p_transaccion='SIGEFO_CUCO_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						cuco.id_curso_competencia,
						cuco.id_curso,
						cuco.id_competencia,
						cuco.estado_reg,
						cuco.id_usuario_ai,
						cuco.id_usuario_reg,
						cuco.usuario_ai,
						cuco.fecha_reg,
						cuco.fecha_mod,
						cuco.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        sigefoco.competencia	
						from sigefo.tcurso_competencia cuco
						inner join segu.tusuario usu1 on usu1.id_usuario = cuco.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = cuco.id_usuario_mod
                        join sigefo.tcompetencia sigefoco on sigefoco.id_competencia=cuco.id_competencia
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SIGEFO_CUCO_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		22-01-2017 20:25:54
	***********************************/

	elsif(p_transaccion='SIGEFO_CUCO_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_curso_competencia)
					    from sigefo.tcurso_competencia cuco
					    inner join segu.tusuario usu1 on usu1.id_usuario = cuco.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = cuco.id_usuario_mod
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