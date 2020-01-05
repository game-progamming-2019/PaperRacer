extends Static
class_name CurbKurve

func _init(x, y, style = "",  direction = 0).(x, y, direction):
	match style:
		"block":
			self.texture = preload("res://assets/racetrack/gridnode/bande_kurve_block.png");
		"invers":
			self.texture = preload("res://assets/racetrack/gridnode/bande_kurve_invers.png");
		_:
			self.texture = preload("res://assets/racetrack/gridnode/bande_kurve.png");
	
	

