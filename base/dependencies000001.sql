/***********************************I-DEP-YAC-SIGEFO-0-02/05/2017*****************************************/

select pxp.f_insert_testructura_gui ('SIGEFO', 'SISTEMA');

ALTER TABLE sigefo.tplanificacion
  ADD CONSTRAINT tplanificacion_fk FOREIGN KEY (id_gestion)
    REFERENCES param.tgestion(id_gestion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;


ALTER TABLE sigefo.tplanificacion_critico
  ADD CONSTRAINT tplanificacion_critico_fk FOREIGN KEY (id_planificacion)
REFERENCES sigefo.tplanificacion(id_planificacion)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
    
/***********************************F-DEP-YAC-SIGEFO-0-02/05/2017*****************************************/
