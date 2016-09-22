package;

import flixel.util.FlxColor;
import flixel.text.FlxText;

import Reg;

class Score extends FlxText
{
	static inline private var xCord = 10;
	static inline private var yCord = 1;
	static inline private var fWidht = 100;
	static inline private var fountSize = 8;
	
	public function new(X:Float = 0, Y:Float = 0, FieldWidth:Float = 0, ?Text:String, Size:Int = 8, EmbeddedFont:Bool = true) 
	{
		super(X, Y, FieldWidth, Text, Size, EmbeddedFont);
		text = "Score " + Std.string(Reg._score);
		x = xCord; y = yCord;
		setFormat("assets/font/ca.ttf", fountSize, FlxColor.WHITE, LEFT);
		updateScoreText();
	}
	
	public function addScore(score:Int)
	{
		Reg._score+= score;
		updateScoreText();
	}
	public function getScore():Int	return Reg._score;
	
	public function updateScoreText()
	{
		var strScore:String = "0000" + Std.string(Reg._score);
		
		if (Reg._score > 0 && Reg._score < 100) strScore = "000" + Std.string(Reg._score);
		if (Reg._score >= 100 && Reg._score < 1000) strScore = "00" + Std.string(Reg._score);
		if (Reg._score >= 1000 && Reg._score < 10000) strScore = "0" + Std.string(Reg._score);
		if (Reg._score >= 10000) strScore = Std.string(Reg._score);
				
		text = "Score " + strScore;
		if (Reg._score > Reg.highscore) Reg.highscore = Reg._score;
	}
}