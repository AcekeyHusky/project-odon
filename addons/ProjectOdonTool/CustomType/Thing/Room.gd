@icon("res://assets/icons/room.svg")
@tool
extends Thing
class_name Room

@export var command_keywords: Array = []

@export_group("Exit(s)")
@export var north_west: Room
@export var north: Room
@export var north_east : Room
@export var west: Room
@export var east: Room
@export var south_west: Room
@export var south: Room
@export var south_east: Room
@export var up: Room
@export var down: Room

var RoomScript

	
func go_to_dir(dir:String):
	if self[dir]:
		return self[dir]
