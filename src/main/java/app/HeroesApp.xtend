package app

import org.uqbar.xtrest.api.XTRest
import controller.HeroesController
import bootstrap.HeroesBootstrap

class HeroesApp {
	
	def static void main(String[] args) {
		new  HeroesBootstrap().run	
		XTRest.start(9000, HeroesController)
	}
	
}