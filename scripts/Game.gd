extends Control

var turn:int = 0
var cur_place
var cur_room:int = 0
var max_room:int
var room_env:String
var random = RandomNumberGenerator.new()

@onready var player = $Player
@onready var world = $World
@onready var logs = $Logs
@onready var input = $Input
@onready var settings = $Settings
@onready var commands = $Commands
	
func get_event(event):
	cur_place = event.place
	
func get_place(place):
	var places_data = $Places.places
	if place in places_data:
		var place_info = places_data[place]
		max_room = place_info["rooms"]
		print(place_info["env_msg"])
		room_env = place_info["env_msg"]

func printf(text):
	if logs.get_parsed_text() != "":
		logs.add_text("\n"+text)
	else:
		logs.add_text(text)
	
func run_command(text):
	printf("> %s" % text)
	if settings.settingMode:
		if !colorCheck(text):
			printf("คุณต้องใส่ค่าสี RGB ก่อน")
		else:
			printf("สีอักษรปัจจุบัน: " + settings.textColor)
			printf("กลับเข้าสู่โหมดเล่นเกมปกติ")
			settings.setTextColor(text)
			settings.settingMode = false
	else:
		if text == "ค้น":
			$Commands.cmd_search()
		elif text == "ดู" or text == "เบิ่ง":
			$Commands.cmd_look()
		elif text == "นอน" or text == "พัก":
			$Commands.cmd_rest()
		elif text == "ล้าง":
			$Commands.cmd_clear()
		elif text == "ไป":
			$Commands.cmd_go()
		elif text == "ช่วย":
			$Commands.cmd_help()
		elif text == "สถานะ":
			$Commands.cmd_status()
		elif text == "ต่อย":
			$Commands.cmd_punch()
		elif text == "ปรับแต่ง" or text == "ตั้งค่า":
			$Commands.cmd_setting()
	
func can_pass():
	# if no_enemy_block
		return true
		
func take_step():
	player.stats.tired -= 1
	printf("คุณเดินหน้าต่อไปอีกก้าว")
	player.stats.cur_pos += 1
	printf("คุณยังคงอยู่ใน "+cur_place)
	if random.randf_range(0,1) >= 0.5:	
		printf($Events.events.found_enemy.msg0)
	print("Current World Position: "+var_to_str(player.stats.cur_pos))
		
func _ready():
	random.randomize()
	input.grab_focus()
	get_event($Events.events.ev_start)
	get_place(cur_place)
	printf($Events.events.ev_start.msg0)
	
func _on_input_entered():
		commands.process_input(input.text)
		input.clear()

func _process(_delta):
	$Logs.modulate = $Settings.textColor
	if Input.is_action_just_pressed("enter") and input.text != "":
		_on_input_entered()
		
func colorCheck(text):
	if text.length() == 6:
		for i in text:
			if !(i.is_valid_hex_number()):
				return false
		return true
	else:
		return false
