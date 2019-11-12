extends GridNode
class_name Road

var area
var collisionshape
var Highlight = preload("res://scenes/Racetrack/src/GridNode/src/Road/Highlight.tscn").instance()

func _init(x, y).(true, x, y):
	area = Area2D.new()
	self.add_child(area)
	collisionshape = CollisionShape2D.new()
	area.add_child(collisionshape)
	collisionshape.shape = RectangleShape2D.new()
	collisionshape.shape.set_extents(Vector2(Global.get_rectangle_size()/2, Global.get_rectangle_size()/2))
	
	self.add_child(Highlight)
func highlight():
	Highlight.highlight()
	
func unhighlight():
	Highlight.unhighlight()
	