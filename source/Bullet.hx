package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Bullet extends FlxSprite
{

	public function new(?X:Float=0, ?Y:Float=0, direccion:Int, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(2, 4);
		x = X - (width / 2);
		y = Y - (height / 2);
		velocity.y = -200 * direccion;
	}
}