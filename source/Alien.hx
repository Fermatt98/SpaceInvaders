package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Alien extends FlxSprite
{
	private var _atuendo:Int;
	private var _cambio:Int = 0;
	private var animacionTimer:Float = 0;
	
	
	public function new(?X:Float=0, ?Y:Float=0,?a:Int, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(8, 8);
		if (a == 0)
		{
			loadGraphic("assets/img/gif/alien_3.png"); 
			_atuendo = a;
		}
		if (a == 1 || a == 2)
		{
			loadGraphic("assets/img/gif/alien_2.png");
			_atuendo = a;
		}
		if (a == 3 || a == 4)
		{
			loadGraphic("assets/img/gif/alien_1.png");
			_atuendo = a;
		}
		x = X;
		y = Y;
		velocity.x = Reg.velAlien;
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		animacionTimer += elapsed;
		if (animacionTimer >= Reg.animacionControlTime)
		{
			if (_atuendo == 0)
			{
				if (_cambio == 0)
				{
					loadGraphic("assets/img/gif/alien_3_3.png");
					_cambio = 1;
				}
				else
				{
					loadGraphic("assets/img/gif/alien_3.png");
					_cambio = 0;
				}
			}
			if (_atuendo == 1 || _atuendo == 2)
			{
				if (_cambio == 0)
				{
					loadGraphic("assets/img/gif/alien_2_2.png");
					_cambio = 1;
				}
				else
				{
					loadGraphic("assets/img/gif/alien_2.png");
					_cambio = 0;
				}
			}
			if (_atuendo == 3 || _atuendo == 4)
			{
				if (_cambio == 0)
				{
					loadGraphic("assets/img/gif/alien_1_2.png");
					_cambio = 1;
				}
				else
				{
					loadGraphic("assets/img/gif/alien_1.png");
					_cambio = 0;
				}
			}
			animacionTimer = 0;
		}
	}
	
	/*
	
	public function animar():Void
	{
		if (_atuendo == 0)
		{
			if (_cambio == 0)
			{
				loadGraphic("assets/img/gif/alien_3_2.png");
			}
			else
			{
				loadGraphic("assets/img/gif/alien_3.png");
			}
		}
		if (_atuendo == 1 || _atuendo == 2)
		{
			if (_cambio == 0)
			{
				loadGraphic("assets/img/gif/alien_2_2.png");
			}
			else
			{
				loadGraphic("assets/img/gif/alien_2.png");
			}
		}
		if (_atuendo == 3 || _atuendo == 4)
		{
			if (_cambio == 0)
			{
				loadGraphic("assets/img/gif/alien_1_2.png");
			}
			else
			{
				loadGraphic("assets/img/gif/alien_1.png");
			}
		}
	}
	*/
}