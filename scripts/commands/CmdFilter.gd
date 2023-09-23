"""
กรองคำหยาบคาย
"""
extends Node
@onready var game = $"../.."

var key = "เหี้ย"

func fun():
	game.printf("จุ๊ๆ ไม่เอา ไม่พูด")
