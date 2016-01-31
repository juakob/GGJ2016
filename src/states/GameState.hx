package states;

import flash.desktop.Clipboard;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import helpers.Constants;
import helpers.MapReader;
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
	public var mapAI:FlxTilemap;
	
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
		
		
	}
	
	override public function create():Void 
	{
		initMap();
		initAIMap();
		var extras = Assets.getText("map/level1_extras.csv");
		initAINodes(extras);
		initPlayer();
		initEnemies();
		initPentagrams(extras);
	}
	
	override public function update():Void 
	{
		super.update();
		FlxG.collide(map, player);
		player.updateRitualObjectPosition();
		EnemyManager.instance.enemyUpdates(map, player);
		PentagramManager.instance.pentagramUpdate(player);
		checkGameOver();
		checkGameWin();
	}
	private function initAINodes(aMap:String)
	{
		nodes = new Array();
		var positions = MapReader.detect(2, aMap, tileSize);
		for (position in positions) 
		{
			nodes.push(new PathNode(position));
		}
	}
	private function initMap() {
		map = new FlxTilemap();
		map.loadMap(Assets.getText("map/level1_collision.csv"), "img/tiles.png", 40, 40);
		map.allowCollisions = FlxObject.ANY;
		map.setTileProperties(2, FlxObject.NONE);
		add(map);
	}
	
	private function initAIMap()
	{
		mapAI = new FlxTilemap();
		mapAI.loadMap(Assets.getText("map/level1_tilesCollisionAI.csv"), "img/tiles.png", 40, 40);
		mapAI.allowCollisions = FlxObject.ANY;
		add(mapAI);
	}
	
	private function initPlayer() {
		player = new Player(16*tileSize, 9*tileSize);
		add(player);
	}
	
	private function initEnemies() {
		EnemyManager.instance.loadDefaultEnemyes(this);
	}
	
	private function initPentagrams(aExtra:String) {
		PentagramManager.instance.positionsPentagrams = MapReader.detect(4, aExtra, 40);
		PentagramManager.instance.positionsRitualObjects=MapReader.detect(5, aExtra, 40);
		PentagramManager.instance.initPentagrams(this);
	}
	
	private function checkGameOver() {
		if (EnemyManager.instance.gameOver) {
			FlxG.camera.fade(FlxColor.BLACK, .33, false, switchGameOver);
		}
	}
	
	private function switchGameOver():Void  {
		FlxG.switchState(new GameOverState());
	}
	
	private function checkGameWin() {
		if (PentagramManager.instance.allPentagramsActives) {
			FlxG.camera.fade(FlxColor.WHITE, .33, false, switchWin);
		}
	}
	
	private function switchWin():Void  {
		FlxG.switchState(new states.WinState());
	}
}