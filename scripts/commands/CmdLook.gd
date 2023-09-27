"""
ดูสถานที่ สิ่งมีชีวิต หรือวัตถุ

วิธีใช้:
	ดู
	ดู<สมช>
	ดู<วัตถุ>
"""
extends Command

func _init():
	key = "ดู"
	aliases = ["เบิ่ง"]

func fun():
	if words.size() > 1 :
		game.current_room.look_something(words[1])
	else:
		game.current_room.look()
	

