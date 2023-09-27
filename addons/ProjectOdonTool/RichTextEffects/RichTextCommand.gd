@tool
extends RichTextEffect
class_name RichTextCommand

var bbcode = "command"

func _process_custom_fx(char_fx):
	char_fx.color = Color.YELLOW
	return true
