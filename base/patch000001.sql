/***********************************I-SCP-YAC-SIGEFO-0-02/05/2017****************************************/

CREATE TABLE sigefo.tplanificacion (
  id_planificacion SERIAL NOT NULL,
  id_gestion INTEGER,
  nombre_planificacion VARCHAR(150),
  contenido_basico TEXT,
  necesidad TEXT,
  cantidad_personas INTEGER,
  horas_previstas INTEGER,
  PRIMARY KEY(id_planificacion)
) INHERITS (pxp.tbase)

WITH (oids = false)
TABLESPACE pg_default;


CREATE TABLE sigefo.tplanificacion_critico (
  id_planificacion INTEGER,
  cod_criterio VARCHAR(10)
) INHERITS (pxp.tbase)

WITH (oids = false);

/***********************************F-SCP-YAC-SIGEFO-0-02/05/2017****************************************/
