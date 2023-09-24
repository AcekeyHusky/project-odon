"""
ดูสถานที่ สิ่งมีชีวิต หรือวัตถุ

วิธีใช้:
	ดู
	ดู<สมช>
	ดู<วัตถุ>
"""
extends Node
@onready var game = $"../.."

var key = "ดู"
var aliases = ["เบิ่ง"]

func fun(_args):
	if _args.size() > 1 :
		game.current_room.look_something(_args[1])
	else:
		game.current_room.look()
	

