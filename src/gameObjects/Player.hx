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
		var moveX:Bool = false;
		var moveY:Bool = false;
		if (FlxG.keys.pressed.LEFT)
		{
			velocity.add( -speedX, 0);
			moveX = true;
		}  
		if (FlxG.keys.pressed.RIGHT)
		{
			velocity.add(speedX, 0);
			moveX = true;
		} 
		if (FlxG.keys.pressed.UP)
		{
			velocity.add(0, -speedY);
			moveY = true;
		} 
		if (FlxG.keys.pressed.DOWN)
		{
			velocity.add(0, speedY);
			moveY = true;
		} 
		if (velocity.x > 1000) {
			velocity.x = 1000;
		}
		if (velocity.x < -1000) {
			velocity.x = -1000;
		}
		
		if (velocity.y > 1000) {
			velocity.y = 1000;
		}
		
		if (velocity.y < -1000) {
			velocity.y = -1000;
		}
		
		
		if (!moveX) {
			var oldVx:Float = velocity.x;
			
			if (oldVx > 0 || oldVx < 0) {
				velocity.add( -oldVx, 0);
				if ((velocity.x > 0 && oldVx < 0) || (velocity.x < 0 && oldVx > 0)) {
					velocity.x = 0;
				}
			}
		}
		if (!moveY) {
			var oldVy:Float = velocity.y;
			if (oldVy > 0 || oldVy < 0) {
				velocity.add(0, -oldVy);
				if ((velocity.y > 0 && oldVy < 0) || (velocity.y < 0 && oldVy > 0)) {
					velocity.y = 0;
				}
			}
		}
		
	}
	
}