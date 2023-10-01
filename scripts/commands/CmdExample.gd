"""
ตัวอย่างการเพิ่ม Command

วิธีเพิ่ม
ให้เพิ่ม node เป็น Command จากนั้น Extend Script
แล้วก็อปเทมเพลตข้างล่างนี้ไปใส่

ดูรายละเอียดเพิ่มเติมได้ที่ "res://addons/ProjectOdonTool/CustomType/Command.gd"
"""
extends Command

func _ready():
	key = "สวัสดี" # สามารถเปลี่ยน key ในสคริปต์ได้ในฟังชันก์นี้
	is_in_help = false # ตั้งให้ไม่ปรากฏใน help
	
func fun(): # ชุดโค้ดที่จะะทำงานเมื่อพิมพ์คำสั่ง
	game.tell("สวัสดีจ้า") # แสดงผลข้อความนี้ในเกม
