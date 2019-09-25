extends Sprite

var SIZE: int 
var ASSETS = [preload("res://assets/racetrack/gridnode/karo.png")]
var is_highlighted: bool = false

func _init():
	SIZE = Settings.RECTANGLE_SIZE
	set_texture(ASSETS[0])
	
func initialise(x, y) -> void:
	self.position = Vector2(x,y)
	$Area2D/CollisionShape2D.shape.set_extents(Vector2(Settings.RECTANGLE_SIZE/2, Settings.RECTANGLE_SIZE/2))
	
func highlight(margin = null) -> void:
	self.is_highlighted = true
	if margin != null:
		pass
	$Highlight.show()

func unhighlight() -> void:
	$Highlight.hide()