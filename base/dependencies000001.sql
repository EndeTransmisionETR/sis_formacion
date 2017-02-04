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
/***********************************I-DEP-YAC-SIGEFO-0-05/05/2017*****************************************/

select pxp.f_insert_testructura_gui ('SIGEFOP', 'SIGEFO');
select pxp.f_insert_testructura_gui ('SIGEFOCO', 'SIGEFO');

/***********************************F-DEP-YAC-SIGEFO-0-05/05/2017*****************************************/



/***********************************I-DEP-JUAN-SIGEFO-0-05/05/2017*****************************************/

ALTER TABLE sigefo.tcurso
  ADD CONSTRAINT tcurso_fk FOREIGN KEY (id_gestion)
    REFERENCES param.tgestion(id_gestion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    

ALTER TABLE sigefo.tcurso
  ADD CONSTRAINT tcurso_fk1 FOREIGN KEY (id_lugar)
    REFERENCES param.tlugar(id_lugar)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    

ALTER TABLE sigefo.tcurso
  ADD CONSTRAINT tcurso_fk2 FOREIGN KEY (id_proveedor)
    REFERENCES param.tproveedor(id_proveedor)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    


ALTER TABLE sigefo.tcurso_competencia
  ADD CONSTRAINT tcurso_competencia_fk FOREIGN KEY (id_curso)
    REFERENCES sigefo.tcurso(id_curso)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    

ALTER TABLE sigefo.tcurso_competencia
  ADD CONSTRAINT tcurso_competencia_fk1 FOREIGN KEY (id_competencia)
    REFERENCES sigefo.tcompetencia(id_competencia)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE; 
    

ALTER TABLE sigefo.tcurso_planificacion
  ADD CONSTRAINT tcurso_planificacion_fk FOREIGN KEY (id_curso)
    REFERENCES sigefo.tcurso(id_curso)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    

ALTER TABLE sigefo.tcurso_planificacion
  ADD CONSTRAINT tcurso_planificacion_fk1 FOREIGN KEY (id_planificacion)
    REFERENCES sigefo.tplanificacion(id_planificacion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;    
/***********************************F-DEP-JUAN-SIGEFO-0-05/05/2017*****************************************/

/***********************************I-DEP-YAC-SIGEFO-1-05/05/2017*****************************************/

ALTER TABLE sigefo.tplanificacion_proveedor
  ADD CONSTRAINT tplanificacion_proveedor_fk FOREIGN KEY (id_planificacion)
REFERENCES sigefo.tplanificacion(id_planificacion)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
/***********************************F-DEP-YAC-SIGEFO-1-05/05/2017*****************************************/

/***********************************I-DEP-JUAN-SIGEFO-0-08/05/2017*****************************************/


ALTER TABLE sigefo.tcurso_funcionario
  ADD CONSTRAINT tcurso_funcionario_fk FOREIGN KEY (id_curso)
    REFERENCES sigefo.tcurso(id_curso)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE sigefo.tcurso_funcionario
  ADD CONSTRAINT tcurso_funcionario_fk1 FOREIGN KEY (id_funcionario)
    REFERENCES orga.tfuncionario(id_funcionario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
select pxp.f_insert_testructura_gui ('SIGEFOCU', 'SIGEFO');
select pxp.f_delete_testructura_gui ('CUPL', 'SIGEFOCU');
select pxp.f_insert_testructura_gui ('CUPL', 'SIGEFO');
select pxp.f_delete_testructura_gui ('CUFU', 'CUPL');
select pxp.f_insert_testructura_gui ('CUFU', 'SIGEFO');

/***********************************F-DEP-JUAN-SIGEFO-0-08/05/2017*****************************************/

/***********************************I-DEP-JUAN-SIGEFO-0-09/05/2017*****************************************/
ALTER TABLE sigefo.tcurso_competencia
  DROP CONSTRAINT tcurso_competencia_fk RESTRICT;

ALTER TABLE sigefo.tcurso_competencia
  ADD CONSTRAINT tcurso_competencia_fk FOREIGN KEY (id_curso)
    REFERENCES sigefo.tcurso(id_curso)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    

ALTER TABLE sigefo.tcurso_planificacion
  DROP CONSTRAINT tcurso_planificacion_fk RESTRICT;

ALTER TABLE sigefo.tcurso_planificacion
  ADD CONSTRAINT tcurso_planificacion_fk FOREIGN KEY (id_curso)
    REFERENCES sigefo.tcurso(id_curso)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
    NOT DEFERRABLE;


ALTER TABLE sigefo.tcurso_funcionario
  DROP CONSTRAINT tcurso_funcionario_fk RESTRICT;

ALTER TABLE sigefo.tcurso_funcionario
  ADD CONSTRAINT tcurso_funcionario_fk FOREIGN KEY (id_curso)
    REFERENCES sigefo.tcurso(id_curso)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    

ALTER TABLE sigefo.tplanificacion_criterio
  DROP CONSTRAINT tplanificacion_critico_fk RESTRICT;

ALTER TABLE sigefo.tplanificacion_criterio
  ADD CONSTRAINT tplanificacion_critico_fk FOREIGN KEY (id_planificacion)
    REFERENCES sigefo.tplanificacion(id_planificacion)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    

ALTER TABLE sigefo.tplanificacion_competencia
  DROP CONSTRAINT tplanificacion_competencia_fk RESTRICT;

ALTER TABLE sigefo.tplanificacion_competencia
  ADD CONSTRAINT tplanificacion_competencia_fk FOREIGN KEY (id_planificacion)
    REFERENCES sigefo.tplanificacion(id_planificacion)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    

ALTER TABLE sigefo.tplanificacion_cargo
  DROP CONSTRAINT tplanificacion_cargo_fk RESTRICT;

ALTER TABLE sigefo.tplanificacion_cargo
  ADD CONSTRAINT tplanificacion_cargo_fk FOREIGN KEY (id_planificacion)
    REFERENCES sigefo.tplanificacion(id_planificacion)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    

ALTER TABLE sigefo.tplanificacion_proveedor
  DROP CONSTRAINT tplanificacion_proveedor_fk RESTRICT;

ALTER TABLE sigefo.tplanificacion_proveedor
  ADD CONSTRAINT tplanificacion_proveedor_fk FOREIGN KEY (id_planificacion)
    REFERENCES sigefo.tplanificacion(id_planificacion)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

/***********************************F-DEP-JUAN-SIGEFO-0-09/05/2017*****************************************/

/***********************************I-DEP-YAC-SIGEFO-1-09/05/2017*****************************************/
select pxp.f_insert_testructura_gui ('CUR', 'SIGEFO');
/***********************************F-DEP-YAC-SIGEFO-1-09/05/2017*****************************************/

/***********************************I-DEP-YAC-SIGEFO-0-10/05/2017*****************************************/

ALTER TABLE sigefo.tplanificacion_uo
  ADD CONSTRAINT tplanificacion_uo_fk FOREIGN KEY (id_planificacion)
REFERENCES sigefo.tplanificacion(id_planificacion)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


ALTER TABLE sigefo.tplanificacion_uo
  ADD CONSTRAINT tplanificacion_uo_fk1 FOREIGN KEY (id_uo)
REFERENCES orga.tuo(id_uo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
/***********************************F-DEP-YAC-SIGEFO-0-10/05/2017*****************************************/

/***********************************I-DEP-JUAN-SIGEFO-0-16/05/2017*****************************************/
select pxp.f_insert_testructura_gui ('CACO', 'SIGEFO');
/***********************************F-DEP-JUAN-SIGEFO-0-16/05/2017*****************************************/
