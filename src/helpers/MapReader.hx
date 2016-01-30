package helpers;
import flixel.util.FlxPoint;

/**
 * ...
 * @author Joaquin
 */
class MapReader
{

	public static function detect(aIndex:Int, aMap:String,aTileSize:Int):Array<FlxPoint>
	{
		var points:Array<FlxPoint> = new Array();
		
		aMap = StringTools.rtrim(aMap);
		var rows=aMap.split("\n");
		var rowValues:Array<String>;
		var rowIndex:Int = 0;
		var columnIndex:Int = 0;
		for (row in rows) 
		{
			columnIndex = 0;
			rowValues = row.split(",");
			for (values in rowValues) 
			{
				if (Std.parseInt(values) == aIndex)
				{
					points.push(new FlxPoint(columnIndex*aTileSize+aTileSize/2, rowIndex*aTileSize+aTileSize/2));
				}
				++columnIndex;
			}
			++rowIndex;
		}
		return points;
		
	}
}