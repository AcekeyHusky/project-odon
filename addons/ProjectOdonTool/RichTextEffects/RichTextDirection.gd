@tool
extends RichTextEffect
class_name RichTextDirection

var bbcode = "dir"

func _process_custom_fx(char_fx):
	char_fx.color = Color.HOT_PINK
	return true
