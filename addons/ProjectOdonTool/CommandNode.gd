@tool
extends Node
class_name Command
@onready var game = get_node("../..")
@onready var player = get_node("../../Player")
@onready var logs = get_node("../../ScrollContainer/VBoxContainer/Logs")
@onready var settings = get_node("../../Settings")
@onready var history = get_node("../../CommandHistory")
@onready var commands = ".."

var key: = "KEY"
var desc: String # description
var aliases: Array # Key ทางเลือก
var is_help_visible: bool = true
var is_can_use: bool = true
var words: Array

func fun():
	game.printf("สวัสดี")
	
func exec(input: Array):
	words = input
	fun()
