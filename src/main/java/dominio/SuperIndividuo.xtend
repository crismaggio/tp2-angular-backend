package dominio

import java.time.LocalDate
import java.time.Period
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import com.fasterxml.jackson.annotation.JsonIgnore
import java.util.ArrayList
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.Transactional
import com.fasterxml.jackson.annotation.JsonIgnoreProperties

@Transactional
@Accessors
@Observable
@JsonIgnoreProperties("victorias", "derrotas", "nombreYApellido","empates", "baseDeOperaciones", "fecha_ini", "fuerza", "dinero", "resistencia", "mejoras", "notificaciones", "obs", "determinadaCantDerrotas", "password")
class SuperIndividuo extends Entidad implements Defensores {
	@JsonIgnore List<TipoDeIndividuo> tiposPosibles = #[Heroe.instance, Antiheroe.instance, Villano.instance]
	String foto
	String nombre
	String apellido
	String nombreYApellido
	String alias
	String mail = "MAIL@MAIL.COM"
	int victorias
	int derrotas
	int empates
	String password
	Point baseDeOperaciones
	@JsonIgnore TipoDeIndividuo tipo
	LocalDate fecha_ini = LocalDate.now
	Double fuerza

	@JsonIgnore List<Equipo> equipos = new ArrayList
	@JsonIgnore List<Item> items = new ArrayList
	@JsonIgnore List<SuperIndividuo> enemigos = new ArrayList
	@JsonIgnore List<SuperIndividuo> amigos = new ArrayList
	Double dinero
	Double resistencia
	List<Mejora> mejoras = new ArrayList
	List<String> notificaciones = new ArrayList
	List<observer> obs = new ArrayList
	int determinadaCantDerrotas = 5

	def igresaraUnEquipo(Equipo equipo) {
		equipos.add(equipo)
	}

	def tipo(TipoDeIndividuo tipo) {
		this.tipo = tipo
		postObs()
	}

	def postObs() {
		obs.forEach[it.send(this)]
	}

	def recibirNotificacion(String string) {
		notificaciones.add(string)
	}

	def aumentarDerotas(int derrota) {
		this.derrotas = this.victorias + derrota
		postObs()
	}

	def aumentarVictorias(int victorias) {
		this.victorias = this.victorias + victorias
		postObs()
	}

	def void agregarObs(observer obs) {
		this.obs.add(obs)

	}

	def experiencia() {
		aniosDeActividad + (victorias / 2) + (derrotas / 2) + (empates / 4)
	}

	def int aniosDeActividad() {
		Period.between(fecha_ini, LocalDate.now).years

	}

	def comprarMejora(Mejora mejora) {
		if (dineroSuficienteParaLaCompra(mejora)) {
			dinero = dinero - mejora.precio
			mejoras.add(mejora)
		}

	}

	def dineroSuficienteParaLaCompra(Mejora mejora) {
		dinero > mejora.precio

	}

	def tieneItemYMejora(Mejora mejora, Item _item) {
		items.contains(_item) && mejoras.contains(mejora)
	}

	def usarMejora(Mejora _mejora, Item _item) {
		if (tieneItemYMejora(_mejora, _item)) {
			_mejora.mejorarItem(_item)
			mejoras.remove(_mejora)
		}

	}

	def agregarItemYOrdenaLista(Item item) {
		items.add(item)
		ordenaItemsDeMayoraMenor
	}

	def poderDeAtaque() {
		fuerza + ItemMasPoderoso.poderDeAtaque + sumaPorcentajeItemsRestantes
	}

	def ItemMasPoderoso() {
		items.head ?: new Item()

	}

	def sumaPorcentajeItemsRestantes() {
		0.2 * (items.tail.fold(0.0, [acum, item|acum + item.poderDeAtaque()]) ?: 0)

	}

	def void ordenaItemsDeMayoraMenor() {
		items = items.sortBy[poderDeAtaque].reverse

	}

	def poderDeDefensa() {
		resistencia + promedioDeResistenciaDeItems
	}

	def promedioDeResistenciaDeItems() {
		(items).fold(0.0, [acum, item|acum + item.getResistencia()]) / cantidadDeItems
	} // TODO cuando veamos excepciones ver de mejorar esto

	def cantidadDeItems() {
		if(items.size == 0) 1 else items.size
	}

	def cantidadDeBatallas() {
		victorias + derrotas + empates

	}

	def esSenior() {
		(aniosDeActividad > 4 && cantidadDeBatallas > 100) || (experiencia > 50)

	}

	def agregaEnemigo(SuperIndividuo enemigo) {
		if (enemigo != this)
			enemigos.add(enemigo)
	}

	def agregaAmigo(SuperIndividuo amigo) {

		amigos.add(amigo)
	}

	def pastaDeLider() {
		esSenior && (tasaVictoriasContraDerrotas > 10)
	}

	def tasaVictoriasContraDerrotas() {
		tasaVictorias - tasaDerrotas
	}

	def tasaVictorias() {
		(victorias * 100) / cantidadDeBatallas
	}

	def tasaDerrotas() {
		(derrotas * 100) / cantidadDeBatallas
	}

	def Double efectividadSuperIndividuo() {
		return tipo.efectividad(this)
	}

	override chancesDeContrarrestarAmenaza(Amenaza _amenaza) {
		efectividadSuperIndividuo / (efectividadSuperIndividuo + _amenaza.nivelDeAmenaza)
	}

	override costoDeCombatirUnaAmenaza(Amenaza amenaza) {
		((distanciaEntreBaseYAmenaza(amenaza) + amenaza.nivelDeAmenaza) / efectividadSuperIndividuo) *
			contieneEnemigos(amenaza)
	}

	def contieneEnemigos(Amenaza amenaza) {
		if (amenaza.contieneEnemigos(this))
			1.20
		else
			1

	}

	def distanciaEntreBaseYAmenaza(Amenaza _amenaza) {
		baseDeOperaciones.distance(_amenaza.lugar)
	}

	def tieneEnemigos() {
		enemigos.size > 0
	}

	def Boolean esAmigo(SuperIndividuo individuo) {
		amigos.contains(individuo)

	}

	def Boolean esEnemigo(SuperIndividuo enemigo) {
		enemigos.contains(enemigo)
	}

	override tieneValorBusqueda(String valor) {
		nombreYApellido.contains(valor) || alias.contains(valor)
	}

//	override actualizar(Entidad elemento) {
//		val superIndividuoActualizado = elemento as SuperIndividuo
//		amigos = superIndividuoActualizado.amigos
//
//	}
	override actualizar(Entidad elemento) {
		val superIndividuoActualizado = elemento as SuperIndividuo
//		amigos = superIndividuoActualizado.amigos
		this.nombre = superIndividuoActualizado.nombre
		this.apellido = superIndividuoActualizado.apellido
		this.victorias = superIndividuoActualizado.victorias
		this.derrotas = superIndividuoActualizado.derrotas
		this.empates = superIndividuoActualizado.empates
		this.fecha_ini = superIndividuoActualizado.fecha_ini
		this.fuerza = superIndividuoActualizado.fuerza
		this.resistencia = superIndividuoActualizado.resistencia
		this.tipo = superIndividuoActualizado.tipo
	}

	def cantidaDeamigosEnElEquipo(List<SuperIndividuo> lista) {
		lista.filter[x|this.esAmigo(x)].size
	}

}

@Accessors
class Superjson {
    String tipo
	String poderAtaque
	String efectividad
	String experiencia

}
@Accessors
class UsuarioAuxiliar {
    String id
	
	 List<String>amigos
	 List<String>enemigos

}