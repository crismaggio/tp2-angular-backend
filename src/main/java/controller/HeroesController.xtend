package controller

import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import dominio.RepoIndividuo
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.json.JSONUtils
import dominio.SuperIndividuo
import java.util.List
import dominio.Equipo
import org.uqbar.xtrest.api.annotation.Delete
import dominio.RepoEquipo
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.api.annotation.Body
import dominio.EquipoTemp
import dominio.Superjson
import dominio.RepoItem
import org.uqbar.xtrest.api.annotation.Put
import dominio.UsuarioAuxiliar

@Controller
class HeroesController {

	extension JSONUtils = new JSONUtils

	@Get("/superIndividuos")
	def Result superIndividuos() {
		try {
			ok(RepoIndividuo.instance.elementos.toJson)
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}

	@Get("/poderAtaqueItem/:id")
	def Result poderAtaqueItem() {
		try {
			ok(RepoItem.instance.searchById(id).poderDeAtaque.toJson)
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}

	@Get("/username/:id")
	def Result usuario() {
		try {

			var Superjson usuario = new Superjson => [
				poderAtaque = RepoIndividuo.instance.searchById(id).poderDeAtaque.toJson
				efectividad = RepoIndividuo.instance.searchById(id).efectividadSuperIndividuo.toJson
				experiencia = RepoIndividuo.instance.searchById(id).experiencia.toJson
				tipo = RepoIndividuo.instance.searchById(id).tipo.descripcion
			]

			ok(usuario.toJson)

		} catch (Exception e) {
			internalServerError(e.message)
		}
	}

	@Get("/usuario/:id/items")
	def Result items() {

		val SuperIndividuo usuario = RepoIndividuo.instance.searchById(id)
		val items = usuario.items
		println(items)
		ok(items.toJson)

	}

	@Get("/usuario/:id")
	def Result usuarioid() {

		val SuperIndividuo usuario = RepoIndividuo.instance.searchById(id)

		ok(usuario.toJson)

	}

	@Get("/username/:alias/password/:password")
	def Result usuario() {
		try {
			val SuperIndividuo usuario = RepoIndividuo.instance.search(alias)

			if (usuario.password == password)
				ok(usuario.toJson)

		} catch (Exception e) {
			internalServerError(e.message)
		}
	}

	@Get("/superIndividuoLogin/:id/amigos")
	def Result amigos() {
		try {
			val List<SuperIndividuo> amigos = RepoIndividuo.instance.searchById(id).amigos

			ok(amigos.toJson)

		} catch (Exception e) {
			internalServerError(e.message)
		}
	}
	
	@Get("/superIndividuoLogin/:id/enemigos")
	def Result enemigos() {
		try {
			val List<SuperIndividuo> enemigos = RepoIndividuo.instance.searchById(id).enemigos

			ok(enemigos.toJson)

		} catch (Exception e) {
			internalServerError(e.message)
		}
	}

//@Get("/superIndividuoLogin/:id/amigos")
// def Result amigos() {
// try {
// val List<SuperIndividuo> amigos = RepoIndividuo.instance.searchById(id).amigos
//
// ok(amigos.toJson)
//
// } catch (Exception e) {
// internalServerError(e.message)
// }
// }
//
	@Get("/usuario/:id/usuarios")
	def Result usuarios() {
		try {
			val List<SuperIndividuo> usuarios = RepoIndividuo.instance.elementos.filter [
				!RepoIndividuo.instance.searchById(id).amigos.contains(it) &&
					it != RepoIndividuo.instance.searchById(id)
			].toList.filter[!RepoIndividuo.instance.searchById(id).enemigos.contains(it)].toList

			ok(usuarios.toJson)

		} catch (Exception e) {
			internalServerError(e.message)
		}
	}

	@Delete("/usuarios/:id/delete/:idAmigo/:accion")
	def Result deleteAmigo() {
		try {
			if (accion == "amigo") {
				val eliminadoOkk = RepoIndividuo.instance.searchById(id).amigos.remove(
					RepoIndividuo.instance.searchById(idAmigo))
			} else {
				val eliminadoOk = RepoIndividuo.instance.searchById(id).enemigos.remove(
					RepoIndividuo.instance.searchById(idAmigo))
			}
			return if(true) ok() else badRequest("No existe el amigo con identificador ")
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Delete("/usuarios/:id/salir/:idEquipo")
	def Result salirEquipo() {
		try {
			val SuperIndividuo superIndividuoLogin = RepoIndividuo.instance.searchById(id)
			val Equipo equipo = RepoEquipo.instance.searchById(idEquipo)
			equipo.integrantes.remove(superIndividuoLogin)
			val eliminadoOk = superIndividuoLogin.equipos.remove(equipo)
			return if(eliminadoOk) ok() else badRequest("No existe el equipo con identificador " + equipo.id)
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Delete("/deleteEquipo/:idEquipo")
	def Result deleteEquipo() {
		try {
			val Equipo equipo = RepoEquipo.instance.searchById(idEquipo)
			RepoIndividuo.instance.elementos.forEach[if(it.equipos.contains(equipo)) it.equipos.remove(equipo)]

			RepoEquipo.instance.elementos.remove(equipo)
			val eliminadoOk = equipo.integrantes.removeAll(equipo.integrantes)

// val eliminadoOk = superIndividuoLogin.equipos.remove(equipo)
			return if(eliminadoOk) ok() else badRequest("No existe el equipo con identificador " + equipo.id)
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Post("/usuarios/:id/equipos")
	def Result agregarEventoPropio(@Body String body) {

		var SuperIndividuousuariod = RepoIndividuo.instance.searchById(id)
		var EquipoTemp equipotem = body.fromJson(EquipoTemp)
		var SuperIndividuolider = RepoIndividuo.instance.searchById(equipotem.idlider)
		var SuperIndividuofundador = RepoIndividuo.instance.searchById(equipotem.idfundador)
		var Equipo equipo = RepoEquipo.instance.searchById(equipotem.id)
		equipo.lider = SuperIndividuolider
		equipo.fundador = SuperIndividuofundador
		print("xz<x<z")
		equipo.nombre = equipotem.nombre
		ok()
	}

//
	@Put("/usuario/:id/amigos")
	def Result actualizarAmigos(@Body String body) {
		println("lo que me viene del front-end: " + body)
		println(" ")
		val usuario = body.fromJson(UsuarioAuxiliar)

// var objectMapper = new ObjectMapper()
// var jsonRecibido = objectMapper.readTree(body)
//
// val amigosPorAgregar = jsonRecibido.get("amigos").toList
// println("amigosPorAgregar: " + usuario.amigos )
		var usuarioBackend = RepoIndividuo.instance.searchById(id)
		usuarioBackend.amigos.removeAll(usuarioBackend.amigos)
		println("usuarioBackend sin amigos: " + usuario.amigos)

		usuarioBackend.amigos.addAll(usuario.amigos.map[RepoIndividuo.instance.searchById(it)])
		println("usuarioBackend con amigos: " + usuario.amigos)
		ok()
	}

//	@Put("/usuario/:id/enemigos")
//	def Result actualizarEnemigos(@Body String body) {
//		println("lo que me viene del front-end: " + body)
//		println(" ")
//		val usuario = body.fromJson(UsuarioAuxiliar)
//
//		var usuarioBackend = RepoIndividuo.instance.searchById(id)
//		usuarioBackend.enemigos.removeAll(usuarioBackend.enemigos)
//		println("usuarioBackend sin enemigos: " + usuario.enemigos)
//
//		usuarioBackend.enemigos.addAll(usuario.enemigos.map[RepoIndividuo.instance.searchById(it)])
//		println("usuarioBackend con enemigos: " + usuario.enemigos)
//		ok()
//	}
//
// @Put("/usuario/:id/amigos")
// def Result agregarAmigo(@Body String body) {
// var individuo = body.fromJson(SuperIndividuo)
// var supelog = RepoIndividuo.instance.searchById(id)
// supelog.agregaAmigo(RepoIndividuo.instance.searchById(individuo.id))
// ok()
// }
	@Put("/superIndividuoLogin/:id/usuarioagregar/:idusuario")
	def Result agregarOsacar(@Body String body) {

		var String accione = body // .fromJson(String)
		if (accione == "amigo") {
			RepoIndividuo.instance.searchById(id).amigos.add(RepoIndividuo.instance.searchById(idusuario))
		} else {
			RepoIndividuo.instance.searchById(id).enemigos.add(RepoIndividuo.instance.searchById(idusuario))
		}
		print("xz<x<z")
		ok()
	}

	@Get("/superIndividuoLogin/:id/equipos")
	def Result equipos() {
		try {
			val List<Equipo> equipos = RepoIndividuo.instance.searchById(id).equipos

			ok(equipos.toJson)

		} catch (Exception e) {
			internalServerError(e.message)
		}
	}
}