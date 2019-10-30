package viewModels

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import dominio.RepoIndividuo
import dominio.SuperIndividuo
import dominio.TipoDeIndividuo
import java.util.List
import dominio.Heroe
import dominio.Antiheroe
import dominio.Villano

@Accessors
@Observable
class GestionSuperIndividuos extends Gestion<SuperIndividuo> {

	List<TipoDeIndividuo> tiposPosibles = #[Heroe.instance, Antiheroe.instance, Villano.instance]

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