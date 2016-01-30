package states;

import flash.desktop.Clipboard;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.util.FlxRandom;
import gameObjects.Enemy;
import gameObjects.EnemyType;
import gameObjects.Player;
import managers.EnemyManager;
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
		
		player = new Player(350, 350);
		add(player);

		EnemyManager.instance.loadEnemyes(this, 1, EnemyType.Cultist, 80, 80);
		EnemyManager.instance.loadEnemyes(this, 1, EnemyType.Farmer, 400, 100);
		EnemyManager.instance.loadEnemyes(this, 1, EnemyType.Kid, 500, 500);
		EnemyManager.instance.loadEnemyes(this, 1, EnemyType.Police, 250, 600);
	}
	
	
	
	override public function update():Void 
	{
		super.update();
		FlxG.collide(map, player);
		EnemyManager.instance.enemyUpdates(map, player, gameOver);
	}

	private function gameOver():Void {
		FlxG.camera.fade(FlxColor.BLACK, .33, false, doneFadeOut);
	}
	
	private function doneFadeOut():Void {
		
	}
	
}