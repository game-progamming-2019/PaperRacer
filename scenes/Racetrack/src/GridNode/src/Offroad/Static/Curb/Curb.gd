extends Static
class_name Curb

func _init(x, y, style = "", direction = 0).(x, y, direction):
	match style:
		"block":
			self.texture = preload("res://assets/racetrack/gridnode/bande_gerade_block.png")
		_:
			self.texture = preload("res://assets/racetrack/gridnode/bande_gerade.png")
	
	

