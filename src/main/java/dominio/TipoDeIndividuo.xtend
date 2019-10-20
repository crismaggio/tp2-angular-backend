package dominio

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
abstract class TipoDeIndividuo {
	val String tipoIndividuo = this.descripcion()
	def double efectividad(SuperIndividuo superIndividuo)

	def double efectividadBase(SuperIndividuo superIndividuo, double factor, double factor2) {
		(superIndividuo.poderDeAtaque * factor + superIndividuo.poderDeDefensa) * (superIndividuo.experiencia / factor2)
	}
	def String descripcion(){this.class.simpleName}
}

class Heroe extends TipoDeIndividuo {
 	
	private new() {
	}

	static Heroe instance

	static def getInstance() {
		if (instance === null) {
			instance = new Heroe
		}
		instance
	}

	override efectividad(SuperIndividuo superIndividuo) {
		efectividadBase(superIndividuo, 1, 10) + sumaDePoderEnCasoDeSerSenior(superIndividuo)
	}

	def sumaDePoderEnCasoDeSerSenior(SuperIndividuo superIndividuo) {
		if(superIndividuo.esSenior) superIndividuo.poderDeAtaque * 0.2 else 0
	}

}

class Antiheroe extends TipoDeIndividuo {
	Antiheroe tipo

	private new() {
	}

	static Antiheroe instance

	static def getInstance() {
		if (instance === null) {
			instance = new Antiheroe
		}
		instance
	}

	override efectividad(SuperIndividuo superIndividuo) {
		(efectividadBase(superIndividuo, 1.5, 20)) * sumaDePoderEnCasoDeTenerMasDeCiendeEXp(superIndividuo)
	}

	def sumaDePoderEnCasoDeTenerMasDeCiendeEXp(SuperIndividuo superIndividuo) {
		if(superIndividuo.experiencia > 100) 1.25 else 1
	}
}

class Villano extends TipoDeIndividuo {
	Villano tipo

	private new() {
	}

	static Villano instance

	static def getInstance() {
		if (instance === null) {
			instance = new Villano
		}
		instance
	}

	override efectividad(SuperIndividuo superIndividuo) {
		efectividadBase(superIndividuo, 2, superIndividuo.experiencia)
	}

}