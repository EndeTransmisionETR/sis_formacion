<?php
/**
*@package pXP
*@file gen-ACTCurso.php
*@author  (admin)
*@date 22-01-2017 15:35:03
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTCurso extends ACTbase{    
			
	function listarCurso(){
		$this->objParam->defecto('ordenacion','id_curso');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODCurso','listarCurso');
		} else{
			$this->objFunc=$this->create('MODCurso');
			
			$this->res=$this->objFunc->listarCurso($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarCurso(){
		$this->objFunc=$this->create('MODCurso');	
		if($this->objParam->insertar('id_curso')){
			$this->res=$this->objFunc->insertarCurso($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarCurso($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarCurso(){
			$this->objFunc=$this->create('MODCurso');	
		$this->res=$this->objFunc->eliminarCurso($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>