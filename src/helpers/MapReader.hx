package helpers;
import flixel.util.FlxPoint;

/**
 * ...
 * @author Joaquin
 */
class MapReader
{

	public function detect(aIndex:Int, aMap:String,aTileSize:Int):Array<FlxPoint>
	{
		var points:Array<FlxPoint> = new Array();
		
		aMap = StringTools.rtrim(aMap);
		var rows=MapData.split("\n");
		var rowValues:Array<String>;
		var rowIndex:Int = 0;
		for (row in rows) 
		{
			var columnIndex:Int = 0;
			rowValues = aMap.split(",");
			for (values in rowValues) 
			{
				if (values == aIndex)
				{
					points.push(new FlxPoint(rowIndex*aTileSize, columnIndex*aTileSize));
				}
			}
			++rowIndex;
		}
		return points;
		
	}
}