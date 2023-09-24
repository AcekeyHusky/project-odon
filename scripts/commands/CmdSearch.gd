extends Node
@onready var game = $".."

var result_succ = "และคุณก็พบ"
var result_fail = "แต่น่าเสียดายที่คุณไม่พบอะไรเลย"

func fun(_args):
	game.printf("คุณพยายามค้นดูว่าที่นี่มีอะไรน่าสนใจบ้าง")
