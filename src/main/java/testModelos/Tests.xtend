package testModelos

import java.time.LocalDate
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point
import java.util.Map
import java.util.HashMap
import dominio.SuperIndividuo
import dominio.Equipo
import dominio.Item
import dominio.ItemCompuesto
import dominio.RepoIndividuo
import dominio.RepoItem
import dominio.Heroe
import dominio.RepoEquipo
import dominio.Villano
import viewModels.MainViewViewModel
import viewModels.GestionItems
import viewModels.GestionEquipos
import viewModels.GestionSuperIndividuos
import dialogs.SuperIndividuosDialogModel
import dominio.Antiheroe

class Tests {
	var SuperIndividuo superman
	var SuperIndividuo robin
	var SuperIndividuo joker
	var SuperIndividuo batman
	var SuperIndividuo greenArrow
	var SuperIndividuo deadpool
	var Equipo fantastico
	var Equipo oscuro
	var Item navaja
	var Item bazooka
	var ItemCompuesto espejoMagico
	MainViewViewModel modeloVistaPrincipal = new MainViewViewModel
	GestionItems gestionItem = new GestionItems
	GestionEquipos gestionEquipo = new GestionEquipos
	GestionSuperIndividuos gestionSuperIndividuo = new GestionSuperIndividuos
	SuperIndividuosDialogModel superIndividuosModeloDelDialog = new SuperIndividuosDialogModel

	var repositorioSuperIndividuos = RepoIndividuo.instance
	var repositorioItems = RepoItem.instance

	@Before
	def void init() {
		superman = new SuperIndividuo() => [
			nombre = "Clark"
			apellido = "Kent"
			nombreYApellido = nombre + apellido
			alias = "Superman"
			victorias = 2
			derrotas = 2
			empates = 4
			tipo = Heroe.getInstance
			resistencia = 4.0
			fecha_ini = LocalDate.now.minusYears(1)
			fuerza = 5.0
			baseDeOperaciones = new Point(4, 5)
			fecha_ini = LocalDate.of(1900, 10, 10) // Para hacerlo Senior
		]
		espejoMagico = new ItemCompuesto => [nombre = "espejoMagico"]
		robin = new SuperIndividuo() => [
			nombre = "robin"
			apellido = ""
			nombreYApellido = nombre + apellido
			alias = "El chico maravilla"
			victorias = 2
			derrotas = 2
			empates = 4
			tipo = Heroe.getInstance
			resistencia = 6.0
			fecha_ini = LocalDate.now.minusYears(1)
			fuerza = 4.0
			baseDeOperaciones = new Point(4, 5)
		]

		joker = new SuperIndividuo() => [
			nombre = "El Joker"
			apellido = ""
			nombreYApellido = nombre + apellido
			alias = "Joker"
			victorias = 2
			derrotas = 2
			empates = 4
			dinero = 30.0
			tipo = Villano.getInstance
			resistencia = 4.0
			fecha_ini = LocalDate.now.minusYears(1)
			fuerza = 4.0
		]

		batman = new SuperIndividuo() => [
			nombre = "Bruno"
			apellido = "Dias"
			nombreYApellido = nombre + apellido
			alias = "Batman"
			tipo = Heroe.getInstance
			victorias = 100
			derrotas = 4
			empates = 4
			resistencia = 4.0
			fecha_ini = LocalDate.now.minusYears(219)
			fuerza = 4.0
			baseDeOperaciones = new Point(4, 4)
		]

		greenArrow = new SuperIndividuo() => [
			nombre = "Oliver"
			apellido = "Queen"
			nombreYApellido = nombre + apellido
			alias = "Arrow"
			tipo = Heroe.getInstance
			victorias = 80
			derrotas = 6
			empates = 4
			resistencia = 5.0
			fecha_ini = LocalDate.now.minusYears(219)
			fuerza = 4.0
			baseDeOperaciones = new Point(4, 4)
		]

		deadpool = new SuperIndividuo() => [
			nombreYApellido = "Wade Winston Wilson"
			alias = "Deadpool"
			victorias = 2
			derrotas = 2
			empates = 4
			tipo = Antiheroe.instance
			resistencia = 4.0
			fecha_ini = LocalDate.now.minusYears(1)
			fuerza = 4.0
			baseDeOperaciones = new Point(4, 5)
		]
		fantastico = new Equipo() => [

			nombre = "fantastico"

		]
		fantastico.setLider(superman)
		oscuro = new Equipo() => [
			nombre = "oscuro"
		]
		oscuro.setLider(batman)
		RepoEquipo.instance.agregarElemento(fantastico)
		RepoEquipo.instance.agregarElemento(oscuro)

		fantastico.agregarAEquipo(robin)
		oscuro.agregarAEquipo(batman)
		oscuro.agregarAEquipo(greenArrow)
		oscuro.agregarAEquipo(robin)

		repositorioSuperIndividuos.agregarElemento(superman)
		repositorioSuperIndividuos.agregarElemento(robin)
		repositorioSuperIndividuos.agregarElemento(joker)
		repositorioSuperIndividuos.agregarElemento(batman)
		repositorioSuperIndividuos.agregarElemento(greenArrow)

		navaja = new Item() => [
			nombre = "navaja"
			alcance = 2
			peso = 5
			danio = 7
			resistencia = 2
		]
		bazooka = new Item() => [
			nombre = "bazooka"
			alcance = 10
			peso = 10
			danio = 10
			resistencia = 10
		]
		repositorioItems.agregarElemento(navaja)
		repositorioItems.agregarElemento(bazooka)

		repositorioItems.agregarElemento(espejoMagico)
//		repositorioItems.agregarElemento(navaja)
//		repositorioItems.agregarElemento(bazooka)
//		repositorioItems.agregarElemento(navaja)
//		repositorioItems.agregarElemento(bazooka)
//		repositorioItems.agregarElemento(navaja)
//		repositorioItems.agregarElemento(bazooka)
	}

// Tests de modelo de la vista principal
	@Test
	def equipoMasPoderoso() {
		Assert.assertEquals(oscuro.nombre, modeloVistaPrincipal.equipoMasPoderoso)
	}

