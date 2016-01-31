package managers;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;
import gameObjects.Enemy;
import gameObjects.EnemyType;
import gameObjects.LitleGirldEnemy;
import gameObjects.Player;
import gameObjects.PoliceEnemy;
import states.GameState;

/**
 * ...
 * @author thepjteam
 */
class EnemyManager
{	
	public var gameOver(get, null):Bool;
	public function get_gameOver():Bool {
		return gameOver;
	}
	
	private var auxCryingLitleGirl:LitleGirldEnemy;
	
	public var enemies(get, null):FlxGroup;
	private function get_enemies():FlxGroup {
        if(enemies == null) {
            enemies = new FlxGroup();
        }
        return enemies;
    }

	public static var instance(get, null):EnemyManager;
    private static function get_instance():EnemyManager {
        if(instance == null) {
            instance = new EnemyManager();
        }
        return instance;
    }
	
	private function new() {
		
	}
	
	public function loadDefaultEnemyes(game:FlxState) {

		loadEnemies( 2, EnemyType.Farmer);
		loadEnemies(2, EnemyType.LitleGirl);
		loadEnemies( 2, EnemyType.Police);
	}
	private function randomPos():FlxPoint
	{
		var index = FlxRandom.intRanged(0, GameState.gamestate.nodes.length - 1);
		return GameState.gamestate.nodes[index].randomDestination();
	}
	public function loadEnemies( cuantity:Int, type:EnemyType) {
		var game = GameState.gamestate;
		var enemy:Enemy;
		for (i in 0...cuantity) {
			enemy = getEnemyForType(type);
			enemies.add(enemy);
			game.add(enemy);
		}
	}
	
	private function getEnemyForType(type:EnemyType):Enemy {
		var pos:FlxPoint;
		pos = randomPos();
		switch (type) {
			case EnemyType.Police:
				return new PoliceEnemy(pos.x, pos.y);
			case EnemyType.LitleGirl:
				return new LitleGirldEnemy(pos.x, pos.y);
			case EnemyType.Farmer:
				return new PoliceEnemy(pos.x, pos.y);
		}
	}
	
	public function enemyUpdates(map:FlxTilemap, player:Player) {
		gameOver = false;
		//FlxG.collide(enemies, map, enemyMapCollide);
		FlxG.overlap(enemies, player, enemyPlayer);
		FlxG.collide(enemies, null, enemyEnemyCollide);
	}
	
	private function enemyMapCollide(enemy:Enemy, map:FlxTilemap):Void {
		enemy.changeVelocity();
	}

	private function enemyPlayer(enemy:Enemy, player:Player):Void {
		if (enemy.type == EnemyType.LitleGirl) {
			var lg:LitleGirldEnemy = cast(enemy, LitleGirldEnemy);
			if (lg.cry()) {
				FlxG.sound.play("sounds/scream.mp3");
				FlxG.sound.play("sounds/ohh.mp3");
				FlxG.sound.play("sounds/ohh.mp3");
				FlxG.sound.play("sounds/ohh.mp3");
				/*var timer = new haxe.Timer(1000); // 1000ms delay
				timer.run = function() { FlxG.sound.play("sounds/ohh.mp3"); this.stop(); };*/
				auxCryingLitleGirl = lg;
				enemies.forEachAlive(followCryingLiltleGirl);
			}
		} else {
			player.isCaught = true;
			gameOver = true;
		}
	}
	
	private function followCryingLiltleGirl(enemy:FlxBasic):Void {
		var realEnemy:Enemy = cast(enemy, Enemy);
		if (realEnemy.type != EnemyType.LitleGirl) {
			if (auxCryingLitleGirl != null) {
				var point:FlxPoint =  new FlxPoint(auxCryingLitleGirl.x+auxCryingLitleGirl.width/2, auxCryingLitleGirl.y+auxCryingLitleGirl.height/2);
				realEnemy.pathTo(point, 100);
				realEnemy.followigGirl = true;
			}
		}
	}
	
	private function enemyEnemyCollide(enemy:Enemy, player:Enemy):Void {
		enemy.changeVelocity();
	}
}