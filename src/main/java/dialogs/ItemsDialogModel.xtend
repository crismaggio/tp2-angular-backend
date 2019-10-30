package dialogs

import dominio.Item
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import dominio.RepoItem
import dominio.ItemCompuesto

@Accessors
@Observable
class ItemsDialogModel extends CreacionEdicionDialogModel<Item> {
	
	new() {
		super()
		super.entidadClonada = new Item
		super.entidadSeleccionada = new Item
	}
	
	new(Item nuevo) {
		super()
		super.entidadClonada = new Item
		super.entidadSeleccionada = nuevo
	}
	
	override repo() {		
		RepoItem.instance.elementos.filter[  !(it instanceof ItemCompuesto)].toList		
	}

	def agregarItem(){
		RepoItem.instance.agregarElemento(entidadSeleccionada)
	}
		
	def actualizarItem(){
		RepoItem.instance.update(entidadSeleccionada)
	}
	
	def eliminarItem(){
		RepoItem.instance.delete(entidadSeleccionada)
	}
}