extends Camera2D

var direction:Vector2 = Vector2.ZERO
export var SPEED: int = 10

var move_camera = false
var start_position = Vector2.ZERO

func _input(event):
	if event.is_action_pressed("ui_drag"):
		print("Hello")
		move_camera = true
		start_position = get_global_mouse_position()
		
	if event.is_action_released("ui_drag"):
		print("Tschüss")
		move_camera = false
	
func _physics_process(delta):
	if move_camera:
		self.position += start_position - get_global_mouse_position()
	pass