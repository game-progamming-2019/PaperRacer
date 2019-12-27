extends Node2D
class_name Generator

# Could be reworked into "LogicLayer" and "RenderLayer"
static func build(Racetrack, path):
	
	#	----------	#
	# 	Tile Layer  #
	#	----------	#
	
	var mapping = {
	0: Street,
	1: Curb,
	2: PaperTile,
	3: StartFinish,
	4: StartPosition,
	5: CurbKurve
	}
	
	# Contains all necessary information
	var Information = JSON_parse(path)
	Global.COLUMNS = int(Information["columns"])
	Global.ROWS = int(Information["rows"]);
	var map = Information["map"];
	for x in range(Global.get_row_count()):
		Racetrack.GRID.append([]);
		for y in range(Global.get_column_count()):
			var node;
			if map[x][y] is Array:
				node = mapping[int(map[x][y][0])].new(x, y, int(map[x][y][1]));
				if int(map[x][y][0]) == 3:
					Racetrack.StartFinishNodes.append(node);
				elif int(map[x][y][0]) == 4:
					Racetrack.StartPositionNodes.append(node);
			else:
				node = mapping[int(map[x][y])].new(x, y);
			Racetrack.GRID[x].append(node);
			Racetrack.get_node("Track").add_child(node);
	
	#	----------------	#
	#	Decoration Layer	#
	#	----------------	#
	
	mapping = {
		1: Palmtree
	};
	var deco = Information["decoration"];
	for x in range(Global.get_column_count()):
		for y in range(Global.get_row_count()):
			print(deco.size());
			if deco[x][y] != 0:
				var node = mapping[int(deco[x][y])].new(x, y);
				Racetrack.DECO.append(node);
				Racetrack.get_node("Decoration").add_child(node);
	
	
	
static func JSON_parse(path):
	var file = File.new()
	file.open("res://assets/maps/map_1.json", File.READ)
	var result = JSON.parse(file.get_as_text()).result
	return result