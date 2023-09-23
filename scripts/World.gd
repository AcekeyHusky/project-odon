extends Node

var size:int

func generate_world(max_size):
	size = 2
	# ทำต่อให้ทีจิ

func _ready():
	var test = Node.new()
	test.name = "TEST"
	add_child(test, true)
	print(test.name)
