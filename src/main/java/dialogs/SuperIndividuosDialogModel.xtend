package dialogs

import dominio.SuperIndividuo
import dominio.TipoDeIndividuo
import dominio.Heroe
import dominio.Antiheroe
import dominio.Villano
import java.util.List
import dominio.RepoIndividuo
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class SuperIndividuosDialogModel extends CreacionEdicionDialogModel<SuperIndividuo> {
	
	List<TipoDeIndividuo> tiposPosibles = #[Heroe.instance, Antiheroe.instance, Villano.instance]

	new() {
		super()
		super.entidadClonada = new SuperIndividuo
		super.entidadSeleccionada = new SuperIndividuo
	}

	new(SuperIndividuo nuevo) {
		super.entidadClonada = new SuperIndividuo
		super.entidadSeleccionada = nuevo
	}

	override repo() {
		RepoIndividuo.instance.elementos
	}

	def actualizarSuperIndividuo() {
		RepoIndividuo.instance.update(entidadSeleccionada)
	}

	def eliminarSuperIndividuo() {
		RepoIndividuo.instance.delete(entidadSeleccionada)
	}

	def agregarSuperIndividuo() {
		RepoIndividuo.instance.agregarElemento(entidadSeleccionada)
	}
}