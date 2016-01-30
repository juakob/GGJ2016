package gameObjects;

import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author Manuel Atienza
 */
class RitualObject extends FlxSprite
{
	
	
	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		makeGraphic(16, 16,FlxColor.PINK);
	}
	
	public function getType():Int {
		
		return 0;
	}
	
}