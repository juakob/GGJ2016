package gameObjects;

import flixel.FlxG;
import flixel.FlxSprite;
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
		width = Constants.TILES_WIDTH;
		height = Constants.TILES_WIDTH;
	}
	
	override public function update():Void {
		var player:Player = GameState.gamestate.player;
		
		if (this.overlaps(player) && animation.curAnim!=null && animation.curAnim.name != "rustle") {
			FlxG.log.advanced("Rustling");
			//animation.play("rustle");
		}else if (!this.overlaps(player) && animation.curAnim!=null && animation.curAnim.name == "rustle") {
			FlxG.log.advanced("Idle");
			animation.play("idle");
		}
	}
	
	public function initAnimations():Void {
		createAnimRustle();
		createAnimIdle();
	}
	
	public function createAnimRustle() {
		
	}
	
	public function createAnimIdle() {
		
	}
	
}