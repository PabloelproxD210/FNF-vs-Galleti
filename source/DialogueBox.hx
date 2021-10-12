package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// :v
	var colores = [0xFFD89494, 0xFF3F2021];
	var checar = 0;

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;
	var portraitGF:FlxSprite = new FlxSprite();
	var portraitLeft2:FlxSprite;
	var portraitLeft3:FlxSprite;
	var portraitRight2:FlxSprite;
	var portraitGF2:FlxSprite = new FlxSprite();

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);

			case 'cookies' | 'virus' | 'devil':
				hasDialog = true;
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		switch (PlayState.SONG.song.toLowerCase()){
			case 'senpai' | 'roses' | 'thorns':
				portraitLeft = new FlxSprite(-20, 40);
				portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait', 'week6');
				portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
				portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
				portraitLeft.updateHitbox();
				portraitLeft.scrollFactor.set();
				add(portraitLeft);
				portraitLeft.visible = false;

				portraitRight = new FlxSprite(0, 40);
				portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait', 'week6');
				portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
				portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
				portraitRight.updateHitbox();
				portraitRight.scrollFactor.set();
				add(portraitRight);
				portraitRight.visible = false;
		
				box.animation.play('normalOpen');
				box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
				box.updateHitbox();

				if(PlayState.SONG.song.toLowerCase() == "thorns"){
					var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
					face.setGraphicSize(Std.int(face.width * 6));
					add(face);
				}
				add(box);

				box.screenCenter(X);
				portraitLeft.screenCenter(X);

			case 'cookies' | 'virus' | 'devil':

				portraitLeft = new FlxSprite(80, 70);
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/cripiportrait', 'galleti');
				portraitLeft.animation.addByPrefix('enter', '1 idle', 24, false);
				portraitLeft.setGraphicSize(Std.int(portraitLeft.width  * 1));
				portraitLeft.updateHitbox();
				portraitLeft.scrollFactor.set();
				portraitLeft.antialiasing = true;
				add(portraitLeft);
				portraitLeft.visible = false;

				portraitLeft2 = new FlxSprite(80, 120);
				portraitLeft2.frames = Paths.getSparrowAtlas('portraits/angryportrait', 'galleti');
				portraitLeft2.animation.addByPrefix('enter', 'Símbolo 2', 24, false);
				portraitLeft2.setGraphicSize(Std.int(portraitLeft2.width  * 1));
				portraitLeft2.updateHitbox();
				portraitLeft2.scrollFactor.set();
				portraitLeft2.antialiasing = true;
				add(portraitLeft2);
				portraitLeft2.visible = false;

				portraitLeft3 = new FlxSprite(80, 70);
				portraitLeft3.frames = Paths.getSparrowAtlas('portraits/demonportrait', 'galleti');
				portraitLeft3.animation.addByPrefix('enter', 'Símbolo 2', 24, false);
				portraitLeft3.setGraphicSize(Std.int(portraitLeft3.width  * 1));
				portraitLeft3.updateHitbox();
				portraitLeft3.scrollFactor.set();
				portraitLeft3.antialiasing = true;
				add(portraitLeft3);
				portraitLeft3.visible = false;


				portraitRight = new FlxSprite(780, 62);
				portraitRight.frames = Paths.getSparrowAtlas('portraits/BF', 'galleti');
				portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter instance 1', 24, false);
				portraitRight.setGraphicSize(Std.int(portraitRight.width * 1));
				portraitRight.updateHitbox();
				portraitRight.scrollFactor.set();
				portraitRight.antialiasing = true;
				add(portraitRight);
				portraitRight.visible = false;

				portraitRight2 = new FlxSprite(780, 62);
				portraitRight2.frames = Paths.getSparrowAtlas('portraits/BFUhh', 'galleti');
				portraitRight2.animation.addByPrefix('enter', 'Boyfriend portrait enter instance 1', 24, false);
				portraitRight2.setGraphicSize(Std.int(portraitRight2.width * 1));
				portraitRight2.updateHitbox();
				portraitRight2.scrollFactor.set();
				portraitRight2.antialiasing = true;
				add(portraitRight2);
				portraitRight2.visible = false;

				portraitGF = new FlxSprite(590, 90);
				portraitGF.frames = Paths.getSparrowAtlas('portraits/GFTalk', 'galleti');
				portraitGF.animation.addByPrefix('enter', 'Senpai Portrait Enter instance 1', 24, false);
				portraitGF.setGraphicSize(Std.int(portraitGF.width * 1));
				portraitGF.updateHitbox();
				portraitGF.scrollFactor.set();
				portraitGF.antialiasing = true;
				add(portraitGF);
				portraitGF.visible = false;

				portraitGF2 = new FlxSprite(590, 90);
				portraitGF2.frames = Paths.getSparrowAtlas('portraits/GFCheer', 'galleti');
				portraitGF2.animation.addByPrefix('enter', 'Senpai Portrait Enter instance 1', 24, false);
				portraitGF2.setGraphicSize(Std.int(portraitGF2.width * 1));
				portraitGF2.updateHitbox();
				portraitGF2.scrollFactor.set();
				portraitGF2.antialiasing = true;
				add(portraitGF2);
				portraitGF2.visible = false;

				colores[2] = FlxColor.fromRGB(168, 48, 136);
				colores[3] = FlxColor.fromRGB(120, 58, 103);
		
				box = new FlxSprite(-20, 390);
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByPrefix('normal', 'speech bubble normal0', 24, true);
				box.setGraphicSize(Std.int(box.width * 1));
				box.antialiasing = true;
				box.updateHitbox();
				box.animation.play('normalOpen');
				add(box);

				box.screenCenter(X);
		}

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox', 'week6'));
		add(handSelect);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		portraitLeft.visible = false;
		portraitLeft2.visible = false;
		portraitLeft3.visible = false;
		portraitRight.visible = false;
		portraitGF.visible = false;
		portraitRight2.visible = false;
		portraitGF2.visible = false;
		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'dad2':
				if (!portraitLeft2.visible)
				{
					if(checar == 1){
						box.flipX = true;
					}
					portraitLeft2.visible = true;
					portraitLeft2.animation.play('enter');
				}
			case 'dad3':
				if (!portraitLeft3.visible)
				{
					if(checar == 1){
						box.flipX = true;
					}
					portraitLeft3.visible = true;
					portraitLeft3.animation.play('enter');
				}
			case 'bf':
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'gf':
				if (!portraitRight.visible)
				{
					portraitGF.visible = true;
					portraitGF.animation.play('enter');
					if(checar == 1){
						dropText.color = colores[3];
						swagDialogue.color = colores[2];
					}
				}
			case 'bf2':
				if (!portraitRight2.visible)
				{
					portraitRight2.visible = true;
					portraitRight2.animation.play('enter');
				}
			case 'gf2':
				if (!portraitRight2.visible)
				{
					portraitGF2.visible = true;
					portraitGF2.animation.play('enter');
					if(checar == 1){
						dropText.color = colores[3];
						swagDialogue.color = colores[2];
					}
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
