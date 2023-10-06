"""
สามารถเปลี่ยนสถานที่, ตัวละครเริ่มต้นได้ด้วยการลาก Resource ไปยัง Inspector ด้านขวาของโหนดนี้
"""

extends Node

@export var starter_room: Room
@export var starter_player: Living

@onready var game = $".."
@onready var map = game.get_node("UI/Layout/SubViewportContainer/Map")
@onready var commands = game.get_node("CommandHandler")

var rooms: Array = []
var here: Room
var player: Living

var text_format: Dictionary
var started: bool = false

func on_enter_room(_room_id: int):
	var _room = rooms[_room_id]
	game.tell("[room]%s[/room]" % _room.name)
	if not _room.is_saw:
		game.tell(_room.description)
		_room.is_saw = true

func rooms_init() -> void:
	if starter_room:
		rooms.append(starter_room)
	else:
		rooms.append(load("res://database/rooms/TheVoid.tres"))
		
	if starter_player:
		player = starter_player
	else:
		player = load("res://database/livings/Player.tres")
	
	here = rooms[0]
	here.add_contents(player)
	print(rooms[0].name)
	print(rooms[0].contents[0].name)
	text_format = {"player":player.name}

func _ready() -> void:
	rooms_init()
	debug_room()
	update_thing_list()
	
func _process(_delta):
	text_format = {"player":player.name}
	if not started:
		event_start()
		started = true
	
func event_start() -> void:
	on_enter_room(0)
	
func go_to_room(dir: String) -> void:
	var _target = here.go_to_dir(dir)
	print(_target)
	if _target:
		_target = load(_target)
		if not rooms.has(_target):
			rooms.append(_target)
		var _room_id = rooms.find(_target)
		player.name = "สุดหล่อ"
		move_player(_room_id)
		on_enter_room(_room_id)
		map.on_room_change(dir)
	else:
		print("cannot go ", dir)
	debug_room()
	pass

func move_player(_room_id) -> void:
	rooms[_room_id].add_contents(player)
	here.remove_contents(player)
	here = rooms[_room_id]
	
func debug_room() -> void:
	print("")
	print("Room %s: %s" % [rooms.find(here), here.name])
	if here.contents != []:
		print("ไอเทมในห้อง")
		for i in here.contents:
			print("- " + i.name)
	for i in rooms:
		print("Rooms %s: %s" % [rooms.find(i), i.name])

func search_thing(_thing: String):
	return search_thing_from(_thing, here)
					
func search_thing_from(_search: String, _from: Thing):
	if _from.name == _search:
		return _from
	
	if "contents" in _from:
		var contents = _from.get("contents")
		
		for child in contents:
			if search_thing_from(_search, child) != null:
				return search_thing_from(_search, child)
			if ("keys") in child and _search in child.keys:
				return child
				
	return null

func update_thing_list() -> void:
	commands.thing_list = []
	append_things(here.contents)
	
func append_things(contents:Array[Thing]):
	for content in contents:
		commands.thing_list.append(content.name)
		for id in content.keys:
				commands.thing_list.append(id)
		if content.contents.size() > 0:
			append_things(content.contents)
	
