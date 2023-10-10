extends Control

@onready var game = $".."

var intialized:bool = false
var playerPath:String = ""

var playerItem:Array[String] = []

signal item_updated

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func process_ui():
	# World ไม่ได้ตั้งต้นมา เช็คก่อนเรียกใช้
	if game.has_node("World") && !intialized:
		intialized = true
		initialize_world()
	
	if intialized :
		if playerPath == "" :
			if game.has_node("World"):
				var root = game.get_node("World")
				find_player(root)
		else:
			var player = get_node(playerPath)
			if player.get_child_count() != playerItem.size():
				update_item_list()

func update_item_list():
	if playerPath != "":
		var player = get_node(playerPath)
		playerItem = []
		for item in player.get_children():
			playerItem.append(item.name)
		emit_signal("item_updated", playerItem)

func find_player(node:Node):
	for child in node.get_children():
		if child.name == "ผู้เล่น":
			playerPath = "{path}".format({"path":child.get_path()})
			return 
		if child.get_child_count() > 0:
			return find_player(child)
	
# ไว้อัปเดท playerPath ตอนเปลี่ยนแผนที่
func scene_change():
	if game.has_node("World"):
			var root = game.get_node("World")
			find_player(root)
	pass

# event สำหรับ init world ครั้งแรก
func initialize_world():	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_ui()
