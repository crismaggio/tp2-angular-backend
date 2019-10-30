package transformers

import org.uqbar.arena.bindings.ValueTransformer
import org.uqbar.commons.model.exceptions.UserException

class DoubleVacioONuloTransformer implements ValueTransformer<Double, String> {

	String mensajeDeError

	new(String _mensajeDeError) {
		mensajeDeError = _mensajeDeError
	}

	override getModelType() {
		Double
	}

	override getViewType() {
		String
	}

	override modelToView(Double valueFromModel) {
		valueFromModel.toString
	}

	override viewToModel(String valueFromView) {
		if (valueFromView === null || valueFromView.isEmpty) {
			throw new UserException(mensajeDeError)
		}
		Double.parseDouble(valueFromView)
	} 
	
}