package test


import org.junit.Assert
import org.junit.Before
import org.junit.Test


import runnable.HeroesApplication
import bootstrap.HeroesBootstrap
import dominio.RepoIndividuo
import views.GestionIndividuoWindow
import viewModels.GestionSuperIndividuos
import dominio.SuperIndividuo
import dominio.Item
import dominio.ItemCompuesto
import dominio.Mejora
import dominio.Ataque
import dominio.Equipo
import dominio.RepoEquipo
import dominio.RepoItem
import dominio.Heroe
import java.time.LocalDate
import org.uqbar.geodds.Point
import dominio.Villano

class TestTP {

	var SuperIndividuo superman
		var SuperIndividuo robin
		var SuperIndividuo joker
		var SuperIndividuo batman
		var SuperIndividuo greenArrow
		var Equipo fantastico
		var Equipo oscuro
		var Item navaja
		var Item bazooka
		var ItemCompuesto espejoMagico
	

	  HeroesBootstrap        bootstrap=new  HeroesBootstrap
GestionSuperIndividuos gestionSuperIndi



	@Before
	
	def void init() {
	
	
		var repositorioSuperIndividuos = RepoIndividuo.instance
		var repositorioItems = RepoItem.instance

//		superman = new SuperIndividuo() => [
//			nombre = "Clark"
//			apellido = "Kent"
//			nombreYApellido = nombre + apellido
//			alias = "Superman"
//			victorias = 2
//			derrotas = 2
//			empates = 4
//			tipo = Heroe.getInstance
//			resistencia = 4.0
//			fecha_ini = LocalDate.now.minusYears(1)
//			fuerza = 5.0
//			baseDeOperaciones = new Point(4, 5)
//			fecha_ini = LocalDate.of(1900, 10, 10) // Para hacerlo Senior
//		]
//		espejoMagico = new ItemCompuesto => [nombre = "espejoMagico"]
//		robin = new SuperIndividuo() => [
//			nombre = "robin"
//			apellido = ""
//			nombreYApellido = nombre + apellido
//			alias = "El chico maravilla"
//			victorias = 2
//			derrotas = 2
//			empates = 4
//			tipo = Heroe.getInstance
//			resistencia = 6.0
//			fecha_ini = LocalDate.now.minusYears(1)
//			fuerza = 4.0
//			baseDeOperaciones = new Point(4, 5)
//		]
//
//		joker = new SuperIndividuo() => [
//			nombre = "El Joker"
//			apellido = ""
//			nombreYApellido = nombre + apellido
//			alias = "Joker"
//			victorias = 2
//			derrotas = 2
//			empates = 4
//			dinero = 30.0
//			tipo = Villano.getInstance
//			resistencia = 4.0
//			fecha_ini = LocalDate.now.minusYears(1)
//			fuerza = 4.0
//		]
//
//		batman = new SuperIndividuo() => [
//			nombre = "Bruno"
//			apellido = "Dias"
//			nombreYApellido = nombre + apellido
//			alias = "Batman"
//			tipo = Heroe.getInstance
//			victorias = 100
//			derrotas = 4
//			empates = 4
//			resistencia = 4.0
//			fecha_ini = LocalDate.now.minusYears(219)
//			fuerza = 4.0
//			baseDeOperaciones = new Point(4, 4)
//		]
//
//		greenArrow = new SuperIndividuo() => [
//			nombre = "Oliver"
//			apellido = "Queen"
//			nombreYApellido = nombre + apellido
//			alias = "Arrow"
//			tipo = Heroe.getInstance
//			victorias = 80
//			derrotas = 6
//			empates = 4
//			resistencia = 5.0
//			fecha_ini = LocalDate.now.minusYears(219)
//			fuerza = 4.0
//			baseDeOperaciones = new Point(4, 4)
//		]
//
//		fantastico = new Equipo() => [
//
//			nombre = "fantastico"
//
//		]
//		fantastico.setLider(superman)
//		oscuro = new Equipo() => [
//			nombre = "oscuro"
//		]
//		oscuro.setLider(batman)
//		RepoEquipo.instance.agregarElemento(fantastico)
//		RepoEquipo.instance.agregarElemento(oscuro)
//
//		fantastico.agregarAEquipo(robin)
//		oscuro.agregarAEquipo(batman)
//		oscuro.agregarAEquipo(greenArrow)
//		oscuro.agregarAEquipo(robin)
//
//		repositorioSuperIndividuos.agregarElemento(superman)
//		repositorioSuperIndividuos.agregarElemento(robin)
//		repositorioSuperIndividuos.agregarElemento(joker)
//		repositorioSuperIndividuos.agregarElemento(batman)
//		repositorioSuperIndividuos.agregarElemento(greenArrow)
//
//		navaja = new Item() => [
//			nombre = "navaja"
//			alcance = 2
//			peso = 5
//			danio = 7
//			resistencia = 2
//		]
//		bazooka = new Item() => [
//			nombre = "bazooka"
//			alcance = 10
//			peso = 10
//			danio = 10
//			resistencia = 10
//		]
		repositorioItems.agregarElemento(navaja)
		repositorioItems.agregarElemento(bazooka)

		repositorioItems.agregarElemento(espejoMagico)

}
//	def void init() {
//	
//		val	HeroesApplication adas= new HeroesApplication(bootstrap)
//
//}
	@Test
	def bustrapIntancia() {
 bootstrap.run
		Assert.assertEquals( RepoIndividuo.instance.elementos.size, 5)
//		Assert.assertEquals(true, superman.items.contains(bazooka))

	}
@Test
	def seEliminaElementosIndividuos() {
		bootstrap.run
val gestionSuperIndi= new GestionSuperIndividuos
	gestionSuperIndi.entidadSeleccionada = superman
gestionSuperIndi.eliminarSuperIndividuo()
		Assert.assertEquals( RepoIndividuo.instance.elementos.size, 4)
//		Assert.assertEquals(true, superman.items.contains(bazooka))

	}
@Test
	def seCreaUnelmento() {
		bootstrap.run
val gestionSuperIndi= new GestionSuperIndividuos
	gestionSuperIndi.agregarSuperIndividuo
gestionSuperIndi.eliminarSuperIndividuo()
		Assert.assertEquals( RepoIndividuo.instance.elementos.size, 6)
//		Assert.assertEquals(true, superman.items.contains(bazooka))

	}


}
