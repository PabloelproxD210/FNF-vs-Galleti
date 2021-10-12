package;

import flixel.FlxG;
import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;
	public var id:Int;

	public var defualtIconScale:Float = 1;
	public var iconScale:Float = 1;
	public var iconSize:Float;

	public function new(char:String = 'bf', isPlayer:Bool = false, ?_id:Int = -1)
	{
		super();

		if(FlxG.save.data.antialiasing)
			{
				antialiasing = true;
			}
		if (char == 'sm')
		{
			loadGraphic(Paths.image("stepmania-icon"));
			return;
		}
		loadGraphic(Paths.image('iconGrid'), true, 150, 150);
		animation.add('bf', [0, 1, 30], 0, false, isPlayer); //add a 2 after the 1 here
		animation.add('bf-car', [0, 1, 30], 0, false, isPlayer);
		animation.add('bf-christmas', [0, 1, 30], 0, false, isPlayer);
		animation.add('bf-pixel', [21, 21, 21], 0, false, isPlayer);
		animation.add('spooky', [2, 3, 2], 0, false, isPlayer);
		animation.add('pico', [4, 5, 4], 0, false, isPlayer);
		animation.add('mom', [6, 7, 6], 0, false, isPlayer);
		animation.add('mom-car', [6, 7, 6], 0, false, isPlayer);
		animation.add('tankman', [8, 9, 8], 0, false, isPlayer);
		animation.add('face', [10, 11, 10], 0, false, isPlayer);
		animation.add('dad', [12, 13, 12], 0, false, isPlayer);
		animation.add('senpai', [22, 22], 0, false, isPlayer);
		animation.add('senpai-angry', [22, 22], 0, false, isPlayer);
		animation.add('spirit', [23, 23], 0, false, isPlayer);
		animation.add('criper', [24, 25, 24], 0, false, isPlayer);
		animation.add('angrycriper', [26, 27, 26], 0, false, isPlayer);
		animation.add('criperdemon', [28, 29, 28], 0, false, isPlayer);
		animation.add('bf-old', [14, 15, 14], 0, false, isPlayer);
		animation.add('gf', [16, 16, 16], 0, false, isPlayer);
		animation.add('gf-christmas', [16, 16, 16], 0, false, isPlayer);
		animation.add('gf-pixel', [16, 16, 16], 0, false, isPlayer);
		animation.add('parents-christmas', [17, 18, 17], 0, false, isPlayer);
		animation.add('monster', [19, 20, 19], 0, false, isPlayer);
		animation.add('monster-christmas', [19, 20, 19], 0, false, isPlayer);
		animation.play(char);

		switch(char)
		{
			case 'bf-pixel' | 'senpai' | 'senpai-angry' | 'spirit' | 'gf-pixel':
				antialiasing = false;
		}

		id = _id;
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
