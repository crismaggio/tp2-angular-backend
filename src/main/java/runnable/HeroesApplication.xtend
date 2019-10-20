package runnable

import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window
import views.MainView
import viewModels.MainViewViewModel
import bootstrap.HeroesBootstrap

class HeroesApplication extends Application {
		
	new(HeroesBootstrap bootstrap) {
		super(bootstrap)
	}

	static def void main(String[] args) {
		new HeroesApplication(new  HeroesBootstrap()).start()
	}

	override protected Window<?> createMainWindow() {
		return new MainView(this, new MainViewViewModel)
	}
	
}