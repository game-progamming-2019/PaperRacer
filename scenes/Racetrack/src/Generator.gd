extends Node2D
class_name Generator
	
static func build(Racetrack, path):
	#	----------	#
	# Graphical Layer
	#	----------	#
	var mapping = {
	0: Street,
	1: Curb,
	2: PaperTile,
	3: StartFinish
	}
	
	# Contains all necessary information
	var Information = JSON_parse(path)
	Global.COLUMNS = int(Information["columns"])
	Global.ROWS = int(Information["rows"])
	var map = Information["map"]
	
	for x in range(Global.get_column_count()):
		Racetrack.GRID.append([])
		for y in range(Global.get_row_count()):
			var node = mapping[int(map[y][x])].new(x, y)
			Racetrack.GRID[x].append(node)
			Racetrack.get_node("Track").add_child(node)
	
	#	-----------	 #
	#	Logic Layer	 #
	#	-----------	 #
	
static func JSON_parse(path):
	var file = File.new()
	file.open("res://assets/maps/map_1.json", File.READ)
	var result = JSON.parse(file.get_as_text()).result
	return result