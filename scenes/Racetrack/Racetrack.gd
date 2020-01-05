# Autor: Christoph Brosch
# Erstellt 14.09.2019
# Aktualisiert 15.09.2019
extends Node2D

var GRID = [];
var DECO = [];
var StartPositionNodes = [];
var StartFinishNodes = [];

# Baut das Level
# 14.09 - Baut ein Feld der Größe ROWS, COLUMNS
func initialise(map_path):
	Generator.build(self, map_path);

# Irreführender Name, 
func getChoosableGridNodes(position: Vector2, selection):
	var field = []
	for vector in selection:
		if getGridNode(position.x + vector.x, position.y + vector.y) != null:
			if getGridNode(position.x + vector.x, position.y + vector.y).is_trespassable():
				if !getGridNode(position.x + vector.x, position.y + vector.y).hasDriverOnIt:
					field.append(getGridNode(position.x + vector.x, position.y + vector.y))
	return field
	
func highlight(driver, selection):
	for gridNode in selection:
		gridNode.highlight(driver);

func unhighlight(selection):
	for gridNode in selection:
		gridNode.unhighlight()
		
func getGridNode(x,y):
	# Überprüfe überschreitungen der Feldgröße
	if x < 0 || x >= Global.get_column_count():
		return null
	elif y < 0 || y >= Global.get_row_count():
		return null
	else:
		return GRID[x][y]

func getGridNodesInBetween(current, target):
	var gridNodes = [];
	while current.x != target.x:
		if current.x < target.x:
			current.x += 1;
		elif current.x > target.x:
			current.x -= 1;
		if current != target:
			gridNodes.append(getGridNode(current.x, current.y));
	while current.y != target.y:
		if current.y < target.y:
			current.y += 1;
		elif current.y > target.y:
			current.y -= 1;
		if current != target:
			gridNodes.append(getGridNode(current.x, current.y));
	return gridNodes;
		
func getCoordinates(gridNode):
	print("GRIDs row count: " + String(GRID.size()));
	print("GRIDs column count: " + String(GRID[0].size()));
	for x in range(Global.get_column_count()):
		for y in range(Global.get_row_count()):
			if gridNode == GRID[x][y]:
				return(Vector2(x,y))

func getStartPosition(index: int):
	for tile in StartPositionNodes:
		if tile.getIndex() == index:
			return getCoordinates(tile);

# Wird nur für Debug zwecke verwendet.
func highlight_all():
	for x in range(Global.get_column_count()):
		for y in range(Global.get_row_count()):
			GRID[x][y].highlight()

	