package gameObjects;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.loaders.TexturePackerData;

/**
 * ...
 * @author Manuel Atienza
 */
class RitualObject extends FlxSprite
{
	
	
	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);		
		loadTexture();
		addAnimations();
		animation.play("shining");
	}
	
	private function loadTexture() {
		var tex1:TexturePackerData = new TexturePackerData("spritesheet/mapObjects.json", "spritesheet/mapObjects.png");
		loadGraphicFromTexture(tex1);
	}
	
	private function addAnimations() {
		addShiningAnimation();
	}
	
	private function addShiningAnimation() {
		var framesByName:Array<String> =  new Array<String>();
		framesByName.push("cabra_2.png");
		framesByName.push("cabra_3.png");
		framesByName.push("cabra_4.png");
		animation.addByNames("shining", framesByName, 12);
	}
	
	
	public function getType():Int {
		
		return 0;
	}
	
}