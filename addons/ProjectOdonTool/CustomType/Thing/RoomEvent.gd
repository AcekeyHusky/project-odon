extends Node

class_name RoomEvent

signal tell

var get_data : Callable

func set_get_data(getter_func:Callable):
	get_data = getter_func

func Tell(msg :String):
	emit_signal("tell",msg)
