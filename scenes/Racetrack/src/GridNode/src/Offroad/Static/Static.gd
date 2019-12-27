extends Offroad
class_name Static

# Standartrichtung eines Tiles ist immer Oben.
var _direction: Vector2

func _init(x, y, direction).(x, y):
	match direction:
		0:
			self._direction = Vector2.UP;
			self.rotation_degrees = 0;
		1:
			self._direction = Vector2.RIGHT;
			self.rotation_degrees = 90;
		2:
			self._direction = Vector2.DOWN;
			self.rotation_degrees = 180;
		3:
			self._direction = Vector2.LEFT
			self.rotation_degrees = 270;
	pass