package dialogs

import dominio.Equipo
import java.util.List
import dominio.SuperIndividuo
import java.util.ArrayList
import dominio.RepoEquipo
import dominio.RepoIndividuo
import dominio.Villano
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class EquiposDialogModel extends CreacionEdicionDialogModel<Equipo> {
	List<SuperIndividuo> superIndividuosDisponibles
	List<SuperIndividuo> superIndividuosAsignados
	List<SuperIndividuo> posiblesLideres

	SuperIndividuo integrantePorRemover=new SuperIndividuo
	SuperIndividuo integrantePorAsignar =new SuperIndividuo

	SuperIndividuo liderEquipo

	List<SuperIndividuo> posiblesIntegrantes

	new(Equipo nuevo) {
		super()
		super.entidadClonada = new Equipo
		super.entidadSeleccionada = nuevo
		this.asignacionInicial
		this.getIndividuosDelEquipo
//	    this.integrantePorAsignar = new SuperIndividuo
//	    this.integrantePorRemover = new SuperIndividuo
	}

	new() {
		super.entidadClonada = new Equipo
		super.entidadSeleccionada = new Equipo
		this.asignacionInicial
		this.posiblesLideres = RepoIndividuo.instance.elementos
	}

	def asignacionInicial() {		
		posiblesIntegrantes = new ArrayList
		liderEquipo = new SuperIndividuo
//		this.integrantePorRemover = new SuperIndividuo
//		integrantePorAsignar = new SuperIndividuo
		this.superIndividuosAsignados = new ArrayList
		this.posiblesLideres = new ArrayList
		this.superIndividuosDisponibles = this.filtroDeIntegrantesNuevoEquipo()
	}

	override clonarBackup() {

		entidadSeleccionada.integrantes.removeAll(entidadSeleccionada.integrantes)

		entidadSeleccionada.integrantes.addAll(posiblesIntegrantes)

		posiblesIntegrantes.removeAll(entidadSeleccionada.integrantes)
	}

	override repo() {
		RepoEquipo.instance.elementos
	}

	def getIndividuosDelEquipo() {
		posiblesIntegrantes.removeAll(entidadSeleccionada.integrantes)
		posiblesIntegrantes.addAll(entidadSeleccionada.integrantes)

		superIndividuosAsignados = entidadSeleccionada.integrantes
		superIndividuosDisponibles = filtroDeIntegrantes

		posiblesLideres = entidadSeleccionada.integrantesConLider
		liderEquipo = entidadSeleccionada.lider
	}

	def filtroDeIntegrantes() {
		RepoIndividuo.instance.elementos.filter [ elemento |
			!entidadSeleccionada.integrantes.contains(elemento) && !(elemento.tipo instanceof Villano) &&
				entidadSeleccionada.lider != elemento
		].toList

	}

	def filtroDeIntegrantesNuevoEquipo() {
		RepoIndividuo.instance.elementos.filter[!(it.tipo instanceof Villano)].toList

	}

	def actualizarEquipo() {
		this.asignarLider
		this.asignarEquipos
		RepoEquipo.instance.update(entidadSeleccionada)
	}

	def asignarEquipos() {
		entidadSeleccionada.integrantes = superIndividuosAsignados.toList
		RepoEquipo.instance.update(entidadSeleccionada)
	}

	def eliminarEquipo() {
		RepoEquipo.instance.delete(entidadSeleccionada)
	}

	def agregarEquipo() {
		this.asignarLider
		entidadSeleccionada.integrantes.addAll(superIndividuosAsignados)
		RepoEquipo.instance.agregarElemento(entidadSeleccionada)
	}

	def asignarLider() {

		superIndividuosAsignados.remove(liderEquipo)
		entidadSeleccionada.lider = liderEquipo
	}

	def asignarIntegrante() {
		superIndividuosAsignados.add(integrantePorAsignar)

		superIndividuosDisponibles.remove(integrantePorAsignar)

//		posiblesLideres.add(integrantePorAsignar)

		
	}

	def removerIntegrante() {
		superIndividuosAsignados.remove(integrantePorRemover)
		superIndividuosDisponibles.add(integrantePorRemover)
//		posiblesLideres.add(integrantePorRemover)
	}
}
