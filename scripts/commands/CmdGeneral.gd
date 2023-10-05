"""
Node สำหรับรวบรวม Command ทั่วไปไว้ในคลาสเดียว
"""
extends Node

var cmd_set = [CmdClear
	, CmdRest
	, CmdPunch
	, CmdStatus
	, CmdInventory]

class CmdClear extends Command:
	func _init():
		name = "CmdClear"
		key = "ล้าง"
		description = "ล้างข้อความบนหน้าจอทั้งหมด"
	func fun():
		logs.clear()
		logs.visible_characters = 0

class CmdRest extends Command:
	func _init():
		name = "CmdRest"
		key = "นอน"
		description = "นอนไง"
	func fun():
		game.tell("คุณพยายามข่มตาหลับ แต่ตาคุณยังสว่างอยู่เลย")
		game.tell("คุณยังไม่รู้สึกง่วงสักเท่าไหร่")

class CmdPunch extends Command:
	func _init():
		name = "CmdPunch"
		key = "ต่อย"
		description = "ต่อยไง"
	func fun():
		# if no ememy
		game.tell("คุณต่อยลม")

class CmdStatus extends Command:
	func _init():
		name = "CmdStatus"
		key = "สถานะ"
		description = "ดูสถานะของผู้เล่น"
	func fun():
		game.tell("พลังชีวิต = 10")
		
class CmdInventory extends Command:
	func _init():
		name = "CmdInventory"
		key = "ช่องเก็บของ"
		aliases = ["ชกข", "inv", "inventory"]
		description = "ดูไอเทมในตัว"
	func fun():
		var contents = world.player.contents
		if contents.size() > 0:
			for i in world.player.contents:
				game.tell("- " + i.name)
			return
		game.tell("~ว่างเปล่า~")
		
func _ready():
	self.queue_free()
	
