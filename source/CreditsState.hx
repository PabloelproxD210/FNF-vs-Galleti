package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.input.gamepad.FlxGamepad;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import lime.utils.Assets;

using StringTools;

class CreditsState extends MusicBeatState
{
	var curSelected:Int = 1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];

	private static var creditsStuff:Array<Dynamic> = [ 
		['Vs Galleti'],
		['PABLOELPROXD210',		'pabloelproxd210',		'Coding The Mod',	'',	0xFF228b22],
		['Pogstation64',		'Pogstation64',		'Mod Artist',	'',	0xFFff010f],
		['Bacon4Lyfe',		'Bacon4Lyfe',		'Coding Little details',	'',	0xFFffffff],
		['Cape',		'Cape',		'Charting The Mod',	'',	0xFF6c00df],
		['Big Thiccs',		'BigThiccs',		'Vocals Into The song',	'',	0xFF85929a],
		['BitFox Original',		'BitFoxOriginal',		'Making The Songs',	'',	0xFFffae35],
		['Galleti',		'Galleti',		'Idiot Owner',	'',	0xFF06ff00],
		[''],
		['Special thanks'], 
		['KadeDeveloper',		'kade',		'Creator of the Kade Engine',	'',	0xFF226A0D],
		['Shadow Mario',		'shadowmario',		'Some functions of your engine',	'',	0xFFE5E20E],
		['Rozebud',		'ejemplo',		'Option menu song',	'',	0xFFf73399],
		['Castle Crashers Boss Rush REVIVED',			'ejemplo',	'Hitsounds', '',	0xFFbdb76b],
		[''],
	];

	var bg:FlxSprite;
	var descText:FlxText;
	private var intendedColor:Int;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In The Credits", null);
		#end
		
		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(0, 70 * i, creditsStuff[i][0], !isSelectable, false);
			optionText.isMenuItem = true;
			optionText.screenCenter(X);
			if(isSelectable) {
				optionText.x -= 70;
			}
			optionText.x;
			//optionText.yMult = 90;
			optionText.targetY = i;
			grpOptions.add(optionText);

			if(isSelectable) {
				var icon:AttachedSprite = new AttachedSprite(Paths.image('credits/' + creditsStuff[i][1]));
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;
	
				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);
			}
		}

		descText = new FlxText(50, 600, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 2.4;
		add(descText);

		bg.color = creditsStuff[curSelected][4];
		intendedColor = bg.color;
		changeSelection();
		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var upP = FlxG.keys.justPressed.UP;
		var downP = FlxG.keys.justPressed.DOWN;
		var accepted = controls.ACCEPT;
		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (upP)
			{
				changeSelection(-1);
			}
			if (downP)
			{
				changeSelection(1);
			}

		if (controls.BACK)
		{
			FlxTween.cancelTweensOf(bg);
			FlxG.sound.play(Paths.sound('cancelMenu'));
			FlxG.switchState(new MainMenuState());
		}
		super.update(elapsed);
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var newColor:Int = creditsStuff[curSelected][4];
		if(newColor != intendedColor) {
			FlxTween.cancelTweensOf(bg);
			intendedColor = newColor;
			FlxTween.color(bg, 1, bg.color, intendedColor);
		}

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}

				for (j in 0...iconArray.length) {
					var tracker:FlxSprite = iconArray[j].sprTracker;
					if(tracker == item) {
						iconArray[j].alpha = item.alpha;
						break;
					}
				}
			}
		}
		descText.text = creditsStuff[curSelected][2];
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}
