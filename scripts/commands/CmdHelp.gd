"""
คำสั่ง 'ช่วย'
"""
extends Command

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
	game.tell("ดูเหมือนว่าคุณจะสามารถทำสิ่งต่อไปนี้ได้.....")
	for _cmd in commands_list.filter(func(item): return item['visible_in_help'] == true ):
		var _display_cmd = ""
		if ( typeof(_cmd.cmd) == TYPE_ARRAY ):
			_display_cmd = ", ".join( PackedStringArray(_cmd.cmd) )
		else:
			_display_cmd = _cmd.cmd
		#game.tell( "- %s ( %s )" % [ _display_cmd, _cmd.desc ] )
		game.tell( "- [cmd]%s[/cmd]" % [ _cmd.desc, _display_cmd ])
	
