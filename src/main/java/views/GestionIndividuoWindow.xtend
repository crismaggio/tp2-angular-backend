package views

import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner
import viewModels.GestionSuperIndividuos
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.bindings.NotNullObservable
import dialogs.EditarSuperIndividuo
import dialogs.CrearSuperIndividuo
import org.uqbar.arena.widgets.tables.Table
import dominio.SuperIndividuo

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import dialogs.SuperIndividuosDialogModel

class GestionIndividuoWindow extends GestionWindow<GestionSuperIndividuos> {

	new(WindowOwner parent) {
		super(parent, new GestionSuperIndividuos)
	}

	override protected addActions(Panel actionsPanel) {
	}

	override protected createFormPanel(Panel mainPanel) {
		mainPanel.layout = new HorizontalLayout
		val superIndividuoSeleccionado = new NotNullObservable("entidadSeleccionada")
		this.crearTabla(mainPanel)
		val Panel panelDeBotones = new Panel(mainPanel)

		crearBotonEdicion(panelDeBotones, superIndividuoSeleccionado, "Editar")
		crearBotonEliminacion(panelDeBotones, superIndividuoSeleccionado, "Eliminar")
		crearBotonCreacion(panelDeBotones, "Nuevo")

	}

	override crearTabla(Panel panel) {
		this.crearColumnas(
			new Table<SuperIndividuo>(panel, SuperIndividuo) => [
				numberVisibleRows = 5
				items <=> "repo"
				value <=> "entidadSeleccionada"
			]
		)
	}

	override crearColumnas(Table table) {
		this.crearColumnaParaTabla(table, "Alias", "alias", 150)
		this.crearColumnaParaTabla(table, "Nombre", "nombre", 150)
		this.crearColumnaParaTabla(table, "Apellido", "apellido", 150)
		this.crearColumnaParaTabla(table, "Efectividad", "efectividadSuperIndividuo", 150)
	}

	override void editar() {
		new EditarSuperIndividuo(this, new SuperIndividuosDialogModel(this.modelObject.entidadSeleccionada)) => [
			onAccept[]
			open
		]
		actualizarPropiedadEnVista(modelObject.entidadSeleccionada, "nombre")
		actualizarPropiedadEnVista(modelObject.entidadSeleccionada, "apellido")
		actualizarPropiedadEnVista(modelObject.entidadSeleccionada, "alias")
		actualizarPropiedadEnVista(modelObject.entidadSeleccionada, "efectividadSuperIndividuo")
		this.actualizarVistaEnTiempoReal("repo")
	}

	override void eliminar() {
		modelObject.eliminarSuperIndividuo()
		this.actualizarVistaEnTiempoReal("repo")
	}

	override void crear() {// new GestionSuperIndividuos(new SuperIndividuo)
		new CrearSuperIndividuo(this, new SuperIndividuosDialogModel()) => [
			onAccept[this.actualizarVistaEnTiempoReal("repo")]
			open
		]
	}

}

