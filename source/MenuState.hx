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
	private var time:Float = 0;
	private var highScore:Highscore;

	override public function create():Void
	{
		super.create();
		menu = new FlxSprite();
		menu.makeGraphic(160, 144);
		menu.loadGraphic("assets/img/gif/previa.png");
		highScore = new Highscore();
		add(menu);
		Reg.cantVidas = 2;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		time += elapsed;
		trace(time);
		if (time >= 2)
		{
			menu.loadGraphic("assets/img/gif/menu.png");
			add(highScore);
		}
		if (FlxG.keys.justPressed.SPACE && time > 2)
		{
			FlxG.switchState(new PlayState());
			highScore.destroy();
			Reg._score = 0;
		}	
	}
}

