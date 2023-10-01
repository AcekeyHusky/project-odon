extends Resource
class_name Thing

## ชื่อน่ะสิ
@export var name: String
## คำฮธิบายน่ะสิ
@export_multiline var description: String
## ชื่ออื่น
@export var aliases: Array
# คำคุณศัพท์หรือว่าคำวิเศษณ์ในภาษาไทยไงล่ะ
@export var adjective: Array
## สิ่งที่บรรจุอยู่ข้างใน
@export var contents: Array
## สคริปต์
@export var source: Script

var _script: Node

signal tell

func init_script():
	# ข้ามการ call หากไม่ได้ใส่ source
	if !source:
		return null

	# เข็ค instance RoomScript หากไม่มีจะสร้าง instance
	if !_script :
		_script = source.new()
