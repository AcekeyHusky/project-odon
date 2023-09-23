extends Node

var size:int

func _ready():
	var test = Node.new()
	test.name = "TEST"
	add_child(test, true)
	print(test.name)
