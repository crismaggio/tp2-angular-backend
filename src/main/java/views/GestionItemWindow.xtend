package views

import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner
import viewModels.GestionItems
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.bindings.NotNullObservable
import dialogs.EditarItem
import dialogs.CrearItem

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.tables.Table
import dominio.Item
import dialogs.ItemsDialogModel

class GestionItemWindow extends GestionWindow<GestionItems> {
	
	new(WindowOwner parent) {
		super(parent, new GestionItems)		
	}

	override protected addActions(Panel actionsPanel) {} /* Sin definición */

	override protected createFormPanel(Panel mainPanel) {
		mainPanel.layout = new HorizontalLayout
		val itemSeleccionado = new NotNullObservable("entidadSeleccionada")
		this.crearTabla(mainPanel)
		val Panel panelDeBotones = new Panel(mainPanel)

		crearBotonEdicion(panelDeBotones, itemSeleccionado,"Editar")
		crearBotonEliminacion(panelDeBotones, itemSeleccionado,"Eliminar")
		crearBotonCreacion(panelDeBotones, "Nuevo")
	}
	
	override crearTabla(Panel panel){
		this.crearColumnas(
			new Table<Item>(panel, Item) => [
				numberVisibleRows = 5
				items <=> "repo"
				value <=> "entidadSeleccionada"
			]
		)
	}
	
	override crearColumnas (Table tabla){
		this.crearColumnaParaTabla(tabla, "Nombre", "nombre", 150)
		this.crearColumnaParaTabla(tabla, "Poder de Ataque", "poderDeAtaque", 150)
		this.crearColumnaParaTabla(tabla, "Resistencia", "resistencia", 150)
	}
	
	override void editar(){
		new EditarItem(this, new ItemsDialogModel(this.modelObject.entidadSeleccionada)) => [
			onAccept[]
			open
		]
		actualizarPropiedadEnVista(modelObject.entidadSeleccionada, "nombre")
		actualizarPropiedadEnVista(modelObject.entidadSeleccionada, "poderDeAtaque")
		actualizarPropiedadEnVista(modelObject.entidadSeleccionada, "resistencia")
		this.actualizarVistaEnTiempoReal("repo")
	}

	override void eliminar() {
		modelObject.eliminarItem()
		this.actualizarVistaEnTiempoReal("repo")
	}
	
	override void crear(){
		new CrearItem(this, new ItemsDialogModel()) => [
			onAccept[this.actualizarVistaEnTiempoReal("repo")]
			open
		]
	}
}