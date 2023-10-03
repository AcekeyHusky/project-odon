"""
คำสั่ง 'ช่วย'
"""
extends Command

@export_multiline var text_help_init: String
@export_multiline var text_help_no_desc: String

# commands_list ตรงนี้จะไม่ได้ใช้แล้วนะ
var commands_list = [
	{
		"cmd": ["ดู", "เบิ่ง"],
		"desc": "ดูไง",
		"fun": Callable(self, "cmd_look"),
		"visible_in_help": true,
	},
	{
		"cmd": "นอน",
		"desc": "นอนไง",
		"fun": Callable(self, "cmd_rest"),
		"visible_in_help": true,
	},
	{
		"cmd": "ล้าง",
		"desc": "ลบข้อความทั้งหมดไปจากหน้าต่าง",
		"fun": Callable(self, "cmd_clear"),
		"visible_in_help": true,
	},
	{
		"cmd": "ไป",
		"desc": "ไปไง",
		"fun": Callable(self, "cmd_go"),
		"visible_in_help": true,
	},
	{
		"cmd": "ช่วย",
		"desc": "ช่วยด้วยยยยยยยยยยยยยยยยยยยยย",
		"fun": Callable(self, "cmd_help"),
		"visible_in_help": true,
	},
	{
		"cmd": "สถานะ",
		"desc": "สถานะไง",
		"fun": Callable(self, "cmd_status"),
		"visible_in_help": true,
	},
	{
		"cmd": "ต่อย",
		"desc": "ต่อยไง",
		"fun": Callable(self, "cmd_punch"),
		"visible_in_help": true,
	},
	{
		"cmd": ["ปรับแต่ง","ตั้งค่า"],
		"desc": "ปรับแต่งรูปแบบจอแสดงผล (สีข้อความ)",
		"fun": Callable(self, "cmd_setting"),
		"visible_in_help": true,
	},
	
	# เพิ่มต่อให้ครบด้วยจ้า.....
]

func fun():
	game.tell(text_help_init)
	#var cmd_lists :Array = []
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
	game.tell( "  • [cmd]%s[/cmd]  [color=LIGHT_SKY_BLUE]%s[/color]" % [ _display_cmd, cmd_desc ])
