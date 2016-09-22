package;

import flixel.util.FlxColor;
import flixel.text.FlxText;

class Highscore extends FlxText
{
	static inline private var xCord = 60;
	static inline private var yCord = 1;
	static inline private var fountSize = 8;
	public function new(X:Float=0, Y:Float=0, FieldWidth:Float=0, ?Text:String, Size:Int=8, EmbeddedFont:Bool=true) 
	{
		super(X, Y, FieldWidth, Text, Size, EmbeddedFont);	
		text = "High-Score " + Std.string(Reg.highscore);
		x = xCord; y = yCord;
		setFormat("assets/font/ca.ttf", fountSize, 0x8cad0f, LEFT);
		updateHighScoreText();
	}
	public function updateHighScoreText()
	{
		var strScore:String = "0000" + Std.string(Reg.highscore);
		
		if (Reg.highscore > 0 && Reg.highscore < 100) strScore = "000" + Std.string(Reg.highscore);
		if (Reg.highscore >= 100 && Reg.highscore < 1000) strScore = "00" + Std.string(Reg.highscore);
		if (Reg.highscore >= 1000 && Reg.highscore < 10000) strScore = "0" + Std.string(Reg.highscore);
		if (Reg.highscore >= 10000) strScore = Std.string(Reg.highscore);
				
		text = "High-Score " + strScore;		
	}
}