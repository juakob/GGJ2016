package states;

import flash.desktop.Clipboard;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import helpers.Constants;
import managers.PentagramManager;

import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;
import gameObjects.Enemy;
import gameObjects.Pentagram;
import flixel.util.FlxColor;
import flixel.util.FlxRandom;
import gameObjects.Enemy;
import gameObjects.EnemyType;
import gameObjects.Player;
import gameObjects.RitualObject;
import managers.EnemyManager;
import helpers.PathNode;
import openfl.Assets;

/**
 * ...
 * @author Joaquin
 */
class GameState extends FlxState
{
	public static var gamestate:GameState;
	
	public var nodes:Array<PathNode>;
	
	public var map:FlxTilemap;
	//PLAYER VARS
	public var player:Player;
	
	//ENEMY VARS
	var amountEnemies:Int=1;
	var enemies:FlxTypedGroup<Enemy>;
	
	private var tileSize:Int = Constants.TAIL_SIZE;
	
	public function new() 
	{
		super();
		gamestate = this;
		nodes = new Array();
		var node:PathNode = new PathNode();
		node.addTarget(new FlxPoint(7*40, 40*2));
		nodes.push(node);
		node = new PathNode();
		node.addTarget(new FlxPoint(27*40, 14*40));
		nodes.push(node);
		
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
		
		PentagramManager.instance.checkRitualObjectsCollision(player);
		
		EnemyManager.instance.enemyUpdates(map, player, gameOver);
		PentagramManager.instance.checkPentagramsCollision(player);
		PentagramManager.instance.checkWinCondition();
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
		EnemyManager.instance.loadDefaultEnemyes(this);
	}
	
	private function initPentagrams() {
		PentagramManager.instance.initPentagrams(this);
	}
	
	private function gameOver() {
		FlxG.camera.fade(FlxColor.BLACK, .33, false, doneFadeOut);
	}
	
	private function doneFadeOut():Void 
	{
		FlxG.switchState(new GameOverState());
	}
}