"""
สามารถเปลี่ยนสถานที่, ตัวละครเริ่มต้นได้ด้วยการลาก Resource ไปยัง Inspector ด้านขวาของโหนดนี้
"""

extends Node

## ห้องเริ่มต้น
@export var starter_room: Room
## ตัวละครผู้เล่น
@export var starter_player: Actor

@onready var game = $".."
@onready var map = game.get_node("UI/Layout/SubViewportContainer/Map")
@onready var commands = game.get_node("CommandHandler")

var here: Room
var player: Actor

var text_format: Dictionary
var started: bool = false

var test: bool

func on_enter_room(_room: Room):
	game.tell("[room]%s[/room]" % _room.key)
	if not _room.is_looked:
		game.tell(_room.description)
		_room.is_looked = true

func rooms_init() -> void:
	here = starter_room
	
	if starter_player:
		player = starter_player

	text_format = {"player":player.name}


func _ready() -> void:
	rooms_init()
	debug_room()
	update_thing_list()
	game.music.play_bgm()
	

func _process(_delta):
	text_format = {"player":player.name}
	if not started:
		event_start()
		started = true
	
func event_start() -> void:
	on_enter_room(here)
	
# ย้ายห้อง
func go_to_room(dir: String) -> void:
	var _target_room = here.go_to_dir(dir)
	if _target_room:
		player.name = "สุดหล่อ"
		move_player(_target_room)
		on_enter_room(_target_room)
		map.on_room_change(dir)
	else:
		game.tell("ไปไม่ล่าย")
		print("cannot go ", dir)
	debug_room()
	pass

# ย้ายผู้เล่น
func move_player(_room_id) -> void:
	player.reparent(_room_id)
	here = _room_id
	
func debug_room() -> void:
	print("")
	print("Room %s:" % here)
	print("ไอเทมในห้อง")
	print(here.get_contents())

func search_thing(_thing: String):
	return search_thing_from(_thing, here)
					
func search_thing_from(_search: String, _from: Thing):
	if  _search == _from.key:
		return _from	
	
	for _thing in _from.get_contents():
		if _search == _thing.key:
			return _thing
		if _thing.aliases.has(_search):
			return _thing
			
		for _sub_thing in _thing.get_contents():
			if search_thing_from(_search, _sub_thing) != null:
				return search_thing_from(_search, _sub_thing)
				
	return null

func update_thing_list() -> void:
	commands.thing_list = []
	append_things(here.get_contents())
	
func append_things(contents: Array):
	for content in contents:
		if content.is_reveal:
			commands.thing_list.append(content.key)
			if content.aliases.size() > 0:
				for id in content.aliases:
					commands.thing_list.append(id)
			if content.get_contents().size() > 0:
				append_things(content.get_contents())
