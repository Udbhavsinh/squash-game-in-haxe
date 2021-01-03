package;

import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxG;

class Paddle extends FlxSprite {
	
	var leftKey:String;
	var rightKey:String;
	var upKey:String;
	var downKey:String;



	public function new(X,Y,_leftKey:String,_rightKey:String,_upKey:String,_downKey:String) {
		super(X,Y);
		leftKey=_leftKey;
		rightKey=_rightKey;
		upKey=_upKey;
		downKey=_downKey;

		
		loadGraphic(AssetPaths.blue__png);
		immovable=true;
		
	}
	override public function update (elapsed:Float)
	{

		super.update(elapsed);
		
			if (FlxG.keys.anyPressed([leftKey]) && x> 0) {
			x-=5;
			}
			else if (FlxG.keys.anyPressed([rightKey]) && x+width < FlxG.width) {
			x+=5;
			}

			else if (FlxG.keys.anyPressed([upKey]) && y+height > FlxG.height-80) {
			y-=5;
			}
			else if (FlxG.keys.anyPressed([downKey]) && y+height < FlxG.height) {
			y+=5;
			}
		
	}
	public function halt ()
	{


			if (FlxG.keys.anyPressed([leftKey]) && x> 0) {
			x-=-5;
			}
			else if (FlxG.keys.anyPressed([rightKey]) && x+width < FlxG.width) {
			x+=-5;
			}

			else if (FlxG.keys.anyPressed([upKey]) && y+height > FlxG.height-80) {
			y-=-5;
			}
			else if (FlxG.keys.anyPressed([downKey]) && y+height < FlxG.height) {
			y+=-5;
			}
		

	}
	public function resetplayer()
	{
		x=30; 
		y=FlxG.height-40;
		
	}

}