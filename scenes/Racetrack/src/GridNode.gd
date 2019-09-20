# Autor: Christoph Brosch
# Erstellt 14.09.2019

extends Sprite
class_name GridNode

var SIZE: int 
var ASSETS = [preload("res://assets/racetrack/gridnode/karo.png")]
var is_highlighted: bool = false

func _init(x, y):
	
	SIZE = Settings.RECTANGLE_SIZE
	self.position = Vector2(x, y)
	set_texture(ASSETS[0])
	
	# Soll registrieren das auf das GridNode gedrückt wurde
	
	var area = Area2D.new()
	var collision_shape = CollisionShape2D.new()
	collision_shape.shape = RectangleShape2D.new()
	collision_shape.shape.set_extents(Vector2(Settings.RECTANGLE_SIZE/2, Settings.RECTANGLE_SIZE/2))
	area.add_child(collision_shape)
	area.modulate = Color("FF00FF")
	self.add_child(area)

func highlight(margin = null):
	self.is_highlighted = true
	if margin != null:
		pass
	# Veränderung
	self.modulate = Color("257AFD")

func unhighlight():
	self.is_highlighted = false
	# Veränderung
	self.modulate = Color("FFFFFF")

func on_rectangle_clicked(event):
	print(event)

func active():
	self.modulate = Color("000000")
	
"""
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			print("1")
"""