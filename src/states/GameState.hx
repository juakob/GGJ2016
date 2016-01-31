package states;

import flash.desktop.Clipboard;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.util.loaders.TexturePackerData;
import gameObjects.Arbusto;
import gameObjects.Caldero;
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
	public var hackWall:FlxGroup;
	public var mapAI:FlxTilemap;
	
	//PLAYER VARS
	public var player:Player;
	
	//ENEMY VARS
	var amountEnemies:Int=1;
	var enemies:FlxTypedGroup<Enemy>;
	
	private var tileSize:Int = Constants.TILE_SIZE;
	
	//EXTRAS
	var caldero:Caldero;
	var pastos:FlxTypedGroup<Arbusto>;
	
	public function new() 
	{
		super();
		gamestate = this;		
		//FlxG.sound.load("sounds/backgroundMusic.mp3",1,true);
		
	}
	private function createBlock(x:Float,y:Float)
	{
		var block:FlxSprite = new FlxSprite(x*tileSize, y*tileSize);
		block.makeGraphic(tileSize, tileSize);
		block.immovable = true;
		hackWall.add(block);
	}
	
	override public function create():Void 
	{
		FlxG.sound.playMusic("sounds/backgroundMusic.mp3");
		PentagramManager.init();
		initMap();
		createHackWalls();
		initAIMap();
		var extras = Assets.getText("map/level1_extras.csv");
		initAINodes(extras);
		initPlayer();
		initEnemies();
		initPentagrams(extras);
		
		initExtras();
	}
	
	public function initExtras() {
		caldero = new Caldero((16*tileSize)-Constants.TILE_SIZE/3, (9*tileSize) - Constants.TILE_SIZE*(2/3));
		add(caldero);
	}
	
	override public function update():Void 
	{
		super.update();
		FlxG.collide(map, player);
		FlxG.collide(hackWall, player);
		player.updateRitualObjectPosition();
		//EnemyManager.instance.enemyUpdates(map, player);
		PentagramManager.instance.pentagramUpdate(player);
		FlxG.collide(player, caldero);
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
		
		//var positionsBushe = MapReader.detect(1, aMap, tileSize);
		//pastos = new FlxTypedGroup<Arbusto>();
		//var arbusto:Arbusto;
		//var posX:Float;
		//var posY:Float;
		//for (position in positions) {
			////CREATE BUSHES
			//posX = position.x - Constants.TILE_SIZE / 2 - Constants.TILE_SIZE;
			//posY = position.y - Constants.TILE_SIZE / 2 - Constants.TILE_SIZE;
			//arbusto = new Arbusto(posX, posY);
			//pastos.add(arbusto);
			//add(arbusto);
		//}
	}
	private function initMap() {
		map = new FlxTilemap();
		map.loadMap(Assets.getText("map/level1_collision.csv"), "img/tiles.png", 40, 40);
		map.allowCollisions = FlxObject.ANY;
		map.setTileProperties(2, FlxObject.NONE);
		add(map);
		
		var mapVisual:FlxSprite = new FlxSprite(0, 0);
		mapVisual.loadGraphic("img/test_level_fondo.png");		
		add(mapVisual);
	}
	private function createHackWalls()
	{
		hackWall = new FlxGroup();
		createBlock( -1, 7);
		createBlock( -1, 9);
		createBlock(4, -1);
		createBlock(6, -1);
		createBlock(25, -1);
		createBlock(27, -1);
		createBlock(32, 7);
		createBlock(32, 9);
		createBlock(4, 18);
		createBlock(6, 18);
		createBlock(25, 18);
		createBlock(27, 18);
	}
	private function initAIMap()
	{
		mapAI = new FlxTilemap();
		mapAI.loadMap(Assets.getText("map/level1_tilesCollisionAI.csv"), "img/tiles.png", 40, 40);
		mapAI.allowCollisions = FlxObject.ANY;
	//	add(mapAI);
	}
	
	private function initPlayer() {
		player = new Player(15*tileSize, 8*tileSize);
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
	
	private var isdeath:Bool;
	private function checkGameOver() {
		if (EnemyManager.instance.gameOver && !isdeath) {
			isdeath = true;
			FlxG.sound.play("sounds/death.mp3");
			FlxG.camera.fade(FlxColor.BLACK, .80, false, switchGameOver);
		}
	}
	
	private function switchGameOver():Void  {
		FlxG.switchState(new GameOverState());
	}
	
	private function checkGameWin() {
		if (PentagramManager.instance.allPentagramsActives) {
			caldero.initDemon();
			if (FlxG.keys.pressed.ENTER) {
				FlxG.camera.fade(FlxColor.WHITE, 0.5, false, switchWin);
			}
		}
	}
	
	private function switchWin():Void  {
		FlxG.switchState(new states.WinState());
	}
}