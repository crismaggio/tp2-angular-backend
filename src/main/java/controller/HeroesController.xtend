package controller

import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import dominio.RepoIndividuo
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.json.JSONUtils
import dominio.SuperIndividuo
import java.util.List
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.api.annotation.Delete

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
			val SuperIndividuo usuario= RepoIndividuo.instance.search(alias)
			
			if(usuario.password==password)
			ok(usuario.toJson)	
			
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}
	
	
	/** R E L A C I O N E S :  amigos - enemigos ======  Comienzo */
	
	@Get("/superIndividuoLogin/:id/amigos")
	def Result amigos() {
		try {
			val List<SuperIndividuo> amigos= RepoIndividuo.instance.searchById(id).amigos
			
			
			ok(amigos.toJson)	
			
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}	
	
	@Get("/superIndividuoLogin/:id/enemigos")
	def Result enemigos() {
		try {
			val List<SuperIndividuo> enemigos= RepoIndividuo.instance.searchById(id).enemigos
			
			ok(enemigos.toJson)
			
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}	
	
		@Get("/superIndividuoLogin/:id/amigosXid")
	def Result amigosXid() {
		try {
			val List<String> amigosXid= RepoIndividuo.instance.searchById(id).amigos.map(a|a.id)
			
			ok(amigosXid.toJson)
			
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}	
	
		@Get("/superIndividuoLogin/:id/enemigosXid")
	def Result enemigosXid() {
		try {
			val List<String> enemigosXid= RepoIndividuo.instance.searchById(id).enemigos.map(a|a.id)
			
			ok(enemigosXid.toJson)
			
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}
	
	@Post("/superIndividuoLogin/:id/amigos/:idAmigo")
	def agregarAmigo(){
		try {
			var SuperIndividuo logeado = RepoIndividuo.instance.search(id)
			val amigoAgregado = RepoIndividuo.instance.search(idAmigo)
			val agregadoOk = logeado.agregaAmigo(amigoAgregado)
			
			return if (logeado.amigos.contains(agregadoOk)) ok() else badRequest("No fue posible agregar el amigo con identificador " + amigoAgregado.id)
		} catch (Exception e) {
			badRequest(e.message)
		}
	}
	
	@Delete("/superIndividuoLogin/:id/amigos/:idAmigo")
	def eliminarAmigo(){
		try {
			var SuperIndividuo logeado = RepoIndividuo.instance.search(id)
			val amigoEliminado = RepoIndividuo.instance.search(idAmigo)
			val eliminadoOk = logeado.amigos.remove(amigoEliminado)
			
			return if (!logeado.amigos.contains(eliminadoOk)) ok() else badRequest("No fue posible eliminar el amigo con identificador " + amigoEliminado.id)
		} catch (Exception e) {
			badRequest(e.message)
		}
	}
	
	@Post("/superIndividuoLogin/:id/amigos/:idEnemigo")
	def agregarEnemigo(){
		try {
			var SuperIndividuo logeado = RepoIndividuo.instance.search(id)
			val enemigoAgregado = RepoIndividuo.instance.search(idEnemigo)
			val agregadoOk = logeado.agregaEnemigo(enemigoAgregado)
			
			return if (logeado.enemigos.contains(agregadoOk)) ok() else badRequest("No fue posible agregar el enemigo con identificador " + enemigoAgregado.id)
		} catch (Exception e) {
			badRequest(e.message)
		}
	}
	
	@Delete("/superIndividuoLogin/:id/amigos/:idAmigo")
	def eliminarEnemigo(){
		try {
			var SuperIndividuo logeado = RepoIndividuo.instance.search(id)
			val enemigoEliminado = RepoIndividuo.instance.search(idAmigo)
			val eliminadoOk = logeado.enemigos.remove(enemigoEliminado)
			
			return if (!logeado.enemigos.contains(eliminadoOk)) ok() else badRequest("No fue posible eliminar el enemigo con identificador " + enemigoEliminado.id)
		} catch (Exception e) {
			badRequest(e.message)
		}
	}
	
	/** R E L A C I O N E S :  amigos - enemigos ===========  Fin */
	
}