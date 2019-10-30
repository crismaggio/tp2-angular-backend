//package testsDominio
//
//import java.time.LocalDate
//import org.junit.Assert
//import org.junit.Before
//import org.junit.Test
//import org.uqbar.geodds.Point
//import static org.mockito.Mockito.*
//import org.json.simple.JSONObject
//import java.util.Map
//import java.util.HashMap
//import org.json.simple.JSONArray
//import dominio.SuperIndividuo
//
//class TestTP {
//	SuperIndividuo superman
//	SuperIndividuo batman
//	SuperIndividuo joker
//	SuperIndividuo jo
//	SuperIndividuo deadpool
//	SuperIndividuo robin
//	ItemSimple navaja
//	ItemSimple pistola
//	ItemSimple bazooka
//	ItemCompuesto espejoMagico
//	Mejora mejora
//	Ataque bomba
//	DesastreNatural terremoto
//	Equipo fantastico
//	Equipo laLigaDeLosMancos
//	RepoIndividuo repoSuperIndividuo
//	RepoEquipo repoEquipo
//	RepoItem repoItem
//	ItemUpdater actualizadorDeItems
//	AmigosUpdater actualizadorDeAmigos
//	JSONObject batarang
//	JSONObject baticinturon
//	JSONObject sprayAntiTiburones
//	JSONObject idAmigoJson
//	JSONArray listaAmigosJson
//	String listaItemsString
//	String listaAmigosString1
//	JSONArray componentesBati
//	JSONArray amigosDelBatiJson
//	JSONArray listaItemsJson
//	EliminadorDeVillano eliminadorDeVillanos
//	RegalarItem regalaritem
//	InflacionDeItem inflacion
//
////	InflacionDeItem inflacion
////	Definicion de Mocks
//	var servicioActualizacionMockItems = mock(ItemsRestService)
//	var servicioActualizacionMockAmigos = mock(AmigosRestService)
//	Villano villano = Villano.instance
//
////	Fin de definicion de Mocks
//	@Before
//	def void init() {
//		// Cambio a Singleton: Se cambia 'new' por '.instace'
//		repoSuperIndividuo = RepoIndividuo.instance
//		repoEquipo = RepoEquipo.instance
//		repoItem = RepoItem.instance
//
//		superman = new SuperIndividuo() => [
//			nombreYApellido = "Clark Kent"
//			alias = "Superman"
//			victorias = 2
//			derrotas = 2
//			empates = 4
//			tipo = Heroe.getInstance
//			resistencia = 4.0
//			fecha_ini = LocalDate.now.minusYears(1)
//			fuerza = 4.0
//			baseDeOperaciones = new Point(4, 5)
//		]
//		robin = new SuperIndividuo() => [
//			nombreYApellido = "robin"
//			alias = "robin"
//			victorias = 2
//			derrotas = 2
//			empates = 4
//			tipo = Heroe.getInstance
//			resistencia = 4.0
//			fecha_ini = LocalDate.now.minusYears(1)
//			fuerza = 4.0
//			baseDeOperaciones = new Point(4, 5)
//		]
//
//		joker = new SuperIndividuo() => [
//			nombreYApellido = "El Joker"
//			alias = "Joker"
//			victorias = 2
//			derrotas = 2
//			empates = 4
//			dinero = 30.0
//			tipo = Villano.getInstance
//			resistencia = 4.0
//			fecha_ini = LocalDate.now.minusYears(1)
//			fuerza = 4.0
//		]
//		jo = new SuperIndividuo() => [
//			nombreYApellido = "El Joker"
//			alias = "Joker"
//			victorias = 2
//			derrotas = 2
//			empates = 4
//			dinero = 30.0
//			tipo = Villano.getInstance
//			resistencia = 4.0
//			fecha_ini = LocalDate.now.minusYears(1)
//			fuerza = 4.0
//		]
//		batman = new SuperIndividuo() => [
//			nombreYApellido = "Bruno Dias"
//			alias = "Batman"
//			tipo = Heroe.getInstance
//			victorias = 100
//			derrotas = 4
//			empates = 4
//			resistencia = 4.0
//			fecha_ini = LocalDate.now.minusYears(219)
//			fuerza = 4.0
//			baseDeOperaciones = new Point(4, 4)
//		]
//
//		deadpool = new SuperIndividuo() => [
//			nombreYApellido = "Wade Winston Wilson"
//			alias = "Deadpool"
//			victorias = 2
//			derrotas = 2
//			empates = 4
//			tipo = Antiheroe.instance
//			resistencia = 4.0
//			fecha_ini = LocalDate.now.minusYears(1)
//			fuerza = 4.0
//			baseDeOperaciones = new Point(4, 5)
//		]
//
//		navaja = new ItemSimple() => [
//			nombre = "navaja"
//			alcance = 2
//			peso = 5
//			danio = 7
//			resistencia = 2
//		]
//		pistola = new ItemSimple() => [
//			nombre = "pistola"
//			alcance = 6
//			peso = 3
//			danio = 18
//			resistencia = 2
//		]
//		bazooka = new ItemSimple() => [
//			nombre = "bazooka"
//			alcance = 2
//			peso = 66
//			danio = 10
//			resistencia = 3
//		]
//		espejoMagico = new ItemCompuesto() => [
//			nombre = "baticinturon"
//			componentes = #[bazooka, navaja]
//		]
//
//		mejora = new Mejora() => [
//
//			alcance = 20
//			precio = 2
//			danio = 50
//			resistencia = 0
//
//		]
//
//		bomba = new Ataque() => [
//
//			lugar = new Point(3, 4)
//			personasEnPeligro = 500
//			agregarInvolucrado(joker)
//		]
//
//		terremoto = new DesastreNatural() => [
//
//			superficiAfectada = 10.0
//			potencia = 10.0
//			lugar = new Point(3, 4)
//		]
//
//		fantastico = new Equipo() => [
//
//			nombre = "fantastico"
//			lider = batman
//		]
//
//		laLigaDeLosMancos = new Equipo() => [
//
//			nombre = "La liga de los mancos"
//			lider = deadpool
//		]
//
//		actualizadorDeItems = new ItemUpdater() => [
//			repositorioObjetivo = repoItem
//		]
//
//		actualizadorDeAmigos = new AmigosUpdater() => [
//			repositorioObjetivo = repoSuperIndividuo
//		]
//
//		eliminadorDeVillanos = new EliminadorDeVillano(repoEquipo) => []
//
//		regalaritem = new RegalarItem(repoSuperIndividuo, 1, bazooka) => [
//			repo = repoSuperIndividuo
//			añosparaElregalo = 1
//			item = bazooka
//
//		]
//		batarang = new JSONObject() => [
//			put("id", "I1")
//			put("nombre", "Batarang")
//			put("alcance", 100.0)
//			put("peso", 1.0)
//			put("danio", 50.0)
//			put("resistencia", 0.0)
//			put("precio", 800.0)
//			put("sobrenatural", false)
//		]
//
//		sprayAntiTiburones = new JSONObject() => [
//			put("id", "I2")
//			put("nombre", "Spray anti-tiburones")
//			put("alcance", 10.0)
//			put("peso", 1.5)
//			put("danio", 25.0)
//			put("resistencia", 30.0)
//			put("precio", 400.0)
//			put("sobrenatural", false)
//		]
//		
//		inflacion = new InflacionDeItem(repoItem)
//
//		componentesBati = new JSONArray()
//		componentesBati.add("I1")
//		componentesBati.add("I2")
//
//		baticinturon = new JSONObject()
//		baticinturon.put("id", "I3")
//		baticinturon.put("nombre", "Baticinturon")
//		baticinturon.put("componentes", componentesBati)
//
//		listaItemsJson = new JSONArray()
//		listaItemsJson.add(batarang)
//		listaItemsJson.add(sprayAntiTiburones)
//		listaItemsJson.add(baticinturon)
//
//		listaItemsString = listaItemsJson.toString
//
//		amigosDelBatiJson = new JSONArray()
//		amigosDelBatiJson.add("SI5")
//		amigosDelBatiJson.add("SI1")
//
//		idAmigoJson = new JSONObject()
//		idAmigoJson.put("id_individuo", "SI4")
//		idAmigoJson.put("amigos", amigosDelBatiJson)
//
//		listaAmigosJson = new JSONArray()
//		listaAmigosJson.add(idAmigoJson)
//
//		listaAmigosString1 = listaAmigosJson.toString
//	}
//
//	@Test
//	def procesoRegalarItem() {
//		repoSuperIndividuo.agregarElemento(robin)
//		repoSuperIndividuo.agregarElemento(batman)
//		repoSuperIndividuo.agregarElemento(joker)
//		repoSuperIndividuo.agregarElemento(deadpool)
//		repoSuperIndividuo.agregarElemento(superman)
//		regalaritem.ejecutar
//		Assert.assertEquals(false, batman.items.contains(bazooka))
//		Assert.assertEquals(true, superman.items.contains(bazooka))
//
//	}
//
//	@Test
//	def notifiCAcionDerrotas() {
//
//		robin.agregaEnemigo(joker)
//		robin.agregaEnemigo(jo)
//		robin.agregarObs(new NotificacionllegoANDerrotas(robin.derrotas))
//		robin.aumentarDerotas(3)
//
//		Assert.assertEquals(jo.notificaciones.get(0), joker.notificaciones.get(0))
//
//	}
//
//	@Test
//	def notifiCAcionCambioDetipo() {
//
//		robin.agregaAmigo(superman)
//		fantastico.agregarAEquipo(robin)
//		fantastico.agregarAEquipo(superman)
//		robin.agregarObs(new NotificacionCambioDeTipo(robin.tipo))
//		robin.tipo(Villano.instance)
//
//		Assert.assertEquals(superman.notificaciones.get(0), superman.notificaciones.get(0))
//
//	}
//
//	@Test
//	def notifiCAcionVictorias() {
//
//		robin.agregaAmigo(batman)
//		robin.agregaAmigo(superman)
//		robin.agregarObs(new NotificacionAumentarCantVictorias(robin.victorias))
//		robin.aumentarVictorias(200)
//
//		Assert.assertEquals(superman.notificaciones.get(0), batman.notificaciones.get(0))
//
//	}
//
//	@Test
//	def AniosDeExperienciaDeSuperman() {
//
//		Assert.assertEquals(1, superman.aniosDeActividad)
//	}
//
//	@Test
//	def supermanTiene4DeExperiencia() {
//		Assert.assertEquals(4, superman.experiencia)
//	}
//
//	@Test
//	def cualEsELPoderDeNavaja() {
//		Assert.assertEquals(6.9, navaja.poderDeAtaque, 0.1)
//	}
//
//	@Test
//	def cambioNaturalezaDeItem() {
//		Assert.assertTrue(navaja.hacerSobrenatural)
//	}
//
//	@Test
//	def elPoderDeAtaqueEsMayorPorSerSobreNatural() {
//		Assert.assertEquals(6.9, navaja.poderDeAtaque, 0.01)
//		navaja.hacerSobrenatural
//		Assert.assertEquals(10.35, navaja.poderDeAtaque, 0.01)
//	}
//
//	@Test
//	def laSumaPorcentualRestanteEs2coma14() {
//		superman.agregarItemYOrdenaLista(navaja)
//		superman.agregarItemYOrdenaLista(pistola)
//		superman.agregarItemYOrdenaLista(bazooka)
//		Assert.assertEquals(2.14, superman.sumaPorcentajeItemsRestantes(), 0.01)
//	}
//
//	@Test
//	def agregoLaNavajayPistolaASuperman() {
//		superman.agregarItemYOrdenaLista(bazooka)
//		superman.agregarItemYOrdenaLista(pistola)
//		superman.agregarItemYOrdenaLista(navaja)
//		Assert.assertEquals(#[pistola, navaja, bazooka], superman.items)
//	}
//
//	@Test
//	def poderAtaqueDeSuperman() {
//		superman.agregarItemYOrdenaLista(pistola)
//		superman.agregarItemYOrdenaLista(bazooka)
//		superman.agregarItemYOrdenaLista(navaja)
//		Assert.assertEquals(25.04, superman.poderDeAtaque(), 0.1)
//	}
//
//	@Test
//	def itemMasPoderosoDeSuperman() {
//		superman.agregarItemYOrdenaLista(bazooka)
//		superman.agregarItemYOrdenaLista(pistola)
//		superman.agregarItemYOrdenaLista(navaja)
//		Assert.assertEquals(pistola, superman.ItemMasPoderoso())
//	}
//
//	@Test
//	def PoderDeDefensaDeSuperman() {
//		superman.agregarItemYOrdenaLista(pistola)
//		superman.agregarItemYOrdenaLista(navaja)
//		Assert.assertEquals(6.0, superman.poderDeDefensa(), 0.1)
//	}
//
//	@Test
//	def supermanEsSenior() {
//		Assert.assertFalse(superman.esSenior())
//
//	}
//
//	@Test
//	def batmanEsSenior() {
//		Assert.assertTrue(batman.esSenior())
//
//	}
//
//	@Test
//	def agregaUnEnemigoYVeSiLoTiene() {
//		superman.agregaEnemigo(batman)
//		Assert.assertEquals(#[batman], superman.enemigos)
//	}
//
//	@Test
//	def supermanTieneTasaDeVictoriasDe25porciento() {
//		Assert.assertEquals(25, superman.tasaVictorias)
//	}
//
//	@Test
//	def supermanTieneTasaDeDerrotasDe25porciento() {
//		Assert.assertEquals(25, superman.tasaDerrotas)
//	}
//
//	@Test
//	def supermanNoTienePastaDeLider() {
//		Assert.assertFalse(superman.pastaDeLider)
//	}
//
//	@Test
//	def batmanTienePastaDeLider() {
//		Assert.assertTrue(batman.pastaDeLider)
//	}
//
//	@Test
//	def experienciadebatman() {
//		Assert.assertEquals(272, batman.experiencia(), 0.01)
//
//	}
//
//	@Test
//	def efectividadSuperman() {
//		superman.agregarItemYOrdenaLista(pistola)
//		Assert.assertEquals(11.56, superman.efectividadSuperIndividuo, 0.01)
//
//	}
//
//	@Test
//	def efectividadBatman() {
//		batman.agregarItemYOrdenaLista(navaja)
//		Assert.assertEquals(461.85, batman.efectividadSuperIndividuo, 0.01)
//
//	}
//
//	@Test
//	def efectiVillano() {
//		joker.agregarItemYOrdenaLista(navaja)
//		Assert.assertEquals(27.8, joker.efectividadSuperIndividuo, 0.01)
//
//	}
//
//	@Test
//	def efectividadAntiheroeDeadpool() {
//		deadpool.agregarItemYOrdenaLista(navaja)
//		Assert.assertEquals(
//			4.47,
//			deadpool.efectividadSuperIndividuo,
//			0.01
//		)
//	}
//
//	@Test
//	def mejorandoItem() {
//		joker.agregarItemYOrdenaLista(navaja)
//		joker.comprarMejora(mejora)
//		joker.usarMejora(mejora, navaja)
//		Assert.assertEquals(10.48, navaja.poderDeAtaque, 0.1)
//
//	}
//
//	@Test
//	def jokercomprcomprarMejorayUsa() {
//		joker.agregarItemYOrdenaLista(navaja)
//		joker.comprarMejora(mejora)
//		joker.usarMejora(mejora, navaja)
//		Assert.assertEquals(28.00, joker.dinero, 0.1)
//
//	}
//
//	@Test
//	def magnitudDeAtaqueBombaEs() {
//		joker.agregarItemYOrdenaLista(pistola)
//		Assert.assertEquals(22.9, bomba.magnitud, 0.01)
//	}
//
//	@Test
//	def laBombaTieneAlJokerComoEnemigoDeBatman() {
//		batman.agregaEnemigo(joker)
//		Assert.assertTrue(bomba.contieneEnemigos(batman))
//	}
//
//	@Test
//	def costoDeCombatirAmenazaConEnemigo() {
//		batman.agregaEnemigo(joker)
//		batman.agregarItemYOrdenaLista(pistola)
//		joker.agregarItemYOrdenaLista(pistola)
//		Assert.assertEquals(17.54, batman.costoDeCombatirUnaAmenaza(bomba), 0.01)
//	}
//
//	@Test
//	def terremotoTiene100DeMagnitud() {
//		Assert.assertEquals(200, terremoto.magnitud, 0.01)
//	}
//
//	@Test
//	def siAgregoUnVillanoQuedaIgualElEquipo() {
//
//		fantastico.agregarAEquipo(joker)
//		Assert.assertEquals(#[], fantastico.integrantes)
//	}
//
//	@Test
//	def siAgregoUnNoVillanoSeAgrega() {
//		fantastico.agregarAEquipo(superman)
//		Assert.assertEquals(#[superman], fantastico.integrantes)
//	}
//
//	@Test
//	def siTengo10IntegrantesNoPuedoAgregarMas() {
//		fantastico.agregarAEquipo(superman)
//		fantastico.agregarAEquipo(superman)
//		fantastico.agregarAEquipo(superman)
//		fantastico.agregarAEquipo(superman)
//		fantastico.agregarAEquipo(superman)
//		fantastico.agregarAEquipo(superman)
//		fantastico.agregarAEquipo(superman)
//		fantastico.agregarAEquipo(superman)
//		fantastico.agregarAEquipo(superman) // este es el 10
//		fantastico.agregarAEquipo(superman) // no lo agrega
//		Assert.assertEquals(10, fantastico.cantidadDeIntegrantesConLider)
//	}
//
//	@Test
//	def batmanDeLiderYSupermanEnEquipoPoderDe220() {
//		fantastico.agregarAEquipo(superman)
//
//		Assert.assertEquals(220.4, fantastico.poderGrupal, 0.01)
//	}
//
//	@Test
//	def fantasticoIntegrantesConLider() {
//		fantastico.agregarAEquipo(superman)
//
//		Assert.assertEquals(#[superman, batman], fantastico.integrantesConLider)
//	}
//
//	@Test
//	def cantidadDeEnemigosInvolucradosEnLaAmenazaEnBonba() {
//		fantastico.agregarAEquipo(superman)
//		batman.agregaEnemigo(joker)
//		batman.agregaEnemigo(jo)
//		superman.agregaEnemigo(joker)
//		Assert.assertEquals(2, fantastico.cantidadDeEnemigosInvolucradosEnLaAmenaza(bomba), 0.1)
//	}
//
//	@Test
//	def supermanNoPuedeSerEnemigoDeSiMismo() {
//		superman.agregaEnemigo(superman)
//		Assert.assertEquals(#[], superman.enemigos)
//	}
//
//	@Test
//	def batmanConsideraDeAmigoASuperman() {
//		batman.agregaAmigo(superman)
//		Assert.assertTrue(batman.esAmigo(superman))
//	}
//
//	@Test
//	def batmanNoConsideraDeAmigoASuperman() {
//		Assert.assertFalse(batman.esAmigo(superman))
//	}
//
//	@Test
//	def cantidadDeAmistadesEnComunEnEquipoCon2Amistades() {
//		fantastico.agregarAEquipo(robin)
//		batman.agregaAmigo(robin)
//		robin.agregaAmigo(batman)
//		Assert.assertEquals(2, fantastico.cantidadDeAmistadesEnComun(), 0.1)
//	}
//
//	@Test
//	def siBatmanEsAmigoDeSupermanQueNoEstaEnElEquipoNoSumaAmistades() {
//		batman.agregaAmigo(superman)
//		Assert.assertEquals(0, fantastico.cantidadDeAmistadesEnComun(), 0.1)
//	}
//
//	@Test
//	def con2AmistadesEnElEquipoMeDa10PorcDeAdicionalPorAmistad() {
//		fantastico.agregarAEquipo(robin)
//		batman.agregaAmigo(robin)
//		robin.agregaAmigo(batman)
//		Assert.assertEquals(1.10, fantastico.porcentajeAdicionalPorAmistad(), 0.1)
//	}
//
//	@Test
//	def poderGrupal() {
//		fantastico.agregarAEquipo(robin)
//		batman.agregaAmigo(robin)
//		robin.agregaAmigo(batman)
//		Assert.assertEquals(242.44, fantastico.poderGrupal(), 0.1)
//	}
//
//	@Test
//	def itemCompuestoTieneUnSobrenaturalYEsSobrenatural() {
//		navaja.hacerSobrenatural
//		Assert.assertTrue(espejoMagico.sobrenatural)
//	}
//
//	@Test
//	def itemCompuestoNoTieneUnSobrenaturalYNoEsSobrenatural() {
//		Assert.assertFalse(espejoMagico.sobrenatural)
//	}
//
//	@Test
//	def laResistenciaDelBaticinturonEsIgualALaDeLaBazooka() {
//		Assert.assertEquals(3.0, espejoMagico.resistencia, 0.01)
//	}
//
//	@Test
//	def elPoderDelBaticinturonEsLaSumaDelPoderDeLaBazookaYLaNavaja() {
//		Assert.assertEquals(10.7, espejoMagico.poderDeAtaque, 0.01)
//	}
//
//	@Test
//	def testeoDelete() {
//		repoSuperIndividuo.agregarElemento(robin)
//		repoSuperIndividuo.agregarElemento(batman)
//		repoSuperIndividuo.delete(batman)
//		Assert.assertEquals(#[robin], repoSuperIndividuo.elementos)
//	}
//
//	@Test
//	def siAgrego2IndividuosAumentaElId() {
//		repoSuperIndividuo.agregarElemento(robin)
//		repoSuperIndividuo.agregarElemento(batman)
//		Assert.assertEquals("SI2", batman.id)
//	}
//
//	@Test
//	def searchByIdSuperIndividuo() {
//		repoSuperIndividuo.agregarElemento(robin)
//		repoSuperIndividuo.agregarElemento(batman)
//		Assert.assertEquals(batman, repoSuperIndividuo.searchById("SI2"))
//	}
//
//	@Test
//	def searchByIdEquipo() {
//		repoEquipo.agregarElemento(fantastico)
//		Assert.assertEquals(fantastico, repoEquipo.searchById("E1"))
//	}
//
//	@Test
//	def searchByIdItem() {
//		repoItem.agregarElemento(espejoMagico)
//		Assert.assertEquals(espejoMagico, repoItem.searchById("I1"))
//	}
//
//	@Test
//	def searchDeSuperIndividuoAlias() {
//		repoSuperIndividuo.agregarElemento(robin)
//		repoSuperIndividuo.agregarElemento(batman)
//		repoSuperIndividuo.agregarElemento(joker)
//
//		Assert.assertEquals(#[batman], repoSuperIndividuo.search("Batma"))
//	}
//
//	@Test
//	def searchDeSuperIndividuoNombre() {
//		repoSuperIndividuo.agregarElemento(robin)
//		repoSuperIndividuo.agregarElemento(batman)
//		repoSuperIndividuo.agregarElemento(joker)
//
//		Assert.assertEquals(#[batman], repoSuperIndividuo.search("Brun"))
//	}
//
//	@Test
//	def searchDeItem() {
//		repoItem.agregarElemento(espejoMagico)
//		repoItem.agregarElemento(navaja)
//
//		Assert.assertEquals(#[espejoMagico], repoItem.search("baticinturon"))
//	}
//
//	@Test
//	def searchDeEquipoNombreDeEquipo() {
//		repoEquipo.agregarElemento(fantastico)
//		repoEquipo.agregarElemento(laLigaDeLosMancos)
//
//		Assert.assertEquals(#[laLigaDeLosMancos], repoEquipo.search("liga"))
//	}
//
//	@Test
//	def searchDeEquipoAliasDeUnIntegrante() {
//		repoEquipo.agregarElemento(fantastico)
//		repoEquipo.agregarElemento(laLigaDeLosMancos)
//		fantastico.agregarAEquipo(superman)
//
//		Assert.assertEquals(#[fantastico], repoEquipo.search("Superm"))
//	}
//
//	@Test
//	def elBaticinturonDelJsonEsCompuesto() {
//		val Map<String, Object> jsonMap = new HashMap<String, Object>()
//		jsonMap.put("ID", "I3")
//		jsonMap.put("nombre", "Baticinturon")
//		jsonMap.put("componentes", '["I1","I2"]')
//		val JSONObject jsonPosta = new JSONObject(jsonMap)
//		Assert.assertTrue(actualizadorDeItems.validaSiEsItemCompuesto(jsonPosta))
//	}
//
//	@Test
//	def procesandoJsonItems() {
//		when(servicioActualizacionMockItems.getItems).thenReturn(listaItemsString)
//		actualizadorDeItems.jsonArray = servicioActualizacionMockItems
//		actualizadorDeItems.procesarJson
//
//		Assert.assertEquals(3, repoItem.elementos.size)
//	}
//
//	@Test
//	def vemosSiElBaticinturonTieneLosComponenetesQueVienieronEnJson() {
//		when(servicioActualizacionMockItems.getItems).thenReturn(listaItemsString)
//		actualizadorDeItems.jsonArray = servicioActualizacionMockItems
//		actualizadorDeItems.procesarJson
//		val listaComponentes = repoItem.searchById("I3").componentes.map[item|item.nombre]
//
//		Assert.assertEquals(#["Batarang", "Spray anti-tiburones"], listaComponentes)
//	}
//
//	@Test
//	def procesandoJsonAmigos() {
//		repoSuperIndividuo.agregarElemento(robin)
//		repoSuperIndividuo.agregarElemento(batman)
//		repoSuperIndividuo.agregarElemento(joker)
//		repoSuperIndividuo.agregarElemento(deadpool)
//		repoSuperIndividuo.agregarElemento(superman)
//		when(servicioActualizacionMockAmigos.getAmistades).thenReturn(listaAmigosString1)
//
//		actualizadorDeAmigos.jsonArray = servicioActualizacionMockAmigos
//		actualizadorDeAmigos.procesarJson
//
//		Assert.assertEquals(#[robin, superman], deadpool.amigos)
//	}
//
//	@Test
//	def eliminar1VillanoDeLasLIsta() {
//		repoEquipo.agregarElemento(fantastico)
//		fantastico.agregarAEquipo(robin)
//		robin.tipo(Villano.instance)
//		eliminadorDeVillanos.ejecutar()
//		Assert.assertEquals(#[], fantastico.integrantes)
//
//	}
//
//	@Test
//	def eliminarVillanosDeLasLIstas() {
//		repoEquipo.agregarElemento(fantastico)
//		fantastico.agregarAEquipo(superman)
//		fantastico.agregarAEquipo(robin)
//		robin.tipo(villano)
//		eliminadorDeVillanos.ejecutar()
//		Assert.assertEquals(#[superman], fantastico.integrantes)
//
//	}
//
//	@Test
//	def eliminarVillanosDeTodasLasLIstas() {
//		repoEquipo.agregarElemento(fantastico)
//		repoEquipo.agregarElemento(laLigaDeLosMancos)
//		laLigaDeLosMancos.agregarAEquipo(superman)
//		laLigaDeLosMancos.agregarAEquipo(robin)
//		robin.tipo(villano)
//		fantastico.agregarAEquipo(superman)
//		fantastico.agregarAEquipo(robin)
//		robin.tipo(villano)
//		eliminadorDeVillanos.ejecutar()
//		Assert.assertEquals(#[superman], fantastico.integrantes)
//		Assert.assertEquals(#[superman], laLigaDeLosMancos.integrantes)
//
//	}
//
//	@Test
//	def laInflacionVaAumentarElprecioDelItemsEnUnPorcentaje() {
//		repoItem.agregarElemento(navaja)
//		navaja.setPrecio(100.0)
//		navaja.setPorcentaje(20.0)
//		inflacion.ejecutar()
//		Assert.assertEquals(120, navaja.getPrecio(), 0.1)
//	}
//
//}
