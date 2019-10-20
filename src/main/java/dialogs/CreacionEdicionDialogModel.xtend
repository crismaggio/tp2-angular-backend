package dialogs

import java.util.List
import dominio.Entidad
import org.uqbar.commons.model.utils.ObservableUtils
import org.apache.commons.beanutils.BeanUtils
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.Transactional

@Accessors
@Observable
abstract class CreacionEdicionDialogModel<T extends Entidad>{
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