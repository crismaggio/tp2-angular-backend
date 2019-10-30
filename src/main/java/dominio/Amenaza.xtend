package dominio

import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
abstract class Amenaza extends Entidad {

	Point lugar
	int personasEnPeligro

	def Double magnitud()

	def nivelDeAmenaza() {
		personasEnPeligro * magnitud
	}

	def boolean contieneEnemigos(SuperIndividuo _individuo)

	def List<SuperIndividuo> involucrados()

}

@Accessors
class DesastreNatural extends Amenaza {

	double superficiAfectada
	double potencia

	override Double magnitud() {
		(potencia + superficiAfectada) * 10
	}

	override contieneEnemigos(SuperIndividuo _individuo) {
		false
	}

	override involucrados() {
	}

	override actualizar(Entidad elemento) {
	}

	override tieneValorBusqueda(String valor) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}

@Accessors
class Ataque extends Amenaza {

	val List<SuperIndividuo> involucrados = newArrayList

	def agregarInvolucrado(SuperIndividuo _involucrado) {
		if (_involucrado.tipo instanceof Villano)
			involucrados.add(_involucrado)
	}

	override contieneEnemigos(SuperIndividuo individuo) {
		involucrados.exists[involucrado|individuo.esEnemigo(involucrado)]
	}

	override magnitud() {
		involucrados.fold(0.0, [acum, involucrado|acum + involucrado.poderDeAtaque()])
	}

	override involucrados() {
		involucrados
	}

	override actualizar(Entidad elemento) {
	}

	override tieneValorBusqueda(String valor) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}