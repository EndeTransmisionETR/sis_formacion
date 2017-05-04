/***********************************I-DEP-YAC-SIGEFO-0-02/05/2017*****************************************/

select pxp.f_insert_testructura_gui ('SIGEFO', 'SISTEMA');

ALTER TABLE sigefo.tplanificacion
  ADD CONSTRAINT tplanificacion_fk FOREIGN KEY (id_gestion)
    REFERENCES param.tgestion(id_gestion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
/***********************************F-DEP-YAC-SIGEFO-0-02/05/2017*****************************************/
/***********************************I-DEP-YAC-SIGEFO-0-04/05/2017*****************************************/


ALTER TABLE sigefo.tplanificacion_critico
  ADD CONSTRAINT tplanificacion_critico_fk FOREIGN KEY (id_planificacion)
REFERENCES sigefo.tplanificacion(id_planificacion)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


ALTER TABLE sigefo.tcargo_competencia
  ADD CONSTRAINT tcargo_competencia_fk FOREIGN KEY (id_cargo)
REFERENCES orga.tcargo(id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


ALTER TABLE sigefo.tcargo_competencia
  ADD CONSTRAINT tcargo_competencia_fk1 FOREIGN KEY (id_competencia)
REFERENCES sigefo.tcompetencia(id_competencia)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


ALTER TABLE sigefo.tplanificacion_competencia
  ADD CONSTRAINT tplanificacion_competencia_fk FOREIGN KEY (id_planificacion)
REFERENCES sigefo.tplanificacion(id_planificacion)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


ALTER TABLE sigefo.tplanificacion_competencia
  ADD CONSTRAINT tplanificacion_competencia_fk1 FOREIGN KEY (id_competencia)
REFERENCES sigefo.tcompetencia(id_competencia)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


ALTER TABLE sigefo.tplanificacion_cargo
  ADD CONSTRAINT tplanificacion_cargo_fk FOREIGN KEY (id_planificacion)
REFERENCES sigefo.tplanificacion(id_planificacion)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


ALTER TABLE sigefo.tplanificacion_cargo
  ADD CONSTRAINT tplanificacion_cargo_fk1 FOREIGN KEY (id_cargo)
REFERENCES orga.tcargo(id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

/***********************************F-DEP-YAC-SIGEFO-0-04/05/2017*****************************************/
