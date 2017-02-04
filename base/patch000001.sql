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


/***********************************I-SCP-JUAN-SIGEFO-0-05/05/2017****************************************/

CREATE TABLE sigefo.tcurso (
  id_curso SERIAL NOT NULL,
  id_gestion INTEGER,
  nombre_curso VARCHAR(50),
  cod_tipo VARCHAR(50),
  cod_clasificacion VARCHAR(50),
  objetivo VARCHAR(1000),
  contenido VARCHAR(1000),
  fecha_inicio DATE,
  fecha_fin DATE,
  horas INTEGER,
  id_lugar INTEGER,
  origen VARCHAR(50),
  expositor VARCHAR(50),
  id_proveedor INTEGER,
  PRIMARY KEY(id_curso)
) INHERITS (pxp.tbase)

WITH (oids = false);


CREATE TABLE sigefo.tcurso_competencia (
  id_curso_competencia SERIAL NOT NULL,
  id_curso INTEGER,
  id_competencia INTEGER,
  PRIMARY KEY(id_curso_competencia)
) INHERITS (pxp.tbase)

WITH (oids = false);


CREATE TABLE sigefo.tcurso_planificacion (
  id_curso_planificacion SERIAL NOT NULL,
  id_curso INTEGER,
  id_planificacion INTEGER,
  PRIMARY KEY(id_curso_planificacion)
) INHERITS (pxp.tbase)

WITH (oids = false);
/***********************************F-SCP-JUAN-SIGEFO-0-05/05/2017****************************************/

/***********************************I-SCP-YAC-SIGEFO-0-05/05/2017****************************************/

CREATE TABLE sigefo.tplanificacion_proveedor (
  id_planificacion INTEGER,
  id_proveedor INTEGER
) INHERITS (pxp.tbase)

WITH (oids = false);

/***********************************F-SCP-YAC-SIGEFO-0-05/05/2017****************************************/

/***********************************I-SCP-JUAN-SIGEFO-0-08/05/2017****************************************/

CREATE TABLE sigefo.tcurso_funcionario (
  id_curso_funcionario SERIAL NOT NULL,
  id_curso INTEGER,
  id_funcionario INTEGER,
  PRIMARY KEY(id_curso_funcionario)
  ) INHERITS (pxp.tbase)

WITH (oids = false);
  
/***********************************F-SCP-JUAN-SIGEFO-0-08/05/2017****************************************/

/***********************************I-SCP-YAC-SIGEFO-0-08/05/2017****************************************/

ALTER TABLE sigefo.tplanificacion_critico
  RENAME TO tplanificacion_criterio;

/***********************************F-SCP-YAC-SIGEFO-0-08/05/2017****************************************/
/***********************************I-SCP-YAC-SIGEFO-0-10/05/2017****************************************/

CREATE TABLE sigefo.tplanificacion_uo (
  id_planificacion INTEGER,
  id_uo INTEGER
) INHERITS (pxp.tbase)

WITH (oids = false);
/***********************************F-SCP-YAC-SIGEFO-0-10/05/2017****************************************/

/***********************************I-SCP-YAC-SIGEFO-0-15/05/2017****************************************/
ALTER TABLE sigefo.tcurso
  ADD COLUMN id_lugar_pais INTEGER;
/***********************************F-SCP-YAC-SIGEFO-0-15/05/2017****************************************/
