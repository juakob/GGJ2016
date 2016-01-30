package managers;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.util.FlxRandom;
import gameObjects.Enemy;
import gameObjects.EnemyType;
import gameObjects.Player;

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
		instance.loadEnemyes(game, 1, EnemyType.Farmer, 400, 100);
		instance.loadEnemyes(game, 1, EnemyType.Kid, 500, 500);
		loadEnemyes(game, 1, EnemyType.Police, 400, 600);
	}

	public function loadEnemyes(game:FlxState, cuantity:Int, type:EnemyType, x:Float, y:Float) {
		var enemy:Enemy;
		for (i in 0...cuantity) {
			enemy = new Enemy(x, y, type);
			enemies.add(enemy);
			game.add(enemy);
		}
	}
	
	public function enemyUpdates(map:FlxTilemap, player:Player) {
		gameOver = false;
		FlxG.collide(enemies, map, enemyMapCollide);
		FlxG.collide(enemies, player, enemyPlayer);
		FlxG.collide(enemies, null, enemyEnemyCollide);
	}
	
	private function enemyMapCollide(enemy:Enemy, map:FlxTilemap):Void {
		enemy.changeVelocity();
	}

	private function enemyPlayer(enemy:Enemy, player:Player):Void {
		gameOver = true;
	}
	
	private function enemyEnemyCollide(enemy:Enemy, player:Enemy):Void {
		enemy.changeVelocity();
	}
}