extends Node
class_name GameManager

## เนื้อเรื่องที่มีให้เล่น
@export var tales: Array[Tale]

@onready var game = self
@onready var commands = $CommandHandler
@onready var logs = %Logs
@onready var input = %Input
@onready var finput = %FakeInput
@onready var music = %Music
@onready var commandHistory = $UI/CommandHistory
@onready var map = $UI/Layout/SubViewportContainer/Map

signal world_loaded

var can_use_cmd: bool = true
var is_wait: bool = true
var text_send = ""

var voices : PackedStringArray

enum STATES {FIX, FREE}
var state = STATES.FIX

# แสดงผลข้อความบน Logs
func tell(_text: String):
	# เล่นเสียงภาษาไทย
	if(voices):
		DisplayServer.tts_speak(_text, voices[0])
	
	# ใช้ append_text แทน add_text เพื่อให้สามารถใช้ bbcode ได้
	if logs.get_parsed_text() != "" and _text != "\n":
		logs.append_text("\n")
	logs.append_text(_text)
	await get_tree().create_timer(0.1).timeout
	

func event_welcome() -> void:
	tell("สวัสดี! ยินดีต้อนรับสู่ Project Odon การผจญภัยอันยิ่งใหญ่กำลังรอคอยคุณอยู่ แต่ก่อนอื่นคุณต้องเลือกการผจญภัยที่ต้องการเล่นก่อน")
	tell("\n")
	
	for tale in tales:
		game.tell("%s  %s" % [tales.find(tale),tale.name])
		
	tell("\n")
	tell("พิมพ์หมายเลขที่ต้องการ จากนั้นกดปุ่ม Enter")
	
	
func _ready() -> void:
	# ค้นหาเสียงแค่ครั้งเดียวพอแล้ว
	var voice_list := DisplayServer.tts_get_voices()
	for item in voice_list:
		if item["language"].to_lower().contains("th"):
			voices = DisplayServer.tts_get_voices_for_language(item["language"])
	
	finput.text = ""
	input.grab_focus()
	event_welcome()
		
var is_loaded_world: bool

func _process(_delta) -> void:
	if text_send and not is_loaded_world:
		var find_id = int(text_send)
		if find_id >= 0 and find_id < tales.size():
			var selecting_id = tales[find_id]
			var current_tale = load(selecting_id.world).instantiate()
			print(current_tale)
			current_tale.name = "World"
			add_child(current_tale, true)
			is_loaded_world = true
			world_loaded.emit()
			state = STATES.FREE
			logs.reset()
			#tell("คุณต้องการเล่นการผจญภัย " + selecting_id.name + " งั้นหรือ?")
			#tell("พิมพ์ ช/ม แล้วกด Enter เพื่อยืนยัน")
			#if text_send == "ช":
			#	tell("Ok")
			# TODO
	
	
func _input(_event):
	if _event.is_action_pressed("enter") and input.text != "":
		on_pressed_enter()
	if _event.is_action_pressed("ui_right") and commandHistory.text.length() > 0:
		input.text=""
		input.insert_text_at_caret(commandHistory.text)
		
		
func on_pressed_enter() -> void:
	if state == STATES.FREE:
		commands.process_input(input.text)
	text_send = input.text
	commandHistory.text = ""
	input.clear()
	finput.clear()
	

func _on_input_text_changed() -> void:
	var merge_command = []
	var thing_command = []
	
	for i in commands.thing_list:
		thing_command.append("{key}{keyword}".format({"key":"ดู","keyword":i}))
		
	merge_command.append_array(commands.command_history)
	merge_command.append_array(thing_command)
	
	var match_command = merge_command.filter(func(text): return text.begins_with(input.text))
	commandHistory.text = ""
	if match_command.size() > 0 :
		var command_text = match_command[0]
		commandHistory.text = command_text
	
	if state == STATES.FIX:
		finput.text = input.text
		return
	commands.faking_input()
	


