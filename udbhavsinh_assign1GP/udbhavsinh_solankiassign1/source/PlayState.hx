package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;
import flixel.math.FlxRandom;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.math.FlxMath;
import flixel.ui.FlxButton;
import flixel.group.FlxGroup;
import Paddle;
import Paddle2;
import Ball;


class PlayState extends FlxState
{
	var ball:Ball;
	var bluePlayer:Paddle;
	var redPlayer:Paddle2;

	var blueScore=0;
	var redScore=0;

	var bluetouch = false;
	var redtouch = true;
	var blueserve=false;
	var redserve=false;
	var topwalltouch=false;
	
    var topwall:FlxSprite;
	var leftwall:FlxSprite;
	var rightwall:FlxSprite;


	var scoreText:FlxText;
	var servechangeText:FlxText;
	var bluescoreText:FlxText;
	var redscoreText:FlxText;

	var winBlueText:FlxText;
	var winRedText:FlxText;

	var background:FlxSprite;

	var maxScore:Int=2;

	override public function create():Void
	{
		super.create();
		FlxG.mouse.visible=false;

		background =new FlxSprite();
		
		background.loadGraphic(AssetPaths.background__jpg);
		add(background);


		scoreText=new FlxText(0,0, FlxG.width, "Struggles|Legends");
		scoreText.setFormat(null,36, FlxColor.YELLOW,"center");
		add(scoreText);

		servechangeText=new FlxText(0,100, FlxG.width, "Serve Change");
		servechangeText.setFormat(null,36, FlxColor.WHITE,"center");
		servechangeText.visible=false;
		add(servechangeText);

		winBlueText= new FlxText(0,300, FlxG.width, " Strugglers won");
		winBlueText.setFormat(null,50,FlxColor.BLUE,"center");
		winBlueText.visible= false;
		add(winBlueText);

		winRedText= new FlxText(0,300, FlxG.width, " Legends won");
		winRedText.setFormat(null,50,FlxColor.RED,"center");
		winRedText.visible= false;
		add(winRedText);

		bluescoreText= new FlxText(-200,0, FlxG.width, "Strugglers won");
		bluescoreText.setFormat(null,36,FlxColor.BLUE,"center");
		bluescoreText.visible= false;
		add(bluescoreText);

		redscoreText= new FlxText(200,0, FlxG.width, "Legends won");
		redscoreText.setFormat(null,36,FlxColor.RED,"center");
		redscoreText.visible= false;
		add(redscoreText);


		bluePlayer= new Paddle(30, FlxG.height-40,"A","D","W","S");
		add(bluePlayer);

		redPlayer= new Paddle2(FlxG.width-180, FlxG.height-40,"LEFT","RIGHT","UP","DOWN");
		add(redPlayer);

		ball= new Ball(105,FlxG.height/2);
		add(ball);

		topwall = new FlxSprite();
		topwall.makeGraphic(FlxG.width,2,FlxColor.MAGENTA);
		topwall.immovable=true;
		add(topwall);

		leftwall = new FlxSprite();
		leftwall.makeGraphic(2,FlxG.height,FlxColor.MAGENTA);
		leftwall.immovable=true;
		add(leftwall);

		rightwall = new FlxSprite(FlxG.width-2,0);
		rightwall.makeGraphic(2,FlxG.height,FlxColor.MAGENTA);
		rightwall.immovable = true;
		add(rightwall);
	}

	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		FlxG.collide(leftwall,ball, function(leftwall:FlxSprite,ball:FlxSprite){
			ball.velocity.x *= -1.1;
			FlxG.camera.shake(0.01,0.01);
			FlxG.sound.play("assets/sounds/wall.wav");
			
		});

		FlxG.collide(rightwall,ball, function(rightwall:FlxSprite,ball:FlxSprite){
			ball.velocity.x *= -1.1;
			FlxG.camera.shake(0.01,0.01);
			FlxG.sound.play("assets/sounds/wall.wav");
			
		});

		FlxG.collide(topwall,ball, function(topwall:FlxSprite,ball:FlxSprite){
			bluescoreText.visible= false;
			redscoreText.visible= false;
			servechangeText.visible=false;
			ball.velocity.y *= -1;
			FlxG.camera.shake(0.01,0.01);
			FlxG.sound.play("assets/sounds/wall.wav");
			
			topwalltouch=true;
		});

