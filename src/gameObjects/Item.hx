package gameObjects;

import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author Joaquin
 */
class Item extends FlxSprite
{

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		makeGraphic(10, 10, FlxColor.BLUE);
		
	}
	
}