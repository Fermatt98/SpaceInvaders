package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.math.FlxRandom;
import flixel.system.FlxAssets.FlxSoundAsset;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.system.FlxSound;

class PlayState extends FlxState
{
	private var player:FlxSprite;
	private var scoreText:Score;
	private var bullet:FlxSprite;
	private var bulletEnemy:FlxSprite;
	private var bulletEnemy2:FlxSprite;
	private var escudo:EscudoMaker;
	private var escudo2:EscudoMaker;
	private var escudo3:EscudoMaker;
	private var escudo4:EscudoMaker;
	private var alien:Array<FlxSprite>;
	private var shoot:Bool = false;
	private var shootEnemy:Bool = false;
	private var shootEnemy2:Bool = false;
	private var colicionMuros:Bool = false;
	private var rndEnemy:FlxRandom;
	private var colision = false;
	private var enemyGroup:FlxGroup;
	private var escudoGroup:FlxGroup;
	private var escudoGroup2:FlxGroup;
	private var escudoGroup3:FlxGroup;
	private var escudoGroup4:FlxGroup;
	private var rndEntero:Int;
	private var imagen:Int;
	private var destruido:String;
	private var killCounter:Int = 0;
	private var enemyShootTimer:Float = 0;
	private var ovniTimer:Float = 0;
	private var animacionTimer:Float = 0;
	private var ovni:FlxSprite;
	private var ovniExists:Bool = false;
	private var ovniShoot:Bool = false;
	private var bulletOvni:FlxSprite;
	private var disparo2:Int;
	private var gamemode:Int;
	private var menu:FlxSprite;
	private var winMenu:Bool = false;
	private var menuTimer:Float = 0;
	private var bulletSfx:FlxSound;
	private var explosionAlien:FlxSound;
	private var ovniSpawnSfx:FlxSound;
	private var ovniUnspawnSfx:FlxSound;
	private var youWin:FlxSound;
	private var explosionPlayer:FlxSound;
	private var vidas:VidaMaker;
	private var vidasGroup:FlxGroup;
	private var youLose:FlxSound;
	private var deadTime:Float = 10;
	private var deadTimeControl:Float = 0.2;
	private var bulletDead:Bool = false;
	private var bulletDead2:Bool = false;
	private var continuar:Bool = false;
	private var deadCont:Int = 0;
	private var alienRight:Bool = true;
	
	
	override public function create():Void
	{
		super.create();
		player = new FlxSprite();
		player.makeGraphic(16, 8);
		player.loadGraphic("assets/img/gif/nave.png");
		player.y = FlxG.height - player.height;
		player.x = 80 - player.width / 2;
		scoreText = new Score();
		escudo = new EscudoMaker(16, 110);
		escudo2 = new EscudoMaker(51, 110);
		escudo3 = new EscudoMaker(85, 110);
		escudo4 = new EscudoMaker(120, 110);
		vidas = new VidaMaker(100, 3);
		imagen = 0;
		escudoGroup = escudo.getGroup();
		escudoGroup2 = escudo2.getGroup();
		escudoGroup3 = escudo3.getGroup();
		escudoGroup4 = escudo4.getGroup();
		vidasGroup = vidas.getGroup();
		add(vidasGroup);
		add(player);
		add(scoreText);
		alien = new Array<FlxSprite>();
		enemyGroup = new FlxGroup();
		rndEnemy = new FlxRandom();
		AlienMaker();
		gamemode = 1;
		FlxG.camera.bgColor = 0xff0f380f;
		FlxG.sound.playMusic("assets/music/Space_invaders_gameplay.wav", 1, true);
		bulletSfx = FlxG.sound.load("assets/sounds/Bullet.wav");
		explosionAlien = FlxG.sound.load("assets/sounds/Explosion_Alien.wav");
		explosionPlayer = FlxG.sound.load("assets/sounds/Explosion_Player.wav");
		ovniSpawnSfx = FlxG.sound.load("assets/music/Ovni_Spawn.wav");
		ovniUnspawnSfx = FlxG.sound.load("assets/music/Ovni_Unspawn.wav");
		youWin = FlxG.sound.load("assets/music/youWin.wav");
		youLose = FlxG.sound.load("assets/music/Game-over-yeah.wav");
		bullet = new Bullet();
		bullet.kill();
		bulletEnemy = new Bullet();
		bulletEnemy.kill();
		bulletEnemy2 = new Bullet();
		bulletEnemy2.kill();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (gamemode == 1)
		{
			enemyShootTimer += elapsed;
			ovniTimer += elapsed;
			animacionTimer += elapsed;
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
				bullet = new Bullet((player.x + (player.width/2)), player.y,1);
				add(bullet);
				bulletSfx.stop();
				bulletSfx.play();
				shoot = true;
			}
			if (ovniTimer >= Reg.ovniTime)
			{
				ovni = new Ovni();
				add(ovni);
				ovniExists = true;
				ovniTimer = 0;
				FlxG.sound.playMusic("assets/music/Ovni_Spawn.wav", 1, true);
			}
			if (ovniExists == true)
			{
				if (ovni.x < 0 - ovni.width)
				{
					ovni.destroy();
					ovniExists = false;
					FlxG.sound.playMusic("assets/music/Space_invaders_gameplay.wav", 1, true);                      
				}
				if (ovniShoot == false)
				{
					bulletOvni = new Bullet(ovni.x + ovni.width / 2, ovni.y + ovni.height / 2, -1);
					add(bulletOvni);
					ovniShoot = true;
				}
				
			}
			if (enemyShootTimer >= Reg.enemyShootTime)
			{
				if (shootEnemy == false)
				{
					
					rndEntero = rndEnemy.int(0, alien.length - 1 );
					while(shootEnemy == false)
					{
						if(alien[rndEntero].exists)
						{
							bulletEnemy = new Bullet((alien[rndEntero].x + (alien[rndEntero].width / 2)), (alien[rndEntero].y + (alien[rndEntero].height / 2)), -1);
							disparo2 = rndEntero;
							while (shootEnemy2 == false && alien.length > 2)
							{
								rndEntero = rndEnemy.int(0, alien.length - 1 );
								if (alien[rndEntero].exists && disparo2 != rndEntero)
								{
									bulletEnemy2 = new Bullet((alien[rndEntero].x + (alien[rndEntero].width / 2)), (alien[rndEntero].y + (alien[rndEntero].height / 2)), -1);
								}
								else
								{
									rndEntero = rndEnemy.int(0, alien.length - 1);
								}
								add(bulletEnemy2);
								shootEnemy2 = true;
							}
							add(bulletEnemy);
							shootEnemy = true;
						}
						else
						{
							rndEntero = rndEnemy.int(0, alien.length - 1);
						}
						
					}	
				}
				enemyShootTimer = 0;
			}
			if (ovniShoot == true)
			{
				if (bulletOvni.y > 140)
				{
					bulletOvni.destroy();
					ovniShoot = false;
				}
				else
				{
					for(i in 0...escudoGroup.length)
					{
						if (FlxG.overlap(bulletOvni, escudoGroup.members[i]))
						{
							destruido = escudo.vida(i);
							if (destruido == "muerto")
							{
								escudoGroup.members[i].destroy();
								escudoGroup.remove(escudoGroup.members[ i]);
							}
							bulletOvni.destroy();
							ovniShoot = false;
						}
					}
					for(i in 0...escudoGroup2.length)
					{
						if (FlxG.overlap(bulletOvni, escudoGroup2.members[i]))
						{
							destruido = escudo2.vida(i);
							if (destruido == "muerto")
							{
								escudoGroup2.members[i].destroy();
								escudoGroup2.remove(escudoGroup2.members[ i]);
							}
							bulletOvni.destroy();
							ovniShoot = false;
						}
					}
					for(i in 0...escudoGroup3.length)
					{
						if (FlxG.overlap(bulletOvni, escudoGroup3.members[i]))
						{
							destruido = escudo3.vida(i);
							if (destruido == "muerto")
							{
								escudoGroup3.members[i].destroy();
								escudoGroup3.remove(escudoGroup3.members[ i]);
							}
							bulletOvni.destroy();
							ovniShoot = false;
						}
					}
					for(i in 0...escudoGroup4.length)
					{
						if (FlxG.overlap(bulletOvni, escudoGroup4.members[i]))
						{
							destruido = escudo4 .vida(i);
							if (destruido == "muerto")
							{
								escudoGroup4.members[i].destroy();
								escudoGroup4.remove(escudoGroup4.members[ i]);
							}
							bulletOvni.destroy();
							ovniShoot = false;
						}
					}
					if (FlxG.overlap(bulletOvni, player))
					{	
						vidasGroup.members[Reg.cantVidas].destroy();
						vidasGroup.remove(vidasGroup.members[Reg.cantVidas]);
						gamemode = 4;
						Reg.cantVidas -= 1;
						bulletOvni.destroy();
						ovniShoot = false;
					}
					if (shoot == true)
					{
						if (FlxG.overlap(bulletOvni, bullet))
						{	
							bulletOvni.destroy();
							ovniShoot = false;
							bullet.destroy();
							shoot = false;
						}
					}
				}
			}
			if (shootEnemy == true && bulletEnemy.exists)
			{
				if (bulletEnemy.y > 140)
				{
					bulletEnemy.kill();
					shootEnemy = false;
				}
				else
				{
					for(i in 0...escudoGroup.length)
					{
						if (FlxG.overlap(bulletEnemy, escudoGroup.members[i]))
						{
							destruido = escudo.vida(i);
							if (destruido == "muerto")
							{
								escudoGroup.members[i].destroy();
								escudoGroup.remove(escudoGroup.members[ i]);
							}
							bulletEnemy.kill();
							shootEnemy = false;
						}
					}
					for(i in 0...escudoGroup2.length)
					{
						if (FlxG.overlap(bulletEnemy, escudoGroup2.members[i]))
						{
							destruido = escudo2.vida(i);
							if (destruido == "muerto")
							{
								escudoGroup2.members[i].destroy();
								escudoGroup2.remove(escudoGroup2.members[ i]);
							}
							bulletEnemy.kill();
							shootEnemy= false;
						}
					}
					for(i in 0...escudoGroup3.length)
					{
						if (FlxG.overlap(bulletEnemy, escudoGroup3.members[i]))
						{
							destruido = escudo3.vida(i);
							if (destruido == "muerto")
							{
								escudoGroup3.members[i].destroy();
								escudoGroup3.remove(escudoGroup3.members[ i]);
							}
							bulletEnemy.kill();
							shootEnemy = false;
						}
					}
					for(i in 0...escudoGroup4.length)
					{
						if (FlxG.overlap(bulletEnemy, escudoGroup4.members[i]))
						{
							destruido = escudo4.vida(i);
							if (destruido == "muerto")
							{
								escudoGroup4.members[i].destroy();
								escudoGroup4.remove(escudoGroup4.members[ i]);
							}
							bulletEnemy.kill();
							shootEnemy = false;
						}
					}
					if (FlxG.overlap(bulletEnemy, player))
					{	
						vidasGroup.members[Reg.cantVidas].destroy();
						vidasGroup.remove(vidasGroup.members[Reg.cantVidas]);
						gamemode = 4;
						Reg.cantVidas -= 1;
						bulletEnemy.kill();
						shootEnemy = false;
					}
					if (shoot == true)
					{
						if (FlxG.overlap(bulletEnemy, bullet))
						{	
							bulletEnemy.destroy();
							shootEnemy = false;
							bullet.destroy();
							shoot = false;
						}
					}
				}
			}
			if (shootEnemy2 == true && bulletEnemy2.exists)
			{
				if (bulletEnemy2.y > 140)
				{
					bulletEnemy2.kill();
					shootEnemy2 = false;
				}
				else
				{
					for(i in 0...escudoGroup.length)
					{
						if (FlxG.overlap(bulletEnemy2, escudoGroup.members[i]))
						{
							destruido = escudo.vida(i);
							if (destruido == "muerto")
							{
								escudoGroup.members[i].destroy();
								escudoGroup.remove(escudoGroup.members[ i]);
							}
							bulletEnemy2.kill();
							shootEnemy2 = false;
						}
					}
					for(i in 0...escudoGroup2.length)
					{
						if (FlxG.overlap(bulletEnemy2, escudoGroup2.members[i]))
						{
							destruido = escudo2.vida(i);
							if (destruido == "muerto")
							{
								escudoGroup2.members[i].destroy();
								escudoGroup2.remove(escudoGroup2.members[ i]);
							}
							bulletEnemy2.kill();
							shootEnemy2= false;
						}
					}
					for(i in 0...escudoGroup3.length)
					{
						if (FlxG.overlap(bulletEnemy2, escudoGroup3.members[i]))
						{
							destruido = escudo3.vida(i);
							if (destruido == "muerto")
							{
								escudoGroup3.members[i].destroy();
								escudoGroup3.remove(escudoGroup3.members[ i]);
							}
							bulletEnemy2.kill();
							shootEnemy2 = false;
						}
					}
					for(i in 0...escudoGroup4.length)
					{
						if (FlxG.overlap(bulletEnemy2, escudoGroup4.members[i]))
						{
							destruido = escudo4 .vida(i);
							if (destruido == "muerto")
							{
								escudoGroup4.members[i].destroy();
								escudoGroup4.remove(escudoGroup4.members[ i]);
							}
							bulletEnemy2.kill();
							shootEnemy2 = false;
						}
					}
					if (FlxG.overlap(bulletEnemy2, player))
					{	
						vidasGroup.members[Reg.cantVidas].destroy();
						vidasGroup.remove(vidasGroup.members[Reg.cantVidas]);
						gamemode = 4;
						Reg.cantVidas -= 1;
						bulletEnemy2.kill();
						shootEnemy2 = false;
					}
					if (shoot == true)
					{
						if (FlxG.overlap(bulletEnemy2, bullet))
						{	
							bulletEnemy2.destroy();
							shootEnemy2 = false;
							bullet.destroy();
							shoot = false;
						}
					}
				}
			}
			if (shoot == true && bullet.exists)
			{
				if (bullet.y < 0)
				{
					bullet.kill();
					shoot = false;
				}
				else if (FlxG.overlap(bullet, ovni))
				{
					ovni.destroy();
					ovniExists = false;
					scoreText.addScore(Reg.puntosOvni);
					shoot = false;
					bullet.kill();
					FlxG.sound.playMusic("assets/music/Space_invaders_gameplay.wav", 1, true);
					ovniUnspawnSfx.play();
					explosionAlien.play();
				}
				else
				{
					for (i in 0...enemyGroup.length)
					{
						if (FlxG.overlap(bullet, enemyGroup.members[i]))
						{
							enemyGroup.members[i].kill();
							if (i <= 7) scoreText.addScore(Reg.puntosEnemigo3);
							if (i >= 8 && i <= 23) scoreText.addScore(Reg.puntosEnemigo2);
							if ( i >= 24 && i <= enemyGroup.length) scoreText.addScore(Reg.puntosEnemigo1);
							killCounter += 1;
							bullet.kill();
							explosionAlien.play();
							shoot = false;
							for (i in 0...alien.length)
							{
								if (alien[i].exists)
								{
									if (alien[i].velocity.x < 0)
									{
										alien[i].velocity.x = (Reg.velAlien + (killCounter ))*-1;
									}
									else
									{
										alien[i].velocity.x = Reg.velAlien + (killCounter );
									}
								}
							}
						}
					}
					for(i in 0...escudoGroup.length)
					{
						if (FlxG.overlap(bullet, escudoGroup.members[i]))
						{
							destruido = escudo.vida(i);
							if (destruido == "muerto")
							{
								escudoGroup.members[i].destroy();
								escudoGroup.remove(escudoGroup.members[ i]);
							}
							bullet.kill();
							shoot = false;
						}
					}
					for(i in 0...escudoGroup2.length)
					{
						if (FlxG.overlap(bullet, escudoGroup2.members[i]))
						{
							destruido = escudo2.vida(i);
							if (destruido == "muerto")
							{
								escudoGroup2.members[i].destroy();
								escudoGroup2.remove(escudoGroup2.members[ i]);
							}
							bullet.kill();
							shoot = false;
						}
					}
					for(i in 0...escudoGroup3.length)
					{
						if (FlxG.overlap(bullet, escudoGroup3.members[i]))
						{
							destruido = escudo3.vida(i);
							if (destruido == "muerto")
							{
								escudoGroup3.members[i].destroy();
								escudoGroup3.remove(escudoGroup3.members[ i]);
							}
							bullet.kill();
							shoot = false;
						}
					}
					for(i in 0...escudoGroup4.length )
					{
						if (FlxG.overlap(bullet, escudoGroup4.members[i]))
						{
							destruido = escudo4.vida(i);
							if (destruido == "muerto")
							{
								escudoGroup4.members[i].destroy();
								escudoGroup4 .remove(escudoGroup4.members[ i]);
							}
							bullet.kill();
							shoot = false;
						}
					}
				}
			}
		
			// colicion aliens con escudo//
			// --------------------------//
			for (i in 0...alien.length)
			{
				if (alien[i].y > 100)
				{
					for (k in 0...escudoGroup.length)
					{
						if (FlxG.overlap(alien[i], escudoGroup.members[k]))
						{
							escudoGroup.members[k].kill();
							escudoGroup.remove(escudoGroup.members[k]);
						}
					}
					for (k in 0...escudoGroup2.length)
					{
						if (FlxG.overlap(alien[i], escudoGroup2.members[k]))
						{
							escudoGroup2.members[k].kill();
							escudoGroup2.remove(escudoGroup2.members[k]);
						}
					}
					for (k in 0...escudoGroup3.length)
					{
						if (FlxG.overlap(alien[i], escudoGroup3.members[k]))
						{
							escudoGroup3.members[k].kill();
							escudoGroup3.remove(escudoGroup3.members[k]);
						}
					}
					for (k in 0...escudoGroup.length)
					{
						if (FlxG.overlap(alien[i], escudoGroup4.members[k]))
						{
							escudoGroup4.members[k].kill();
							escudoGroup4.remove(escudoGroup4.members[k]);
						}
					}
				}
			}
			
			// --------------------------//
			// fin colicion aliens//
			for (i in 0...alien.length)
			{
				if (((alien[i].x < 0 || alien[i].x > 160 - alien[i].width) && colision == false) && alien[i].exists)
				{
					colision = true;
					for (k in 0...alien.length)
					{
						alien[k].y += 8;
						alien[k].velocity.x *= -1;
						if (alien[k].velocity.x < 0)
						{
							alienRight = false;
						}
						else
						{
							alienRight = true;
						}
					}
				}
				if (alien[i].y >= FlxG.height - alien[i].height && alien[i].exists)
				{
					gamemode = 4;
					Reg.cantVidas = -1;
				}
			}
			colision = false;
			if (killCounter >= 40)
			{
				gamemode = 2;
			}
		}
		else if (gamemode == 2)
		{
			menuTimer += elapsed;
			if (winMenu == false)
			{
				FlxG.sound.pause();
				menu = new FlxSprite();
				menu.makeGraphic(160, 144);
				menu.loadGraphic("assets/img/gif/win.png");
				menu.x = FlxG.width / 2 -menu.width / 2;
				menu.y = FlxG.height / 2 -menu.height / 2;
				add(menu);
				winMenu = true;
				youWin.play();
				AlienStop();
			}
			if (menuTimer >= Reg.menuTime)
			{
				menu.destroy();
				FlxG.resetState();
				menuTimer = 0;
				killCounter = 0;
				gamemode = 1;
			}
		}
		else if (gamemode == 3)
		{
			menuTimer += elapsed;
			if (winMenu == false)
			{
				FlxG.sound.pause();
				menu = new FlxSprite();
				menu.makeGraphic(160, 144);
				menu.loadGraphic("assets/img/gif/lose.png");
				menu.x = FlxG.width / 2 -menu.width / 2;
				menu.y = FlxG.height / 2 -menu.height / 2;
				youLose.play();
				add(menu);
				winMenu = true;
			}
			if (menuTimer >= Reg.menuTime)
			{
				menu.destroy();
				FlxG.switchState(new MenuState());
				menuTimer = 0;
				killCounter = 0;
				gamemode = 1;
				AlienPlay(); 
				
			}
		}
		else if (gamemode == 4)
		{
			AlienStop();
			deadTime += elapsed;
			if (deadTime > deadTimeControl)
			{
				deadTime = 0;
				if (deadCont == 0)
				{
					explosionPlayer.play();
					player.loadGraphic("assets/img/gif/explocion_1.png");
					deadCont += 1;
				}
				else if (deadCont == 1)
				{
					player.loadGraphic("assets/img/gif/explocion_2.png");
					deadCont += 1;
				}
				else if (deadCont == 2)
				{
					player.loadGraphic("assets/img/gif/explocion_3.png");
					deadCont += 1;
				}
				else if (deadCont == 3)
				{
					deadTime = 10;
					deadCont = 0;
					deadTimeControl = 0.2;
					if (Reg.cantVidas == -1)
					{
						player.kill();
						gamemode = 3;
					}
					else
					{
						gamemode = 1;
						player.loadGraphic("assets/img/gif/nave.png");
						AlienPlay();
					}
				}
			}
		}
	}
	
	public function AlienMaker()
	{
		for (i in 0...5)
		{
			for (k in 0...8)
			{
				alien.push(new Alien((16 * k) + 20, (8 * i) + 24, i));
				enemyGroup.add(alien[i * 8 + k]);
				add(alien[i*8+k]);
			}
		}
		ovni = new Ovni();
		ovni.kill();
	}
	
	private function AlienStop()
	{
		for (i in 0...alien.length)
		{
			if (alien[i].exists)
			{
				alien[i].velocity.x = 0;
			}
			
		}
		player.velocity.x = 0;
		if (ovni.exists)
		{
			ovni.velocity.x = 0;

		}
	}
	
	private function AlienPlay()
	{
		for (i in 0...alien.length)
		{
			if (alien[i].exists)
			{
				alien[i].velocity.x = 5 + (killCounter / 2);
				if (alienRight == false)
				{
					alien[i].velocity.x *=-1;
				}
			}
			
		}
		if (ovni.exists)
		{
			ovni.velocity.x = -40;
		}
		bullet.kill();
		bulletEnemy.kill();
		bulletEnemy2.kill();
		shoot = false;
		shootEnemy = false;
		shootEnemy2 = false;
		ovniShoot = false;
	}
}
