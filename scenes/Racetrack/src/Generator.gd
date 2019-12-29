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
	var Information = Global.JSON_parse(path)
	Global.COLUMNS = int(Information["columns"])
	Global.ROWS = int(Information["rows"]);
	
	
	var map = Information["map"];
	for x in range(Global.get_column_count()):
		Racetrack.GRID.append([]);
		for y in range(Global.get_row_count()):
			
			var node;
			if map[y][x] is Array:
				node = mapping[int(map[y][x][0])].new(x, y, int(map[y][x][1]));
				if int(map[y][x][0]) == 3:
					Racetrack.StartFinishNodes.append(node);
				elif int(map[y][x][0]) == 4:
					Racetrack.StartPositionNodes.append(node);
			else:
				node = mapping[int(map[y][x])].new(x, y);
				
			Racetrack.GRID[x].append(node);
			Racetrack.get_node("Track").add_child(node);
	
	#	----------------	#
	#	Decoration Layer	#
	#	----------------	#
	var MappingInformation = Global.JSON_parse(Information["mapping-file"]);
	var DecorationLayer = Information["decoration"];
	
	for x in range(Global.get_column_count()):
		for y in range(Global.get_row_count()):
			if DecorationLayer[y][x] is Array: # or Object for later iterations
				pass
			else:
				var id = DecorationLayer[y][x];
				var obj = get_obj(id, MappingInformation);
				match obj["class"]:
					"EventBased": pass;
					"Permanent": pass;
					"Fixed": print("Hello");
				
				
static func get_obj(id, mapping):
	for fixed in mapping["dynamic"]["fixed"]:
		if int(fixed.id) == id:
			fixed["class"] = "Fixed";
			return fixed;