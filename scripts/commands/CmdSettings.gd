extends Node
@onready var game = $"../.."

var key = "ตั้งค่า"

func fun(_args):
	game.cur_stage = 1
	game.printf("คุณเข้าสู่หน้าตั้งค่า/ปรับแต่งจอแสดงผล")
	game.printf("ใส่รหัสสีเพื่อเปลี่ยนสีตัวอักษร (รหัส RGB โดยไม่ต้องมี #)")
