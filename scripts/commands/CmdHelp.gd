"""
คำสั่ง 'ช่วย'
"""
extends Command

@export_multiline var text_help_init: String
@export_multiline var text_help_no_desc: String

func fun():
	game.tell(text_help_init)
	for child in get_parent().get_children():
		if child is Command:
			# สร้าง key และ aliases
			var _key = child.get("key")
			if ("aliases" in child && child.get("aliases").size() > 0 ):
				_key = [ _key ] + child.get("aliases")
			# สร้างคำอธิบาย
			var _desc = text_help_no_desc
			if ("description" in child):
				if (child.get("description") != ''):
					_desc = child.get("description")
			# เช็คว่าแสดงใน help ได้หรือไม่
			if ("is_in_help" in child && child.get("is_in_help") == true):
				display_help_cmd(_key, _desc)


func display_help_cmd(cmd_name, cmd_desc):
	var _display_cmd = ""
	if ( typeof(cmd_name) == TYPE_ARRAY ):
		_display_cmd = ", ".join( PackedStringArray(cmd_name) )
	else:
		_display_cmd = cmd_name
	game.tell( "• [cmd]%s[/cmd]\n[color=LIGHT_SKY_BLUE]%s[/color]" % [ _display_cmd, cmd_desc ])
