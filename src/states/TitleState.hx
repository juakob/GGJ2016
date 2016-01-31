package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

/**
 * ...
 * @author Manuel Atienza
 */
class TitleState extends FlxState
{
	public function new() {
		super();
	}
	
	override public function create() 
	{
		super.create();
		var image = new FlxSprite();
		image.loadGraphic("img/title_screen.png");
		image.setPosition(0,0);
		//image.loadGraphic("img/gameover.png");
		//image.setPosition(Lib.current.stage.stageWidth / 2, Lib.current.stage.stageHeight / 2);
		add(image);
	}
	
	public override function update() {
		super.update();
		if (FlxG.keys.pressed.ENTER)  {
			FlxG.switchState(new GameState());
		}
	}
}