package gameObjects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author Joaquin
 */
class Player extends FlxSprite
{
	private static var maxVel:Int = 260;
	
	
	var speedX:Float = 20;
	var speedY:Float = 20;
	
	public var ritualObjectHold:RitualObject;
	
	public function new(X:Float=0, Y:Float=0) 
	{
		
		super(X, Y);
		makeGraphic(32, 32,FlxColor.PURPLE);
		
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
		if (velocity.x > maxVel) {
			velocity.x = maxVel;
		}
		if (velocity.x < -maxVel) {
			velocity.x = -maxVel;
		}
		
		if (velocity.y > maxVel) {
			velocity.y = maxVel;
		}
		
		if (velocity.y < -maxVel) {
			velocity.y = -maxVel;
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