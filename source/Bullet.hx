package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Bullet extends FlxSprite
{

	public function new(?X:Float=0, ?Y:Float=0, ?direccion:Int=1, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(2, 4);
		loadGraphic("assets/img/gif/disparo.png");
		x = X - (width / 2);
		y = Y - (height / 2);
		if (direccion == 1)
		{
			velocity.y = -200 * direccion;
		}
		else
		{
			velocity.y = -100 * direccion;
		}
		if (direccion == -1)
		{
			loadGraphic("assets/img/gif/disparo_alien.png");
		}
	}
}