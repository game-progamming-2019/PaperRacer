extends Road
class_name StartPosition

var index: int;
func _init(x, y, index:int).(x, y, false, true):
	self.texture = preload("res://assets/racetrack/gridnode/asphalt.png")

	# if another one has the same index, error
	self.index = index;

func getIndex():
	return self.index;
