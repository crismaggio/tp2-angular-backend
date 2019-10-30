package dominio

import java.time.LocalDate
import org.eclipse.xtend.lib.annotations.Accessors

interface Proceso {

	def void ejecutar()

}

class EliminadorDeVillano implements Proceso {
	new(RepoEquipo repoEquipo) {
		repo = repoEquipo
	}

	RepoEquipo repo 

	override ejecutar() {
		repo.elementos.forEach[eliminarVillano]
	}

}

class RegalarItem implements Proceso {
	new(RepoIndividuo repoIndividuo, int añosparaElregalo, Item item) {
		this.repo = repoIndividuo
		this.añosparaElregalo = añosparaElregalo
		this.item = item
	}

	@Accessors int añosparaElregalo
	@Accessors RepoIndividuo repo
	@Accessors Item item

	override ejecutar() {
		listaCumpleCondicion().forEach[it.agregarItemYOrdenaLista(item)]

	}

	def listaCumpleCondicion() {
		repo.elementos.filter[it.fecha_ini == LocalDate.now.minusYears(añosparaElregalo)]

	}
}

class InflacionDeItem implements Proceso {
	new(RepoItem repoItem) {
		repo = repoItem
	}

	RepoItem repo

	override ejecutar() {
		repo.elementos.forEach[aumentarPrecioDeItem]
	}

}
