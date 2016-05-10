package template;

import template.utils.metadata.Metadatas;
import template.utils.Sound;
import openfl.display.Sprite;
import template.utils.localization.Localization;

/**
 * ...
 * @author Flavien
 */
class Main extends Sprite 
{

	public function new() {
		super();

		Metadatas.load();
	}
}
