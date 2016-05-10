package template;

import openfl.display.Sprite;
import src.template.localization.Localization;

/**
 * ...
 * @author Flavien
 */
class Main extends Sprite 
{

	public function new() {
		super();
		Localization.init();
		Localization.getText("run");
	}

}
