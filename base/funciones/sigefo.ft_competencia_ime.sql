CREATE OR REPLACE FUNCTION "sigefo"."ft_competencia_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Sistema de gestión de la formación
 FUNCION: 		sigefo.ft_competencia_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'sigefo.tcompetencia'
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

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_competencia	integer;
			    
BEGIN

    v_nombre_funcion = 'sigefo.ft_competencia_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SIGEFO_SIGEFOCO_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		04-05-2017 19:30:13
	***********************************/

	if(p_transaccion='SIGEFO_SIGEFOCO_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into sigefo.tcompetencia(
			tipo,
			estado_reg,
			competencia,
			id_usuario_ai,
			id_usuario_reg,
			fecha_reg,
			usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.tipo,
			'activo',
			v_parametros.competencia,
			v_parametros._id_usuario_ai,
			p_id_usuario,
			now(),
			v_parametros._nombre_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_competencia into v_id_competencia;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Competencias almacenado(a) con exito (id_competencia'||v_id_competencia||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_competencia',v_id_competencia::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SIGEFO_SIGEFOCO_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		04-05-2017 19:30:13
	***********************************/

	elsif(p_transaccion='SIGEFO_SIGEFOCO_MOD')then

		begin
			--Sentencia de la modificacion
			update sigefo.tcompetencia set
			tipo = v_parametros.tipo,
			competencia = v_parametros.competencia,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_competencia=v_parametros.id_competencia;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Competencias modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_competencia',v_parametros.id_competencia::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SIGEFO_SIGEFOCO_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		04-05-2017 19:30:13
	***********************************/

	elsif(p_transaccion='SIGEFO_SIGEFOCO_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from sigefo.tcompetencia
            where id_competencia=v_parametros.id_competencia;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Competencias eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_competencia',v_parametros.id_competencia::varchar);
              
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
ALTER FUNCTION "sigefo"."ft_competencia_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
