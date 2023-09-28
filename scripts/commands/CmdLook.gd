"""
ดูสถานที่ สิ่งมีชีวิต หรือวัตถุ

วิธีใช้:
	ดู
	ดู<สมช>
	ดู<วัตถุ>
"""
extends Command

func _init():
	key = "ดู"
	aliases = ["เบิ่ง"]
	desc = "มองดูสิ่งที่อยู่รอบ ๆ ตัวเอง ใช้เพื่อสำรวจสถานที่นั้นว่าคืออะไร และสามารถกำหนดเฉพาะเจาะจงไปยังสิ่งที่ต้องการดูในสถานที่นั้นได้อีกด้วย"

func fun():
	if words.size() > 1 :
		game.current_room.look_something(words[1])
	else:
		game.current_room.look()
	

