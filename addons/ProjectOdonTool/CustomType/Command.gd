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
@export var is_in_help: bool = true
## ตอนนี้ใช้งานได้หรือไม่
@export var can_use: bool = true

@onready var game = $"../.."
@onready var world = game.get_node("World")
@onready var logs = game.get_node("UI/ScrollContainer/VBoxContainer/Logs")
@onready var history = game.get_node("UI/CommandHistory")
@onready var finput = game.get_node("UI/FakeInputContainer/FakeInput")
@onready var settings = game.get_node("Settings")

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
	
