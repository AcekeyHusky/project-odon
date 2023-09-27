@tool
extends EditorPlugin


func _enter_tree():
	# Add custom Command node (Icon is placeholder)
	add_custom_type("Command","Node",preload("CommandNode.gd"),preload("res://icon.svg"))
	pass


func _exit_tree():
	remove_custom_type("Command")
	pass
