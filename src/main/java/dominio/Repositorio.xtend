package dominio

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.Transactional

@Transactional
@Accessors
@Observable
abstract class Entidad implements Cloneable {
	protected String id

//	def void setId(String idNro) {
//		id = idNro
//	}
	
	def copy() {
		super.clone as Entidad
	}

	def void actualizar(Entidad elemento)

	def boolean tieneValorBusqueda(String valor)

}

@Accessors
@Observable
abstract class Repositorio<T extends Entidad> {
	List<T> elementos = new ArrayList<T>
	var int proximoId = 1

	def void agregarElemento(T elemento) {
		elemento.setId(asignarId)
		elementos.add(elemento)
	}

	def void agregarElementoJson(T elemento) {
		if (validarID(elemento.id)) {
			update(elemento)
		} else {
			elementos.add(elemento)
		}
	}

	def void update(T elemento) {
		searchById(elemento.id).actualizar(elemento)
	}

	def Boolean delete(T elemento) {
		elementos.remove(elemento)
	}

	def validarID(String id) {
		elementos.exists[it.id == id]
	}

	def T searchById(String id) {
		elementos.findFirst[it.id.equals(id)]
		if (!validarID(id)) {
			throw new RepositorioException("No se encontro el id " + id)
		}
		elementos.findFirst[it.id.equals(id)]
	}

	def  search(String value) {
		elementos.findFirst[tieneValorBusqueda(value)]
	}

	def proximoId() {
		proximoId++
	}

	def String asignarId()

	def procesarLista(List<T> elementos) {
		elementos.forEach [
			agregarElementoJson
		]
	}
	
	// INICIO Agregados TP Algo 3	
	def cantidadElementos(){
		elementos.size()
	}
	
	
	// FIN Agregados TP Algo 3
}

class RepoIndividuo extends Repositorio<SuperIndividuo> {
	static RepoIndividuo instance // = new RepoIndividuo

	def static getInstance() {
		if (instance === null) {
			return instance = new RepoIndividuo
		} else {
			instance
		}
	}
	override String asignarId() {
		"SI" + proximoId()
	}

	override procesarLista(List<SuperIndividuo> elementos) {
		elementos.forEach[elemento|searchById(elemento.id).amigos = elemento.amigos]
	}

	def mejorDefensorDelRepo(Amenaza unaAmenaza) {
		if (chancesDeCombatirAmenazaMayoresde60(unaAmenaza).empty) {
			elementos.minBy[costoDeCombatirUnaAmenaza(unaAmenaza)]
		} else {
			chancesDeCombatirAmenazaMayoresde60(unaAmenaza).minBy[costoDeCombatirUnaAmenaza(unaAmenaza)]
		}
	}

	def chancesDeCombatirAmenazaMayoresde60(Amenaza unaAmenaza) {
		elementos.filter[defensor|defensor.chancesDeContrarrestarAmenaza(unaAmenaza) > 60]
	}
	
	def superIndividuosBalanceados(){
		elementos.sortBy([supI | Math.abs(supI.poderDeAtaque - supI.poderDeDefensa)])
	}

}

class RepoItem extends Repositorio<Item> {
	static RepoItem instance // = new RepoItem

	def static getInstance() {
		if (instance === null) {
			return instance = new RepoItem
		} else {
			instance
		}
	}
	override String asignarId() {

		"I" + proximoId()
	}
}

class RepoEquipo extends Repositorio<Equipo> {
//lista de entidades que van a ser equipos
	static RepoEquipo instance // = new RepoEquipo

	def static getInstance() {
		if (instance === null) {
			return instance = new RepoEquipo
		} else {
			instance
		}
	}
	override String asignarId() {
		"E" + proximoId()
	}

	def mejorDefensorDelRepo(Amenaza unaAmenaza) {
		// elementos.minBy[costoDeCombatirUnaAmenaza(unaAmenaza)]
		if (chancesDeCombatirAmenazaMayoresde60(unaAmenaza).empty) {
			elementos.minBy[costoDeCombatirUnaAmenaza(unaAmenaza)]
		} else {
			chancesDeCombatirAmenazaMayoresde60(unaAmenaza).minBy[costoDeCombatirUnaAmenaza(unaAmenaza)]
		}
	}

	def chancesDeCombatirAmenazaMayoresde60(Amenaza unaAmenaza) {
		elementos.filter[defensor|defensor.chancesDeContrarrestarAmenaza(unaAmenaza) > 60]
	}
	// INICIO Agregados TP Algo 3	
	def porcentajeEquiposLlenos(){
		return ( this.elementos.filter[equipo|equipo.cantidadDeIntegrantesConLider == 10].size().doubleValue / this.cantidadElementos.doubleValue) * 100
	}
	
	def  equipoMasEfectivo(){
		this.elementos.maxBy[poderGrupal].nombre
	}
		def   equipoMasPoderoso(){
		this.elementos.sortBy[poderGrupal]
	}
	
	// FIN Agregados TP Algo 3
}

class RepoAmenaza extends Repositorio<Amenaza> {

	private new() {
	}

	override String asignarId() {
		"A" + proximoId()
	}

	static RepoAmenaza instance // = new RepoAmenaza

	def static getInstance() {
		if (instance === null) {
			return instance = new RepoAmenaza
		} else {
			instance
		}
	}

}