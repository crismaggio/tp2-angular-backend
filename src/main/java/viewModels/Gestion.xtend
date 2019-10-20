package viewModels

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.utils.ObservableUtils
import dominio.Entidad
import org.apache.commons.beanutils.BeanUtils

@Accessors
@Observable
abstract class Gestion<T extends Entidad> {
	
	Boolean cancelar = true	
	List<T> elementos
	T elementoSeleccionado
    T entidadSeleccionada
    T entidadClonada
	def List<T> repo()

	new() {
		elementos = repo()
	}
	
	def actualizarPropiedadEnVista(Entidad modelObject, String atributo){
		ObservableUtils.firePropertyChanged(modelObject, atributo)
	}
	
	def  void clonarBackup(){	
		BeanUtils.copyProperties(entidadClonada, entidadSeleccionada)
	}
	
	def revertirEdicion(){
		dorevertirEdicion()
		BeanUtils.copyProperties(entidadSeleccionada, entidadClonada)
	}
	
	def void dorevertirEdicion(){}
	
}
