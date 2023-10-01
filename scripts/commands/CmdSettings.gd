extends Node
@onready var game = $"../.."

var key = "ตั้งค่า"

func fun(_args):
	game.cur_stage = 1
	game.tell("คุณเข้าสู่หน้าตั้งค่า/ปรับแต่งจอแสดงผล")
	game.tell("ใส่รหัสสีเพื่อเปลี่ยนสีตัวอักษร (รหัส RGB โดยไม่ต้องมี #)")

""" ขอปิดก่อน
if game.cur_stage == 1:
	if !settings.colorCheck(input):
		game.tell("คุณต้องใส่ค่าสี RGB ก่อน")
	else:
		settings.setTextColor(input)
		game.tell("สีอักษรปัจจุบัน: " + settings.textColor)
		game.tell("กลับเข้าสู่โหมดเล่นเกมปกติ")
		game.cur_stage = 0
"""

# TODO
