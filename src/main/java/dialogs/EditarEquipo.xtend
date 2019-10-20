package dialogs

import org.uqbar.arena.windows.WindowOwner

class EditarEquipo extends CrearEquipo {

	new(WindowOwner owner, EquiposDialogModel model) {
		super(owner, model)
		this.title = "Editar Equipo"
	}

	override cancel() {
		this.modelObject.clonarBackup()
		super.cancel()

	}

	override aceptar() {
		this.modelObject.actualizarEquipo
		accept
	}

}
