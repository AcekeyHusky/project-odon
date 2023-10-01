@icon("res://assets/icons/console.svg")
extends Node
# อาจจะสร้างขึ้นมาเป็นคลาสแยก

@onready var game = $".."
@onready var logs = $"../ScrollContainer/VBoxContainer/Logs"
@onready var history = $"../CommandHistory"
@onready var finput = $"../FakeInputContainer/FakeInput"
@onready var commands = self

var command_hash: Dictionary = {}
var command_history: Array[String] = []
var cmd: Command
var words: Array
var cmd_keys = []

func fake_input(): ## TODO
	# ระบบใส่ bbcode ให้ FakeInput
	var itext = game.input.text
	words = parse(itext, [cmd_keys])
	for child in get_children():
		var ck = child.get("key")
		if ck == itext:
			break
	if words.size() > 0 and found_key(words[0]):
		if words.size() > 1:
			finput.text = "[cmd]%s[/cmd][color=orange]%s[/color]" % [words[0],words[1]]
		elif words.size() > 0:
			finput.text = "[cmd]%s[/cmd]" % words[0]
	else:
		finput.text = itext

func process_input(input):
	game.tell("\n> %s" % finput.text)
	words = parse(input, [cmd_keys])
	
	if found_key(words[0]):
		print(cmd)
		print(words[0])
		print(words)
		print("")
		cmd.exec(words)
	else:
		game.tell("ไม่พบคำสั่งที่คุณใช้ ลองพิมพ์ [cmd]ช่วย[/cmd] สิ!")	
	
	command_hash[input] = true
	for key in command_hash:
		if !command_history.has(key):
			command_history.append(key)
		
func found_key(_key: String) -> bool:
	for child in get_children():
		if child is Command:
			var child_key = child.get("key")
			var child_aliases = child.get("aliases")
			if child_key == _key or child_aliases.has(_key):
				cmd = child
				return true
	return false
	
func create_cmd_list():
	for child in get_children():
		if child is Command:
			var child_key = child.get("key")
			var child_aliases = child.get("aliases")
			cmd_keys.append(child.key)
			if child_aliases != []:
				for i in child_aliases:
					cmd_keys.append(i)
	print("Keys ปัจจุบัน")
	print(cmd_keys)
	print("")
	
func add_CmdGeneral():
	var cmdg = $CmdGeneral
	var cmd_set = cmdg.cmd_set
	for i in cmd_set:
		add_child(i.new(),true)

func _ready():
	add_CmdGeneral()
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
