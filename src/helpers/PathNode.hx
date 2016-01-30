package helpers;
import flixel.FlxG;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;

/**
 * ...
 * @author Joaquin
 */
class PathNode
{
	
	var point:FlxPoint;
	public var points:Array<FlxPoint>;
	public function new(aPoint:FlxPoint) 
	{
		points = new Array();
		point = aPoint;
	}
	public function  addTarget(point:FlxPoint)
	{
		points.push(point);
	}
	public function randomDestination():FlxPoint
	{
		//var index = FlxRandom.intRanged(0, (points.length -1) );
		//return points[index];
		return point;
	}
	
}