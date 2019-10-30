package dialogs

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Button
import viewModels.GestionItems
import transformers.StringVacioONuloTransformer
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.widgets.NumericField
import transformers.DoubleVacioONuloTransformer

class CrearItem extends TransactionalDialog<ItemsDialogModel>{
	
	new(WindowOwner owner, ItemsDialogModel model) {
		super(owner, model)
	}

	override protected createFormPanel(Panel mainPanel) {
		val panelDatos = new Panel(mainPanel) => [
			layout = new HorizontalLayout
		]
		val panelIzquierdo = new Panel(panelDatos)
		val panelDerecho = new Panel(panelDatos)
		val panelSobrenatural = new Panel(mainPanel) => [
			layout = new HorizontalLayout
		]
		new Label(panelIzquierdo).text = "Nombre:"
		new TextBox(panelIzquierdo) => [
			withFilter [ event | event.potentialTextResult.matches("[a-z,A-Z]*") ]
			(value <=> "entidadSeleccionada.nombre").transformer =  new StringVacioONuloTransformer("El nombre no puede estar vacío")
			width = 200
		]

		new Label(panelIzquierdo).text = "Precio:"
		new NumericField(panelIzquierdo) => [
			(value <=> "entidadSeleccionada.precio").transformer = new DoubleVacioONuloTransformer("El precio no puede ser nulo o vacío")
			width = 200
		]

		new Label(panelIzquierdo).text = "Peso:"
		new NumericField(panelIzquierdo) => [
			(value <=> "entidadSeleccionada.peso").transformer = new DoubleVacioONuloTransformer("El peso no puede ser nulo o vacío")
			width = 200
		]

		new Label(panelDerecho).text = "Alcance:"
		new NumericField(panelDerecho) => [
			(value <=> "entidadSeleccionada.alcance").transformer = new DoubleVacioONuloTransformer("El alcance no puede ser nulo o vacío")
			width = 200
		]

		new Label(panelDerecho).text = "Daño:"
		new NumericField(panelDerecho) => [
			(value <=> "entidadSeleccionada.danio").transformer = new DoubleVacioONuloTransformer("El daño no puede ser nulo o vacío")
			width = 200
		]

		new Label(panelDerecho).text = "Resistencia:"
		new NumericField(panelDerecho) => [
			(value <=> "entidadSeleccionada.resistencia").transformer = new DoubleVacioONuloTransformer("La resistencia no puede ser nula o vacía")
			width = 200
		]
		
		new Label(panelSobrenatural).text = "Sobrenatural:"
		new CheckBox(panelSobrenatural) => [
			value <=> "entidadSeleccionada.sobrenatural"
		]
	}

	override protected void addActions(Panel actions) {
		new Button(actions)
			.setCaption("Aceptar")
			.onClick [ | this.aceptar ]
			.disableOnError

		new Button(actions) => [
			caption = "Cancelar"	
			onClick [|
				this.cancel
			]
			setAsDefault
			bindVisibleToProperty("cancelar")
		]
	}
	
	def aceptar() {
		this.modelObject.agregarItem
		super.accept
	}

}