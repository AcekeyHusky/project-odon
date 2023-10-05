extends SubViewport

@onready var camera = $Camera2D

var map_tile = preload("res://scenes/map_tile.tscn")

var map_loc = Vector3(0,0,0)

var tile_drawed = {
	"0:0:0": $Control/MapTile
}

func _ready():
	camera.position = Vector2(0,0)
	pass # Replace with function body.

func _process(_delta):
	pass

func on_room_change(dir:String):
	var is_level_change = false
	match dir:
		"north":
			map_loc.y = map_loc.y - 1
		"south":
			map_loc.y = map_loc.y + 1
		"east":
			map_loc.x = map_loc.x + 1
		"west":
			map_loc.x = map_loc.x - 1
		"up":
			map_loc.z = map_loc.z + 1
			is_level_change = true
		"down":
			map_loc.z = map_loc.z - 1
			is_level_change = true
			
	if is_level_change :
		draw_level()
	else:
		draw_map()
	
func draw_map():
	camera.position = Vector2(
		0 if map_loc.x == 0 else map_loc.x * 32,
		0 if map_loc.y == 0 else map_loc.y * 32
	)
	
	$Label.position = camera.position
	$Label.position.x = $Label.position.x - 19
	$Label.position.y = $Label.position.y - 11
	var key = "{x}:{y}:{z}".format({"x":map_loc.x,"y":map_loc.y,"z":map_loc.z})
	if !tile_drawed.has(key):
		tile_drawed[key] = map_tile.instantiate()
		add_child(tile_drawed[key])
		tile_drawed[key].position.x = camera.position.x-16
		tile_drawed[key].position.y = camera.position.y-16
	pass
	
func draw_at(pos:Vector3):
	var x = 0 if pos.x == 0 else pos.x * 32
	var y = 0 if pos.y == 0 else pos.y * 32
	var new_tile = map_tile.instantiate()
	add_child(new_tile)
	new_tile.position.x = x-16
	new_tile.position.y = y-16
	pass
	
func draw_level():
	clear_level()
	pass

func clear_level():
	print("clear level")
	
	for tile in get_children():
		if tile is Panel :
			tile.queue_free()
	for tile in tile_drawed.keys():
		var slice = tile.split(":")
		var level = slice[2]
		var x = slice[0]
		var y = slice[1]
		
		if level == "{z}".format({"z":map_loc.z}):
			var pos := Vector3(float(x),float(y),float(level))
			draw_at(pos)
#			print(slice)
	
	
	draw_map()
