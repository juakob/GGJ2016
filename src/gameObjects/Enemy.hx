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
	public var type(get, null):EnemyType;
	
	public function get_type():EnemyType {
		return type;
	}
	
	public var followigGirl:Bool;
	private var path:FlxPath;
	private var currentNode:Int;
	private var direction:Int; //-1 quieto, 0 abajo, 1 arriba, 2 derecha, 3 izquierda	
	private var realColor:Int;
	
	public function new(X:Float=0, Y:Float=0, type:EnemyType) 
	{
		super(X, Y);
		this.type = type;
	}	
	
	
	private function initAll() {
		speedX = 100;
		speedY = 100;
		loadTexture();
		addDeath();
		x -= width / 2;
		y -= height / 2;
		path = new FlxPath();
		currentNode = FlxRandom.intRanged(0, GameState.gamestate.nodes.length-1);
		resetPath();
		direction = -1;
		width = width / 2;
		height = height / 2;
		offset.set(width / 2, height / 2);
		realColor = color;
	}
	
	private function addAnimations() {
		addFrontAnimation();
		addBackAnimation();
		addHorizontalAnimation();
	}
	
	private function addFrontAnimation() {
		var framesByName:Array<String> =  new Array<String>();
		animation.addByNames("Front", framesByName, 12);
	}
	
	private function addBackAnimation() {
		var framesByName:Array<String> =  new Array<String>();
		animation.addByNames("Back", framesByName, 12);
	}
	
	private function addHorizontalAnimation() {
		var framesByName:Array<String> =  new Array<String>();
		animation.addByNames("Horizontal", framesByName, 12);
	}
	
	override public function update():Void 
	{
		super.update();
		if (type != EnemyType.LitleGirl) {
			if (followigGirl) {
				color = 0xff0000;
			} else {
				color = realColor;
			}
		}
		if (path.finished) {
			followigGirl = false;
			resetPath();
		} else {
			setAnimation();
		}
	}
	
	private function setAnimation() {
		var newDirection:Int;
		if (velocity.x > 0) {
			newDirection = 2;
		} else if (velocity.x < 0) {
			newDirection = 3;
		} else if (velocity.y > 0) {
			newDirection = 0;
		} else {
			newDirection = 1;
		}
		if (newDirection != direction) {
			direction = newDirection;
			switch(direction) {
				case 0:
					animation.play("Front");
					flipX = false;
				case 1:
					animation.play("Back");
					flipX = false;
				case 2:
					animation.play("Horizontal");
					flipX = false;
				case 3:
					animation.play("Horizontal");
					flipX = true;
			}
		}
	}
	public function die()
	{
		path.cancel();
		animation.play("Death");
	}
	private override function addDeath() {
		var framesByName:Array<String> =  new Array<String>();
		framesByName.push("nena_frente1.png");
		framesByName.push("nena_frente2.png");
		animation.addByNames("Death", framesByName, 12);
	}
	
	private function loadTexture() {
		var tex1:TexturePackerData = new TexturePackerData("spritesheet/personajes.json", "spritesheet/personajes.png");
		loadGraphicFromTexture(tex1);
	}
	
	private function resetPath():Void {
		currentNode = FlxRandom.intRanged(0, GameState.gamestate.nodes.length-1,[currentNode]);
		path.start(this, GameState.gamestate.mapAI.findPath(FlxPoint.get(this.x+width/2, this.y+height/2), GameState.gamestate.nodes[currentNode].randomDestination()),speedX);
	}
	
	public function pathTo(point:FlxPoint, extraSpeed:Float) {
		path.cancel();
		path.start(this, GameState.gamestate.mapAI.findPath(FlxPoint.get(this.x+width/2, this.y+height/2), point), speedX + extraSpeed);
	}

	public function changeVelocity() {
		speedX = FlxRandom.floatRanged(-5, 5);
		speedY = FlxRandom.floatRanged( -5, 5);
	}
	
}