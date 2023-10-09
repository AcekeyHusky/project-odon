## เพิ่ม Command สำหรับออกคำสั่งในเกม
@icon("res://assets/icons/command.svg")
@tool
extends Node
class_name Command

## Keyword ของคำสั่ง
@export var key: String = "Key"
## Keyword ทางเลือก
@export var aliases: Array[String]
## คำอธิบาย ()
@export_multiline var description: String
## แสดงใน Help หรือไม่
@export var help_option:Global.CMD_HELP_OPTION = Global.CMD_HELP_OPTION.SHOW
## ตอนนี้ใช้งานได้หรือไม่
@export var can_use: bool = true

@onready var game = $"../.."
@onready var logs = game.get_node("UI/ScrollContainer/VBoxContainer/Logs")
@onready var history = game.get_node("UI/CommandHistory")
@onready var finput = game.get_node("UI/FakeInputContainer/FakeInput")
@onready var settings = game.get_node("Settings")

var world: Node
var words: Array

func _int():
	var key: = "KEY"
	var desc: String
	var aliases: Array

func fun():
	game.tell("โหล")
	
func exec(input: Array):
	world = game.get_node("World")
	words = input
	fun()
	
