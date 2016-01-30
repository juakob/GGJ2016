package managers;
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
import gameObjects.Player;
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

		instance.loadEnemyes(game, 1, EnemyType.Farmer);
		instance.loadEnemyes(game, 1, EnemyType.Kid);
		loadEnemyes(game, 1, EnemyType.Police);
	}
	private function randomPos():FlxPoint
	{
		var index = FlxRandom.intRanged(0, GameState.gamestate.nodes.length-1);
		return GameState.gamestate.nodes[index].randomDestination();
	}
	public function loadEnemyes(game:FlxState, cuantity:Int, type:EnemyType) {
		var enemy:Enemy;
		var pos:FlxPoint;
		for (i in 0...cuantity) {
			pos = randomPos();
			enemy = new Enemy(pos.x, pos.y, type);
			enemies.add(enemy);
			game.add(enemy);
		}
	}
	
	public function enemyUpdates(map:FlxTilemap, player:Player) {
		gameOver = false;
		FlxG.collide(enemies, map, enemyMapCollide);
		FlxG.overlap(enemies, player, enemyPlayer);
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