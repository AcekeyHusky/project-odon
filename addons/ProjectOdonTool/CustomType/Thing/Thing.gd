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
@export var is_reveal: bool = true
@export var is_saw: bool

@export_group("Notes")
## สำหรับเขียนคำโน๊ตทิ้งไว้เพื่อใช้การพัฒนา
@export_multiline var notes: String = ""

var _script: Node

signal tell

func add_contents(_thing: Thing) -> void:
	pass
	
func remove_contents(_thing: Thing) -> void:
	pass
	
# ทำงานคล้าย get_children แต่ return เฉพาะคลาส Thing
func get_contents() -> Array:
	var content_list: Array = []
	for child in self.get_children():
		if child is Thing:
			content_list.append(child)
	return content_list
