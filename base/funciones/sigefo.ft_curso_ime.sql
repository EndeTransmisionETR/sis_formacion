--------------- SQL ---------------

CREATE OR REPLACE FUNCTION sigefo.ft_curso_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de gestión de la formación
 FUNCION: 		sigefo.ft_curso_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'sigefo.tcurso'
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

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_curso	integer;
			    
BEGIN

    v_nombre_funcion = 'sigefo.ft_curso_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SIGEFO_SCU_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		22-01-2017 15:35:03
	***********************************/

	if(p_transaccion='SIGEFO_SCU_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into sigefo.tcurso(
			id_gestion,
			id_lugar,
			id_proveedor,
			origen,
			fecha_inicio,
			objetivo,
			estado_reg,
			cod_tipo,
			horas,
			nombre_curso,
			cod_clasificacion,
			expositor,
			contenido,
			fecha_fin,
			fecha_reg,
			usuario_ai,
			id_usuario_reg,
			id_usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.id_gestion,
			v_parametros.id_lugar,
			v_parametros.id_proveedor,
			v_parametros.origen,
			v_parametros.fecha_inicio,
			v_parametros.objetivo,
			'activo',
			v_parametros.cod_tipo,
			v_parametros.horas,
			v_parametros.nombre_curso,
			v_parametros.cod_clasificacion,
			v_parametros.expositor,
			v_parametros.contenido,
			v_parametros.fecha_fin,
			now(),
			v_parametros._nombre_usuario_ai,
			p_id_usuario,
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_curso into v_id_curso;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cursos almacenado(a) con exito (id_curso'||v_id_curso||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_curso',v_id_curso::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SIGEFO_SCU_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		22-01-2017 15:35:03
	***********************************/

	elsif(p_transaccion='SIGEFO_SCU_MOD')then

		begin
			--Sentencia de la modificacion
			update sigefo.tcurso set
			id_gestion = v_parametros.id_gestion,
			id_lugar = v_parametros.id_lugar,
			id_proveedor = v_parametros.id_proveedor,
			origen = v_parametros.origen,
			fecha_inicio = v_parametros.fecha_inicio,
			objetivo = v_parametros.objetivo,
			cod_tipo = v_parametros.cod_tipo,
			horas = v_parametros.horas,
			nombre_curso = v_parametros.nombre_curso,
			cod_clasificacion = v_parametros.cod_clasificacion,
			expositor = v_parametros.expositor,
			contenido = v_parametros.contenido,
			fecha_fin = v_parametros.fecha_fin,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_curso=v_parametros.id_curso;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cursos modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_curso',v_parametros.id_curso::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SIGEFO_SCU_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		22-01-2017 15:35:03
	***********************************/

	elsif(p_transaccion='SIGEFO_SCU_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from sigefo.tcurso
            where id_curso=v_parametros.id_curso;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Cursos eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_curso',v_parametros.id_curso::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

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