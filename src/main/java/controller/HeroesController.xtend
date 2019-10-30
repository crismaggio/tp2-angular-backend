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

	@Get("/username/:alias")
	def Result usuario() {
		try {

			var Superjson usuario = new Superjson => [
				poderAtaque = RepoIndividuo.instance.search(alias).poderDeAtaque.toJson
				efectividad = RepoIndividuo.instance.search(alias).efectividadSuperIndividuo.toJson
				experiencia = RepoIndividuo.instance.search(alias).experiencia.toJson
			]

			ok(usuario.toJson)

		} catch (Exception e) {
			internalServerError(e.message)
		}
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

//@Get("/superIndividuoLogin/:id/amigos")
//	def Result amigos() {
//		try {
//			val List<SuperIndividuo> amigos = RepoIndividuo.instance.searchById(id).amigos
//
//			ok(amigos.toJson)
//
//		} catch (Exception e) {
//			internalServerError(e.message)
//		}
//	}
//	
	@Get("/superIndividuoLogin/:id/disponiblesAmigos")
	def Result disponiblesAmigos() {
		try {
			val List<SuperIndividuo> amigos = RepoIndividuo.instance.elementos.filter [
				!RepoIndividuo.instance.searchById(id).amigos.contains(it)
			].toList

			ok(amigos.toJson)

		} catch (Exception e) {
			internalServerError(e.message)
		}
	}

	@Get("/superIndividuoLogin/:id/disponiblesEnemigos")
	def Result disponiblesEnemigos() {
		try {
			val List<SuperIndividuo> enemigos = RepoIndividuo.instance.elementos.filter [
				!RepoIndividuo.instance.searchById(id).enemigos.contains(it)
			].toList

			ok(enemigos.toJson)

		} catch (Exception e) {
			internalServerError(e.message)
		}
	}

	@Get("/superIndividuoLogin/:id/enemigos")
	def Result enemigos() {
		try {
			val List<SuperIndividuo> amigos = RepoIndividuo.instance.searchById(id).enemigos

			ok(amigos.toJson)

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

//			val eliminadoOk = superIndividuoLogin.equipos.remove(equipo)
			return if(eliminadoOk) ok() else badRequest("No existe el equipo con identificador " + equipo.id)
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

	@Post("/usuarios/:id/equipos")
	def Result agregarEventoPropio(@Body String body) {

		
		var EquipoTemp equipotem = body.fromJson(EquipoTemp)
		var SuperIndividuolider = RepoIndividuo.instance.searchById(equipotem.idlider)
		var SuperIndividuofundador = RepoIndividuo.instance.searchById(equipotem.idfundador)
		var Equipo equipo = RepoEquipo.instance.searchById(equipotem.id)
		equipo.lider = SuperIndividuolider
		equipo.fundador = SuperIndividuofundador
		equipo.nombre = equipotem.nombre
		ok()
	}

	@Put("/superIndividuoLogin/:id/usuarioagregar/:idusuario")
	def Result agregarOsacar(@Body String body) {

		var String accione = body.fromJson(String)
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
