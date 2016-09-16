package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Ovni extends FlxSprite
{

	public function new(?X:Float=160, ?Y:Float=10, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(16, 8);
		loadGraphic("assets/img/gif/ovni.png");
		velocity.x = -40;
	}
}