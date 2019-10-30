package dialogs

import org.uqbar.arena.windows.WindowOwner
import viewModels.GestionSuperIndividuos
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Button

class EditarSuperIndividuo extends CrearSuperIndividuo {

	new(WindowOwner owner, SuperIndividuosDialogModel model) {
		super(owner, model)
		this.title = "Editar Superindividuo"
	}

	override aceptar() {
		this.modelObject.actualizarSuperIndividuo
		super.accept
	}

	override protected void addActions(Panel actions) {
		new Button(actions) => [
			caption = "Aceptar"
			onClick [|this.aceptar]
			disableOnError
		]

		new Button(actions) => [
			caption = "Cancelar"
			onClick [|
				this.cancel
			]
			setAsDefault
			bindVisibleToProperty("cancelar")
		]
	}

}
