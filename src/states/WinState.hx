package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import openfl.Assets;
import openfl.Lib;

/**
 * ...
 * @author thepjteam
 */
class WinState extends FlxState
{
	
	var winText:FlxText;
	
	public function new() {
		super();
	}
	
	public override function create() {
		super.create();
		var image = new FlxSprite();
		image.loadGraphic("img/win.png");
		image.setPosition(Lib.current.stage.stageWidth / 2, Lib.current.stage.stageHeight / 2);
		add(image);
	}
	
	public override function update() {
		super.update();
		if (FlxG.keys.pressed.SPACE)  {
			FlxG.switchState(new GameState());
		}
	}
	
}