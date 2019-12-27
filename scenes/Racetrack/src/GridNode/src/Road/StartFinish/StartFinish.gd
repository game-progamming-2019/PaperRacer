extends Road
class_name StartFinish

var direction: int;

func _init(x, y, direction).(x, y, true, false):
	self.texture = preload("res://assets/racetrack/gridnode/start_finish.png");
	self.direction = direction;

func getDirection():
	match direction:
		0: return Vector2.UP;
		1: return Vector2.RIGHT;
		2: return Vector2.DOWN;
		3: return Vector2.LEFT;