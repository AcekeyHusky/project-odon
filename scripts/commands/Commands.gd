extends Node
@onready var player = get_node("../Player")
@onready var game = $".."
@onready var logs = get_node("../ScrollContainer/VBoxContainer/Logs")
@onready var settings = get_node("../Settings")
@onready var history = get_node("../CommandHistory")

var command_hash:Dictionary = {}
var command_history: Array[String] = []

func process_input(input):
	game.printf("> %s" % input)
	
	if game.cur_stage == 1:
		if !colorCheck(input):
			game.printf("คุณต้องใส่ค่าสี RGB ก่อน")
		else:
			game.printf("สีอักษรปัจจุบัน: " + settings.textColor)
			game.printf("กลับเข้าสู่โหมดเล่นเกมปกติ")
			settings.setTextColor(input)
			game.cur_stage = 0
	else:
		var words = input.split(" ", false)
		if words.size() == 0:
			return "Error: no words were parsed."
		var first_word = words[0]
		var second_word = ""
		if words.size() > 1:
			second_word = words[1]
		
		match first_word:
			"ล้าง":
				CmdClear()
			"ต่อย":
				CmdPunch()
			"สถานะ":
				CmdStatus()
			"นอน":
				CmdRest()
			_:
				var found_key
				for child in get_children():
					var child_key = child.get("key")
					if child_key == first_word:
						child.fun(words)
						found_key = true
						break
				if !found_key:
					game.printf("ไม่พบคำสั่งที่คุณใช้ กรุณาพิมพ์ 'ช่วย'")

	command_hash[input] = true
	
	for key in command_hash:
		if !command_history.has(key):
			command_history.append(key)

	
	
func colorCheck(text):
	if text.length() == 6:
		for i in text:
			if !(i.is_valid_hex_number()):
				return false
		return true
	else:
		return false
	
func CmdRest():
	var msg_showTired = " (ความเหนื่อยล้าปัจจุบัน: "+var_to_str(player.stats.tired)+")"
	if player.stats.tired >= 80:
		game.printf("คุณพยายามข่มตาหลับ แต่ตาคุณยังสว่างอยู่เลย"+msg_showTired)
	elif player.stats.tired >= 60:
		game.printf("คุณยังไม่รู้สึกง่วงสักเท่าไหร่"+msg_showTired)

func CmdClear():
	logs.clear()
	
func CmdStatus():
	game.printf("ฮ.พ. = "+var_to_str(player.stats.hp))

func CmdPunch():
	# If no enemy
	game.printf("คุณต่อยลม")
