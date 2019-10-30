package dominio

import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.XTRest
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils
import java.time.LocalDate
import org.uqbar.geodds.Point

@Controller
class AmenazasController {
	extension JSONUtils = new JSONUtils

	static RepoEquipo repoEquipo = new RepoEquipo
	static RepoIndividuo repoIndividuo = new RepoIndividuo

	@Get("/amenaza/:id/mejor_defensor")
	def Result buscarMejorDefensorDeAmenaza() {
		try {
			val amenaza = RepoAmenaza.instance.searchById(id)
			ok(quienEsElMejorParaResolverLaAmenaza(amenaza).toJson)
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}

	def static void main(String[] args) {
		new CargadorDeRepos(repoEquipo, repoIndividuo)
		XTRest.start(8081, AmenazasController)
	}

	def quienEsElMejorParaResolverLaAmenaza(Amenaza unaAmenaza) {
		if (elCostoDeSuperIdividuoEsMayorQueEquipo(unaAmenaza)) {
			mejorEquipoParaAmenaza(unaAmenaza)
		} else {
			mejorSuperIndividuoParaAmenaza(unaAmenaza)
		}
	}

	def elCostoDeSuperIdividuoEsMayorQueEquipo(Amenaza unaAmenaza) {
		(mejorSuperIndividuoParaAmenaza(unaAmenaza).costoDeCombatirUnaAmenaza(unaAmenaza) >
			mejorEquipoParaAmenaza(unaAmenaza).costoDeCombatirUnaAmenaza(unaAmenaza))
	}

	def mejorSuperIndividuoParaAmenaza(Amenaza unaAmenaza) {
		repoIndividuo.mejorDefensorDelRepo(unaAmenaza)
	}

	def mejorEquipoParaAmenaza(Amenaza unaAmenaza) {
		repoEquipo.mejorDefensorDelRepo(unaAmenaza)
	}

}

class CargadorDeRepos {
	RepoEquipo repoEquipo
	RepoIndividuo repoIndividuo

	SuperIndividuo superman = new SuperIndividuo() => [
		nombreYApellido = "Clark Kent"
		alias = "Superman"
		victorias = 2
		derrotas = 2
		empates = 4
		tipo = Heroe.getInstance
		resistencia = 4.0
		fecha_ini = LocalDate.now.minusYears(1)
		fuerza = 4.0
		baseDeOperaciones = new Point(4, 5)
	]

	SuperIndividuo batman = new SuperIndividuo() => [
		nombreYApellido = "Bruno Dias"
		alias = "Batman"
		victorias = 100
		derrotas = 4
		empates = 4
		tipo = Heroe.getInstance
		resistencia = 4.0
		fecha_ini = LocalDate.now.minusYears(219)
		fuerza = 4.0
		baseDeOperaciones = new Point(4, 4)
	]

	Equipo fantastico = new Equipo() => [

		nombre = "fantastico"
		lider = batman
	]

	DesastreNatural terremoto = new DesastreNatural() => [
		superficiAfectada = 10.0
		potencia = 10.0
		personasEnPeligro = 1
		lugar = (new Point(3, 4))

	]

	RepoAmenaza repoAmenaza = RepoAmenaza.instance

	new(RepoEquipo re, RepoIndividuo ri) {
		repoEquipo = re
		repoIndividuo = ri
		repoEquipo.agregarElemento(fantastico)
		repoIndividuo.agregarElemento(superman)
		repoAmenaza.agregarElemento(terremoto)

	}

}