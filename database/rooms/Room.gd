extends Resource
class_name Room


@export var name:String
@export_multiline var description:String

@export var things: Dictionary
@export var command_keywords: Array = []

@export_group("Direction Path")
@export_file var north_west: String
@export_file var north: String
@export_file var north_east : String
@export_file var west: String
@export_file var east: String
@export_file var south_west: String
@export_file var south: String
@export_file var south_east: String
@export_file var up: String
@export_file var down: String

@export var source: Script



var RoomScript : Node

signal printf

func init_script():
	# ข้ามการ call หากไม่ set source
	if !source:
		return null
		
	# เข็ค instance RoomScript หากไม่มีสร้าง instance
	if !RoomScript :
		RoomScript = source.new()
		RoomScript.set_get_data(get_data)
		RoomScript.connect("printf",_on_printf)

# รัน event จาก script
func exec(method:String,arg=[]):
	init_script()
		
	# เข็ค method ว่ามีหรือไม่เเ
	if RoomScript && RoomScript.has_method(method):
		return RoomScript.call(method,arg)
	else:
		print("Command : ", method, " does not existed")
		return null

# handle คำสั่ง "ดู"
func look():
	init_script()
	# เช็คว่า script มี custom event สำหรับ cmd_look หรือไม่
	if RoomScript && RoomScript.has_method("look"):
		RoomScript.call("look")
	else:
		Printf(description)
		
func go_to_dir(dir:String):
	if self[dir] :
		if RoomScript && RoomScript.has_method("can_pass"):
			if RoomScript.call("can_pass",dir):
				return self[dir]
			else:
				return null
		else:
			return self[dir]
	else:
		Printf("ไม่สามารถไปทางนั้นได้")

func get_data(target: String):
	return self[target]
	
func enter_room():
	init_script()
	# เช็คว่า script มี custom event สำหรับ cmd_look หรือไม่
	if RoomScript && RoomScript.has_method("enter_room"):
		RoomScript.call("enter_room")
	else:
		Printf("เข้ามายัง[room]%s[/room]" % name)
		
func look_something(thing:String):
	init_script()
	# เช็คว่า script มี custom event สำหรับ cmd_look หรือไม่
	if RoomScript && RoomScript.has_method("look_something"):
		RoomScript.call("look_something",thing)
	else:
		if things.has(thing) :
			Printf(things.get(thing))
		else:
			print(things.has(thing))
			Printf("ดูเหมือนว่าจะไม่มี \""+thing+"\" อยู่ที่นี่")
			
func Printf(msg : String):
	emit_signal("printf", msg)
	
func _on_printf(text:String):
	Printf(text)
