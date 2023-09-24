"""
กรองคำหยาบคาย
"""
extends Node
@onready var game = $"../.."

var key = "เหี้ย"

func fun(_args):
	game.printf("จุ๊ๆ ไม่เอา ไม่พูด")
