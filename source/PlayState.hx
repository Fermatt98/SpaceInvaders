package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class PlayState extends FlxState
{
	private var player:FlxSprite;
	private var bullet:FlxSprite;
	private var escudo:FlxSprite;
	private var escudo2:FlxSprite;
	private var escudo3:FlxSprite;
	private var escudo4:FlxSprite;
	private var alien:Array<FlxSprite>;
	private var shoot:Bool = false;
	private var putoFlixel = false;
	
	override public function create():Void
	{
		super.create();
		player = new FlxSprite();
		player.makeGraphic(16, 8);
		player.y = FlxG.height - player.height;
		player.x = 80 - player.width / 2;
		escudo = new EscudoMaker(24, 110);
		escudo2 = new EscudoMaker(53, 110);
		escudo3 = new EscudoMaker(82, 110);
		escudo4 = new EscudoMaker(111,110);
		add(player);
		alien = new Array<FlxSprite>();
		AlienMaker();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (FlxG.keys.pressed.LEFT && player.x > 0)
		{
			player.velocity.x = -Reg.velPlayer;
		}
		else if (FlxG.keys.pressed.RIGHT && player.x < FlxG.width-player.width)
		{
			player.velocity.x = Reg.velPlayer;
		}
		else
		{
			player.velocity.x = 0;
		}
		if (FlxG.keys.justPressed.SPACE && shoot == false)
		{
			bullet = new Bullet((player.x + (player.width/2)), (player.y + (player.height/2)));
			add(bullet);
			shoot = true;
		}
		if (shoot == true)
		{
			if (bullet.y < 0)
			{
				bullet.destroy();
				shoot = false;
			}
		}
		for (i in 0...alien.length)
		{
			if ((alien[i].x < 0 || alien[i].x > 160 - alien[i].width) && putoFlixel == false)
			{
				for (k in 0...alien.length)
				{
					alien[k].y += 8;
					alien[k].velocity.x *= -1;
				}
				putoFlixel = true;
			}
		}
		putoFlixel = false;
	}
	
	public function AlienMaker()
	{
		for (i in 0...5)
		{
			for (k in 0...8)
			{
				alien.push(new Alien((16 * k)+20, (8 * i)+24));
				add(alien[i*8+k]);
			}
		}
	}
}
