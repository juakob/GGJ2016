package gameObjects;

/**
 * ...
 * @author thepjteam
 */
class Police extends Enemy
{

	public function new(X:Float=0, Y:Float=0, type:EnemyType) 
	{
		super(X, Y, type);	
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
		framesByName.push("policia_atras1.png");
		framesByName.push("policia_atras2.png");
		framesByName.push("policia_atras3.png");
		framesByName.push("policia_atras4.png");
		framesByName.push("policia_atras5.png");
		framesByName.push("policia_atras6.png");
		animation.addByNames("Back", framesByName, 12);
	}
	
	private function addVerticalAnimation() {
		var framesByName:Array<String> =  new Array<String>();
		framesByName.push("policia_costado1.png");
		framesByName.push("policia_costado2.png");
		framesByName.push("policia_costado3.png");
		framesByName.push("policia_costado4.png");
		framesByName.push("policia_costado5.png");
		framesByName.push("policia_costado6.png");
		animation.addByNames("Horizontal", framesByName, 12);
	}
}