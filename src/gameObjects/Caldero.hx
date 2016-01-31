package gameObjects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.loaders.TexturePackerData;
import helpers.Constants;
import states.GameState;

/**
 * ...
 * @author Manuel Atienza
 */
class Caldero extends FlxSprite
{
	private static var spriteWidth:Int = 59;
	private static var spriteHeight:Int = 44;
	
	public var demon:FlxSprite;
	
	public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:Dynamic) 
	{
		//super(X, Y);
		super(X + Constants.TILE_SIZE / 8, Y);
		
		
		var texturePacker:TexturePackerData = new TexturePackerData("spritesheet/mapObjects.json", "spritesheet/mapObjects.png");
		loadGraphicFromTexture(texturePacker);
		addBubblingAnimation();
		
		animation.play("bubbling");
		
		this.width = Constants.TILE_SIZE/2;
		this.height = Constants.TILE_SIZE/2;
		offset.x += Constants.TILE_SIZE / 2;
		offset.y += Constants.TILE_SIZE;
		
		immovable = true;
	}
	
	override public function update():Void {
		if (demon==null && FlxG.keys.pressed.X) {
			initDemon();
		}
		if (demon != null && demon.animation.get("spawning").finished) {
			demon.animation.play("idle");
			GameState.gamestate.add(new FlxSprite(250, 450, "img/play_again.png"));
		}
	}
	
	public function addBubblingAnimation() {
		var framesByName:Array<String> =  new Array<String>();
		framesByName.push("caldero_y_velitas_1.png");
		framesByName.push("caldero_y_velitas_2.png");
		framesByName.push("caldero_y_velitas_3.png");
		framesByName.push("caldero_y_velitas_4.png");
		animation.addByNames("bubbling", framesByName, 12);
	}
	
	public function initDemon() {
		if (demon == null) {
			var texturePacker:TexturePackerData = new TexturePackerData("spritesheet/demon.json", "spritesheet/demon.png");
			demon = new FlxSprite();
			demon.loadGraphicFromTexture(texturePacker);
			addDemonSpawningAnimation();
			addDemonIdle();
			GameState.gamestate.add(demon);
			demon.animation.play("spawning");
			demon.x = this.x-demon._halfWidth+16;
			demon.y = this.y - demon.height*(4/5);
			//FlxG.log.advanced("X: "+demon.x+" Y: "+demon.y);
			//FlxG.log.advanced("Width: "+demon.width+" Height: "+demon.height);			
		}
	}
	
	public function addDemonSpawningAnimation() {
		var framesByName:Array<String> = new Array<String>();
		
		framesByName.push("demonAnimation.png");
		framesByName.push("demonAnimation0001.png");
		framesByName.push("demonAnimation0002.png");
		framesByName.push("demonAnimation0003.png");
		framesByName.push("demonAnimation0004.png");
		framesByName.push("demonAnimation0005.png");
		framesByName.push("demonAnimation0006.png");
		framesByName.push("demonAnimation0007.png");
		framesByName.push("demonAnimation0008.png");
		framesByName.push("demonAnimation0009.png");
		framesByName.push("demonAnimation0010.png");
		framesByName.push("demonAnimation0011.png");
		framesByName.push("demonAnimation0012.png");
		
		demon.animation.addByNames("spawning",framesByName,12,false);
	}
	
	public function addDemonIdle() {
		var framesByName:Array<String> = new Array<String>();
		
		framesByName.push("demonAnimation0012.png");
		framesByName.push("demonAnimation0013.png");
		framesByName.push("demonAnimation0014.png");
		framesByName.push("demonAnimation0015.png");
		framesByName.push("demonAnimation0016.png");
		framesByName.push("demonAnimation0017.png");
		framesByName.push("demonAnimation0018.png");
		framesByName.push("demonAnimation0019.png");
		framesByName.push("demonAnimation0020.png");
		framesByName.push("demonAnimation0021.png");
		framesByName.push("demonAnimation0022.png");
		framesByName.push("demonAnimation0023.png");
		framesByName.push("demonAnimation0024.png");
		framesByName.push("demonAnimation0025.png");
		framesByName.push("demonAnimation0026.png");
		framesByName.push("demonAnimation0027.png");
		framesByName.push("demonAnimation0028.png");
		framesByName.push("demonAnimation0027.png");
		framesByName.push("demonAnimation0026.png");
		framesByName.push("demonAnimation0025.png");
		framesByName.push("demonAnimation0024.png");
		framesByName.push("demonAnimation0023.png");
		framesByName.push("demonAnimation0022.png");
		framesByName.push("demonAnimation0021.png");
		framesByName.push("demonAnimation0020.png");
		framesByName.push("demonAnimation0019.png");
		framesByName.push("demonAnimation0018.png");
		framesByName.push("demonAnimation0017.png");
		framesByName.push("demonAnimation0016.png");
		framesByName.push("demonAnimation0015.png");
		framesByName.push("demonAnimation0014.png");
		framesByName.push("demonAnimation0013.png");
		framesByName.push("demonAnimation0012.png");
		framesByName.push("demonAnimation0012.png");
		
		demon.animation.addByNames("idle",framesByName,12,true);		
	}
}