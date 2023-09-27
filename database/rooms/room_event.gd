extends Node

class_name RoomEvent

signal printf

var get_data : Callable

func set_get_data(getter_func:Callable):
	get_data = getter_func

func Printf(msg :String):
	emit_signal("printf",msg)
