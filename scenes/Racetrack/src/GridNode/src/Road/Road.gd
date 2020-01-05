extends GridNode
class_name Road

var area;
var collisionshape;
var Highlight = preload("res://scenes/Racetrack/src/GridNode/src/Road/Highlight.tscn").instance();

var isFinishLine: bool = false;
var isStartPosition: bool = false;
var hasDriverOnIt: bool = false;


func _init(x, y, isFinishLine, isStartPosition).(true, x, y):
	self.isFinishLine = isFinishLine;
	self.isStartPosition = isStartPosition;
	area = Area2D.new();
	self.add_child(area);
	collisionshape = CollisionShape2D.new();
	area.add_child(collisionshape);
	collisionshape.shape = RectangleShape2D.new();
	collisionshape.shape.set_extents(Vector2(Global.get_rectangle_size()/2, Global.get_rectangle_size()/2));
	
	self.add_child(Highlight);
func highlight(driver):
	Highlight.highlight(driver);
	
func unhighlight():
	Highlight.unhighlight();
	