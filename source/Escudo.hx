package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Escudo extends FlxSprite
{
	private var vida = 4;

	public function new(?X:Float=0, ?Y:Float=0, ?n_img:Int, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(6, 8);
		switch(n_img)
		{
			case 0:loadGraphic("assets/img/gif/escudo_1.png");
			case 1:loadGraphic("assets/img/gif/escudo_2.png");
			case 2:loadGraphic("assets/img/gif/escudo_3.png");
			case 3:loadGraphic("assets/img/gif/escudo_4.png");
			case 4:loadGraphic("assets/img/gif/escudo_5.png");
			case 5:loadGraphic("assets/img/gif/escudo_6.png");
			case 6:loadGraphic("assets/img/gif/escudo_7.png");
			case 7:loadGraphic("assets/img/gif/escudo_8.png");
		}
	}
	public function lastimado(a:Int):Int
	{
		vida = vida - 1;
		switch(a)
		{
			case 0:
				switch(vida)
				{
					case 1:loadGraphic("assets/img/gif/escudo_1_4.png");
					case 2:loadGraphic("assets/img/gif/escudo_1_3.png");
					case 3:loadGraphic("assets/img/gif/escudo_1_2.png");
					//default:;
				}
			case 1:
				switch(vida)
				{
					case 1:loadGraphic("assets/img/gif/escudo_2_4.png");
					case 2:loadGraphic("assets/img/gif/escudo_2_3.png");
					case 3:loadGraphic("assets/img/gif/escudo_2_2.png");
					//default:;
				}
			case 2:
				switch(vida)
				{
					case 1:loadGraphic("assets/img/gif/escudo_2_4.png");
					case 2:loadGraphic("assets/img/gif/escudo_2_3.png");
					case 3:loadGraphic("assets/img/gif/escudo_2_2.png");
					//default:;
				}
			case 3:
				switch(vida)
				{
					case 1:loadGraphic("assets/img/gif/escudo_4_4.png");
					case 2:loadGraphic("assets/img/gif/escudo_4_3.png");
					case 3:loadGraphic("assets/img/gif/escudo_4_2.png");
					//default:;
				}
			case 4:
				switch(vida)
				{
					case 1:loadGraphic("assets/img/gif/escudo_2_4.png");
					case 2:loadGraphic("assets/img/gif/escudo_2_3.png");
					case 3:loadGraphic("assets/img/gif/escudo_2_2.png");
					//default:;
				}
			case 5:
				switch(vida)
				{
					case 1:loadGraphic("assets/img/gif/escudo_6_4.png");
					case 2:loadGraphic("assets/img/gif/escudo_6_3.png");
					case 3:loadGraphic("assets/img/gif/escudo_6_2.png");
					//default:;
				}
			case 6:
				switch(vida)
				{
					case 1:loadGraphic("assets/img/gif/escudo_7_4.png");
					case 2:loadGraphic("assets/img/gif/escudo_7_3.png");
					case 3:loadGraphic("assets/img/gif/escudo_7_2.png");
					//default:;
				}
			case 7:
				switch(vida)
				{
					case 1:loadGraphic("assets/img/gif/escudo_2_4.png");
					case 2:loadGraphic("assets/img/gif/escudo_2_3.png");
					case 3:loadGraphic("assets/img/gif/escudo_2_2.png");
					//default:;
				}
		}	
		return vida;
	}
	
}