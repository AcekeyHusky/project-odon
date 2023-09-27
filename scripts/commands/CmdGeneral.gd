extends Node

var cmd_set = [CmdClear
	, CmdRest
	, CmdPunch
	, CmdStatus]

class CmdClear extends Command:
	func _init():
		key = "ล้าง"
	func fun():
		logs.clear()

class CmdRest extends Command:
	func _init():
		key = "นอน"
	func fun():
		var msg_showTired = " (ความเหนื่อยล้าปัจจุบัน: "+var_to_str(player.stats.tired)+")"
		if player.stats.tired >= 80:
			game.printf("คุณพยายามข่มตาหลับ แต่ตาคุณยังสว่างอยู่เลย"+msg_showTired)
		elif player.stats.tired >= 60:
			game.printf("คุณยังไม่รู้สึกง่วงสักเท่าไหร่"+msg_showTired)

class CmdPunch extends Command:
	func _init():
		key = "ต่อย"
	func fun():
		# if no ememy
		game.printf("คุณต่อยลม")

class CmdStatus extends Command:
	func _init():
		key = "สถานะ"
	func fun():
		game.printf("พลังชีวิต = " + var_to_str(player.stats.hp))
