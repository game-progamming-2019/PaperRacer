# Autor: Christoph Brosch
# Erstellt 14.09.2019
# 14.09.2019 - Provisorisch Erstellt
extends Camera2D

var direction:Vector2 = Vector2.ZERO
export var SPEED: int = 10

var move_camera = false
var start_position = Vector2.ZERO

func initialise():
	self.position = Vector2((Settings.ROWS / 2) * Global.get_rectangle_size(), (Settings.COLUMNS / 2) * Global.get_rectangle_size())
	
func _input(event):
	if event.is_action_pressed("ui_drag"):
		move_camera = true
		start_position = get_global_mouse_position()
		
	if event.is_action_released("ui_drag"):
		move_camera = false
		
	if event.is_action_pressed("ui_scroll_up"):
		if (self.zoom > Vector2(1,1)):
			self.zoom -= Vector2(0.05, 0.05)
		
	elif event.is_action_pressed("ui_scroll_down"):
		if (self.zoom < Vector2(3,3)):
			self.zoom += Vector2(0.05, 0.05)
		
func _physics_process(delta):
	if move_camera:
		self.position += start_position - get_global_mouse_position()
	pass