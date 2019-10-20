package views

import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table

import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.commons.model.utils.ObservableUtils
import dominio.Entidad

@Accessors
abstract class GestionWindow<T> extends SimpleWindow<T> {

	new(WindowOwner parent, T viewModel) {
		super(parent, viewModel)
	}

	override protected createFormPanel(Panel mainPanel) {
		mainPanel.layout = new HorizontalLayout
	}
	
	def void crearTabla(Panel panel)
	
	def void crearColumnas(Table table)

	def void crearColumnaParaTabla(Table table, String titulo, String propiedad, int tamanio) {
		new Column(table) => [
			title = titulo
			fixedSize = tamanio
			bindContentsToProperty(propiedad)
		]
	}

	def void crearBotonEdicion(Panel panelDeBotones, NotNullObservable selectedObject, String _caption) {
		new Button(panelDeBotones) => [
			caption = _caption
			width = 100
			onClick([|this.editar])
			bindEnabled(selectedObject)
		]
	}

	def void crearBotonEliminacion(Panel panelDeBotones, NotNullObservable selectedObject, String _caption) {
		new Button(panelDeBotones) => [
			caption = _caption
			width = 100
			onClick([|this.eliminar])
			bindEnabled(selectedObject)
		]
	}

	def void crearBotonCreacion(Panel panelDeBotones, String _caption) {
		new Button(panelDeBotones) => [
			caption = _caption
			width = 100
			onClick([|this.crear])
		]
	}
	
	def actualizarVistaEnTiempoReal(String propiedad){
		ObservableUtils.firePropertyChanged(modelObject, propiedad)
	}
	
	def actualizarPropiedadEnVista(Entidad modelObject, String atributo){
		ObservableUtils.firePropertyChanged(modelObject, atributo)
	}
	
	def void editar() 

	def void eliminar()

	def void crear()
}