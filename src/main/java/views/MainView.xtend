package views

import org.uqbar.arena.widgets.Panel
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.tables.Column
import viewModels.MainViewViewModel
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

import paneles.PanelEstadisticas
import dominio.Equipo
import dominio.Item
import dominio.SuperIndividuo
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Button
import org.uqbar.commons.model.utils.ObservableUtils

class MainView extends SimpleWindow<MainViewViewModel> {

	new(WindowOwner parent, MainViewViewModel model) {
		super(parent, model)
	}

	override protected createFormPanel(Panel mainPanel) {

		this.title = "Hero Manager"
		val panelDerecho = new Panel(mainPanel) // Tengo que crearlo porque sino por algun motivo empieza desde la segunda columna el layout
		mainPanel.layout = new ColumnLayout(2)
		val panelEstadisticas = new Panel(mainPanel) => [
			layout = new ColumnLayout(2)
		]
		val panelSuperIndividuosMejorBalanceados = new Panel(mainPanel)
		val panelEquiposMasPoderosos = new Panel(mainPanel)
		val panelUltimosItems = new Panel(mainPanel)

		new PanelEstadisticas(panelEstadisticas) // Seccion Estadisticas
		
		new Label(panelSuperIndividuosMejorBalanceados).text = "Super individuos mejor balanceados"
		val tablaIndividuos = new Table<SuperIndividuo>(panelSuperIndividuosMejorBalanceados, SuperIndividuo) => [
			numberVisibleRows = 5
			items <=> "superIndividuosBalanceados"
		]
		new Button(panelSuperIndividuosMejorBalanceados) => [
			caption = "Gestión de Individuos"
			onClick[|this.abrirGestionIndividuos()]
		]
		this.agregarColumnaAGrilla(tablaIndividuos, "Alias", "alias",200)
		this.agregarColumnaAGrilla(tablaIndividuos, "Defensa", "poderDeDefensa",200)
		this.agregarColumnaAGrilla(tablaIndividuos, "Ataque", "poderDeAtaque",200)
		
		new Label(panelEquiposMasPoderosos).text = "Equipos Más Poderosos"
		val tablaEquipos = new Table<Equipo>(panelEquiposMasPoderosos, Equipo) => [
			numberVisibleRows = 5
			items <=> "equiposMasPoderosos"
		]
		this.agregarColumnaAGrilla(tablaEquipos, "Nombre", "nombre",300)
		this.agregarColumnaAGrilla(tablaEquipos, "Poder Grupal:", "poderGrupal", 300)
		new Button(panelEquiposMasPoderosos) => [
			caption = "Gestión de Equipos"
			onClick[|this.abrirGestionEquipos()]
		]
		
		new Label(panelUltimosItems).text = "Últimos Items"
		val tablaItems = new Table<Item>(panelUltimosItems, Item) => [
			numberVisibleRows = 5
			items <=> "ultimosItems"
		]
		new Button(panelUltimosItems) => [
			caption = "Gestión de Ítems"
			onClick[|this.abrirGestionItems()]
		]
		this.agregarColumnaAGrilla(tablaItems , "Nombre:", "nombre", 300)
		new Column<Item>(tablaItems)=>[
			title = "Sobrenatural"
			fixedSize = 300
			bindContentsToProperty("sobrenatural").transformer = [
				boolean esSobrenatural | if (esSobrenatural) "SI" else "NO"
			]
		]

	}

	override protected addActions(Panel actionsPanel) {
	}

	def agregarColumnaAGrilla(Table tabla, String label, String binding, int tamanio) {
		new Column(tabla) => [
			title = label
			fixedSize = tamanio
			bindContentsToProperty(binding)
		]
	}
	
	def void abrirGestionIndividuos(WindowOwner window) {
		new GestionIndividuoWindow(window) => [
			open
		]
		ObservableUtils.firePropertyChanged(modelObject, "superIndividuosBalanceados")
		ObservableUtils.firePropertyChanged(modelObject, "cantidadSuperIndividuos")
		ObservableUtils.firePropertyChanged(modelObject, "porcentajeIndividuosSenior")
		ObservableUtils.firePropertyChanged(modelObject, "superIndividuoMasEfectivo")
	}
	
	def void abrirGestionEquipos(WindowOwner window) {
		new GestionEquipoWindow(window) => [
			open
		]
		ObservableUtils.firePropertyChanged(modelObject, "equiposMasPoderosos")
	ObservableUtils.firePropertyChanged(modelObject, "cantidadEquiposRegistrados")
		ObservableUtils.firePropertyChanged(modelObject, "equipoMasPoderoso")
		
	
	}
	
	def void abrirGestionItems(WindowOwner window) {
		new GestionItemWindow(window) => [
			open
		]
		ObservableUtils.firePropertyChanged(modelObject, "ultimosItems")
	}
}
