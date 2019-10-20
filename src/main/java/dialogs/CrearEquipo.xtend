package dialogs

import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.Selector
import dominio.SuperIndividuo
import org.uqbar.arena.bindings.PropertyAdapter
import transformers.StringVacioONuloTransformer
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.List
import org.uqbar.commons.model.utils.ObservableUtils

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class CrearEquipo extends TransactionalDialog<EquiposDialogModel>{
	
	new(WindowOwner owner, EquiposDialogModel model) {
		super(owner, model)
		this.title = "Crear Equipo"	
	}

	def aceptar() {
		this.modelObject.agregarEquipo
		super.accept
	}
	
	override protected createFormPanel(Panel mainPanel) {
		val panel = new Panel(mainPanel) => [
			layout = new ColumnLayout(2)
		]
		new Label(mainPanel).text = ""	//Salto de línea
		new Label(panel).text = "Nombre:"
		
		new TextBox(panel) => [
			withFilter [ event | event.potentialTextResult.matches("[a-z,A-Z,0-9]*") ]
			(value <=> "entidadSeleccionada.nombre").transformer =  new StringVacioONuloTransformer("El nombre no puede estar vacío")
			width = 200	
		]	
		
		panel.layout = new VerticalLayout
		new Label(panel).text = "Lider:"
		new Selector<SuperIndividuo>(panel) => [
			allowNull(false)
			width = 200
			(items <=> "posiblesLideres").adapter = new PropertyAdapter(SuperIndividuo, "alias")
			value <=> "liderEquipo"
		
		
		]
		val panelIntegrantes = new Panel(panel) => [
			layout = new ColumnLayout(2)
		]
		val panelIntegrantesAsignados = new Panel(panelIntegrantes)
		val panelIntegrantesDisponibles = new Panel(panelIntegrantes)

		new Label(panelIntegrantesAsignados).text = "Integrantes Asignados:"
		new List(panelIntegrantesAsignados) => [
			(items <=> "superIndividuosAsignados").adapter = new PropertyAdapter(SuperIndividuo, "alias")			
			value <=> "integrantePorRemover"
			width = 300
			height = 200
		]
		new Button(panelIntegrantesAsignados) => [
			caption = "Remover Integrante"
			onClick [|this.removerIntegrante]
			setAsDefault
			disableOnError
		]
		new Label(panelIntegrantesDisponibles).text = "Integrantes Disponibles:"
		new List(panelIntegrantesDisponibles) => [
			(items <=> "superIndividuosDisponibles").adapter = new PropertyAdapter(SuperIndividuo, "alias")
			value <=> "integrantePorAsignar"
			width = 300
			height = 200
		]

		new Button(panelIntegrantesDisponibles) => [
			caption = "Asignar Integrante"
			onClick [|this.asignarIntegrante]
			setAsDefault
			disableOnError
		]

	}
	
	override protected void addActions(Panel actions) {
		new Button(actions) => [
			caption = "Aceptar"
			onClick [|this.aceptar]			
			disableOnError	
		]

		new Button(actions) => [
			caption = "Cancelar"	
			onClick [|
				this.cancel
			]
			setAsDefault
			bindVisibleToProperty("cancelar")
		]
	}

	def asignarIntegrante() {
		print( this.modelObject.integrantePorAsignar +"dasdasdsadasdasdasdasdsa")          
		this.modelObject.asignarIntegrante()
		this.actualizarIntegrantes
	}

	def removerIntegrante() {
		this.modelObject.removerIntegrante()
		this.actualizarIntegrantes
	}

	def actualizarIntegrantes() {
		ObservableUtils.firePropertyChanged(modelObject, "superIndividuosAsignados")
		ObservableUtils.firePropertyChanged(modelObject, "superIndividuosDisponibles")
		ObservableUtils.firePropertyChanged(modelObject, "posiblesLideres")
	}

}