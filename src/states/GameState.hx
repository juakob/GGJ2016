package states;

import flash.desktop.Clipboard;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxRandom;
import gameObjects.Enemy;
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
	
	var poolSize:Int;
	var enemies:FlxTypedGroup<Enemy>;
	
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
		
		var enemy:Enemy;
		poolSize = 4;
		enemies = new FlxTypedGroup<Enemy>(poolSize);
		for (i in 0...poolSize) {
			enemy = new Enemy(FlxRandom.floatRanged(70, 80), FlxRandom.floatRanged(70, 80));
			enemies.add(enemy);
			add(enemy);
		}
	}
	override public function update():Void 
	{
		super.update();
		FlxG.collide(map, player);
		FlxG.collide(enemies, map, enemyMapCollide);
		FlxG.collide(enemies, player, enemyPlayer);
		FlxG.collide(enemies, null, enemyEnemyCollide);
	}
	
	private function enemyMapCollide(enemy:Enemy, map:FlxTilemap):Void {
		enemy.changeVelocity();
	}
	
	private function enemyPlayer(enemy:Enemy, player:Player):Void {
		enemy.changeVelocity();
	}
	
	private function enemyEnemyCollide(enemy:Enemy, player:Enemy):Void {
		enemy.changeVelocity();
	}
}