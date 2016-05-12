package template;

import openfl.Assets;
import openfl.display.StageScaleMode;
import openfl.events.Event;
import template.game.Game;
import template.utils.game.GameStage;
import template.utils.game.GameStageAlign;
import template.utils.metadata.Metadatas;
import openfl.display.Sprite;

/**
 * ...
 * @author Flavien
 */
class Main extends Sprite 
{

	public function new() {
		super();
		
		var gameStage:GameStage = new GameStage();
		addChild(gameStage);
		gameStage.addGameChild(Assets.getMovieClip("TitleCard:TitleCard"));
		gameStage.alignMode = GameStageAlign.CENTER;
		gameStage.scaleMode = StageScaleMode.SHOW_ALL;
		gameStage.centerGameContainer = true;
		
		addEventListener(Event.ENTER_FRAME, Game.gameloop);
		Metadatas.load();
		Game.start();
	}
}
