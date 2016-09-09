package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class EscudoMaker extends FlxSprite
{
	private var cuadraditos:Array<Escudo>;
	var x2:Int = 0;
	var y2:Int = 8;
	

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		cuadraditos = new Array<Escudo>();
		for ( a in 0...4)
		{
			cuadraditos.push(new Escudo(x2 + X, 0 + Y));
			x2 = x2 + 6;
		}
		x2 = 0;
		for ( a in 0...4)
		{
			cuadraditos.push(new Escudo(x2 + X, y2 + Y));
			x2 = x2 + 6;
		}
		for ( a in 0...8)
		{
			FlxG.state.add(cuadraditos[a]);
		}
		
	
		
		
	}
	
}