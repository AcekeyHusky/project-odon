extends Thing
class_name Item # อยากตั้งว่า object ง่ะ แต่ไม่ได้

## หน่วยเป็นกิโลกรัม
@export var weight: float

## เก็บได้อ๊ะเปล่า
@export var is_can_pick: bool
## ย้ายได้อ๊ะเปล่า
@export var is_can_move: bool
## กินได้อ๊ะเปล่า
@export var is_can_eat: bool
