@tool
extends Node
class_name Thing

## คีย์น่ะสิ
@export var key: String
## คำฮธิบายน่ะสิ
@export_multiline var description: String
## คีย์ทางเลือก
@export var aliases: Array[String]
## คำคุณศัพท์หรือว่าคำวิเศษณ์ในภาษาไทยไงล่ะ
@export var adjective: Array[String]

@export_group("States")
## เปิดเผยหรือไม่ หาก false คำสั่งจะไม่ทำงานด้วย
@export var is_reveal: bool = true
## ใช้คำสั่ง look กับสิ่งนี้หรือยัง
@export var is_looked: bool
## ย้ายอ๊ะยัง
@export var is_moved: bool

@export_group("Notes")
## สำหรับเขียนคำโน๊ตทิ้งไว้เพื่อใช้การพัฒนา
@export_multiline var notes: String = ""

var _script: Node


# ทำงานคล้าย get_children แต่ return เฉพาะคลาส Thing
func get_contents() -> Array:
	var content_list: Array = []
	for child in self.get_children():
		if child is Thing:
			content_list.append(child)
	return content_list
