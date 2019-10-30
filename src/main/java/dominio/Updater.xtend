//package dominio
//
//import org.eclipse.xtend.lib.annotations.Accessors
//import org.json.simple.parser.JSONParser
//import org.json.simple.JSONArray
//import org.json.simple.JSONObject
//import java.util.List
//
//@Accessors
//abstract class Updater<T> {
//	val static PARSEADOR_JSON = new JSONParser
//
//	def String update()
//
//	def procesarJson() {
//		val String json = update
//		val listaElementosJson = PARSEADOR_JSON.parse(json) as JSONArray
//		val List<JSONObject> listadoElementosJson = listaElementosJson.map[it as JSONObject]
//		val List<T> listadoElementos = listadoElementosJson.map[procesarElementoJson]
//
//		procesarLista(listadoElementos)
//	}
//
//	def T procesarElementoJson(JSONObject elementoJason)
//
//	def void procesarLista(List<T> elementos)
//
//}
//
//@Accessors
//class ItemUpdater extends Updater<Item> {
//	var RepoItem repositorioObjetivo
//	ItemsRestService jsonArray = new ItemsRestService
//
//	override update() {
//		jsonArray.getItems
//	}
//
//	override procesarElementoJson(JSONObject elementoJason) {
//		if (validaSiEsItemCompuesto(elementoJason)) {
//			val listaDeComponentesDelJason = elementoJason.get("componentes") as List<String>
//			val componentesPosta = repositorioObjetivo.elementos.filter [ elemento |
//				listaDeComponentesDelJason.contains(elemento.id)
//			].toList
//
//			new ItemCompuesto() => [
//				id = elementoJason.get("id") as String
//				nombre = elementoJason.get("nombre") as String
//				componentes = componentesPosta
//			]
//		} else {
//			new Item() => [
//				id = elementoJason.get("id") as String
//				nombre = elementoJason.get("nombre") as String
//				alcance = elementoJason.get("alcance") as Double
//				peso = elementoJason.get("peso") as Double
//				danio = elementoJason.get("danio") as Double
//				resistencia = elementoJason.get("resistencia") as Double
//				precio = elementoJason.get("precio") as Double
//				sobrenatural = elementoJason.get("sobrenatural") as Boolean
//			]
//		}
//	}
//
//	def validaSiEsItemCompuesto(JSONObject elementoJason) {
//		elementoJason.containsKey("componentes")
//	}
//
//	override procesarLista(List<Item> elementos) {
//		repositorioObjetivo.procesarLista(elementos)
//	}
//}
//
//@Accessors
//class AmigosUpdater extends Updater<SuperIndividuo> {
//	var RepoIndividuo repositorioObjetivo
//	AmigosRestService jsonArray = new AmigosRestService
//
//	override update() {
//		jsonArray.getAmistades
//	}
//
//	override procesarElementoJson(JSONObject elementoJason) {
//		val listaDeAmigosDelJason = elementoJason.get("amigos") as List<String>
//		val amigosPosta = repositorioObjetivo.elementos.filter[elemento|listaDeAmigosDelJason.contains(elemento.id)].
//			toList
//		new SuperIndividuo() => [
//			id = elementoJason.get("id_individuo") as String
//			amigos = amigosPosta
//		]
//	}
//
//	override procesarLista(List<SuperIndividuo> elementos) {
//		repositorioObjetivo.procesarLista(elementos)
//	}
//
//}