extends Command

func fun():
	var text_cant_take = "เกรงว่าคุณจะหยิบสิ่งนั้นไม่ได้"
	
	if words.size() > 1:
		var thing = words[1]
		var thing_search = world.search_thing(thing)
		if not thing_search is Item:
			game.tell(text_cant_take)
		elif thing_search is Item and thing_search.is_saw:
			if thing_search.can_take:
				game.tell(thing_search.description)
				world.player.add_contents(thing_search)
				world.here.remove_contents(thing_search)
				print(thing_search)
			else:
				game.tell(text_cant_take)
		else:
			game.tell(Global.text_no_thing % thing)
