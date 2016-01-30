package gameObjects;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.loaders.TexturePackerData;

/**
 * ...
 * @author Joaquin
 */
class Player extends FlxSprite
{
	private static var maxVel:Int = 260;
	private static var rozamiento:Float = 0.95;
	
	private var speedX:Float = 20;
	private var speedY:Float = 20;
	private var originalSacleX:Float;
	
	public var ritualObjectHold:RitualObject;
	
	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		loadTexture();
		addAnimations();
	}
	
	private function loadTexture() {
		var tex1:TexturePackerData = new TexturePackerData("spritesheet/personajes.json", "spritesheet/personajes.png");
		loadGraphicFromTexture(tex1);
		originalSacleX = scale.x;
	}
	
	private function addAnimations() {
		addFrontAnimation();
		addBackAnimation();
		addVerticalAnimation();
	}
	
	private function addFrontAnimation() {
		var framesByName:Array<String> =  new Array<String>();
		framesByName.push("Ariel_frente1.png");
		framesByName.push("Ariel_frente2.png");
		animation.addByNames("Front", framesByName, 12);
	}
	
	private function addBackAnimation() {
		var framesByName:Array<String> =  new Array<String>();
		framesByName.push("Ariel_atras1.png");
		framesByName.push("Ariel_atras2.png");
		animation.addByNames("Back", framesByName, 12);
	}
	
	private function addVerticalAnimation() {
		var framesByName:Array<String> =  new Array<String>();
		framesByName.push("Ariel_costado1.png");
		framesByName.push("Ariel_costado2.png");
		framesByName.push("Ariel_costado3.png");
		animation.addByNames("Vertical", framesByName, 18);
	}
	
	override public function update():Void 
	{
		super.update();
		var moveX:Bool = false;
		var moveY:Bool = false;
		
		if (FlxG.keys.pressed.LEFT)
		{
			velocity.add( -speedX, 0);
			moveX = true;
			animation.play("Vertical");
			flipX = true;
		}  
		if (FlxG.keys.pressed.RIGHT)
		{
			velocity.add(speedX, 0);
			moveX = true;
			animation.play("Vertical");
			flipX = false;
		} 
		if (FlxG.keys.pressed.UP)
		{
			velocity.add(0, -speedY);
			moveY = true;
			animation.play("Back");
			flipX = false;
		} 
		if (FlxG.keys.pressed.DOWN)
		{
			velocity.add(0, speedY);
			moveY = true;
			animation.play("Front");
			flipX = false;
		} 
		if (velocity.x > maxVel) {
			velocity.x = maxVel;
		}
		if (velocity.x < -maxVel) {
			velocity.x = -maxVel;
		}
		
		if (velocity.y > maxVel) {
			velocity.y = maxVel;
		}
		
		if (velocity.y < -maxVel) {
			velocity.y = -maxVel;
		}
			
		if (!moveX) {
			velocity.x *= rozamiento;
		}
		if (!moveY) {
			velocity.y *= rozamiento;
		}
		if (!moveX && !moveY) {
			animation.pause();
		}
	}
}