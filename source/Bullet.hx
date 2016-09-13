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
		loadGraphic("assets/img/gif/disparo.png");
		x = X - (width / 2);
		y = Y - (height / 2);
		velocity.y = -200 * direccion;
		if (direccion == -1)
		{
			loadGraphic("assets/img/gif/disparo_alien.png");
			trace("DISPARO ALIEN");
		}
	}
}