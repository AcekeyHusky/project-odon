extends Node

var directions: Dictionary = {
	"north_west" : ["ตะวันตกเฉียงเหนือ", "ตกเหนือ", "ตน", "ตตน", "nw"],
	"north" : ["เหนือ","น","n"],
	"north_east" : ["ตะวันออกเฉียงเหนือ", "อีสาน", "ออกเหนือ", "ตอน", "ตอน", "ne"],
	"west" : ["ตะวันตก", "ตก", "ตตต","ตต", "w"],
	"east": ["ตะวันออก", "ออก", "ตอ", "อ", "e"],
	"south_west" : ["ตะวันตกเฉียงใต้", "ตกใต้" , "ตตต", "sw"],
	"south" : ["ใต้", "ต", "s"],
	"south_east" : ["ตะวันออกเฉียงใต้", "ออกใต้" , "อต", "ตอต", "se"],
	"up" : ["ขึ้น", "ข", "บน", "บ"],
	"down" : ["ลง", "ล่าง", "ล"]
}

var text_no_thing: String = "ไม่มี[color=purple]%s[/color]ที่นี่"

func get_direction(_dir) -> String:
	for i in directions.keys():
		if _dir in directions[i]:
			return i
	return ""

func is_in_dictionary(_value: int, _dict: Dictionary) -> bool:
	for key in _dict.keys():
		var array = _dict[key]
		if _value in array:
			return true
	return false

#-------------------------------------------------------

enum CMD_HELP_OPTION {
	HIDE, # ไม่แสดง
	SHOW, # แสดง
	LEARN # แสดงหลังจากลองใช้คำสั่งนั้นแล้ว
}

var is_picked_cat = false
