"""
Node สำหรับรวบรวม Command ทั่วไปไว้ในคลาสเดียว
"""
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
		logs.visible_characters = 0

class CmdRest extends Command:
	func _init():
		key = "นอน"
	func fun():
		var msg_showTired = " (ความเหนื่อยล้าปัจจุบัน: "+var_to_str(player.stats.tired)+")"
		if player.stats.tired >= 80:
			game.tell("คุณพยายามข่มตาหลับ แต่ตาคุณยังสว่างอยู่เลย"+msg_showTired)
		elif player.stats.tired >= 60:
			game.tell("คุณยังไม่รู้สึกง่วงสักเท่าไหร่"+msg_showTired)

class CmdPunch extends Command:
	func _init():
		key = "ต่อย"
	func fun():
		# if no ememy
		game.tell("คุณต่อยลม")

class CmdStatus extends Command:
	func _init():
		key = "สถานะ"
	func fun():
		game.tell("พลังชีวิต = " + var_to_str(player.stats.hp))
