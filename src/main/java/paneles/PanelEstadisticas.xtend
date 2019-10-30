package paneles

import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class PanelEstadisticas {
	new(Panel panel){
		this.createEstadisticasSection(panel)
	}
	// Seccion Estadisticas
	def protected createEstadisticasSection(Panel panelEstadisticas) {
		new Label(panelEstadisticas).text = "Estadísticas:"

		new Label(panelEstadisticas).text = ""
		new Label(panelEstadisticas).text = "Super individuos registrados:"

		new Label(panelEstadisticas) => [
			value <=> "cantidadSuperIndividuos"
		]

		new Label(panelEstadisticas).text = "% Individuos senior:"

		new Label(panelEstadisticas) => [
			value <=> "porcentajeIndividuosSenior"
		]

		new Label(panelEstadisticas).text = "Super individuo más efectivo:"

		new Label(panelEstadisticas) => [
			value <=> "superIndividuoMasEfectivo"
		]
		new Label(panelEstadisticas).text = "Equipos registrados:"

		new Label(panelEstadisticas) => [
			value <=> "cantidadEquiposRegistrados"
		]

		new Label(panelEstadisticas).text = "% Equipos llenos:"

		new Label(panelEstadisticas) => [
			value <=> "porcentajeEquiposLlenos"
		]

		new Label(panelEstadisticas).text = "Equipo más poderoso:"

		new Label(panelEstadisticas) => [
			value <=> "equipoMasPoderoso"
		]
	}
}