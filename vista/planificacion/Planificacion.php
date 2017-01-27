<?php
/**
 * @package pXP
 * @file gen-Planificacion.php
 * @author  (admin)
 * @date 26-04-2017 20:37:24
 * @description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.Planificacion = Ext.extend(Phx.gridInterfaz, {

            constructor: function (config) {
                this.maestro = config.maestro;
                //llama al constructor de la clase padre
                Phx.vista.Planificacion.superclass.constructor.call(this, config);
                this.init();
                this.load({params: {start: 0, limit: this.tam_pag}})
            },

            Atributos: [
                {
                    //configuracion del componente
                    config: {
                        labelSeparator: '',
                        inputType: 'hidden',
                        name: 'id_planificacion'
                    },
                    type: 'Field',
                    form: true
                },
                {
                    config: {
                        name: 'id_gestion',
                        fieldLabel: 'Gestion',
                        allowBlank: false,
                        emptyText: 'Gestion...',
                        blankText: 'Año',
                        store: new Ext.data.JsonStore({
                            url: '../../sis_parametros/control/Gestion/listarGestion',
                            id: 'id_gestion',
                            root: 'datos',
                            sortInfo: {
                                field: 'gestion',
                                direction: 'DESC'
                            },
                            totalProperty: 'total',
                            fields: ['id_gestion', 'gestion'],
                            remoteSort: true,
                            baseParams: {par_filtro: 'gestion'}
                        }),
                        valueField: 'id_gestion',
                        displayField: 'gestion',
                        gdisplayField: 'gestion',
                        hiddenName: 'id_gestion',
                        forceSelection: true,
                        typeAhead: false,
                        triggerAction: 'all',
                        lazyRender: true,
                        mode: 'remote',
                        pageSize: 15,
                        queryDelay: 1000,
                        anchor: '60%',
                        gwidth: 150,
                        minChars: 2,
                        renderer: function (value, p, record) {
                            return String.format('{0}', record.data['gestion']);
                        }
                    },
                    type: 'ComboBox',
                    id_grupo: 0,
                    filters: {pfiltro: 'movtip.nombre', type: 'string'},
                    grid: true,
                    form: true
                },
                {
                    config: {
                        name: 'nombre_planificacion',
                        fieldLabel: 'Nombre planificación',
                        allowBlank: false,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 150
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'sigefop.nombre_planificacion', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                },
                {
                    config: {
                        name: 'contenido_basico',
                        fieldLabel: 'Contenido basico',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 5000
                    },
                    type: 'TextArea',
                    filters: {pfiltro: 'sigefop.contenido_basico', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                },
                {
                    config: {
                        name: 'necesidad',
                        fieldLabel: 'Necesidad',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 5000
                    },
                    type: 'TextArea',
                    filters: {pfiltro: 'sigefop.necesidad', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                },
                {
                    config: {
                        name: 'cantidad_personas',
                        fieldLabel: 'Cantidad personas',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 4
                    },
                    type: 'NumberField',
                    filters: {pfiltro: 'sigefop.cantidad_personas', type: 'numeric'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                },
                {
                    config: {
                        name: 'horas_previstas',
                        fieldLabel: 'Horas previstas',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 4
                    },
                    type: 'NumberField',
                    filters: {pfiltro: 'sigefop.horas_previstas', type: 'numeric'},
                    id_grupo: 1,
                    grid: true,
                    form: true
                },

                {
                    config: {
                        name: 'estado_reg',
                        fieldLabel: 'Estado Reg.',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 10
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'sigefop.estado_reg', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },

                {
                    config: {
                        name: 'fecha_reg',
                        fieldLabel: 'Fecha creación',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        format: 'd/m/Y',
                        renderer: function (value, p, record) {
                            return value ? value.dateFormat('d/m/Y H:i:s') : ''
                        }
                    },
                    type: 'DateField',
                    filters: {pfiltro: 'sigefop.fecha_reg', type: 'date'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'usuario_ai',
                        fieldLabel: 'Funcionaro AI',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 300
                    },
                    type: 'TextField',
                    filters: {pfiltro: 'sigefop.usuario_ai', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'usr_reg',
                        fieldLabel: 'Creado por',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 4
                    },
                    type: 'Field',
                    filters: {pfiltro: 'usu1.cuenta', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'id_usuario_ai',
                        fieldLabel: 'Creado por',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 4
                    },
                    type: 'Field',
                    filters: {pfiltro: 'sigefop.id_usuario_ai', type: 'numeric'},
                    id_grupo: 1,
                    grid: false,
                    form: false
                },
                {
                    config: {
                        name: 'usr_mod',
                        fieldLabel: 'Modificado por',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        maxLength: 4
                    },
                    type: 'Field',
                    filters: {pfiltro: 'usu2.cuenta', type: 'string'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                {
                    config: {
                        name: 'fecha_mod',
                        fieldLabel: 'Fecha Modif.',
                        allowBlank: true,
                        anchor: '80%',
                        gwidth: 100,
                        format: 'd/m/Y',
                        renderer: function (value, p, record) {
                            return value ? value.dateFormat('d/m/Y H:i:s') : ''
                        }
                    },
                    type: 'DateField',
                    filters: {pfiltro: 'sigefop.fecha_mod', type: 'date'},
                    id_grupo: 1,
                    grid: true,
                    form: false
                },
                // TODO: El guardado de los datos lo raliza en codificacion,
                // TODO: Preguntar a remsi.
                {
                    config: {
                        name: 'cod_criterio',
                        fieldLabel: 'Criterio',
                        allowBlank: false,
                        emptyText: 'Criterios...',
                        blankText: 'Debe seleccionar un criterio',
                        store: new Ext.data.JsonStore({
                            url: '../../sis_parametros/control/Catalogo/listarCatalogoCombo',
                            id: 'id_catalogo',
                            root: 'datos',
                            sortInfo: {
                                field: 'descripcion',
                                direction: 'ASC'
                            },
                            totalProperty: 'total',
                            fields: ['id_catalogo', 'codigo', 'descripcion'],
                            // turn on remote sorting
                            remoteSort: true,
                            baseParams: {par_filtro: 'descripcion',cod_subsistema: 'SIGEFO',
                                catalogo_tipo: 'tplanificacion_critico'}
                        }),
                        valueField: 'id_catalogo',
                        displayField: 'descripcion',
                        gdisplayField: 'descripcion',
                        hiddenName: 'id_catalogo',
                        forceSelection: true,
                        typeAhead: false,
                        triggerAction: 'all',
                        lazyRender: true,
                        mode: 'remote',
                        pageSize: 15,
                        queryDelay: 1000,
                        anchor: '60%',
                        gwidth: 150,
                        minChars: 2,
                        enableMultiSelect: true,
                        renderer: function (value, p, record) {
                            return String.format('{0}', record.data['criterio']);
                        }
                    },
                    type: 'AwesomeCombo',
                    id_grupo: 0,
                    filters: {pfiltro: 'descripcion', type: 'string'},
                    grid: true,
                    form: true
                },
                {
//            TODO: Preguntar a cristian como trabajar con los datos de cargo
                    config: {
                        name: 'id_cargos',
                        fieldLabel: 'Cargo',
                        allowBlank: false,
                        emptyText: 'Cargo...',
                        blankText: 'Debe seleccionar un cargo',
                        store: new Ext.data.JsonStore({
                            url: '../../sis_formacion/control/Planificacion/listarCargo',
                            id: 'id_cargo',
                            root: 'datos',
                            sortInfo: {
                                field: 'nombre',
                                direction: 'DESC'
                            },
                            totalProperty: 'total',
                            fields: ['id_cargo', 'nombre'],
                            remoteSort: true,
                            baseParams: {par_filtro: 'nombre'}
                        }),
                        valueField: 'id_cargo',
                        displayField: 'nombre',
                        gdisplayField: 'nombre',
                        hiddenName: 'id_cargo',
                        forceSelection: true,
                        typeAhead: false,
                        triggerAction: 'all',
                        lazyRender: true,
                        mode: 'remote',
                        pageSize: 15,
                        queryDelay: 1000,
                        anchor: '60%',
                        gwidth: 150,
                        minChars: 2,
                        enableMultiSelect: true,
                        renderer: function (value, p, record) {
                            return String.format('{0}', record.data['nombre']);
                        }
                    },
                    type: 'AwesomeCombo',
                    id_grupo: 0,
                    filters: {pfiltro: 'nombre', type: 'string'},
                    grid: true,
                    form: true
                },
                {
                    config: {
                        name: 'id_competencias',
                        fieldLabel: 'Competencias',
                        allowBlank: false,
                        emptyText: 'Competencias...',
                        blankText: 'Debe seleccionar una competencia',
                        store: new Ext.data.JsonStore({
                            url: '../../sis_formacion/control/Competencia/listarCompetencia',
                            id: 'id_competencia',
                            root: 'datos',
                            sortInfo: {
                                field: 'competencia',
                                direction: 'DESC'
                            },
                            totalProperty: 'total',
                            fields: ['id_competencia', 'competencia'],
                            remoteSort: true,
                            baseParams: {par_filtro: 'competencia'}
                        }),
                        valueField: 'id_competencia',
                        displayField: 'competencia',
                        gdisplayField: 'competencia',
                        hiddenName: 'id_competencia',
                        forceSelection: true,
                        typeAhead: false,
                        triggerAction: 'all',
                        lazyRender: true,
                        mode: 'remote',
                        pageSize: 15,
                        queryDelay: 1000,
                        anchor: '60%',
                        gwidth: 150,
                        minChars: 2,
                        enableMultiSelect: true,
                        renderer: function (value, p, record) {
                            return String.format('{0}', record.data['gestion']);
                        }
                    },
                    type: 'AwesomeCombo',
                    id_grupo: 0,
                    filters: {pfiltro: 'movtip.nombre', type: 'string'},
                    grid: true,
                    form: true
                },
                {
                    config: {
                        name: 'id_proveedores',
                        fieldLabel: 'Proveedores',
                        allowBlank: false,
                        emptyText: 'Proveedores...',
                        blankText: 'Debe seleccionar un proveedor',
                        store: new Ext.data.JsonStore({
                            url: '../../sis_parametros/control/Proveedor/listarProveedorCombos',
                            id: 'id_proveedor',
                            root: 'datos',
                            sortInfo: {
                                field: 'rotulo_comercial',
                                direction: 'DESC'
                            },
                            totalProperty: 'total',
                            fields: ['id_proveedor', 'rotulo_comercial'],
                            remoteSort: true,
                            baseParams: {par_filtro: 'rotulo_comercial'}
                        }),
                        valueField: 'id_proveedor',
                        displayField: 'rotulo_comercial',
                        gdisplayField: 'rotulo_comercial',
                        hiddenName: 'id_proveedor',
                        forceSelection: true,
                        typeAhead: false,
                        triggerAction: 'all',
                        lazyRender: true,
                        mode: 'remote',
                        pageSize: 15,
                        queryDelay: 1000,
                        anchor: '60%',
                        gwidth: 150,
                        minChars: 2,
                        enableMultiSelect: true,
                        renderer: function (value, p, record) {
                            return String.format('{0}', record.data['rotulo_comercial']);
                        }
                    },
                    type: 'AwesomeCombo',
                    id_grupo: 0,
                    filters: {pfiltro: 'movtip.rotulo_comercial', type: 'string'},
                    grid: true,
                    form: true
                },
            ],
            tam_pag: 50,
            title: 'Planificación',
            ActSave: '../../sis_formacion/control/Planificacion/insertarPlanificacion',
            ActDel: '../../sis_formacion/control/Planificacion/eliminarPlanificacion',
            ActList: '../../sis_formacion/control/Planificacion/listarPlanificacion',
            id_store: 'id_planificacion',
            fields: [
                {name: 'id_planificacion', type: 'numeric'},
                {name: 'id_gestion', type: 'numeric'},
                {name: 'estado_reg', type: 'string'},
                {name: 'cantidad_personas', type: 'numeric'},
                {name: 'contenido_basico', type: 'string'},
                {name: 'nombre_planificacion', type: 'string'},
                {name: 'necesidad', type: 'string'},
                {name: 'horas_previstas', type: 'numeric'},
                {name: 'fecha_reg', type: 'date', dateFormat: 'Y-m-d H:i:s.u'},
                {name: 'usuario_ai', type: 'string'},
                {name: 'id_usuario_reg', type: 'numeric'},
                {name: 'id_usuario_ai', type: 'numeric'},
                {name: 'id_usuario_mod', type: 'numeric'},
                {name: 'fecha_mod', type: 'date', dateFormat: 'Y-m-d H:i:s.u'},
                {name: 'usr_reg', type: 'string'},
                {name: 'usr_mod', type: 'string'}
            ],
            sortInfo: {
                field: 'id_planificacion',
                direction: 'ASC'
            },
            bdel: true,
            bsave: true
        }
    )
</script>
		
		