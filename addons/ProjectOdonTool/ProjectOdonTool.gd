@tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("Command", "Node", preload("CustomType/CommandType.gd")
	, preload("res://assets/icons/command.svg"))
	pass


func _exit_tree():
	remove_custom_type("Command")
	pass
