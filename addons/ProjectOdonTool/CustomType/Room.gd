extends Thing
class_name Room

@export var command_keywords: Array = []

@export_group("Exit(s)")
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

var RoomScript

func init_script():
	# ข้ามการ call หากไม่ได้ใส่ source
	if !source:
		return null
		
	# เข็ค instance RoomScript หากไม่มีจะสร้าง instance
	if !RoomScript :
		RoomScript = source.new()
		RoomScript.set_get_data(get_data)
		RoomScript.connect("tell",_on_tell)

# รัน event จาก script
func exec(method:String,arg=[]):
	init_script()
		
	# เข็ค method ว่ามีหรือไม่เเ
	if RoomScript && RoomScript.has_method(method):
		return RoomScript.call(method,arg)
	else:
		print("Command : ", method, " does not existed")
		return null
		
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
		Tell("ไม่สามารถไปทางนั้นได้")

func get_data(target: String):
	return self[target]
	

func enter_room():
	init_script()
	if RoomScript && RoomScript.has_method("enter_room"):
		RoomScript.call("enter_room")
	else:
		Tell("[room]%s[/room]" % name)
		if not is_saw:
			Tell(description)
			is_saw = true

			
func Tell(msg : String):
	emit_signal("tell", msg)
	
func _on_tell(text:String):
	Tell(text)
