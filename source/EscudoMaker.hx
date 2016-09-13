package;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class EscudoMaker extends FlxSprite
{
	private var cuadraditos:Array<Escudo>;
	private var tempGroup:FlxGroup = new FlxGroup();


	var x2:Int = 0;
	var y2:Int = 8;
	var b:Int = 0;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		cuadraditos = new Array<Escudo>();
		for ( a in 0...4)
		{
			cuadraditos.push(new Escudo(x2 + X, 0 + Y, a));
			x2 = x2 + 6;
		}
		x2 = 0;
		for ( a in 4...8)
		{
			cuadraditos.push(new Escudo(x2 + X, y2 + Y, a));
			x2 = x2 + 6;
		}
		for ( a in 0...8)
		{
			FlxG.state.add(cuadraditos[a]);
		}
		for (i in 0...cuadraditos.length)
		{
			tempGroup.add(cuadraditos[i]);
		}
	}
	
	public function getGroup():FlxGroup
	{
		return tempGroup;
	}
	public function vida(a:Int):String
	{
		b = cuadraditos[a].lastimado();
		if (b == 0)
		{
			return "muerto";
		}
		return "vivo";
	}
	
}