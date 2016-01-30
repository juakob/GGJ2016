package states;

import flash.desktop.Clipboard;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;

import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.util.FlxRandom;
import gameObjects.Enemy;
import gameObjects.Pentagram;
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
	public static var gamestate:GameState;
	private static var tileSize:Int = 40;
	
	public var map:FlxTilemap;
	//PLAYER VARS
	public var player:Player;
	
	//PENTAGRAM VARS
	var amountOfPentagrams:Int = 4;
	var pentagramsCollected:Int = 0;
	var pentagrams:FlxTypedGroup<Pentagram>;
	
	//ENEMY VARS
	var amountEnemies:Int=1;
	var enemies:FlxTypedGroup<Enemy>;
	
	
	public function new() 
	{
		super();
		gamestate = this;
	}
	
	override public function create():Void 
	{
		initMap();
		initPlayer();
		initEnemies();
		initPentagrams();
	}
	
	override public function update():Void 
	{
		super.update();
		FlxG.collide(map, player);
		
		EnemyManager.instance.enemyUpdates(map, player, gameOver);
		checkPentagramsCollision();
		checkWinCondition();
	}
	
	private function initMap() {
		map = new FlxTilemap();
		map.loadMap(Assets.getText("map/mapTest2.csv"), "img/tiles.png", 40, 40);
		map.allowCollisions = FlxObject.ANY;
		add(map);
	}
	
	private function initPlayer() {
		player = new Player(16*tileSize, 9*tileSize);
		add(player);
	}
	
	private function initEnemies() {
		EnemyManager.instance.loadEnemyes(this, 1, EnemyType.Cultist, 80, 80);
		EnemyManager.instance.loadEnemyes(this, 1, EnemyType.Farmer, 400, 100);
		EnemyManager.instance.loadEnemyes(this, 1, EnemyType.Kid, 500, 500);
		EnemyManager.instance.loadEnemyes(this, 1, EnemyType.Police, 400, 600);
	}
	
	public function checkPentagramsCollision() {
		if (player.overlaps(pentagrams)) {
			var allPentagrams:Array<Pentagram> = pentagrams.members;
			var pentagram:Pentagram;
			var done:Bool = false;
			var pentaChecks:Int=0;
			while (!done) {
				pentagram = allPentagrams.shift();
				pentaChecks++;
				if (player.overlaps(pentagram)) {
					done = true;
					pentagram.kill();
					pentagramsCollected++;
					FlxG.log.advanced("Pentagram removed. Pentagrams checked: "+pentaChecks);
				}else {
					allPentagrams.push(pentagram);
				}
			}
		}
	}
	
	public function checkWinCondition():Bool {
		var win:Bool=false;
		
		if (pentagrams.getFirstAlive() == null) {
			win = true;
			FlxG.log.advanced("Win!");
		}
	
		return win;
	}
	
	private function initPentagrams() {
		pentagrams = new FlxTypedGroup<Pentagram>();
		var pentagram:Pentagram;
		
		pentagram = new Pentagram(5*tileSize, 2*tileSize);
		pentagrams.add(pentagram);
		
		pentagram = new Pentagram(24*tileSize, 15*tileSize);
		pentagrams.add(pentagram);
		
		pentagram = new Pentagram(29*tileSize, 3*tileSize);
		pentagrams.add(pentagram);
		
		pentagram = new Pentagram(3*tileSize, 14*tileSize);
		pentagrams.add(pentagram);
		
		add(pentagrams);
	}
	
	private function enemyMapCollide(enemy:Enemy, map:FlxTilemap):Void {
		enemy.changeVelocity();
	}
	
	private function enemyPlayer(enemy:Enemy, player:Player):Void {
		gameOver();
	}
	
	private function enemyEnemyCollide(enemy:Enemy, player:Enemy):Void {
		enemy.changeVelocity();
	}
	
	private function gameOver() {
		FlxG.camera.fade(FlxColor.BLACK, .33, false, doneFadeOut);
	}
	
	private function doneFadeOut():Void 
	{
		FlxG.switchState(new GameOverState());
	}
}