	@Test
	def superIndividuoMasEfectivo() {
		Assert.assertEquals(greenArrow.nombreYApellido, modeloVistaPrincipal.superIndividuoMasEfectivo)
	}

// Tests de modelo de gestion
	@Test
	def eliminarItem() {
		gestionItem.entidadSeleccionada = navaja
		gestionItem.eliminarItem()
		Assert.assertFalse(RepoItem.instance.elementos.contains(navaja))
	}

	@Test
	def eliminarEquipo() {
		gestionEquipo.entidadSeleccionada = oscuro
		gestionEquipo.eliminarEquipo()
		Assert.assertFalse(RepoEquipo.instance.elementos.contains(oscuro))
	}

	@Test
	def eliminarSuperIndividuo() {
		gestionSuperIndividuo.entidadSeleccionada = robin
		gestionSuperIndividuo.eliminarSuperIndividuo()
		Assert.assertFalse(RepoIndividuo.instance.elementos.contains(robin))
	}

// Tests de dialogs
	@Test
	def edicionSuperIndividuo() {
		superIndividuosModeloDelDialog.entidadSeleccionada = superman
		superIndividuosModeloDelDialog.entidadSeleccionada.nombre = "KalEl"
		superIndividuosModeloDelDialog.actualizarSuperIndividuo
		Assert.assertEquals("KalEl", RepoIndividuo.instance.searchById(superman.id).nombre)
	}

	@Test
	def creacionSuperIndividuo() {
		superIndividuosModeloDelDialog.entidadSeleccionada = deadpool
		superIndividuosModeloDelDialog.agregarSuperIndividuo
		Assert.assertTrue(RepoIndividuo.instance.elementos.contains(deadpool))
	}

}
