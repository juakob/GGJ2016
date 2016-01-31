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
class Arbusto extends FlxSprite
{
	
	public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:Dynamic) 
	{
		super(X, Y);
		initAnimations();
		animation.play("idle");
		width = Constants.TILES_WIDTH;
		height = Constants.TILES_WIDTH;
	}
	
	override public function update():Void {
		var player:Player = GameState.gamestate.player;
		
		if (this.overlaps(player) && animation.curAnim!=null && animation.curAnim.name != "rustle") {
			FlxG.log.advanced("Rustling");
			animation.play("rustle");
		}else if (!this.overlaps(player) && animation.curAnim!=null && animation.curAnim.name == "rustle") {
			FlxG.log.advanced("Idle");
			animation.play("idle");
		}
	}
	
	public function initAnimations():Void {
		var texturePacker:TexturePackerData = new TexturePackerData("spritesheet/mapObjects.json", "spritesheet/mapObjects.png");
		this.loadGraphicFromTexture(texturePacker);
		createAnimRustle();
		createAnimIdle();
	}
	
	public function createAnimRustle() {
		var framesByName:Array<String> =  new Array<String>();
		framesByName.push("pasto000001.png");
		framesByName.push("pasto000002.png");
		framesByName.push("pasto000003.png");
		framesByName.push("pasto000004.png");
		framesByName.push("pasto000005.png");
		framesByName.push("pasto000006.png");
		framesByName.push("pasto000007.png");
		framesByName.push("pasto000008.png");
		framesByName.push("pasto000009.png");
		animation.addByNames("rustle", framesByName, 12);
	}
	
	public function createAnimIdle() {
		var framesByName:Array<String> =  new Array<String>();
		framesByName.push("pasto000001.png");
		animation.addByNames("idle", framesByName, 12);
	}
	
}