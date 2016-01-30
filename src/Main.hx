package;

import flixel.FlxGame;
import openfl.display.Sprite;
import openfl.Lib;
import states.GameState;

/**
 * ...
 * @author Joaquin
 */
class Main extends Sprite 
{

	public function new() 
	{
		super();
		addChild(new FlxGame(1280, 720,GameState));
		// Assets:
		// openfl.Assets.getBitmapData("img/assetname.jpg");
	}

}
