package;

import flixel.FlxGame;
import openfl.display.Sprite;
import openfl.Lib;
import states.GameOverState;
import states.GameState;
import states.TitleState;

/**
 * ...
 * @author Joaquin
 */
class Main extends Sprite 
{

	public function new() 
	{
		super();
		addChild(new FlxGame(1280, 720, TitleState));
		// Assets:
		// openfl.Assets.getBitmapData("img/assetname.jpg");
	}

}
