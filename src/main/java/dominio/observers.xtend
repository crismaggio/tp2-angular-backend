package dominio

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class observer<T> {
	var T estado

	def cambioDeEstado(T newEstado) {

		estado = newEstado

	}

	def send(SuperIndividuo superIndividuo) {
		if (cambioEstado(superIndividuo)) {
			this.doSend(superIndividuo)

			this.cambioDeEstado(this.estadoActual(superIndividuo))
		}
	}

	def boolean cambioEstado(SuperIndividuo superIndividuo) {
		estado != this.estadoActual(superIndividuo)
	}

	def T estadoActual(SuperIndividuo superIndividuo)

	def void doSend(SuperIndividuo superIndividuo)

}

class NotificacionAumentarCantVictorias extends observer<Integer> {

	new(int estado) {
		this.estado = estado
	}

	override doSend(SuperIndividuo superIndividuo) {
		listaSuperIndividuosMenosVictorias(superIndividuo).forEach [
			it.recibirNotificacion(superIndividuo.nombreYApellido + " te  acaba  de superar en  victorias")
		]
	}

	def listaSuperIndividuosMenosVictorias(SuperIndividuo superIndividuo) {
		superIndividuo.amigos.filter[it.victorias < superIndividuo.victorias]

	}

	override estadoActual(SuperIndividuo superIndividuo) {
		superIndividuo.victorias
	}

}
//
//class NotificacionCambioDeTipo extends observer<TipoDeIndividuo> {
//
//	new(TipoDeIndividuo estado) {
//		this.estado = estado
//	}
//
//	override doSend(SuperIndividuo superIndividuo) {
//		listaIntegranteIndividouYamgos(superIndividuo).forEach [
//			if(it != superIndividuo) it.recibirNotificacion(superIndividuo.nombreYApellido + "Cambio su tipo")
//		]
//
//	}
//
//	def listaIntegranteIndividouYamgos(SuperIndividuo superIndividuo) {
//
//		superIndividuo.equipos.flatMap[it.integrantes + superIndividuo.amigos].toSet
//
//	}
//
//	override estadoActual(SuperIndividuo superIndividuo) {
//		superIndividuo.tipo
//	}
//
//}

class NotificacionllegoANDerrotas extends observer<Integer> {
	new(int estado) {
		this.estado = estado
	}

	override doSend(SuperIndividuo superIndividuo) {

		superIndividuo.enemigos.forEach [
			it.recibirNotificacion(
				superIndividuo.nombreYApellido + " llego a " + superIndividuo.determinadaCantDerrotas + "derrotas")
		]
	}

	def condicionCantidadDerrotas(SuperIndividuo superIndividuo) {
		superIndividuo.derrotas == estado

	}

	override estadoActual(SuperIndividuo superIndividuo) {
		superIndividuo.derrotas
	}

	override cambioDeEstado(Integer newEstado) {
	}

}