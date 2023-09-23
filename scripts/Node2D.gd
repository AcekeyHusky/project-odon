extends Node2D


func _draw():
	draw_rect(Rect2(0, 0, 10000, 10000), $"../Settings".BGColor)
