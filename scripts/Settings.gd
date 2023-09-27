extends Node

var textColor = "#ffffff"
var BGColor = "#000000"
var dev_mode = true
var text_color = {
	"command" = "yellow"

}


func setTextColor(color):
	textColor = "#" + color

func setBGColor(color):
	BGColor = "#" + color
	
func colorCheck(text):
	if text.length() == 6:
		for i in text:
			if !(i.is_valid_hex_number()):
				return false
		return true
	else:
		return false
