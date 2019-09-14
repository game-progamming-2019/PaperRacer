# Autor: Christoph Brosch
# Erstellt 14.09.2019

extends Sprite
class_name Rectangle

var SIZE: int 
var ASSETS = [preload("res://assets/racetrack/rectangle/karo.png")]

func _init(x, y, rectangle_size):
	SIZE = rectangle_size
	self.position = Vector2(x, y)
	set_texture(ASSETS[0])
	
	# DEBUG
	var label = Label.new()
	label.set("custom_colors/font_color", Color(0,0,0))
	label.text = str(x)
	#label.rect_position = Vector2(rectangle_size / 2, rectangle_size / 2)
	self.add_child(label)