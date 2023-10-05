extends Resource
class_name Thing

## ชื่อน่ะสิ
@export var name: String
## คำฮธิบายน่ะสิ
@export_multiline var description: String
## คีย์น่ะสิ
@export var keys: Array[String]
# คำคุณศัพท์หรือว่าคำวิเศษณ์ในภาษาไทยไงล่ะ
@export var adjective: Array[String]
## สิ่งที่บรรจุอยู่ข้างใน
@export var contents: Array[Thing]
## สคริปต์
@export var source: Script

@export_group("States")
@export var is_reveal: bool = true
@export var is_saw: bool

var _script: Node

signal tell

func add_contents(_thing: Thing) -> void:
	contents.append(_thing)
	
func remove_contents(_thing: Thing) -> void:
	contents.erase(_thing)

func init_script():
	# ข้ามการ call หากไม่ได้ใส่ source
	if !source:
		return null

	# เข็ค instance RoomScript หากไม่มีจะสร้าง instance
	if !_script :
		_script = source.new()
