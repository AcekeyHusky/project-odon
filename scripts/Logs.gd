extends RichTextLabel

@export var char_per_second: int = 1

@onready var scroll = $"../.."

# อนิเมทตัวอักษรขึ้นวินาทีละตัว
func _process(_delta):
	if get_total_character_count() > visible_characters:
		visible_characters += char_per_second
		%Music.play_se_typing()
		
		var _left_char = get_total_character_count() - visible_characters + char_per_second
		scroll.scroll_vertical += (scroll.get_v_scroll_bar().max_value \
		- scroll.scroll_vertical) / _left_char
	

func reset():
	visible_characters = 0
	clear()
	scroll.scroll_vertical = scroll.get_v_scroll_bar().max_value

# กดปุ่มเพื่อข้ามการอนิเมทตัวอักษร
func _input(event) -> void:
	if event.is_pressed():
		visible_characters = get_total_character_count()
