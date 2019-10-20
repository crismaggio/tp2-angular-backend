package transformers

import org.uqbar.arena.bindings.ValueTransformer
import org.uqbar.commons.model.exceptions.UserException

class IntegerVacioONuloTransformer implements ValueTransformer<Integer, String> {

	String mensajeDeError

	new(String _mensajeDeError) {
		mensajeDeError = _mensajeDeError
	}

	override getModelType() {
		Integer
	}

	override getViewType() {
		String
	}

	override modelToView(Integer valueFromModel) {
		valueFromModel.toString
	}

	override viewToModel(String valueFromView) {
		if (valueFromView === null || valueFromView.isEmpty) {
			throw new UserException(mensajeDeError)
		}
		Integer.parseInt(valueFromView)
	} 	
}