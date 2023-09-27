extends RoomEvent

# เช็คก่อนย้ายห้อง 
func can_pass(dir:String)->bool:
	# logic หากมีเงื่อนไขในการผ่าน
	match dir:
		_:
			return true
			
			
func start(_args=[]):
	Printf("คุณตื่นขึ้นมาที่ไหนไม่รู้ สภาพของห้องดูเหมือนจะมีแค่ไฟสลัวๆ ไม่ค่อยเห็นอะไรมากนัก")
	Printf("บางทีการ[command]ดู[/command]รอบๆ อาจจะเห็นอะไรมากขึ้นก็ได้นะ")
	# Printf("พิมพ์ [command]ดู[/command] แล้วกด Enter เพื่อสำรวจ")

# event ตอนเข้าห้อง
func enter_room(_args=[]):
	Printf("เข้ามายัง "+ get_data.call("name"))

func look(_args=[]):
	Printf("คุณใช้เวลาในการปรับสายตาสักครู่")
	Printf("เมื่อลองมองดีแล้วๆ ที่นี่ดูเหมือนจะเป็นห้องเล็กๆ น่าจะเรียกได้ว่าเป็น[room]ห้องอ่านหนังสือ[/room]ก็ได้")
	Printf("มี[thing]โต๊ะ[/thing]สำหรับอ่านหนังสืออยู่ มันมี[thing]หนังสือปริศนา[/thing]วางทิ้งไว้ และ[thing]ชั้นหนังสือ[/thing]ที่มีหนังสือเรียงรายอยู่มากมาย")
	Printf("อ่ะ ดูเหมือนว่าทาง \"เหนือ\" จะมีประตูทางออกอยู่ด้วยนะ")
	Printf(get_data.call("description"))

# custom look_something event
func look_something(thing :String):
	match thing:
		"หนังสือ": # JUST TEST
			var things = get_data.call("things")
			print(things.Book.description)
			Printf(things.Book.description)
		"โต๊ะ":
			Printf("โต๊ะไง อิอิ")
			# เติมให้หน่อยกั๊บ
			pass
		"ชั้นหนังสือ":
			Printf("ชั้นหนังสือไง อิอิ")
			# เติมให้หน่อยกั๊บ
			pass
		"ห้องลับ":
			Printf("เห้ย รู่ได้ไงว่ามีห้องลับ ขี้โกงนี่นา")
		_:
			Printf("ดูเหมือนว่าจะไม่มี \""+thing+"\" อยู่ที่นี่")
	pass
	
