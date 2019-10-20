package views

import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.bindings.NotNullObservable

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import viewModels.GestionEquipos
import dialogs.EditarEquipo
import dialogs.CrearEquipo
import org.uqbar.arena.widgets.tables.Table
import dominio.Equipo
import org.uqbar.commons.model.utils.ObservableUtils
import dialogs.EquiposDialogModel

class GestionEquipoWindow extends GestionWindow<GestionEquipos> {

	new(WindowOwner parent) {
		super(parent, new GestionEquipos)
	}

	override protected addActions(Panel actionsPanel) {
	}

	override protected createFormPanel(Panel mainPanel) {
		mainPanel.layout = new HorizontalLayout
		val equipoSeleccionado = new NotNullObservable("entidadSeleccionada")
		this.crearTabla(mainPanel)
		val Panel panelDeBotones = new Panel(mainPanel)

		crearBotonEdicion(panelDeBotones, equipoSeleccionado, "Editar")
		crearBotonEliminacion(panelDeBotones, equipoSeleccionado, "Eliminar")
		crearBotonCreacion(panelDeBotones, "Nuevo")
	}
	
	override crearTabla(Panel panel) {
		this.crearColumnas(
			new Table<Equipo>(panel, Equipo) => [
				numberVisibleRows = 5
				items <=> "repo"
				value <=> "entidadSeleccionada"
			]
		)
	}
	
	override crearColumnas(Table table) {
		this.crearColumnaParaTabla(table, "Nombre", "nombre", 200)
		this.crearColumnaParaTabla(table, "Lider", "lider.alias", 200)
		this.crearColumnaParaTabla(table, "Poder Grupal", "poderGrupal", 200)
	}
	
	override void editar() {

		new EditarEquipo(this, new EquiposDialogModel(this.modelObject.entidadSeleccionada)) => [
			onAccept[]
			open
		]
		actualizarPropiedadEnVista(modelObject.entidadSeleccionada, "nombre")
		actualizarPropiedadEnVista(modelObject.entidadSeleccionada, "poderGrupal")
		this.actualizarVistaEnTiempoReal("repo")
	}

	override void eliminar() {
		this.modelObject.eliminarEquipo()
		this.actualizarVistaEnTiempoReal("repo")
	}

	override void crear() { 
		new CrearEquipo(this, new EquiposDialogModel()) => [
			onAccept[this.actualizarVistaEnTiempoReal("repo")]
			open
		]
	}
	
}