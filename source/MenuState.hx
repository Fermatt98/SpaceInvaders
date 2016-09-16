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
	override public function create():Void
	{
		super.create();
		menu = new FlxSprite();
		menu.makeGraphic(160, 144);
		menu.loadGraphic("assets/img/gif/menu.png");
		add(menu);

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (FlxG.keys.justPressed.SPACE)
		{
			FlxG.switchState(new PlayState());
		}	
	}
}
