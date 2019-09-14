# Autor: Christoph Brosch
# Erstellt 14.09.2019

extends Sprite
class_name Rectangle

var SIZE: int 
var ASSETS = [preload("res://assets/racetrack/rectangle/karo.png")]
var highlighted: bool = false

func _init(x, y):
	SIZE = Settings.RECTANGLE_SIZE
	self.position = Vector2(x, y)
	set_texture(ASSETS[0])
	
	# DEBUG
	if Settings.DEBUG:
		var label = Label.new()
		label.set("custom_colors/font_color", Color(0,0,0))
		label.text = str(x)
		self.add_child(label)

func highlight(margin = null):
	self.highlighted = true
	if margin != null:
		pass
	# Veränderung
	self.modulate = Color("257AFD")

func unhighlight():
	self.highlighted = false
	# Veränderung
	self.modulate = Color("FFFFFF")