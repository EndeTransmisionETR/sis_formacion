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

/***********************************F-SCP-YAC-SIGEFO-0-02/05/2017****************************************/
/***********************************I-SCP-YAC-SIGEFO-0-04/05/2017****************************************/

CREATE TABLE sigefo.tplanificacion_critico (
  id_planificacion INTEGER,
  cod_criterio VARCHAR(10)
) INHERITS (pxp.tbase)

WITH (oids = false);


CREATE TABLE sigefo.tcompetencia (
  id_competencia SERIAL NOT NULL,
  competencia VARCHAR(200),
  tipo VARCHAR(15),
  PRIMARY KEY(id_competencia)
) INHERITS (pxp.tbase)

WITH (oids = false);


CREATE TABLE sigefo.tcargo_competencia (
  id_cargo INTEGER,
  id_competencia INTEGER
) INHERITS (pxp.tbase)

WITH (oids = false);


CREATE TABLE sigefo.tplanificacion_competencia (
  id_planificacion INTEGER,
  id_competencia INTEGER
) INHERITS (pxp.tbase)

WITH (oids = false);


CREATE TABLE sigefo.tplanificacion_cargo (
  id_planificacion INTEGER,
  id_cargo INTEGER
) INHERITS (pxp.tbase)

WITH (oids = false);

/***********************************F-SCP-YAC-SIGEFO-0-04/05/2017****************************************/
/***********************************I-SCP-YAC-SIGEFO-0-05/05/2017****************************************/

CREATE TABLE sigefo.tplanificacion_proveedor (
  id_planificacion INTEGER,
  id_proveedor INTEGER
) INHERITS (pxp.tbase)

WITH (oids = false);

/***********************************F-SCP-YAC-SIGEFO-0-05/05/2017****************************************/
