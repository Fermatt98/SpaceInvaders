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
	private var _score:Int = 0;
	
	public function new(X:Float=0, Y:Float=0, FieldWidth:Float=0, ?Text:String, Size:Int=8, EmbeddedFont:Bool=true) 
	{
		super(X, Y, FieldWidth, Text, Size, EmbeddedFont);
		text = "Score " + Std.string(_score);
		x = xCord; y = yCord;
		setFormat("assets/font/ca.ttf", fountSize, FlxColor.WHITE, LEFT);
		updateScoreText();
	}
	
	public function addScore(score:Int)
	{
		_score+= score;
		updateScoreText();
	}
	public function getScore():Int	return _score;
	
	public function updateScoreText()
	{
		var strScore:String = "0000" + Std.string(_score);
		
		if (_score > 0 && _score < 100) strScore = "000" + Std.string(_score);
		if (_score >= 100 && _score < 1000) strScore = "00" + Std.string(_score);
		if (_score >= 1000 && _score < 10000) strScore = "0" + Std.string(_score);
		if (_score >= 10000) strScore = Std.string(_score);
				
		text = "Score " + strScore;
		if (_score > Reg.highscore) Reg.highscore = _score;
	}
}