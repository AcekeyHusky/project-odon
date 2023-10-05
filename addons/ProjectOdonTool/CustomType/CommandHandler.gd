## ตัวจัดการคำสั่งต่าง ๆ
@icon("res://assets/icons/console.svg")
extends Node
class_name CommandHandler

@onready var game = $".."
@onready var logs = game.get_node("UI/ScrollContainer/VBoxContainer/Logs")
@onready var history = game.get_node("UI/CommandHistory")
@onready var finput = game.get_node("UI/FakeInputContainer/FakeInput")
@onready var world = game.get_node("World")
@onready var input = game.get_node("UI/Input")
@onready var commands = self

var command_hash: Dictionary = {}
var command_history: Array[String] = []
var cmd: Command
var words: Array
var cmd_list: Array = []
var dir_list: Array = []
var thing_list: Array = []
var key_lists: Array = [cmd_list, dir_list, thing_list]

func update_key_lists():
	key_lists = [cmd_list, dir_list, thing_list]

## ระบบใส่ bbcode ให้ FakeInput ## TODO
func faking_input() -> void:
	update_key_lists()
	var _input_words: Array = parse(input.text, key_lists)
	var _fake_words: Array = ["", "", ""]
	finput.clear()
	for i in _input_words:
		if is_command(i) and _input_words.find(i) == 0:
			finput.append_text("[cmd]%s[/cmd]" % i)
		elif Global.get_direction(i):
			finput.append_text("[dir]%s[/dir]" % i)
		elif world.search_thing(i) and world.search_thing(i).is_reveal:
			finput.append_text("[thing]%s[/thing]" % i)
		else:
			finput.append_text("%s" % i)
	print(_input_words)

func process_input(_input) -> void:
	game.tell("\n> %s" % input.text)
	words = parse(_input, key_lists)
	var _target = Global.get_direction(_input)
	if is_command(words[0]):
		print(cmd)
		print(words)
		cmd.exec(words)
		world.update_thing_list()
	elif _target:
		world.go_to_room(_target)
	else:
		game.tell("ไม่พบคำสั่งที่คุณใช้ ลองพิมพ์ [cmd]ช่วย[/cmd] สิ!")	
	
	command_hash[_input] = true
	for key in command_hash:
		if !command_history.has(key):
			command_history.append(key)

func is_command(_key: String) -> bool:
	for child in get_children():
		if child is Command:
			var child_key = child.get("key")
			var child_aliases = child.get("aliases")
			if child_key == _key or child_aliases.has(_key):
				cmd = child
				return true
	return false
	

func create_cmd_list() -> void:
	for child in get_children():
		if child is Command:
			var child_key = child.get("key")
			var child_aliases = child.get("aliases")
			cmd_list.append(child.key)
			if child_aliases != []:
				for i in child_aliases:
					cmd_list.append(i)
	print("Keys ปัจจุบัน")
	print(cmd_list)
	print("")
	
func create_dir_list() -> void:
	for i in Global.directions.keys():
		for _dir in Global.directions[i]:
			dir_list.append(_dir)
			

	
func add_CmdGeneral() -> void:
	var cmdg = $CmdGeneral
	var cmd_set = cmdg.cmd_set
	for i in cmd_set:
		add_child(i.new(), true)

# Parse ข้อความ
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
	combined_key_list.sort_custom(sort_string_lengths)

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
	
func sort_string_lengths(a: String, b: String) -> bool:
	if len(a) > len(b):
		return true
	return false

func _ready() -> void:
	add_CmdGeneral()
	create_cmd_list()
	create_dir_list()
