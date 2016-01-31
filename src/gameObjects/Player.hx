package gameObjects;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.XboxButtonID;
import flixel.system.FlxSound;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.util.loaders.TexturePackerData;
import helpers.Constants;
import states.GameState;

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
	
	private var frontFrame:String;
	private var frontHandFrame:String;
	
	private var backFrame:String;
	private var backHandFrame:String;
	
	private var horizontalFrame:String;
	private var horizontalHandFrame:String;
	
	private var currentFrameString:String;
	
	public var isCaught:Bool = false;
	
	private var isMoving:Bool;
	
	private var playerWalk:FlxSound;
	
	public function new(X:Float=0, Y:Float=0) 
	{
		frontFrame = "Ariel_frente1.png";
		frontHandFrame = "Ariel_mano_frente1.png";
		backFrame = "Ariel_atras1.png";
		backHandFrame = "Ariel_mano_artas1.png";
		horizontalFrame = "Ariel_costado1.png";
		horizontalHandFrame = "Ariel_mano_costado1.png";
		
		super(X, Y);
		loadTexture();
		
		width = width / 2;
		height = height / 2;
		offset.set(width / 2, height / 2);
		addAnimations();
		playerWalk = FlxG.sound.load("sounds/walk2.mp3", 1, true);
	}
	
	private function loadTexture() {
		var tex1:TexturePackerData = new TexturePackerData("spritesheet/personajes.json", "spritesheet/personajes.png");
		loadGraphicFromTexture(tex1);
		originalSacleX = scale.x;
	}
	
	private function addAnimations() {
		addFrontAnimation();
		addBackAnimation();
		addHorizontalAnimation();
	}
	
	private function addFrontAnimation() {
		var framesByName:Array<String> =  new Array<String>();
		framesByName.push("Ariel_frente1.png");
		framesByName.push("Ariel_frente2.png");
		animation.addByNames("Front", framesByName, 12);
		
		framesByName =  new Array<String>();
		framesByName.push("Ariel_manos_frente1.png");
		framesByName.push("Ariel_manos_frente2.png");
		animation.addByNames("FrontHands", framesByName, 12);
	}
	
	private function addBackAnimation() {
		var framesByName:Array<String> =  new Array<String>();
		framesByName.push("Ariel_atras1.png");
		framesByName.push("Ariel_atras2.png");
		animation.addByNames("Back", framesByName, 12);
		
		framesByName =  new Array<String>();
		framesByName.push("Ariel_manos_atras1.png");
		framesByName.push("Ariel_manos_atras2.png");
		animation.addByNames("BackHands", framesByName, 12);
	}
	
	private function addHorizontalAnimation() {
		var framesByName:Array<String> =  new Array<String>();
		framesByName.push("Ariel_costado1.png");
		framesByName.push("Ariel_costado2.png");
		framesByName.push("Ariel_costado3.png");
		animation.addByNames("Horizontal", framesByName, 18);
		
		framesByName =  new Array<String>();
		framesByName.push("Ariel_manos_costado1.png");
		framesByName.push("Ariel_manos_costado2.png");
		framesByName.push("Ariel_manos_costado3.png");
		animation.addByNames("HorizontalHands", framesByName, 18);
	}
	
	private function warp()
	{
		if (x < -5)
		{
			x = 1280;
		}
		if (x > 1285)
		{
			x = 0;
		}
		if (y < -5)
		{
			y = 720;
		}
		if (y > 725)
		{
			y = 0;
		}
	}
	
	override public function update():Void 
	{
		super.update();
		if (!isCaught) {
			move();
			checkTiles();
			warp();	
		}else {
			this.velocity.x = 0;
			this.velocity.y = 0;
		}
	}
	
	public function checkTiles() {
		var tileMap:FlxTilemap = GameState.gamestate.map;
		var posX:Int = Std.int(Std.int(this.x+this.width/2)/Constants.TILE_SIZE);
		var posY:Int = Std.int(Std.int(this.y+this.height/2)/Constants.TILE_SIZE);
		var tile:Int = tileMap.getTile(posX, posY);
		//FlxG.log.advanced("X: "+posX+" Y: "+posY);
		if (tile == 2) {
			this.velocity.x /= 2;
			this.velocity.y /= 2;
		}
	}
	
	public function move() {
		var moveX:Bool = false;
		var moveY:Bool = false;
		
		if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.A)
		{
			velocity.add( -speedX, 0);
			moveX = true;
			if (ritualObjectHold != null) {
				animation.play("HorizontalHands");
				currentFrameString = horizontalHandFrame;
			} else {
				animation.play("Horizontal");
				currentFrameString = horizontalFrame;
			}
			flipX = true;
		}  
		if (FlxG.keys.pressed.RIGHT||FlxG.keys.pressed.D)
		{
			velocity.add(speedX, 0);
			moveX = true;
			if (ritualObjectHold != null) {
				animation.play("HorizontalHands");
				currentFrameString = horizontalHandFrame;
			} else {
				animation.play("Horizontal");
				currentFrameString = horizontalFrame;
			}
			flipX = false;
		} 
		if (FlxG.keys.pressed.UP|| FlxG.keys.pressed.W)
		{
			velocity.add(0, -speedY);
			moveY = true;
			if (ritualObjectHold != null) {
				animation.play("BackHands");
				currentFrameString = backHandFrame;
			} else {
				animation.play("Back");
				currentFrameString = backFrame;
			}
			flipX = false;
		} 
		if (FlxG.keys.pressed.DOWN || FlxG.keys.pressed.S)
		{
			velocity.add(0, speedY);
			moveY = true;
			if (ritualObjectHold != null) {
				animation.play("FrontHands");
				currentFrameString = frontHandFrame;
			} else {
				animation.play("Front");
				currentFrameString = frontFrame;
			}
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
			isMoving = false;
			/*if (playerWalk.playing) {
				playerWalk.stop();
			}*/
			animation.pause();
			animation.frameName = currentFrameString;
		} else {
			if (!isMoving) {
				isMoving = true;	
				//playerWalk.play(true);
			}
			
		}
	}
	
	public function updateRitualObjectPosition() {
		if (ritualObjectHold != null) {
			ritualObjectHold.x = x;
			ritualObjectHold.y = y - ritualObjectHold.height;
		}
	}
}