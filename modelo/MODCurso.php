<?php
/**
*@package pXP
*@file gen-MODCurso.php
*@author  (admin)
*@date 22-01-2017 15:35:03
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODCurso extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarCurso(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='sigefo.ft_curso_sel';
		$this->transaccion='SIGEFO_SCU_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_curso','int4');
		$this->captura('id_gestion','int4');
		$this->captura('id_lugar','int4');
		$this->captura('id_proveedor','int4');
		$this->captura('origen','varchar');
		$this->captura('fecha_inicio','date');
		$this->captura('objetivo','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('cod_tipo','varchar');
		$this->captura('horas','int4');
		$this->captura('nombre_curso','varchar');
		$this->captura('cod_clasificacion','varchar');
		$this->captura('expositor','varchar');
		$this->captura('contenido','varchar');
		$this->captura('fecha_fin','date');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		$this->captura('gestion','int4');
		$this->captura('nombre','varchar');
		$this->captura('rotulo_comercial','varchar');
		
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarCurso(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sigefo.ft_curso_ime';
		$this->transaccion='SIGEFO_SCU_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_gestion','id_gestion','int4');
		$this->setParametro('id_lugar','id_lugar','int4');
		$this->setParametro('id_proveedor','id_proveedor','int4');
		$this->setParametro('origen','origen','varchar');
		$this->setParametro('fecha_inicio','fecha_inicio','date');
		$this->setParametro('objetivo','objetivo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('cod_tipo','cod_tipo','varchar');
		$this->setParametro('horas','horas','int4');
		$this->setParametro('nombre_curso','nombre_curso','varchar');
		$this->setParametro('cod_clasificacion','cod_clasificacion','varchar');
		$this->setParametro('expositor','expositor','varchar');
		$this->setParametro('contenido','contenido','varchar');
		$this->setParametro('fecha_fin','fecha_fin','date');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarCurso(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sigefo.ft_curso_ime';
		$this->transaccion='SIGEFO_SCU_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_curso','id_curso','int4');
		$this->setParametro('id_gestion','id_gestion','int4');
		$this->setParametro('id_lugar','id_lugar','int4');
		$this->setParametro('id_proveedor','id_proveedor','int4');
		$this->setParametro('origen','origen','varchar');
		$this->setParametro('fecha_inicio','fecha_inicio','date');
		$this->setParametro('objetivo','objetivo','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('cod_tipo','cod_tipo','varchar');
		$this->setParametro('horas','horas','int4');
		$this->setParametro('nombre_curso','nombre_curso','varchar');
		$this->setParametro('cod_clasificacion','cod_clasificacion','varchar');
		$this->setParametro('expositor','expositor','varchar');
		$this->setParametro('contenido','contenido','varchar');
		$this->setParametro('fecha_fin','fecha_fin','date');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarCurso(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='sigefo.ft_curso_ime';
		$this->transaccion='SIGEFO_SCU_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_curso','id_curso','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>