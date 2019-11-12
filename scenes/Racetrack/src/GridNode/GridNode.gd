extends Sprite
class_name GridNode

var trespassable: bool

func _init(trespassable, x, y):
	self.trespassable = trespassable;
	self.position = Vector2(x * Global.get_rectangle_size() + Global.get_rectangle_size() / 2, y * Global.get_rectangle_size() + Global.get_rectangle_size() / 2)
	
func is_trespassable():
	return trespassable;