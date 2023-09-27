@tool
extends RichTextEffect
class_name RichTextRoom

var bbcode = "room"

func _process_custom_fx(char_fx):
	char_fx.color = Color.SKY_BLUE
	return true
