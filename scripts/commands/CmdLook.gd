"""
ดูสถานที่ สิ่งมีชีวิต หรือวัตถุ

วิธีใช้:
	ดู
	ดู<สมช>
	ดู<วัตถุ>
"""
extends Command

func fun():
	if words.size() > 1:
		var thing = words[1]
		if game.search_thing(thing):
			game.tell(game.search_thing(thing).description)
		else:
			game.tell("ไม่มี[color=purple]%s[/color]ที่นี่" % thing)
			print("Can't Find")
		if thing == "ที่นี่":
			here()
	else:
		here()

func here():
	game.tell(game.here.description)
	
