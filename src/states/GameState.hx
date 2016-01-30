package states;

import flash.desktop.Clipboard;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import gameObjects.Player;
import openfl.Assets;

/**
 * ...
 * @author Joaquin
 */
class GameState extends FlxState
{

	var map:FlxTilemap;
	var player:Player;
	public function new() 
	{
		super();
	}
	override public function create():Void 
	{
		map = new FlxTilemap();
		map.loadMap(Assets.getText("map/mapTest.csv"), "img/tiles.png", 40, 40);
		map.allowCollisions = FlxObject.ANY;
		add(map);
		
		player = new Player(80, 80);
		add(player);
		
		
	}
	override public function update():Void 
	{
		super.update();
		FlxG.collide(map, player);
	}
	
}