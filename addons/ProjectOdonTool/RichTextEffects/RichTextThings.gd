@tool
extends RichTextEffect
class_name RichTextThing

var bbcode = "thing"

func _process_custom_fx(char_fx):
	char_fx.color = Color.GREEN_YELLOW
	return true
