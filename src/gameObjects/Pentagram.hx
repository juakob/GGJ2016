package gameObjects;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author Manuel Atienza
 */
class Pentagram extends FlxSprite
{

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		makeGraphic(16, 16,FlxColor.RED);
	}
	
	public function getType():Int {
		return 0;
	}
	
}