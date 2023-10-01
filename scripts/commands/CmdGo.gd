"""
ย้าย Room

วิธีใช้:
ไป<ทิศ>
ไป <ทิศ>

เช่น
ไปเหนือ
ไป อ
"""
extends Command

var msg_failed = "ไปไหนดีน้าาาา คุณคิดกับตัวเอง....."

func fun():
	if words.size() > 1:
		var dir = words[1]
		match dir:
			"เหนือ","น":
				game.go_to_room("north")
			"ใต้", "ต":
				game.go_to_room("south")
			"ตะวันออก", "ออก", "อ", "ตะวันอออก":
				game.go_to_room("east")
			"ตะวันตก", "ตก", "ตต","ตะวันตก":
				game.go_to_room("west")
			"ขึ้น", "ข":
				game.go_to_room("up")
			"ลง", "ล":
				game.go_to_room("down")
			_:
				game.tell(msg_failed)
	else:
		game.tell(msg_failed)
