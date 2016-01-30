package gameObjects;

import flixel.FlxG;
import flixel.FlxSprite;

/**
 * ...
 * @author Joaquin
 */
class Player extends FlxSprite
{

	var speedX:Float = 100;
	var speedY:Float = 100;
	public function new(X:Float=0, Y:Float=0) 
	{
		
		super(X, Y);
		makeGraphic(32, 32);
		
	}
	
	override public function update():Void 
	{
		super.update();
		velocity.set(0, 0);
		if (FlxG.keys.pressed.LEFT)
		{
			velocity.x = -speedX;
		}
		if (FlxG.keys.pressed.RIGHT)
		{
			velocity.x = speedX;
		}
		if (FlxG.keys.pressed.UP)
		{
			velocity.y = -speedY;
		}
		if (FlxG.keys.pressed.DOWN)
		{
			velocity.y = speedY;
		}
	}
	
}