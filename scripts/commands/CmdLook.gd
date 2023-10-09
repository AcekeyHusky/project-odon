"""
ดูสถานที่ สิ่งมีชีวิต หรือวัตถุ

วิธีใช้:
	ดู
	ดู<สมช>
	ดู<วัตถุ>
"""
extends Command

var easter = 0


func fun():
	if words.size() > 1:
		var thing = words[1]
		var thing_search = world.search_thing(thing)
		if thing == "ที่นี่":
			here()
			return
		if thing_search and thing_search.is_reveal:
			if thing_search.description:
				game.tell(thing_search.description)
			else:
				game.tell(words[1] + "ไง")
			thing_search.is_looked = true	
			for i in thing_search.get_contents():
				i.is_reveal = true
		else:
			game.tell(Global.text_no_thing % thing)
	else:	
		here()


func here():
	if world.here.description:
		game.tell(world.here.description)
	easter_egg()
	

func easter_egg():
	if (easter < 9):
		easter += 1
		# game.tell("(คุณดูห้องนี้ไปแล้ว " + str(easter) + " /10 รอบ)")
		return
	game.tell("[color=red]ยินดีด้วย คุณได้ดูมากเกินไปจนไม่สามารถออกไปจากห้องนี้ได้[/color]")
	Global.directions = {}
