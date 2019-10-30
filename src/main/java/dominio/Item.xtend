package dominio

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.Transactional

//@Accessors
//@Observable
//abstract class Item extends Entidad {
//
//	@Accessors var String nombre
//	@Accessors var Double precio
//
//	def double poderDeAtaque()
//
//	def double resistencia()
//
//	def boolean sobrenatural()
//
//	override tieneValorBusqueda(String valor) {
//		nombre.equals(valor)
//	}
//
//	def List<Item> getComponentes()
//
//	def aumentarPrecioDeItem() {}
//
//}
@Transactional
@Accessors
@Observable
class Item extends Entidad{
@Accessors var String nombre
	@Accessors var double precio
	@Accessors var double alcance
	@Accessors var double peso
	@Accessors var double danio
	var double resistencia
	@Accessors Boolean sobrenatural = false
	@Accessors var double porcentaje

	def aumentarAtaque() {
		if (sobrenatural)
			1.5
		else
			1
	}

	def hacerSobrenatural() {
		sobrenatural = !sobrenatural
	}

	def poderDeAtaque() {
		(danio + (alcance * 0.2) - (peso * 0.1) ) * aumentarAtaque
	}

	def sobrenatural() {
		sobrenatural
	}

//	def resistencia() {
//		resistencia
//	}
//
//	def setResistencia(double valorDeResistencia) {
//		resistencia = valorDeResistencia
//	}

	def aumentarPrecioDeItem() {
		precio = precio * porcentajeAAumentar
		precio

	}

	def porcentajeAAumentar() {
		(porcentaje / 100) + 1
	}

	override actualizar(Entidad elemento) {
		val itemActualizado = elemento as Item
		nombre = itemActualizado.nombre
		precio = itemActualizado.precio
		peso = itemActualizado.peso
		danio = itemActualizado.danio
		alcance = itemActualizado.alcance
		resistencia = itemActualizado.resistencia
		sobrenatural = itemActualizado.sobrenatural
	}

    def getComponentes() {
	}
	
	override tieneValorBusqueda(String valor) {
		nombre.equals(valor)
	}

}

@Accessors
class ItemCompuesto extends Item {
	List<Item> componentes = newArrayList

	override poderDeAtaque() {
		componentes.fold(0.0, [acum, item|acum + item.poderDeAtaque])
	}

	override sobrenatural() {
		componentes.exists[sobrenatural()]
	}

	def resistencia() {
		componentes.maxBy[getResistencia()].getResistencia()
	}

	override actualizar(Entidad elemento) {
		val itemActualizado = elemento as ItemCompuesto
		id = elemento.id
		nombre = itemActualizado.nombre
		componentes = itemActualizado.componentes

	}

}

@Accessors
class Mejora {

	var double alcance
	var double danio
	var double resistencia
	var double precio

	def mejorarItem(Item item) {
		item.alcance = item.alcance * calculadorDePorcentajeDeMejora(alcance)
		item.danio = item.danio * calculadorDePorcentajeDeMejora(danio)
		item.resistencia = item.getResistencia() * calculadorDePorcentajeDeMejora(resistencia)
	}

	def calculadorDePorcentajeDeMejora(double atributo) {
		(atributo / 100) + 1
	}

}