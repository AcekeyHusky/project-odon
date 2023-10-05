extends Node
class_name GameManager

@onready var game = self
@onready var world = $World
@onready var commands = $CommandHandler
@onready var logs = $UI/ScrollContainer/VBoxContainer/Logs
@onready var input = $UI/Input
@onready var settings = $UI/Settings
@onready var commandHistory = $UI/CommandHistory
@onready var music = $Music
@onready var finput = $UI/FakeInputContainer/FakeInput
@onready var map = $UI/Layout/SubViewportContainer/Map

@export var here: Room

func tell(text: String):
	# ใช้ append_text แทน add_text เพื่อให้สามารถใช้ bbcode ได้
	if logs.get_parsed_text() != "":
		logs.append_text("\n"+text.format(world.text_format))
	else:
		logs.append_text(text)
	await get_tree().create_timer(0.1).timeout
	_scroll_bottom()
	
func _ready() -> void:
	finput.text = ""
	music.play_bgm()
	input.grab_focus()

func _process(_delta) -> void:
	logs.modulate = $Settings.textColor
	if Input.is_action_just_pressed("enter") and input.text != "":
		_on_input_entered()
		
	if Input.is_action_just_pressed("ui_right") and commandHistory.text.length() > 0:
		input.text=""
		input.insert_text_at_caret(commandHistory.text)
	
	# อนิเมทตัวอักษรขึ้นวินาทีละตัว
	if logs.get_total_character_count() > logs.visible_characters:
		logs.visible_characters += 1
		music.play_se_typing()

func _input(event) -> void:
	# กดปุ่มเพื่อข้ามการอนิเมทตัวอักษร
	if event.is_pressed():
		logs.visible_characters = logs.get_total_character_count()
		
func can_pass() -> bool:
	# if no_enemy_block
		return true
		
func _scroll_bottom():
	$UI/ScrollContainer.scroll_vertical = $UI/ScrollContainer.get_v_scroll_bar().max_value
	pass

func _on_input_entered() -> void:
		commands.process_input(input.text)
		input.clear()
		finput.clear()
		commandHistory.text = ""	

func _on_input_text_changed() -> void:
	var merge_command = here.command_keywords
	merge_command.append_array(commands.command_history)
	
	var match_command = merge_command.filter(func(text): return text.begins_with(input.text))
	commandHistory.text = ""
	if match_command.size() > 0 :
		var command_text = match_command[0]
		commandHistory.text = command_text
	commands.faking_input()
	
