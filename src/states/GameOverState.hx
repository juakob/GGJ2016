package states;

import flixel.FlxState;
import flixel.text.FlxText;
import openfl.Lib;

/**
 * ...
 * @author thepjteam
 */
class GameOverState extends FlxState
{
	
	var gameOverText:FlxText;
	
	public function new() {
		super();
		gameOverText = new FlxText((Lib.current.stage.stageWidth) / 2, (Lib.current.stage.stageHeight) / 2);
		gameOverText.text = "GAME OVER";
	}
	
}