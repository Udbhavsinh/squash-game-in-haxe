package;

import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.FlxG;

 class Ball extends FlxSprite {
	
	public function new (X, Y) {
		super(X,Y);
		

		
		loadGraphic(AssetPaths.ball__png);
		velocity.y=-230;
		elasticity=1;
	}

	override public function update (elapsed:Float){
		super.update(elapsed);

		if(x<0){
			velocity.x *= -1;
			FlxG.camera.shake(0.01,0.01);

		}

		if(y<0){
			velocity.y *= -1;
			FlxG.camera.shake(0.01,0.01);

		}
		if (x+width > FlxG.width)
		{
			velocity.x *= -1;

			FlxG.camera.shake(0.01,0.01);

		}

	}
	public function blueresetBall()
	{
		
			x= 105;
			y= FlxG.height/2;
			velocity.set();
			
			new FlxTimer().start(2, function (timer)
			{
				velocity.y=-230;
			});
		
	}


	public function redresetBall()
	{
		x= FlxG.width - 125;
		y= FlxG.height/2;
			velocity.set();
			
			new FlxTimer().start(2, function (timer)
			{
				velocity.y=-230;
			});
		
	}
		
}