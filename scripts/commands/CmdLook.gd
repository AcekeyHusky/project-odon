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
			game.tell(thing_search.description)
			thing_search.is_saw = true	
			for i in thing_search.contents:
				i.is_reveal = true
		else:
			game.tell(Global.text_no_thing % thing)
	else:
		
		here()

func here():
	if (easter < 9):
		easter += 1
		game.tell("(คุณดูห้องนี้ไปแล้ว " + str(easter) + " /10 รอบ)")
		game.tell(world.here.description)
	else:
		game.tell("ยินดีด้วย คุณได้ดูมากเกินไปจนไม่สามารถออกไปจากห้องนี้ได้")
		get_tree().quit()
	
