package gameObjects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxPath;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;
import helpers.PathNode;
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
	private var currentNode:Int;
	
	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		makeGraphic(32, 32);
		
		speedX = 100;
		speedY = 100;
		path = new FlxPath();
		currentNode = FlxRandom.intRanged(0, GameState.gamestate.nodes.length-1);
		resetPath();
	}
	
	override public function update():Void 
	{
		super.update();
		//velocity.add(speedX, speedY);
		if (path.finished)
		{
			resetPath();
		}
		//pathfinding();
	}
	
	private function resetPath():Void
	{
		currentNode = FlxRandom.intRanged(0, GameState.gamestate.nodes.length-1,[currentNode]);
			path.start(this, GameState.gamestate.map.findPath(FlxPoint.get(this.x, this.y), GameState.gamestate.nodes[currentNode].randomDestination()),speedX);
	}
	
	
	public function changeVelocity() {
		speedX = FlxRandom.floatRanged(-5, 5);
		speedY = FlxRandom.floatRanged( -5, 5);
	}
	
}