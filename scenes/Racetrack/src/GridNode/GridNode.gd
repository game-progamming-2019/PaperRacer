extends Sprite

var SIZE: int 
# var ASSETS = [preload("res://assets/racetrack/gridnode/karo.png")]
var is_highlighted: bool = false

var trespassable: bool = true

func _init():
	# set_texture(ASSETS[0])
	pass
	
func initialise(trespassable, x, y) -> void:
	self.trespassable = trespassable;
	self.position = Vector2(x,y)
	$Area2D/CollisionShape2D.shape.set_extents(Vector2(Global.get_rectangle_size()/2, Global.get_rectangle_size()/2))
	
func highlight(margin = null) -> void:
	self.is_highlighted = true
	if margin != null:
		pass
	$Highlight.show()

func unhighlight() -> void:
	$Highlight.hide()
	
func is_trespassable() -> bool:
	return self.trespassable;