package gameObjects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxPath;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;
import states.GameState;

/**
 * ...
 * @author thepjteam
 */
class Enemy extends FlxSprite
{

	var speedX:Float = 100;
	var speedY:Float = 100;
	
	private var path:FlxPath;
	
	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		makeGraphic(32, 32);
		
		speedX = FlxRandom.floatRanged(-5, 5);
		speedY = FlxRandom.floatRanged( -5, 5);
		path = new FlxPath();
	}
	
	override public function update():Void 
	{
		super.update();
		velocity.add(speedX, speedY);
		//pathfinding();
	}
	
	public function pathfinding() {
		var player:Player = GameState.gamestate.player;
		var pathPoints:Array<FlxPoint> = GameState.gamestate.map.findPath(FlxPoint.get(this.x + this.width / 2, this.y + this.height / 2), FlxPoint.get(player.x + player.width / 2, player.y + player.height / 2));
		
		if (pathPoints != null) {
			path.start(this, pathPoints);
		}
		
	}
	
	public function changeVelocity() {
		speedX = FlxRandom.floatRanged(-5, 5);
		speedY = FlxRandom.floatRanged( -5, 5);
	}
	
}