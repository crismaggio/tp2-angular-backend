package bootstrap

import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import java.time.LocalDate
import org.uqbar.geodds.Point
import org.uqbar.commons.model.annotations.Observable
import dominio.SuperIndividuo
import dominio.Equipo
import dominio.Item
import dominio.RepoIndividuo
import dominio.RepoEquipo
import dominio.RepoItem
import dominio.Heroe
import dominio.Villano
import dominio.ItemCompuesto
import dominio.ItemComprado

@Observable
class HeroesBootstrap extends CollectionBasedBootstrap {

	override run() {
		var SuperIndividuo mordred
		var SuperIndividuo superman
		var SuperIndividuo robin
		var SuperIndividuo joker
		var SuperIndividuo batman
		var SuperIndividuo greenArrow
		var Equipo fantastico
		var Equipo oscuro
		var Item navaja
		var Item espada
		var Item granada
		var Item bazooka
		var ItemCompuesto espejoMagico
		var ItemComprado primerItem
		var ItemComprado segundoItem 
		var repositorioSuperIndividuos = RepoIndividuo.instance
		var repositorioItems = RepoItem.instance
      
		superman = new SuperIndividuo() => [
			nombre = "Clark"
			apellido = "Kent"
			password = "frutillita"
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

		robin = new SuperIndividuo() => [
			foto = "https://img-cdn.hipertextual.com/files/2014/10/robin-batman-v-superman.jpg?"
			nombre = "robin"
			apellido = ""
			password = "1234"
			nombreYApellido = nombre + apellido
			alias = "Robin"
			victorias = 2
			derrotas = 2
			empates = 4
			tipo = Heroe.getInstance
			resistencia = 6.0
			fecha_ini = LocalDate.now.minusYears(1)
			fuerza = 4.0
			baseDeOperaciones = new Point(4, 5)
		]
		mordred = new SuperIndividuo() => [
			foto = "https://i.pinimg.com/236x/77/61/4f/77614f7975ee7c2454825fa38318fded.jpg"
//			foto="https://i.pinimg.com/originals/db/e4/2d/dbe42dcefe9c722725afe79a67eba92c.jpg"
			nombre = "mordred"
			apellido = "pendragon"
			password = "1234"
			nombreYApellido = nombre + apellido
			alias = "Saber"
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
		fantastico.agregarAEquipo(mordred)
		oscuro.agregarAEquipo(batman)
		oscuro.agregarAEquipo(greenArrow)
		oscuro.agregarAEquipo(robin)
		repositorioSuperIndividuos.agregarElemento(mordred)
		repositorioSuperIndividuos.agregarElemento(superman)
		repositorioSuperIndividuos.agregarElemento(robin)
		repositorioSuperIndividuos.agregarElemento(joker)
		repositorioSuperIndividuos.agregarElemento(batman)
		repositorioSuperIndividuos.agregarElemento(greenArrow)

		navaja = new Item() => [
			nombre = "navaja"
			alcance = 2
			peso = 5
			precio = 250
			danio = 7
			resistencia = 2
			imagen = "https://images-na.ssl-images-amazon.com/images/I/61cFjZ9t0EL._SX466_.jpg"
		]
		bazooka = new Item() => [
			nombre = "bazooka"
			alcance = 10
			peso = 10
			precio = 15000
			danio = 30
			resistencia = 10
			imagen = "https://staticserver2.com/edu/static/pl/800/bazooka.jpg"
		]
		espada = new Item() => [
			nombre = "espada"
			alcance = 5
			peso = 10
			precio = 2500
			danio = 7
			resistencia = 2
			imagen = "https://images-na.ssl-images-amazon.com/images/I/61RDbIYwloL._SY355_.jpg"
		]
		granada = new Item() => [
			nombre = "granada"
			alcance = 20
			peso = 2
			precio = 900
			danio = 20
			resistencia = 1
			imagen = "https://upload.wikimedia.org/wikipedia/commons/0/0d/F1_grenade_DoD.jpg"
		]
		espejoMagico = new ItemCompuesto => [
			nombre = "espejoMagico"
			imagen = "https://decorativecrafts.com/wp-content/uploads/2015/06/389silo-x.jpg"
		]

		primerItem = new ItemComprado(espada,5)
		segundoItem = new ItemComprado(granada,8)
		
		mordred.itemsComprados.add(primerItem)
		mordred.itemsComprados.add(segundoItem)
		
//		mordred.listaItemPorTiempo.add(primerItem)
//		mordred.listaItemPorTiempo.add(segundoItem)
		mordred.listaItemPorTiempo.add(espada)
		mordred.listaItemPorTiempo.add(granada)		
		
		robin.agregarItemYOrdenaLista(navaja)
		robin.agregarItemYOrdenaLista(bazooka)
		mordred.agregarItemYOrdenaLista(bazooka)
		robin.agregaAmigo(batman)
		robin.agregaEnemigo(joker)
		repositorioItems.agregarElemento(navaja)
		repositorioItems.agregarElemento(bazooka)
//		repositorioItems.agregarElemento(espejoMagico)
		
		repositorioItems.agregarElemento(granada,22)
		repositorioItems.agregarElemento(espada,34)
		
//		repositorioItems.agregarElemento(navaja)
//		repositorioItems.agregarElemento(bazooka)
//		repositorioItems.agregarElemento(navaja)
//		repositorioItems.agregarElemento(bazooka)
//		repositorioItems.agregarElemento(navaja)
//		repositorioItems.agregarElemento(bazooka)
	}
}
