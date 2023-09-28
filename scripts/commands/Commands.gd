extends Node
@onready var game = get_node("..")
@onready var player = get_node("../Player")
@onready var logs = get_node("../ScrollContainer/VBoxContainer/Logs")
@onready var settings = get_node("../Settings")
@onready var history = get_node("../CommandHistory")
@onready var finput = $"../FakeInputContainer/FakeInput"
@onready var commands = self

var command_hash: Dictionary = {}
var command_history: Array[String] = []
var cmd: Command
var words: Array

func fake_input():
	# ระบบใส่ bbcode ให้ FakeInput
	var itext = game.input.text
	var found_key = false
	words = parse(itext, [cmd_keys])
	for child in get_children():
		var ck = child.get("key")
		if ck == itext:
			found_key = true
			break
	if words.size() > 0 and is_found_key(words[0]):
		if words.size() > 1:
			finput.text = "[command]%s[/command][color=orange]%s[/color]" % [words[0],words[1]]
		elif words.size() > 0:
			finput.text = "[command]%s[/command]" % words[0]
	else:
		finput.text = itext

func process_input(input):
	game.printf("> %s" % finput.text)
	""" ขอปิดก่อน
	if game.cur_stage == 1:
		if !settings.colorCheck(input):
			game.printf("คุณต้องใส่ค่าสี RGB ก่อน")
		else:
			settings.setTextColor(input)
			game.printf("สีอักษรปัจจุบัน: " + settings.textColor)
			game.printf("กลับเข้าสู่โหมดเล่นเกมปกติ")
			game.cur_stage = 0
	"""
	words = parse(input, [cmd_keys])
	if is_found_key(words[0]):
		print(cmd)
		print(words[0])
		print(words)
		cmd.exec(words)
	else:
		game.printf("[color=red]ไม่พบคำสั่งที่คุณใช้ กรุณาพิมพ์[/color] [command]ช่วย[/command]")	
	
	command_hash[input] = true
	for key in command_hash:
		if !command_history.has(key):
			command_history.append(key)
		
func is_found_key(_key):
	for child in get_children():
		var child_key = child.get("key")
		if child_key == _key:
			cmd = child
			return true
		
var cmd_keys = []

func create_cmd_list():
	for child in get_children():
		if child is Command:
			var child_key = child.get("key")
			cmd_keys.append(child.key)
	print("Current Keys")
	print(cmd_keys)

func _ready():
	# เพิ่ม command set จาก CmdGeneral
	var cmd_set = $CmdGeneral.cmd_set
	for item in cmd_set:
		add_child(item.new(),true)
	
	# เพิ่ม  key ต่างๆ เข้า cmd_list
	create_cmd_list()

# Parsing
func parse(raw_string: String, key_lists: Array) -> Array:
	var slices = []
	words = raw_string.split(" ")
	for word in words:
		var word_slices = slice_word(word, key_lists)
		slices += word_slices
	return slices

func slice_word(word: String, key_lists: Array) -> Array:
	var slices = []
	var i = 0

	# Combine and sort all key lists by length in descending order
	var combined_key_list = []
	for key_list in key_lists:
		combined_key_list += key_list
	combined_key_list.sort_custom(_compare_key_lengths)

	while i < len(word) and combined_key_list.size() > 0:
		var found_key = false

		for key in combined_key_list:
			var key_length = len(key)
			if word.substr(i, key_length) == key:
				slices.append(key)
				i += key_length
				found_key = true
				break

		if not found_key:
			slices.append(word.substr(i))
			break

	return slices
	
func _compare_key_lengths(a: String, b: String) -> int:
	return len(b) - len(a)
