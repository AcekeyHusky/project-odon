@tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("Command", "Node", preload("CustomType/CommandType.gd")
	, preload("res://assets/icons/command.svg"))
	
	#add_custom_type("Room", "Node", preload("CustomType/Thing/RoomType.gd")
	#, preload("res://assets/icons/room.svg"))
	pass


func _exit_tree():
	remove_custom_type("Command")
	#remove_custom_type("Room")
	pass
