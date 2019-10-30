package dialogs

import org.uqbar.arena.windows.WindowOwner
import viewModels.GestionSuperIndividuos
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.layout.ColumnLayout
import transformers.StringVacioONuloTransformer
import transformers.IntegerVacioONuloTransformer
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.widgets.Selector
import dominio.TipoDeIndividuo
import org.uqbar.arena.widgets.NumericField
import transformers.FechasTransformer
import transformers.DoubleVacioONuloTransformer

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class CrearSuperIndividuo extends TransactionalDialog<SuperIndividuosDialogModel> {
	
	new(WindowOwner owner, SuperIndividuosDialogModel model) {
		super(owner, model)
		this.title = "Crear SuperIndividuo"
	}

	def aceptar() {
		this.modelObject.agregarSuperIndividuo
		super.accept
	}

	override protected createFormPanel(Panel mainPanel) {
		val panel = new Panel(mainPanel) => [
			layout = new ColumnLayout(2)
		]
		new Label(mainPanel).text = "" // Salto de línea
		new Label(panel).text = "Nombre:"

		new TextBox(panel) => [
			withFilter [event|event.potentialTextResult.matches("[a-z,A-Z]*")]
			(value <=> "entidadSeleccionada.nombre").transformer = new StringVacioONuloTransformer(
				"El nombre no puede estar vacío")
			width = 200
		]
		new Label(panel).text = "Apellido:"
		new TextBox(panel) => [
			withFilter [event|event.potentialTextResult.matches("[a-z,A-Z]*")]
			(value <=> "entidadSeleccionada.apellido").transformer = new StringVacioONuloTransformer(
				"El apellido no puede estar vacío")
			width = 200
		]

		new Label(panel).text = "Alias:"
		new TextBox(panel) => [
			(value <=> "entidadSeleccionada.alias").transformer = new StringVacioONuloTransformer(
				"El alias no puede estar vacío")
			width = 200
		]

		new Label(panel).text = "Tipo de Individuo:"

		new Selector<TipoDeIndividuo>(panel) => [
			allowNull(false)
			width = 184
			(items <=> "tiposPosibles").adapter = new PropertyAdapter(TipoDeIndividuo, "descripcion")
			value <=> "entidadSeleccionada.tipo"
		]

		new Label(panel).text = "Victorias:"
		new NumericField(panel) => [
			(value <=> "entidadSeleccionada.victorias").transformer = new IntegerVacioONuloTransformer(
				"Las victorias no pueden ser nulas o vacías")
			width = 200
		]

		new Label(panel).text = "Derrotas:"
		new NumericField(panel) => [
			(value <=> "entidadSeleccionada.derrotas").transformer = new IntegerVacioONuloTransformer(
				"Las derrotas no pueden ser nulas o vacías")
			width = 200
		]

		new Label(panel).text = "Empates:"
		new NumericField(panel) => [
			(value <=> "entidadSeleccionada.empates").transformer = new IntegerVacioONuloTransformer(
				"Los empates no pueden ser nulos o vacíos")
			width = 200
		]

		new Label(panel).text = "Fecha Inicio Actividad:"
		new TextBox(panel) => [
			(value <=> "entidadSeleccionada.fecha_ini").transformer = new FechasTransformer
			width = 200
		]

		new Label(panel).text = "Fuerza:"
		new NumericField(panel) => [
			(value <=> "entidadSeleccionada.fuerza").transformer = new DoubleVacioONuloTransformer(
				"La fuerza no puede ser nula o vacía")
			width = 200
		]

		new Label(panel).text = "Resistencia:"
		new NumericField(panel) => [
			(value <=> "entidadSeleccionada.resistencia").transformer = new DoubleVacioONuloTransformer(
				"La resistencia no puede ser nula o vacía")
			width = 200
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
}
