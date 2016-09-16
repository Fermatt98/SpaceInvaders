package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class MenuState extends FlxState
{
	private var menu:FlxSprite;
	private var time:Float;
	override public function create():Void
	{
		super.create();
		menu = new FlxSprite();
		menu.makeGraphic(160, 144);
		menu.loadGraphic("assets/img/gif/previa.png");
		add(menu);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		time = time + elapsed;
		trace(time);
		if (time >= 9)
		{
			menu.loadGraphic("assets/img/gif/menu.png");
		}
		if (FlxG.keys.justPressed.SPACE && time > 10)
		{
			FlxG.switchState(new PlayState());
		}	
	}
}
