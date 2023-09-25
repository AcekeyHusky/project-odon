extends Node

var is_se_playing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	for _child in self.get_children().filter(func(item): return item is AudioStreamPlayer):
		_child.finished.connect(_on_se_finished)
	
func _on_se_finished():
	is_se_playing = false

func play_se_typing():
	if (is_se_playing):
		return
	$beep.play()
	is_se_playing = true
	
