--------------- SQL ---------------

CREATE OR REPLACE FUNCTION sigefo.f_cargo_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de gestión de la formación
 FUNCION: 		sigefo.f_cargo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'orga.tcargo'
 AUTOR: 		 (admin)
 FECHA:	        04-05-2017 20:37:24
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

	v_nombre_funcion = 'sigefo.f_cargo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'SIGEFO_CARGO_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		yac
 	#FECHA:		04-05-2017 20:37:24
	***********************************/
	if(p_transaccion='SIGEFO_CARGO_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='SELECT 
					cargo.id_cargo,
					cargo.id_uo,
					cargo.id_tipo_contrato,
					cargo.id_lugar,
					cargo.nombre,
					cargo.id_cargo AS identificador,
					uo.gerencia,
					uo.nombre_unidad
				FROM orga.tcargo cargo
					INNER JOIN segu.tusuario usu1 ON usu1.id_usuario = cargo.id_usuario_reg
					LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = cargo.id_usuario_mod
					LEFT JOIN orga.tuo uo on uo.id_uo= cargo.id_uo
				LEFT join orga.testructura_uo euo on UO.id_uo=euo.id_uo_hijo
				WHERE cargo.estado_reg = ''activo'' and ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;

		end;
		/*********************************
 #TRANSACCION:  'SIGEFO_CARGO_CONT'
 #DESCRIPCION:	Conteo de registros
 #AUTOR:		yac
 #FECHA:		04-05-2017 19:16:06
***********************************/

	elsif(p_transaccion='SIGEFO_CARGO_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_cargo)
					   FROM orga.tcargo cargo
					INNER JOIN segu.tusuario usu1 ON usu1.id_usuario = cargo.id_usuario_reg
					LEFT JOIN segu.tusuario usu2 ON usu2.id_usuario = cargo.id_usuario_mod
					LEFT JOIN orga.tuo uo on uo.id_uo= cargo.id_uo
				LEFT join orga.testructura_uo euo on UO.id_uo=euo.id_uo_hijo
				WHERE cargo.estado_reg = ''activo''  and ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;


      RAISE NOTICE '%',v_consulta;
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