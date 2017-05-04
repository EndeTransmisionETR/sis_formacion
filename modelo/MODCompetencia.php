<?php
/**
*@package pXP
*@file gen-MODCompetencia.php
*@author  (admin)
*@date 04-05-2017 19:30:13
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODCompetencia extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarCompetencia(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='sigefo.ft_competencia_sel';
		$this->transaccion='SIGEFO_SIGEFOCO_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_competencia','int4');
		$this->captura('tipo','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('competencia','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarCompetencia(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sigefo.ft_competencia_ime';
		$this->transaccion='SIGEFO_SIGEFOCO_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('competencia','competencia','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarCompetencia(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sigefo.ft_competencia_ime';
		$this->transaccion='SIGEFO_SIGEFOCO_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_competencia','id_competencia','int4');
		$this->setParametro('tipo','tipo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('competencia','competencia','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarCompetencia(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sigefo.ft_competencia_ime';
		$this->transaccion='SIGEFO_SIGEFOCO_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_competencia','id_competencia','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>