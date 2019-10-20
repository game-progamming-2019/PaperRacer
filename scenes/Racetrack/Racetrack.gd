# Autor: Christoph Brosch
# Erstellt 14.09.2019
# Aktualisiert 15.09.2019
extends Node2D

onready var GridNode = load("res://scenes/Racetrack/src/GridNode/GridNode.tscn")

var COLUMNS: int
var ROWS: int
# Gibt an wie groß der Sprite ist
var rectangle_size = 51

var GRID = []

# Baut das Level
# 14.09 - Baut ein Feld der Größe ROWS, COLUMNS
func initialise(rows, columns):
	Settings.setRacetrackSize(rows, columns)
	
	self.ROWS = rows
	self.COLUMNS = columns
	
	for x in range(self.ROWS):
		GRID.append([])
		for y in range(self.COLUMNS):
			if (x == 5 and y == 5):
				addRectangle(false, x, y)
			else:
				addRectangle(true, x, y)
	
func addRectangle(trespassable, x, y):
	var gridNode = GridNode.instance()
	gridNode.initialise(trespassable, x * rectangle_size + rectangle_size / 2, y * rectangle_size + rectangle_size / 2)
	gridNode.set_name("gridNode_" + str(x) + "_" + str(y))
	
	GRID[x].append(gridNode)
	self.add_child(gridNode)
	
func getGridNodes(position: Vector2, selection):
	var field = []
	for vector in selection:
		if getGridNode(position.x + vector.x, position.y + vector.y) != null:
			if getGridNode(position.x + vector.x, position.y + vector.y).is_trespassable():
				field.append(getGridNode(position.x + vector.x, position.y + vector.y))
	return field
	
func highlight(selection):
	for gridNode in selection:
		gridNode.highlight()

func unhighlight(selection):
	for gridNode in selection:
		gridNode.unhighlight()
		
func getGridNode(x,y):
	# Überprüfe überschreitungen der Feldgröße
	if x < 0 || x >= COLUMNS:
		return null
	elif y < 0 || y >= ROWS:
		return null
	else:
		return GRID[x][y]
		
func getCoordinates(gridNode):
	for x in range(self.ROWS):
		for y in range(self.COLUMNS):
			if gridNode == GRID[x][y]:
				return(Vector2(x,y))