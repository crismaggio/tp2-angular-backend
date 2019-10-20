package viewModels

import dominio.RepoIndividuo
import org.uqbar.commons.model.annotations.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import dominio.Item
import dominio.RepoItem
import dominio.RepoEquipo
import java.util.List

@Observable
@Accessors
class MainViewViewModel {
	
	var List<Item> lisItem = RepoItem.instance.elementos

	def superIndividuosBalanceados() {
		RepoIndividuo.instance.elementos.sortBy([supI|Math.abs(supI.poderDeAtaque - supI.poderDeDefensa)])
	}

	def double porcentajeIndividuosSenior() {
		(RepoIndividuo.instance.elementos.filter[supI|supI.esSenior].size().doubleValue /
			RepoIndividuo.instance.cantidadElementos.doubleValue) * 100
	}

	def superIndividuoMasEfectivo() {
		RepoIndividuo.instance.elementos.maxBy[efectividadSuperIndividuo].nombreYApellido
	}

	def porcentajeEquiposLlenos() {
		(RepoEquipo.instance.elementos.filter[cantidadDeIntegrantesConLider == 10].size().doubleValue /
			RepoEquipo.instance.cantidadElementos.doubleValue) * 100
	}

	def ultimosItems() {
		lisItem.reverse.subList(0, Math.min(5, RepoItem.instance.elementos.size))
	}

	def cantidadSuperIndividuos() {
		RepoIndividuo.instance.elementos.size
	}

	def cantidadEquiposRegistrados() {
		RepoEquipo.instance.elementos.size
	}

	def equipoMasPoderoso() {
		RepoEquipo.instance.elementos.maxBy[poderGrupal].nombre
	}

	def equiposMasPoderosos() {
		RepoEquipo.instance.elementos.sortBy([poderGrupal])
	}

}
