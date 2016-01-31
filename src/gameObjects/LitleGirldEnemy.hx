package gameObjects;

/**
 * ...
 * @author thepjteam
 */
class LitleGirldEnemy extends Enemy
{

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y, EnemyType.LitleGirl);
	addAnimations();
	}
	
	private function addAnimations() {
		addFrontAnimation();
		addBackAnimation();
		addHorizontalAnimation();
		addCryingAnimation();
	}
	
	private function addFrontAnimation() {
		var framesByName:Array<String> =  new Array<String>();
		framesByName.push("nena_frente1.png");
		framesByName.push("nena_frente2.png");
		animation.addByNames("Front", framesByName, 12);
	}
	
	private function addBackAnimation() {
		var framesByName:Array<String> =  new Array<String>();
		framesByName.push("nena_atras1.png");
		framesByName.push("nena_atras2.png");
		animation.addByNames("Back", framesByName, 12);
	}
	
	private function addHorizontalAnimation() {
		var framesByName:Array<String> =  new Array<String>();
		framesByName.push("nena_costado1.png");
		framesByName.push("nena_costado2.png");
		framesByName.push("nena_costado3.png");
		framesByName.push("nena_costado4.png");
		animation.addByNames("Horizontal", framesByName, 12);
	}
	
	private function addCryingAnimation() {
		var framesByName:Array<String> =  new Array<String>();
		framesByName.push("nena_llorando1.png");
		framesByName.push("nena_llorando2.png");
		framesByName.push("nena_llorando3.png");
		framesByName.push("nena_llorando4.png");
		framesByName.push("nena_llorando5.png");
		framesByName.push("nena_llorando6.png");
		framesByName.push("nena_llorando7.png");
		framesByName.push("nena_llorando8.png");
		animation.addByNames("Crying", framesByName, 12);
	}
}