package;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class VidaMaker extends FlxSprite
{
	private var viditas:Array<Vida>;
	private var tempGroup:FlxGroup = new FlxGroup();

	var _x:Int = 0;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		viditas = new Array <Vida>();
		
		for ( a in 0...Reg.cantVidas+1)
		{
			viditas.push(new Vida(_x + X, 0 + Y));
			_x += 18;
		}
		for (i in 0...viditas.length)
		{
			tempGroup.add(viditas[i]);
		}
	}
	public function getGroup():FlxGroup
	{
		return tempGroup;
	}
}