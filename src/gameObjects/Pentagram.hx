package gameObjects;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.loaders.TexturePackerData;

/**
 * ...
 * @author Manuel Atienza
 */
class Pentagram extends FlxSprite
{
	public var isActive(get, null):Bool;
	private function get_isActive():Bool {
		return isActive;
	}

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		loadTexture();
		addAnimations();
		Inactive();
	}
	
	private function loadTexture() {
		var tex1:TexturePackerData = new TexturePackerData("spritesheet/mapObjects.json", "spritesheet/mapObjects.png");
		loadGraphicFromTexture(tex1);
	}
	
	private function addAnimations() {
		addInactiveAnimation();
		addActivatedAnimation();
	}
	
	private function addInactiveAnimation() {
		var framesByName:Array<String> =  new Array<String>();
		framesByName.push("pentagrama_sinActivar.png");
		animation.addByNames("inactive", framesByName, 12);
	}
	
	private function addActivatedAnimation() {
		var framesByName:Array<String> =  new Array<String>();
		framesByName.push("pentagrama_animado1.png");
		framesByName.push("pentagrama_animado2.png");
		animation.addByNames("active", framesByName, 12);
	}
	
	public function Activate() {
		isActive = true;
		animation.play("active");
	}
	
	public function Inactive() {
		isActive = false;
		animation.play("inactive");
	}
	
	public function getType():Int {
		return 0;
	}
	
}