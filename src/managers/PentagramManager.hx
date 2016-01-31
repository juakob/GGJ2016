package managers;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;
import gameObjects.EnemyType;
import gameObjects.Pentagram;
import gameObjects.Player;
import gameObjects.RitualObject;
import helpers.Constants;
import helpers.MapReader;
import openfl.Assets;

/**
 * ...
 * @author thepjteam
 */
class PentagramManager
{

	//PENTAGRAM VARS
	private var amountOfPentagrams:Int = 4;
	private var pentagrams:FlxTypedGroup<Pentagram>;
	private var ritualObjects:FlxTypedGroup<RitualObject>;
	private var tileSize:Int = Constants.TILE_SIZE;
	private var pentagramsActive:Array<Int>;
	var currentIndex:Int;
	
	public var positionsRitualObjects:Array<FlxPoint>;
	public var positionsPentagrams:Array<FlxPoint>;
	
	public var allPentagramsActives(get, null):Bool;
	private function get_allPentagramsActives():Bool {
		return allPentagramsActives;
	}
	
	public static function init()
	{
		instance = new PentagramManager();
	}
	public static var instance(get, null):PentagramManager;
    private static function get_instance():PentagramManager {
        if(instance == null) {
            instance = new PentagramManager();
        }
        return instance;
    }
	
	private function new() {
		pentagramsActive = new Array();
	}
	
	public function pentagramUpdate(player:Player) {
		checkRitualObjectsCollision(player);
		checkPentagramsCollision(player);
		checkWinCondition();	
	}
	
	public function initPentagrams(state:FlxState) {
		//PENTAGRAMS
		loadPentagramObjects(state);
		
		//RITUAL OBJECTS
		loadRitualObjects(state);
	}
	
	private function loadPentagramObjects(state:FlxState) {
		pentagrams = new FlxTypedGroup<Pentagram>();
		var pentagram:Pentagram;
		for (pos in positionsPentagrams)
		{
			pentagram = new Pentagram(pos.x, pos.y);
			pentagrams.add(pentagram);
		}
		
		state.add(pentagrams);
	}
	
	private function loadRitualObjects(state:FlxState) {
		ritualObjects = new FlxTypedGroup<RitualObject>();
		var ritualObject:RitualObject;
		
		for (pos in positionsRitualObjects)
		{
			ritualObject = new RitualObject(pos.x, pos.y);
			ritualObjects.add(ritualObject);
		}
		
		state.add(ritualObjects);
	}

	public function checkPentagramsCollision(player:Player) {
		var enemyManager = EnemyManager.instance;
		if (player.overlaps(pentagrams)) {
			var allPentagrams:Array<Pentagram> = pentagrams.members;
			var pentagram:Pentagram;
			var done:Bool = false;
			var pentaChecks:Int=0;
			while (!done) {
				pentagram = allPentagrams.shift();
				allPentagrams.push(pentagram);
				pentaChecks++;
				if (player.overlaps(pentagram) && pentagram.isCalling && joinRitualObjectAndPentagram(pentagram, player)) {
					done = true;
					pentagram.Activate();
					pentagramsActive.push(currentIndex);
					trace(currentIndex);
					
					enemyManager.loadEnemies(2, EnemyType.LitleGirl);
					enemyManager.loadEnemies(2, EnemyType.Police);
					enemyManager.loadEnemies(2, EnemyType.Farmer);
					
					//FlxG.log.advanced("Pentagram removed. Pentagrams checked: " + pentaChecks);
					
					//ME DESHAGO POR COMPLETO DEL OBJETO
					ritualObjects.remove(player.ritualObjectHold);
					player.ritualObjectHold.destroy();
					player.ritualObjectHold = null; //NO SE SI SERÍA NECESARIO, PERO POR LAS DUDAS...
				}else {
					if (pentaChecks > allPentagrams.length) {
						//FlxG.log.advanced("Revise " + pentaChecks + ". No puedo borrarlo");
						done = true;
					}
				}
			}
		}
	}
	
	public function joinRitualObjectAndPentagram(pentagram:Pentagram, player:Player):Bool {
		if (player.ritualObjectHold == null) {
			return false;
		}else {
			return player.ritualObjectHold.getType() == pentagram.getType();
		}
	}
	
	public function checkRitualObjectsCollision(player:Player) {
		if (player.overlaps(ritualObjects) && player.ritualObjectHold==null) {
			var allRitualObjects:Array<RitualObject> = ritualObjects.members;
			var ritualObject:RitualObject;
			var done:Bool = false;
			
			while (!done) {
				ritualObject = allRitualObjects.shift();
				if (ritualObject != null && player.overlaps(ritualObject)) {
					
					callingRandom();
					//if (player.ritualObjectHold != null) {
						////REVIVO EL OBJETO VIEJO; PENSADO PARA PODER LEVANTAR OBJETOS DISTINTOS PARA CIRCULOS DISTINTOS
						//var adjustmentX:Float = 0;
						//var adjustmentY:Float = 0;
						//if (player.velocity.x != 0) {
							//adjustmentX = (Math.abs(player.velocity.x) / player.velocity.x) * -1 * player.width;
						//}
						//if (player.velocity.y != 0) {
							//adjustmentY = (Math.abs(player.velocity.y) / player.velocity.y) * -1 * player.height;
						//}
						//FlxG.log.advanced("X: "+ adjustmentX+"Y: "+adjustmentY);
						//player.ritualObjectHold.x = player.x+adjustmentX;
						//player.ritualObjectHold.y = player.y+adjustmentY;
//
						//player.ritualObjectHold.revive();
					//}
					//TOMO EL NUEVO OBJETO
					player.ritualObjectHold = ritualObject;
					//ritualObject.kill();
					
					done = true;
				}
				//SIEMPRE LO DEVOLVEMOS AL ARRAY PORQUE SE DESTRUYEN AL LLEVARLO AL CIRCULO DEL RITUAL
				allRitualObjects.push(ritualObject);
			}
		}
	}
	public function callingRandom():Void
	{
		currentIndex = FlxRandom.intRanged(0, pentagrams.members.length - 1);
		while (true)
		{
			if (!pentagrams.members[currentIndex].isActive)
			{
				pentagrams.members[currentIndex].Calling();
				return;
			}
			currentIndex =++currentIndex % pentagrams.length;
		}
	}
	
	public function checkWinCondition():Void {
		allPentagramsActives = true;
		
		pentagrams.forEach(checkAllPentagrams);
	}
	
	private function checkAllPentagrams(pentagram:Pentagram):Void {
		if (!pentagram.isActive) {
			allPentagramsActives = false;
		}
	}
}