extends Panel

@onready var item_container = $ScrollContainer/VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_ui_item_updated(item_list):
	# ลบ child หากเกิน size ของ item_list
	var remove_list = []
	for n in item_container.get_child_count():
		if n >= item_list.size():
			remove_list.append(item_container.get_child(n))
	for r in remove_list:
		item_container.remove_child(r)
	
	# แก้ไข node / เพิ่ม node ใหม่
	for item in item_list.size():
		var child = item_container.get_child(item)
		if child == null:
			child = Label.new()
			child.name = item_list[item]
			child.text = item_list[item]
			item_container.add_child(child)
		else:
			child.name = item_list[item]
			child.text = item_list[item]
	pass
