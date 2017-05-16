--------------- SQL ---------------

CREATE OR REPLACE FUNCTION sigefo.ft_curso_ime(
  p_administrador INTEGER,
  p_id_usuario    INTEGER,
  p_tabla         VARCHAR,
  p_transaccion   VARCHAR
)
  RETURNS VARCHAR AS
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

  v_nro_requerimiento   INTEGER;
  v_parametros          RECORD;
  v_id_requerimiento    INTEGER;
  v_resp                VARCHAR;
  v_nombre_funcion      TEXT;
  v_mensaje_error       TEXT;
  v_id_curso            INTEGER;

  --variables externas
  va_id_competencias    VARCHAR [];
  v_id_competencia      INTEGER;
  va_id_funcionarios    VARCHAR [];
  v_id_funcionario      INTEGER;
  va_id_planificaciones VARCHAR [];
  v_id_planificacion    INTEGER;


BEGIN

  v_nombre_funcion = 'sigefo.ft_curso_ime';
  v_parametros = pxp.f_get_record(p_tabla);

  /*********************************
   #TRANSACCION:  'SIGEFO_SCU_INS'
   #DESCRIPCION:	Insercion de registros
   #AUTOR:		admin
   #FECHA:		22-01-2017 15:35:03
  ***********************************/

  IF (p_transaccion = 'SIGEFO_SCU_INS')
  THEN

    BEGIN
      --Sentencia de la insercion
      INSERT INTO sigefo.tcurso (
        id_gestion,
        id_lugar,
        id_lugar_pais,
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
      ) VALUES (
        v_parametros.id_gestion,
        v_parametros.id_lugar,
        v_parametros.id_lugar_pais,
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
        NULL,
        NULL
      )
      RETURNING id_curso
        INTO v_id_curso;

      --Insertar curso competencia
      va_id_competencias := string_to_array(v_parametros.id_competencias, ',');

      FOREACH v_id_competencia IN ARRAY va_id_competencias
      LOOP
        INSERT INTO sigefo.tcurso_competencia (
          id_usuario_reg,
          fecha_reg,
          estado_reg,
          id_usuario_ai,
          id_curso,
          id_competencia
        )
        VALUES (
          p_id_usuario,
          now(),
          'activo',
          v_parametros._id_usuario_ai,
          v_id_curso,
          v_id_competencia :: INTEGER
        );

      END LOOP;
      -- Insertar curso funcionario
      va_id_funcionarios := string_to_array(v_parametros.id_funcionarios, ',');

      FOREACH v_id_funcionario IN ARRAY va_id_funcionarios
      LOOP
        INSERT INTO sigefo.tcurso_funcionario (
          id_curso,
          id_funcionario,
          estado_reg,
          fecha_reg,
          usuario_ai,
          id_usuario_reg,
          id_usuario_ai,
          fecha_mod,
          id_usuario_mod
        ) VALUES (
          v_id_curso,
          v_id_funcionario :: INTEGER,
          'activo',
          now(),
          v_parametros._nombre_usuario_ai,
          p_id_usuario,
          v_parametros._id_usuario_ai,
          NULL,
          NULL
        );
      END LOOP;
      -- Insertar curso planificacion
      va_id_planificaciones := string_to_array(v_parametros.id_planificaciones, ',');
      FOREACH v_id_planificacion IN ARRAY va_id_planificaciones
      LOOP
        --Sentencia de la insercion
        INSERT INTO sigefo.tcurso_planificacion (
          id_curso,
          id_planificacion,
          estado_reg,
          id_usuario_ai,
          id_usuario_reg,
          usuario_ai,
          fecha_reg,
          id_usuario_mod,
          fecha_mod
        ) VALUES (
          v_id_curso,
          v_id_planificacion :: INTEGER,
          'activo',
          v_parametros._id_usuario_ai,
          p_id_usuario,
          v_parametros._nombre_usuario_ai,
          now(),
          NULL,
          NULL
        );
      END LOOP;

      --Definicion de la respuesta
      v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', 'Cursos almacenado(a) con exito (id_curso' || v_id_curso || ')');
      v_resp = pxp.f_agrega_clave(v_resp, 'id_curso', v_id_curso :: VARCHAR);

      --Devuelve la respuesta
      RETURN v_resp;

    END;

    /*********************************
     #TRANSACCION:  'SIGEFO_SCU_MOD'
     #DESCRIPCION:	Modificacion de registros
     #AUTOR:		admin
     #FECHA:		22-01-2017 15:35:03
    ***********************************/

  ELSIF (p_transaccion = 'SIGEFO_SCU_MOD')
    THEN

      BEGIN
        --Sentencia de la modificacion
        UPDATE sigefo.tcurso
        SET
          id_gestion        = v_parametros.id_gestion,
          id_lugar          = v_parametros.id_lugar,
          id_lugar_pais     = v_parametros.id_lugar_pais,
          id_proveedor      = v_parametros.id_proveedor,
          origen            = v_parametros.origen,
          fecha_inicio      = v_parametros.fecha_inicio,
          objetivo          = v_parametros.objetivo,
          cod_tipo          = v_parametros.cod_tipo,
          horas             = v_parametros.horas,
          nombre_curso      = v_parametros.nombre_curso,
          cod_clasificacion = v_parametros.cod_clasificacion,
          expositor         = v_parametros.expositor,
          contenido         = v_parametros.contenido,
          fecha_fin         = v_parametros.fecha_fin,
          id_usuario_mod    = p_id_usuario,
          fecha_mod         = now(),
          id_usuario_ai     = v_parametros._id_usuario_ai,
          usuario_ai        = v_parametros._nombre_usuario_ai
        WHERE id_curso = v_parametros.id_curso;

        --Editar curso competencia
        DELETE FROM sigefo.tcurso_competencia cc
        WHERE cc.id_curso = v_parametros.id_curso;
        va_id_competencias := string_to_array(v_parametros.id_competencias, ',');
        FOREACH v_id_competencia IN ARRAY va_id_competencias
        LOOP
          INSERT INTO sigefo.tcurso_competencia (
            id_usuario_reg,
            fecha_reg,
            estado_reg,
            id_usuario_ai,
            id_curso,
            id_competencia
          )
          VALUES (
            p_id_usuario,
            now(),
            'activo',
            v_parametros._id_usuario_ai,
            v_parametros.id_curso,
            v_id_competencia :: INTEGER
          );

        END LOOP;
        -- Editar curso funcionario
        DELETE FROM sigefo.tcurso_funcionario cf
        WHERE cf.id_curso = v_parametros.id_curso;
        va_id_funcionarios := string_to_array(v_parametros.id_funcionarios, ',');
        FOREACH v_id_funcionario IN ARRAY va_id_funcionarios
        LOOP
          INSERT INTO sigefo.tcurso_funcionario (
            id_curso,
            id_funcionario,
            estado_reg,
            fecha_reg,
            usuario_ai,
            id_usuario_reg,
            id_usuario_ai,
            fecha_mod,
            id_usuario_mod
          ) VALUES (
            v_parametros.id_curso,
            v_id_funcionario :: INTEGER,
            'activo',
            now(),
            v_parametros._nombre_usuario_ai,
            p_id_usuario,
            v_parametros._id_usuario_ai,
            NULL,
            NULL
          );
        END LOOP;
        -- Editar curso planificacion
        DELETE FROM sigefo.tcurso_planificacion cp
        WHERE cp.id_curso = v_parametros.id_curso;
        va_id_planificaciones := string_to_array(v_parametros.id_planificaciones, ',');
        FOREACH v_id_planificacion IN ARRAY va_id_planificaciones
        LOOP
          INSERT INTO sigefo.tcurso_planificacion (
            id_curso,
            id_planificacion,
            estado_reg,
            id_usuario_ai,
            id_usuario_reg,
            usuario_ai,
            fecha_reg,
            id_usuario_mod,
            fecha_mod
          ) VALUES (
            v_parametros.id_curso,
            v_id_planificacion :: INTEGER,
            'activo',
            v_parametros._id_usuario_ai,
            p_id_usuario,
            v_parametros._nombre_usuario_ai,
            now(),
            NULL,
            NULL
          );
        END LOOP;

        --Definicion de la respuesta
        v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', 'Cursos modificado(a)');
        v_resp = pxp.f_agrega_clave(v_resp, 'id_curso', v_parametros.id_curso :: VARCHAR);

        --Devuelve la respuesta
        RETURN v_resp;

      END;

      /*********************************
       #TRANSACCION:  'SIGEFO_SCU_ELI'
       #DESCRIPCION:	Eliminacion de registros
       #AUTOR:		admin
       #FECHA:		22-01-2017 15:35:03
      ***********************************/

  ELSIF (p_transaccion = 'SIGEFO_SCU_ELI')
    THEN

      BEGIN
        --Sentencia de la eliminacion
        DELETE FROM sigefo.tcurso
        WHERE id_curso = v_parametros.id_curso;

        --Definicion de la respuesta
        v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', 'Cursos eliminado(a)');
        v_resp = pxp.f_agrega_clave(v_resp, 'id_curso', v_parametros.id_curso :: VARCHAR);

        --Devuelve la respuesta
        RETURN v_resp;

      END;

  ELSE

    RAISE EXCEPTION 'Transaccion inexistente: %', p_transaccion;

  END IF;

  EXCEPTION

  WHEN OTHERS
    THEN
      v_resp = '';
      v_resp = pxp.f_agrega_clave(v_resp, 'mensaje', SQLERRM);
      v_resp = pxp.f_agrega_clave(v_resp, 'codigo_error', SQLSTATE);
      v_resp = pxp.f_agrega_clave(v_resp, 'procedimientos', v_nombre_funcion);
      RAISE EXCEPTION '%', v_resp;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;