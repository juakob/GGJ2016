package gameObjects;
import flixel.FlxG;

/**
 * ...
 * @author thepjteam
 */
class PoliceEnemy extends Enemy
{

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y, EnemyType.Police);	
		addAnimations();
	}
	
	private function addAnimations() {
		addFrontAnimation();
		addBackAnimation();
		addVerticalAnimation();
	}
	
	private function addFrontAnimation() {
		var framesByName:Array<String> =  new Array<String>();
		framesByName.push("policia_frente1.png");
		framesByName.push("policia_frente2.png");
		framesByName.push("policia_frente3.png");
		framesByName.push("policia_frente4.png");
		framesByName.push("policia_frente5.png");
		animation.addByNames("Front", framesByName, 12);
	}
	
	private function addBackAnimation() {
		var framesByName:Array<String> =  new Array<String>();
		framesByName.push("policia_atrás1.png");
		framesByName.push("policia_atrás2.png");
		framesByName.push("policia_atrás3.png");
		framesByName.push("policia_atrás4.png");
		framesByName.push("policia_atrás5.png");
		framesByName.push("policia_atrás6.png");
		animation.addByNames("Back", framesByName, 12);
	}
	
	private function addVerticalAnimation() {
		var framesByName:Array<String> =  new Array<String>();
		framesByName.push("policia_costado_1.png");
		framesByName.push("policia_costado_2.png");
		framesByName.push("policia_costado_3.png");
		framesByName.push("policia_costado_4.png");
		framesByName.push("policia_costado_5.png");
		framesByName.push("policia_costado_6.png");
		animation.addByNames("Horizontal", framesByName, 12);
	}
}