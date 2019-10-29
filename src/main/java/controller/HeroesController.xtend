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
			val List<SuperIndividuo> amigos = RepoIndividuo.instance.elementos.filter[!RepoIndividuo.instance.searchById(id).amigos.contains(it)].toList  

			ok(amigos.toJson)

		} catch (Exception e) {
			internalServerError(e.message)
		}
	}
	@Get("/superIndividuoLogin/:id/disponiblesEnemigos")
	def Result disponiblesEnemigos() {
		try {
			val List<SuperIndividuo> enemigos = RepoIndividuo.instance.elementos.filter[!RepoIndividuo.instance.searchById(id).enemigos.contains(it)].toList  

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
	

	@Delete("/usuarios/:id/equipos/:idEquipo")
	def Result eliminarAmigo() {
		try {
			val SuperIndividuo superIndividuoLogin = RepoIndividuo.instance.searchById(id)
			val Equipo equipo = RepoEquipo.instance.searchById(idEquipo)

			val eliminadoOk = superIndividuoLogin.equipos.remove(equipo)
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
			var  SuperIndividuofundador = RepoIndividuo.instance.searchById(equipotem.idfundador)
			var Equipo equipo = RepoEquipo.instance.searchById(equipotem.id)
 equipo.lider = SuperIndividuolider
  equipo.fundador  = SuperIndividuofundador
  print("xz<x<z")   
      equipo.nombre=equipotem.nombre
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
