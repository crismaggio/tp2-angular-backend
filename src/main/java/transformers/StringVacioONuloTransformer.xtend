package transformers

import org.uqbar.arena.bindings.ValueTransformer
import org.uqbar.commons.model.exceptions.UserException

class StringVacioONuloTransformer implements ValueTransformer<String, String> {

	String mensajeDeError

	new(String _mensajeDeError) {
		mensajeDeError = _mensajeDeError
	}

	override getModelType() {
		String
	}

	override getViewType() {
		String
	}

	override modelToView(String valueFromModel) {
		valueFromModel
	}

	override viewToModel(String valueFromView) {
		if (valueFromView === null || valueFromView.isEmpty) {
			throw new UserException(mensajeDeError)
		}

		valueFromView
	}

}
