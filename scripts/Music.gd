extends Node

var is_se_playing = false
var is_bgm_playing = false
var cur_room_bgm = "room1" #ชื่อเพลงที่จะเล่นตามห้อง

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

func play_bgm(): #เล่นเพลง bgm
	if (is_bgm_playing):
		return
	get_node(cur_room_bgm).play()
	is_bgm_playing = true
