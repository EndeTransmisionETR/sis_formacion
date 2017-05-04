<?php
/**
*@package pXP
*@file gen-ACTCompetencia.php
*@author  (admin)
*@date 04-05-2017 19:30:13
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTCompetencia extends ACTbase{    
			
	function listarCompetencia(){
		$this->objParam->defecto('ordenacion','id_competencia');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODCompetencia','listarCompetencia');
		} else{
			$this->objFunc=$this->create('MODCompetencia');
			
			$this->res=$this->objFunc->listarCompetencia($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarCompetencia(){
		$this->objFunc=$this->create('MODCompetencia');	
		if($this->objParam->insertar('id_competencia')){
			$this->res=$this->objFunc->insertarCompetencia($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarCompetencia($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarCompetencia(){
			$this->objFunc=$this->create('MODCompetencia');	
		$this->res=$this->objFunc->eliminarCompetencia($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>