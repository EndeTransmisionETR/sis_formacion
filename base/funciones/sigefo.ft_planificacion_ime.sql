CREATE OR REPLACE FUNCTION "sigefo"."ft_planificacion_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Sistema de gestión de la formación
 FUNCION: 		sigefo.ft_planificacion_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'sigefo.tplanificacion'
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

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_planificacion	integer;
			    
BEGIN

    v_nombre_funcion = 'sigefo.ft_planificacion_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SIGEFO_SIGEFOP_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		26-04-2017 20:37:24
	***********************************/

	if(p_transaccion='SIGEFO_SIGEFOP_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into sigefo.tplanificacion(
			id_gestion,
			estado_reg,
			cantidad_personas,
			contenido_basico,
			nombre_planificacion,
			necesidad,
			horas_previstas,
			fecha_reg,
			usuario_ai,
			id_usuario_reg,
			id_usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.id_gestion,
			'activo',
			v_parametros.cantidad_personas,
			v_parametros.contenido_basico,
			v_parametros.nombre_planificacion,
			v_parametros.necesidad,
			v_parametros.horas_previstas,
			now(),
			v_parametros._nombre_usuario_ai,
			p_id_usuario,
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_planificacion into v_id_planificacion;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Planificación almacenado(a) con exito (id_planificacion'||v_id_planificacion||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_planificacion',v_id_planificacion::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SIGEFO_SIGEFOP_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		26-04-2017 20:37:24
	***********************************/

	elsif(p_transaccion='SIGEFO_SIGEFOP_MOD')then

		begin
			--Sentencia de la modificacion
			update sigefo.tplanificacion set
			id_gestion = v_parametros.id_gestion,
			cantidad_personas = v_parametros.cantidad_personas,
			contenido_basico = v_parametros.contenido_basico,
			nombre_planificacion = v_parametros.nombre_planificacion,
			necesidad = v_parametros.necesidad,
			horas_previstas = v_parametros.horas_previstas,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_planificacion=v_parametros.id_planificacion;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Planificación modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_planificacion',v_parametros.id_planificacion::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SIGEFO_SIGEFOP_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		26-04-2017 20:37:24
	***********************************/

	elsif(p_transaccion='SIGEFO_SIGEFOP_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from sigefo.tplanificacion
            where id_planificacion=v_parametros.id_planificacion;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Planificación eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_planificacion',v_parametros.id_planificacion::varchar);
              
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
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "sigefo"."ft_planificacion_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
