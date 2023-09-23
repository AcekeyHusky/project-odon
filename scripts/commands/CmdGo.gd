extends Node
@onready var game = $"../.."

var key = "ไป"

func fun():
	if game.can_pass():
		game.take_step()
