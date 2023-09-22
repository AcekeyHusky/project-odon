extends Node

var events = {
	"ev_start" : {
		"type" : "scenario",
		"place" : "field",
		"msg0" : "คุณตื่นขึ้นมาที่ไหนไม่รู้ รู้แค่ว่ามันเป็นทุ่งโล่งที่เต็มไปด้วยต้นไม้ใบหญ้า\nพิมพ์ 'ดู' แล้วกด Enter เพื่อสำรวจ"
	},
	"found_enemy" : {
		"type" : "random_encounter",
		"place" : {
			"all" : true,
			},
		"msg0" : "และในขณะนั้น คุณก็พับกบ เอ้ย พบกับ",
	}
}
