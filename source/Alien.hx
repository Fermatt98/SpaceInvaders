package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Alien extends FlxSprite
{

	public function new(?X:Float=0, ?Y:Float=0,?a:Int, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(8, 8);
		if (a == 0)
		{
			loadGraphic("assets/img/gif/alien_3.png"); 
		}
		if (a == 1 || a == 2)
		{
			loadGraphic("assets/img/gif/alien_2.png"); 
		}
		if (a == 3 || a == 4)
		{
			loadGraphic("assets/img/gif/alien_1.png"); 
		}
		x = X;
		y = Y;
		velocity.x = 5;
	}
}