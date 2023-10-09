extends Command

func fun():
	var text_cant_take = "เกรงว่าคุณจะหยิบสิ่งนั้นไม่ได้"
	
	if words.size() > 1:
		var thing = words[1]
		var thing_search = world.search_thing(thing)
		
		if not thing_search is Item:
			game.tell(text_cant_take)
			
		elif thing_search is Item and thing_search.is_reveal:
			if thing_search.get_parent() == world.player:
				game.tell("คุณมีสิ่งนั้นอยู่แล้ว")
				return
				
			if thing_search.can_take:
				game.tell("คุณหยิบ[thing]%s[/thing]" % thing_search.name)
				if not thing_search.is_saw:
					game.tell(thing_search.description)
					thing_search.is_saw = true
				thing_search.reparent(world.player)
				print(thing_search)
			else:
				game.tell(text_cant_take)
				
		else:
			game.tell(Global.text_no_thing % thing)
