package gameObjects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxRandom;
import flixel.util.FlxPath;
import flixel.util.FlxPoint;
import flixel.util.loaders.TexturePackerData;
import openfl.Assets;
import helpers.PathNode;
import states.GameState;

/**
 * ...
 * @author thepjteam
 */
class Enemy extends FlxSprite
{

	var speedX:Float = 100;
	var speedY:Float = 100;
	var type:EnemyType;
	private var path:FlxPath;
	private var currentNode:Int;
	
	public function new(X:Float=0, Y:Float=0, type:EnemyType) 
	{
		super(X, Y);
		this.type = type;
		speedX = 100;
		speedY = 100;
		loadTexture();
		path = new FlxPath();
		currentNode = FlxRandom.intRanged(0, GameState.gamestate.nodes.length-1);
		resetPath();
	}
	
	override public function update():Void 
	{
		super.update();
		//velocity.add(speedX, speedY);
		if (path.finished)
		{
			resetPath();
		}
	}
	private function loadTexture() {
		FlxG.log.notice(Assets.getText("spritesheet/personajes.json"));
		var tex1:TexturePackerData = new TexturePackerData("spritesheet/personajes.json", "spritesheet/personajes.png");
		var frameName:String;
		switch (type) {
		case EnemyType.Farmer:
			frameName = "Granjero.png";
		case EnemyType.Kid:
			frameName = "Llorona.png";
		case EnemyType.Police:
			frameName = "Policia.png";
		}
		loadGraphicFromTexture(tex1, false, frameName);
	}
	
	private function resetPath():Void
	{
		currentNode = FlxRandom.intRanged(0, GameState.gamestate.nodes.length-1,[currentNode]);
			path.start(this, GameState.gamestate.map.findPath(FlxPoint.get(this.x, this.y), GameState.gamestate.nodes[currentNode].randomDestination()),speedX);
	}

	
	
	
	public function changeVelocity() {
		speedX = FlxRandom.floatRanged(-5, 5);
		speedY = FlxRandom.floatRanged( -5, 5);
	}
	
}