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

func fun():
	game.printf("คุณแหกตาเบิ่งสถานที่แห่งนี้ และพบว่า..." + game.room_env)

