package dialogs

import org.uqbar.arena.windows.WindowOwner
import viewModels.GestionItems

class EditarItem extends CrearItem{
	
	new(WindowOwner owner, ItemsDialogModel model) {
		super(owner, model)
		this.title = "Editar Item"
	}
	
	override aceptar(){
		this.modelObject.actualizarItem
		super.accept
	}
	
}