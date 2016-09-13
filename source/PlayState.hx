package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.math.FlxRandom;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class PlayState extends FlxState
{
	private var player:FlxSprite;
	private var bullet:FlxSprite;
	private var bulletEnemi:FlxSprite;
	private var escudo:EscudoMaker;
	private var escudo2:EscudoMaker;
	private var escudo3:EscudoMaker;
	private var escudo4:EscudoMaker;
	private var alien:Array<FlxSprite>;
	private var bullet_alien:Array<Int>;
	private var shoot:Bool = false;
	private var shootEnemi:Bool = false;
	private var rndEnemi:FlxRandom;
	private var colision = false;
	private var enemyGroup:FlxGroup;
	private var escudoGroup:FlxGroup;
	private var escudoGroup2:FlxGroup;
	private var escudoGroup3:FlxGroup;
	private var escudoGroup4:FlxGroup;
	private var rndEntero:Int;
	private var imagen:Int;
	
	override public function create():Void
	{
		super.create();
		player = new FlxSprite();
		player.makeGraphic(16, 8);
		player.loadGraphic("assets/img/gif/nave.png");
		player.y = FlxG.height - player.height;
		player.x = 80 - player.width / 2;
		escudo = new EscudoMaker(24, 110);
		escudo2 = new EscudoMaker(53, 110);
		escudo3 = new EscudoMaker(82, 110);
		escudo4 = new EscudoMaker(111, 110);
		imagen = 0;
		escudoGroup = escudo.getGroup();
		escudoGroup2 = escudo2.getGroup();
		escudoGroup3 = escudo3.getGroup();
		escudoGroup4 = escudo4.getGroup();
		add(player);
		alien = new Array<FlxSprite>();
		bullet_alien = new Array<Int>();
		for (a in 0...alien.length)
		{
			bullet_alien[a] = -1;
		}
		enemyGroup = new FlxGroup();
		rndEnemi = new FlxRandom();
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
			bullet = new Bullet((player.x + (player.width/2)), (player.y + (player.height/2)),1);
			add(bullet);
			shoot = true;
		}
		if (shootEnemi == false)
		{
			
			rndEntero = rndEnemi.int(0, alien.length );
			while(shootEnemi == false)
			{
				if(enemyGroup.members[rndEntero].exists)
				{
					bullet_alien[rndEntero] = rndEntero;
					trace(rndEntero);
					bulletEnemi = new Bullet((alien[rndEntero].x + (alien[rndEntero].width / 2)), (alien[rndEntero].y + (alien[rndEntero].height / 2)), -1);
					add(bulletEnemi);
					shootEnemi = true;    
				}
				else
				{
					rndEntero = rndEnemi.int(0, alien.length);
				}
			}	
		}
		if (shootEnemi == true)
		{
			if (bulletEnemi.y > 140)
			{
				bulletEnemi.destroy();
				shootEnemi = false;
			} 
		}
		if (shoot == true)
		{
			if (bullet.y < 0)
			{
				bullet.destroy();
				shoot = false;
			}
			else
			{
				for (i in 0...enemyGroup.length)
				{
					if (FlxG.overlap(bullet, enemyGroup.members[i]))
					{
						enemyGroup.members[i].kill();
						bullet.destroy();
						shoot = false;
					}
				}
				for(i in 0...escudoGroup.length)
				{
					if (FlxG.overlap(bullet, escudoGroup.members[i]))
					{
						escudoGroup.members[i].destroy();
						escudoGroup.remove(escudoGroup.members[ i]);
						bullet.destroy();
						shoot = false;
					}
				}
				for(i in 0...escudoGroup2.length)
				{
					if (FlxG.overlap(bullet, escudoGroup2.members[i]))
					{
						escudoGroup2.members[i].destroy();
						escudoGroup2.remove(escudoGroup2.members[ i]);
						bullet.destroy();
						shoot = false;
					}
				}
				for(i in 0...escudoGroup3.length)
				{
					if (FlxG.overlap(bullet, escudoGroup3.members[i]))
					{
						escudoGroup3.members[i].destroy();
						escudoGroup3.remove(escudoGroup3.members[ i]);
						bullet.destroy();
						shoot = false;
					}
				}
				for(i in 0...escudoGroup4.length)
				{
					if (FlxG.overlap(bullet, escudoGroup4.members[i]))
					{
						escudoGroup4.members[i].destroy();
						escudoGroup4.remove(escudoGroup4.members[ i]);
						bullet.destroy();
						shoot = false;
					}
				}
			}
		}
		for (i in 0...alien.length)
		{
			if ((alien[i].x < 0 || alien[i].x > 160 - alien[i].width) && colision == false)
			{
				for (k in 0...alien.length)
				{
					alien[k].y += 8;
					alien[k].velocity.x *= -1;
				}
				colision = true;
			}
		}
		colision = false;
	}
	
	public function AlienMaker()
	{
		for (i in 0...5)
		{
			for (k in 0...8)
			{
				alien.push(new Alien((16 * k) + 20, (8 * i) + 24));
				enemyGroup.add(alien[i * 8 + k]);
				add(alien[i*8+k]);
			}
		}
	}
}
