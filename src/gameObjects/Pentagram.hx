package gameObjects;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.loaders.TexturePackerData;
import helpers.Constants;

/**
 * ...
 * @author Manuel Atienza
 */
class Pentagram extends FlxSprite
{
	public var isActive(get, null):Bool;
	public var isCalling(default, null):Bool;
	private function get_isActive():Bool {
		return isActive;
	}
	

	public function new(X:Float=0, Y:Float=0) 
	{
		isCalling = false;
		//super(X, Y);
		super(X - Constants.TILE_SIZE / 2, Y - Constants.TILE_SIZE / 2);
		
		
		loadTexture();
		addAnimations();
		
		Inactive();
		
		
		this.width = Constants.TILE_SIZE;
		this.height = Constants.TILE_SIZE;
	}
	
	private function loadTexture() {
		var tex1:TexturePackerData = new TexturePackerData("spritesheet/mapObjects.json", "spritesheet/mapObjects.png");
		loadGraphicFromTexture(tex1);
	}
	
	private function addAnimations() {
		addInactiveAnimation();
		addCallingAnimation();
		addActivatedAnimation();
	}
	
	private function addInactiveAnimation() {
		var framesByName:Array<String> =  new Array<String>();
		framesByName.push("pentagrama_desactivado.png");
		animation.addByNames("inactive", framesByName, 12);
	}
	
	private function addCallingAnimation() {
		var framesByName:Array<String> =  new Array<String>();
		framesByName.push("pentagrama_llamada.png");
		framesByName.push("pentagrama_llamada1.png");
		framesByName.push("pentagrama_llamada2.png");
		framesByName.push("pentagrama_llamada3.png");
		framesByName.push("pentagrama_llamada4.png");
		framesByName.push("pentagrama_llamada5.png");
		framesByName.push("pentagrama_llamada6.png");
		animation.addByNames("calling", framesByName, 12);
	}
	
	private function addActivatedAnimation() {
		var framesByName:Array<String> =  new Array<String>();
		framesByName.push("pentagrama_activado1.png");
		framesByName.push("pentagrama_activado2.png");
		framesByName.push("pentagrama_activado3.png");
		framesByName.push("pentagrama_activado4.png");
		animation.addByNames("active", framesByName, 12);
	}
	
	public function Calling() {
		isCalling = true;
		isActive = false;
		allowCollisions = FlxObject.ANY;
		animation.play("calling");
	}
	
	public function Activate() {
		isActive = true;
		isCalling = false;
		allowCollisions = FlxObject.NONE;
		animation.play("active");
	}
	
	public function Inactive() {
		
			isActive = false;
			isCalling = false;
			allowCollisions = FlxObject.NONE;
			animation.play("inactive");
		
	}
	
	public function getType():Int {
		return 0;
	}
	
}