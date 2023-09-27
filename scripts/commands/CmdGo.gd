"""
ย้าย Room

วิธีใช้:
ไป<ทิศ>
ไป <ทิศ>

เช่น ไปเหนือ, ไป อ

"""
extends Command

var msg_failed = "[color=red]ไปไหนดีน้าาาา คุณคิดกับตัวเอง.....[/color]"

func _init():
	key = "ไป"

func fun():
	if words.size() > 1:
		var dir = words[1]
		match dir:
			"เหนือ","น", "north", "n":
				game.go_to_room("north")
			"ใต้", "ต" ,"south","s":
				game.go_to_room("south")
			"ตะวันออก", "ออก", "อ", "ตะวันอออก","east","e":
				game.go_to_room("east")
			"ตะวันตก", "ตก", "ตต","ตะวันตก","west","w":
				game.go_to_room("west")
			"ขึ้น", "ข","up","u":
				game.go_to_room("up")
			"ลง", "ล","down","d":
				game.go_to_room("down")
			_:
				game.printf(msg_failed)
	else:
		game.printf(msg_failed)