		if(bluetouch==false && topwalltouch==true){
			FlxG.collide(bluePlayer,ball, function(bluePlayer:FlxSprite,ball:FlxSprite){
				ball.velocity.x=(ball.getMidpoint().x - bluePlayer.getMidpoint().x)*5;
				ball.velocity.y*=1.1;

				FlxG.camera.shake(0.01,0.01);
				bluetouch= true;
				redtouch = false;
				topwalltouch=false;
			    FlxG.sound.play("assets/sounds/wall.wav");

				if(blueserve==true)
			{
				blueserve=false;
				redserve=false;
			}
			if(redserve==true)
			{
				redserve=false;
				blueserve=false;
			}
				
			});
		}

		if(redtouch==false && topwalltouch==true)
		{
			FlxG.collide(redPlayer,ball, function(redPlayer:FlxSprite,ball:FlxSprite){
				ball.velocity.x=(ball.getMidpoint().x - redPlayer.getMidpoint().x)*5;
				ball.velocity.y*=1.1;
				FlxG.camera.shake(0.01,0.01);
				redtouch=true;
				bluetouch= false;
				
				topwalltouch=false;

				FlxG.sound.play("assets/sounds/wall.wav");
			
				if(blueserve==true)
			{
				blueserve=false;
				redserve=false;
			}
			if(redserve==true)
			{
				redserve=false;
				blueserve=false;
			}
				
			
			});
		}

		if((bluetouch==false && redtouch == true)||(blueserve==true))
		{
			redPlayer.halt();
			redPlayer.alpha=0.3;
			bluePlayer.alpha=1.0;
			
		}

		if((redtouch==false && bluetouch == true)||(redserve==true))
		{
			bluePlayer.halt();

			redPlayer.alpha=1.0;
			bluePlayer.alpha=0.3;
			
		}
		

		if(ball.y>FlxG.height && redtouch == false && bluetouch== false)
		{
			if(redserve==true)
			{
			servechangeText.visible=true;
			ball.blueresetBall();
			redserve=false;
			blueserve=true;	
			redPlayer.alpha=0.3;
			bluePlayer.alpha=1.0;
			redtouch=false;
			bluetouch=false;
			bluePlayer.resetplayer();
			redPlayer.resetplayer();
			redPlayer.halt();
			}
			else if(blueserve==true)
			{
				servechangeText.visible=true;
				ball.redresetBall();
				blueserve=false;
				redserve=true;
				redPlayer.alpha=1.0;
				bluePlayer.alpha=0.3;
				redtouch=false;
				bluetouch=false;
				bluePlayer.halt();

				bluePlayer.resetplayer();
				redPlayer.resetplayer();
			}
			
		}

		if((ball.y>FlxG.height && redtouch == true && topwalltouch==true)||(ball.y>FlxG.height && bluetouch == true && topwalltouch==false))
		{
			redScore++;
			
			scoreText.text= blueScore + "|" + redScore;

			FlxG.sound.play("assets/sounds/point.wav");
			blueserve=false;
	 		redserve=true;
			redtouch=false;
			bluetouch= false;
			bluescoreText.visible= false;
			redscoreText.visible= true;
			redPlayer.alpha=1.0;
			bluePlayer.alpha=0.3;
			ball.redresetBall();
			bluePlayer.halt();


			bluePlayer.resetplayer();
			redPlayer.resetplayer();


			if(redScore>maxScore){

			FlxG.sound.play("assets/sounds/point.wav");
				bluescoreText.visible= false;
				redscoreText.visible= false;
				scoreText.visible= true;
				winRedText.visible=true;
				ball.velocity.set();
				
				ball.visible=false;
				ball.redresetBall();
				redPlayer.visible=false;
				bluePlayer.visible=false;
				 new FlxTimer().start(5, function (timer){
				 	FlxG.resetGame();
				 });
			}
		}

		if((ball.y>FlxG.height && bluetouch== true && topwalltouch==true )||(ball.y>FlxG.height && redtouch== true && topwalltouch==false ))
		{
			blueScore++;

			FlxG.sound.play("assets/sounds/point.wav");
			
			scoreText.text= blueScore + "|" + redScore;
			blueserve=true;
	 		redserve=false;
			redtouch=false;
			bluetouch= false;
			bluescoreText.visible= true;
			redscoreText.visible= false;
			redPlayer.alpha=0.3;
			bluePlayer.alpha=1.0;
			ball.blueresetBall();

			bluePlayer.resetplayer();
			redPlayer.resetplayer();
			redPlayer.halt();

			if(blueScore>maxScore)
			{

			FlxG.sound.play("assets/sounds/point.wav");
				bluescoreText.visible= false;
				redscoreText.visible= false;
				scoreText.visible= true;
				winBlueText.visible=true;
				ball.blueresetBall();
				

				ball.visible=false;
				redPlayer.visible=false;
				bluePlayer.visible=false;
				 new FlxTimer().start(5, function (timer)
				 {
				 	FlxG.resetGame();
				 });
			}

		}
	}
}