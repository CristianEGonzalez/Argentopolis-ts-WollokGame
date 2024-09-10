import wollok.game.*
import juego.*
import pantalla.*
import propiedades.*

object tablero{
	const property startMenu = new Fondo(img="startMenu.png")
	const property selectPlayerScreen = new Animation(img="seleccionarJugadores",position = game.at(0,0))
	const property selector = new Selector(img="selector.png", position=game.at(0,8))
	const property mapaArgentina = new Fondo(position=game.at(1,1),img="argentina.png")
	const property indicadorTurno = new IndicadorJugador(position=game.at(5,7))
	const property instrucciones1 = new Instrucciones(img = "instrucciones1.png")
	const property instrucciones2 = new Instrucciones(img = "instrucciones2.png")
	const property teclas = new Instrucciones(img = "teclas.png")
	const property teclaInstrucciones = new Visual(position=game.at(3,1),img="teclaInstrucciones.png")

	method generarTablero(){
		//Elimina el Menu de Inicio
		song.menu().stop()
		self.startMenu().removeVisual()
		self.selectPlayerScreen().removeVisual()
		self.selector().removeVisual()
		//Fondo de tablero
		self.mapaArgentina().addVisual()
		//Tecla en pantalla para abrir instrucciones
		self.teclaInstrucciones().addVisual()
		//Indicador de Jugador en turno actual
		self.indicadorTurno().addVisual()
		self.indicadorTurno().animation(2)
		//Coloca todos los casilleros y etiquetas del tablero
		self.generarCasilleros()
		//Música de partida
		song.partida().shouldLoop(true)
		game.schedule(300,{song.partida().play()})
	}
	
	method generarCasilleros(){				
		const casilleros =[
			banco,salida,
			new CasilleroSuerte(position = game.at(0,0),img="suerte.png"),
			new Carcel(position = game.at(0,8),img="carcel.png"),
			new CasilleroMufa(position = game.at(8,8),img="mufa.png"),

			new Visual(position = game.at(7,1), img = "label-malvinasEntreRios.png"),
			new Visual(position = game.at(6,1), img = "label-buenosAires.png"),
			new Visual(position = game.at(5,1), img = "label-santaFe.png"),
			new Visual(position = game.at(4,1), img = "label-sarmiento.png"),
			new Visual(position = game.at(3,1), img = "label-santiago.png"),
			new Visual(position = game.at(2,1), img = "label-laPampa.png"),
			new Visual(position = game.at(1,1), img = "label-cordobaChaco.png"),
			new Visual(position = game.at(1,2), img = "label-corrientes.png"),
			new Visual(position = game.at(1,3), img = "label-misiones.png"),
			new Visual(position = game.at(1,4), img = "label-roca.png"),
			new Visual(position = game.at(1,5), img = "label-formosa.png"),
			new Visual(position = game.at(1,6), img = "label-jujuy.png"),
			new Visual(position = game.at(1,7), img = "label-saltaTucuman.png"),
			new Visual(position = game.at(2,7), img = "label-catamarca.png"),
			new Visual(position = game.at(3,7), img = "label-laRioja.png"),
			new Visual(position = game.at(4,7), img = "label-mitre.png"),
			new Visual(position = game.at(5,7), img = "label-sanJuan.png"),
			new Visual(position = game.at(6,7), img = "label-sanLuis.png"),
			new Visual(position = game.at(7,7), img = "label-mendozaChubut.png"),
			new Visual(position = game.at(7,6), img = "label-rioNegro.png"),
			new Visual(position = game.at(7,5), img = "label-neuquen.png"),
			new Visual(position = game.at(7,4), img = "label-sanMartin.png"),
			new Visual(position = game.at(7,3), img = "label-santaCruz.png"),
			new Visual(position = game.at(7,2), img = "label-tierraDelFuego.png")
			]
		
		casilleros.forEach{casillero => game.addVisual(casillero)}
		banco.todasDelBanco(casilleros)
		
		regiones.todasLasRegiones().forEach{ unaRegion =>
			unaRegion.forEach{ubicacion => game.addVisual(ubicacion) }
			banco.todasDelBanco(unaRegion)
		}
	}
}

class Dado inherits Visual{
	const property valor = [1,2,3,4,5,6].anyOne()
	
	override method position() = game.at(4,1)
	override method image() = "dado" + valor.toString() + ".png"
}

object banco{
	var property position = game.at(6,1)
	var property dinero = 9999999
	const misPropiedades = #{}
	
	method image() = "MrArgentopoly.png"
	
	method todasDelBanco(propiedades){
		propiedades.forEach{unCasillero => misPropiedades.add(unCasillero)}
	}
	
	method misPropiedades() = misPropiedades
	
	method cobrar(monto){dinero += monto}
	method pagar(monto){dinero -= monto}
}

object regiones{
	const region1 = [
		new Provincia(position = game.at(7,0), img = "entreRios.png"),
		new Provincia(position = game.at(6,0), img = "buenosAires.png"),
		new Provincia(position = game.at(5,0), img = "santaFe.png")
	]
		
	const region2 = [
		new Provincia(position = game.at(3,0), img = "santiago.png"),
		new Provincia(position = game.at(2,0), img = "laPampa.png"),
		new Provincia(position = game.at(1,0), img = "cordoba.png")
	]	
	
	const region3 = [
		new Provincia(position = game.at(0,1), img = "chaco.png"),
		new Provincia(position = game.at(0,2), img = "corrientes.png"),
		new Provincia(position = game.at(0,3), img = "misiones.png")
	]	
	
	const region4 = [
		new Provincia(position = game.at(0,5), img = "formosa.png"),
		new Provincia(position = game.at(0,6), img = "jujuy.png"),
		new Provincia(position = game.at(0,7), img = "salta.png")
	]
	
	const region5 = [
		new Provincia(position = game.at(1,8), img = "tucuman.png"),
		new Provincia(position = game.at(2,8), img = "catamarca.png"),
		new Provincia(position = game.at(3,8), img = "laRioja.png")
	]
	
	const region6 = [
		new Provincia(position = game.at(5,8), img = "sanJuan.png"),
		new Provincia(position = game.at(6,8), img = "sanLuis.png"),
		new Provincia(position = game.at(7,8), img = "mendoza.png")
	]
	
	const region7 = [
		new Provincia(position = game.at(8,7), img = "chubut.png"),
		new Provincia(position = game.at(8,6), img = "rioNegro.png"),
		new Provincia(position = game.at(8,5), img = "neuquen.png")
	]
	
	const region8 = [
		new Provincia(position = game.at(8,3), img = "santaCruz.png"),
		new Provincia(position = game.at(8,2), img = "tierraDelFuego.png"),
		new Provincia(position = game.at(8,1), img = "malvinas.png")
	]
	
	const trenes = [
		new Tren(position = game.at(4,0), img = "sarmiento.png"),
		new Tren(position = game.at(8,4), img = "sanMartin.png"),
		new Tren(position = game.at(0,4), img = "roca.png"),
		new Tren(position = game.at(4,8), img = "mitre.png")
	]
	
	const property todasLasRegiones = [
		region1,region2,region3,region4,
		region5,region6,region7,region8,
		trenes
	]
}



