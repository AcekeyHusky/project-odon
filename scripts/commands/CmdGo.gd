extends Node
@onready var game = $"../.."

var key = "ไป"

func fun(_args:Array[String]):
	if _args.size() > 1:
		var dir = _args[1]
		match dir:
			"เหนือ","north","n":
				game.go_to_room("north")
			"ใต้","south","s":
				game.go_to_room("south")
			"ออก","ตะวันอออก","east","e":
				game.go_to_room("east")
			"ตก","ตะวันตก","west","w":
				game.go_to_room("west")
			"ขึ้น","up","u":
				game.go_to_room("up")
			"ลง","down","d":
				game.go_to_room("down")
			_:
				game.printf("ไปไหนดัีน้าาา คุณคิดกับตัวเอง....")
		
	else:
		game.printf("ไปไหนดัีน้าาา คุณคิดกับตัวเอง....")
