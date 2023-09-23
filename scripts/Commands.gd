extends Node

@onready var player = get_node("../Player")
@onready var game = $".."
@onready var logs = get_node("../Logs")
@onready var settings = get_node("../Settings")

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

var msg0:String
var msg1:String
var msg2:String
var result_succ:String
var result_fail:String

func cmd_look():
	msg0 = "คุณแหกตาเบิ่งสถานที่แห่งนี้ และพบว่า..."
	game.printf(msg0+game.room_env)

func cmd_search():
	msg0 = "คุณพยายามค้นดูว่าที่นี่มีอะไรน่าสนใจบ้าง"
	result_succ = "และคุณก็พบ"
	result_fail = "แต่น่าเสียดายที่คุณไม่พบอะไรเลย"
	game.printf(msg0)
	
func cmd_rest():
	var msg_showTired = " (ความเหนื่อยล้าปัจจุบัน: "+var_to_str(player.stats.tired)+")"
	if player.stats.tired >= 80:
		game.printf("คุณพยายามข่มตาหลับ แต่ตาคุณยังสว่างอยู่เลย"+msg_showTired)
	elif player.stats.tired >= 60:
		game.printf("คุณยังไม่รู้สึกง่วงสักเท่าไหร่"+msg_showTired)
	
func cmd_clear():
	logs.clear()
	
func cmd_help():
	game.printf("ดูเหมือนว่าคุณจะสามารถทำสิ่งต่อไปนี้ได้.....")
	for _cmd in commands_list.filter(func(item): return item['visible_in_help'] == true ):
		var _display_cmd = ""
		if ( typeof(_cmd.cmd) == TYPE_ARRAY ):
			_display_cmd = ", ".join( PackedStringArray(_cmd.cmd) )
		else:
			_display_cmd = _cmd.cmd
		game.printf( "- %s ( %s )" % [ _display_cmd, _cmd.desc ] )
	
func cmd_go():
	if game.shall_pass():
		game.take_step()
	
func cmd_status():
	game.printf("ฮ.พ. = "+var_to_str(player.stats.hp))

func cmd_punch():
	# If no enemy
	game.printf("คุณต่อยลม")

func cmd_setting():
	settings.settingMode = true
	game.printf("คุณเข้าสู่หน้าตั้งค่า/ปรับแต่งจอแสดงผล")
	game.printf("ใส่รหัสสีเพื่อเปลี่ยนสีตัวอักษร (รหัส RGB โดยไม่ต้องมี #)")
