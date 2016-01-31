package gameObjects;

import flixel.FlxSprite;
import flixel.util.loaders.TexturePackerData;

/**
 * ...
 * @author Manuel Atienza
 */
class Caldero extends FlxSprite
{
	private static var spriteWidth:Int = 59;
	private static var spriteHeight:Int = 44;
	
	private static var demon:FlxSprite;
	
	public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:Dynamic) 
	{
		super(X, Y);
		
		var texturePacker:TexturePackerData = new TexturePackerData("spritesheet/mapObjects.json", "spritesheet/mapObjects.png");
		loadGraphicFromTexture(texturePacker);
		addBubblingAnimation();
		
		animation.play("bubbling");
		
		width = (59/2);
		height = (44/2)-5;
		offset.set(18, (height / 2)+5);
		
		immovable = true;
	}
	
	public function addBubblingAnimation() {
		var framesByName:Array<String> =  new Array<String>();
		framesByName.push("caldero_y_velitas_1.png");
		framesByName.push("caldero_y_velitas_2.png");
		framesByName.push("caldero_y_velitas_3.png");
		framesByName.push("caldero_y_velitas_4.png");
		animation.addByNames("bubbling", framesByName, 12);
	}
	
	public function invokeDemon() {
		var texturePacker:TexturePackerData = new TexturePackerData("spritesheet/demon.json", "spritesheet/demon.png");
		demon = new FlxSprite();
		demon.loadGraphicFromTexture(texturePacker);
		addDemonSpawningAnimation();
		addDemonIdle();
	}
	
	public function addDemonSpawningAnimation() {
		var framesByName:Array<String> = new Array<String>();
		var fileName:String = "demonAnimation";
		framesByName.push(fileName+".png");
		for (i in 1...29) {
			if (i < 10) {
				framesByName.push(fileName+"000" + i + ".png");
			}else {
				framesByName.push(fileName+"00" + i + ".png");
			}
		}
		animation.addByNames("spawning",framesByName);
	}
	
	public function addDemonIdle() {
		var framesByName:Array<String> = new Array<String>();
		var fileName:String = "demonAnimation";
		framesByName.push(fileName+".png");
		for (i in 1...29) {
			if (i < 10) {
				framesByName.push(fileName+"000" + i + ".png");
			}else {
				framesByName.push(fileName+"00" + i + ".png");
			}
		}
		animation.addByNames("idle",framesByName);		
	}
}