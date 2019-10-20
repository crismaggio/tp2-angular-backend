package controller

import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import dominio.RepoIndividuo
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.json.JSONUtils
import dominio.SuperIndividuo

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
			ok( usuario.toJson)			
			
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}	
	
}