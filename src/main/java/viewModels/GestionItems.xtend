package viewModels


import dominio.Item
import dominio.RepoItem
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import dominio.ItemCompuesto

@Accessors
@Observable
class GestionItems extends Gestion<Item> {
	
	override repo() {		
		RepoItem.instance.elementos.filter[  !(it instanceof ItemCompuesto)].toList
	}

	def agregarItem(){
		RepoItem.instance.agregarElemento(entidadSeleccionada)
	}
		
	def actualizarItem(){
		RepoItem.instance.update(entidadClonada)
	}
	
	def eliminarItem(){
		RepoItem.instance.delete(entidadSeleccionada)
	}
}