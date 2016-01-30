package gameObjects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxRandom;
import flixel.util.FlxPath;
import flixel.util.FlxPoint;
import flixel.util.loaders.TexturePackerData;
import openfl.Assets;
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

	public function new(X:Float=0, Y:Float=0, type:EnemyType) 
	{
		super(X, Y);
		this.type = type;
		speedX = FlxRandom.floatRanged(-5, 5);
		speedY = FlxRandom.floatRanged( -5, 5);
		loadTexture();
	}
	
	private function loadTexture() {
		FlxG.log.notice(Assets.getText("spritesheet/personajes.json"));
		var tex1:TexturePackerData = new TexturePackerData("spritesheet/personajes.json", "spritesheet/personajes.png");
		var frameName:String;
		switch (type) {
		case EnemyType.Cultist:
			frameName = "Cultista.png";
		case EnemyType.Farmer:
			frameName = "Granjero.png";
		case EnemyType.Kid:
			frameName = "Llorona.png";
		case EnemyType.Police:
			frameName = "Policia.png";
		}
		loadGraphicFromTexture(tex1, false, frameName);
	}
	
	
	public function pathfinding() {
		var player:Player = GameState.gamestate.player;
		var pathPoints:Array<FlxPoint> = GameState.gamestate.map.findPath(FlxPoint.get(this.x + this.width / 2, this.y + this.height / 2), FlxPoint.get(player.x + player.width / 2, player.y + player.height / 2));
		
		if (pathPoints != null) {
			//path.start(this, pathPoints);
		}
		
	}

	override public function update():Void 
	{
		super.update();
		velocity.add(speedX, speedY);
	}
	
	public function changeVelocity() {
		speedX = FlxRandom.floatRanged(-5, 5);
		speedY = FlxRandom.floatRanged( -5, 5);
	}
	
}