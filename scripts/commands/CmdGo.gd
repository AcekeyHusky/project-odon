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
		var _dir: String = words[1]
		var _target = Global.get_direction(_dir)
		print(_target)
		if _target:
			world.go_to_room(_target)
	else:
		game.tell(msg_failed)
		

