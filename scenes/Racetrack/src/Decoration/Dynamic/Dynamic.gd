extends AnimatedSprite
class_name DynamicDecoration

func _init(x, y):
	self.position = Vector2(x * Global.get_rectangle_size(), y * Global.get_rectangle_size());