#if !macro


@:access(lime.app.Application)
@:access(lime.Assets)
@:access(openfl.display.Stage)


class ApplicationMain {
	
	
	public static var config:lime.app.Config;
	public static var preloader:openfl.display.Preloader;
	
	
	public static function create ():Void {
		
		var app = new openfl.display.Application ();
		app.create (config);
		
		var display = new NMEPreloader ();
		
		preloader = new openfl.display.Preloader (display);
		app.setPreloader (preloader);
		preloader.onComplete.add (init);
		preloader.create (config);
		
		#if (js && html5)
		var urls = [];
		var types = [];
		
		
		urls.push ("assets/sounds/beep.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("assets/sounds/flixel.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("Nokia Cellphone FC Small");
		types.push (lime.Assets.AssetType.FONT);
		
		
		urls.push ("Arial");
		types.push (lime.Assets.AssetType.FONT);
		
		
		urls.push ("img/Ariel_atras1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Ariel_atras2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Ariel_costado1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Ariel_costado2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Ariel_costado3.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Ariel_frente1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Ariel_frente2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/cabra_1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/cabra_2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/cabra_3.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/cabra_4.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Cultista.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/gameover.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Granjero.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Llorona.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/pentagrama_animado1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/pentagrama_animado2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/pentagrama_sinActivar.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/personajes.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Policia.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/tiles.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/win.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("map/level1_collision.csv");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("map/level1_extras.csv");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("map/level1_tilesCollisionAI.csv");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("map/mapTest.csv");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("map/mapTest2.csv");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("map/untitled.csv");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("map/untitled.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("spritesheet/mapObjects.json");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("spritesheet/mapObjects.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("spritesheet/personajes.json");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("spritesheet/personajes.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/sounds/test_sound.mp3");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		
		if (config.assetsPrefix != null) {
			
			for (i in 0...urls.length) {
				
				if (types[i] != lime.Assets.AssetType.FONT) {
					
					urls[i] = config.assetsPrefix + urls[i];
					
				}
				
			}
			
		}
		
		preloader.load (urls, types);
		#end
		
		var result = app.exec ();
		
		#if (sys && !nodejs && !emscripten)
		Sys.exit (result);
		#end
		
	}
	
	
	public static function init ():Void {
		
		var loaded = 0;
		var total = 0;
		var library_onLoad = function (__) {
			
			loaded++;
			
			if (loaded == total) {
				
				start ();
				
			}
			
		}
		
		preloader = null;
		
		
		
		
		if (total == 0) {
			
			start ();
			
		}
		
	}
	
	
	public static function main () {
		
		config = {
			
			build: "17",
			company: "Joaquin",
			file: "GGJ2016",
			fps: 60,
			name: "GGJ2016",
			orientation: "",
			packageName: "GGJ2016",
			version: "1.0.0",
			windows: [
				
				{
					antialiasing: 0,
					background: 0,
					borderless: false,
					depthBuffer: false,
					display: 0,
					fullscreen: false,
					hardware: true,
					height: 720,
					parameters: "{}",
					resizable: true,
					stencilBuffer: true,
					title: "GGJ2016",
					vsync: false,
					width: 1280,
					x: null,
					y: null
				},
			]
			
		};
		
		#if hxtelemetry
		var telemetry = new hxtelemetry.HxTelemetry.Config ();
		telemetry.allocations = true;
		telemetry.host = "localhost";
		telemetry.app_name = config.name;
		Reflect.setField (config, "telemetry", telemetry);
		#end
		
		#if (js && html5)
		#if (munit || utest)
		openfl.Lib.embed (null, 1280, 720, "000000");
		#end
		#else
		create ();
		#end
		
	}
	
	
	public static function start ():Void {
		
		var hasMain = false;
		var entryPoint = Type.resolveClass ("Main");
		
		for (methodName in Type.getClassFields (entryPoint)) {
			
			if (methodName == "main") {
				
				hasMain = true;
				break;
				
			}
			
		}
		
		lime.Assets.initialize ();
		
		if (hasMain) {
			
			Reflect.callMethod (entryPoint, Reflect.field (entryPoint, "main"), []);
			
		} else {
			
			var instance:DocumentClass = Type.createInstance (DocumentClass, []);
			
			/*if (Std.is (instance, openfl.display.DisplayObject)) {
				
				openfl.Lib.current.addChild (cast instance);
				
			}*/
			
		}
		
		#if !flash
		if (openfl.Lib.current.stage.window.fullscreen) {
			
			openfl.Lib.current.stage.dispatchEvent (new openfl.events.FullScreenEvent (openfl.events.FullScreenEvent.FULL_SCREEN, false, false, true, true));
			
		}
		
		openfl.Lib.current.stage.dispatchEvent (new openfl.events.Event (openfl.events.Event.RESIZE, false, false));
		#end
		
	}
	
	
	#if neko
	@:noCompletion @:dox(hide) public static function __init__ () {
		
		var loader = new neko.vm.Loader (untyped $loader);
		loader.addPath (haxe.io.Path.directory (Sys.executablePath ()));
		loader.addPath ("./");
		loader.addPath ("@executable_path/");
		
	}
	#end
	
	
}


@:build(DocumentClass.build())
@:keep class DocumentClass extends Main {}


#else


import haxe.macro.Context;
import haxe.macro.Expr;


class DocumentClass {
	
	
	macro public static function build ():Array<Field> {
		
		var classType = Context.getLocalClass ().get ();
		var searchTypes = classType;
		
		while (searchTypes.superClass != null) {
			
			if (searchTypes.pack.length == 2 && searchTypes.pack[1] == "display" && searchTypes.name == "DisplayObject") {
				
				var fields = Context.getBuildFields ();
				
				var method = macro {
					
					openfl.Lib.current.addChild (this);
					super ();
					dispatchEvent (new openfl.events.Event (openfl.events.Event.ADDED_TO_STAGE, false, false));
					
				}
				
				fields.push ({ name: "new", access: [ APublic ], kind: FFun({ args: [], expr: method, params: [], ret: macro :Void }), pos: Context.currentPos () });
				
				return fields;
				
			}
			
			searchTypes = searchTypes.superClass.t.get ();
			
		}
		
		return null;
		
	}
	
	
}


#end