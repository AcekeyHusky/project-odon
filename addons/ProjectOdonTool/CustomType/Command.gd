## เพิ่ม Command สำหรับออกคำสั่งในเกม
@icon("res://assets/icons/command.svg")
@tool
extends Node
class_name Command

## Keyword ของคำสั่ง
@export var key: String = "Key"
## Keyword ทางเลือก
@export var aliases: Array
## คำอธิบาย ()
@export_multiline var description: String
## แสดงใน Help หรือไม่
@export var is_in_help: bool = true
## ตอนนี้ใช้งานได้หรือไม่
@export var can_use: bool = true

@onready var game = $"../.."
@onready var player = get_node("../../Player")
@onready var logs = get_node("../../ScrollContainer/VBoxContainer/Logs")
@onready var settings = get_node("../../Settings")
@onready var history = get_node("../../CommandHistory")
@onready var commands = ".."

var words: Array

func _int():
	var key: = "KEY"
	var desc: String
	var aliases: Array

func fun():
	game.tell("โหล")
	
func exec(input: Array):
	words = input
	fun()
	
