package viewModels

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import dominio.Equipo
import dominio.SuperIndividuo
import dominio.RepoIndividuo
import dominio.RepoEquipo
import java.util.List
import dominio.Villano
import java.util.ArrayList

@Accessors
@Observable
class GestionEquipos extends Gestion<Equipo> {
	
	override repo() {
		RepoEquipo.instance.elementos
	}
	
	def eliminarEquipo(){
		RepoEquipo.instance.delete(entidadSeleccionada)
	}
}