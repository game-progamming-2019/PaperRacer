# Autor: Christoph Brosch
# Erstellt 14.09.2019
# Aktualisiert 15.09.2019
extends Node2D

var COLUMNS: int
var ROWS: int
# Gibt an wie groß der Sprite ist
var rectangle_size = 51

var RECTANGLES = []

# Baut das Level
# 14.09 - Baut ein Feld der Größe ROWS, COLUMNS
func initialise(rows, columns):
	Settings.setRacetrackSize(rows, columns)
	
	self.ROWS = rows
	self.COLUMNS = columns
	
	for x in range(self.ROWS):
		RECTANGLES.append([])
		for y in range(self.COLUMNS):
			addRectangle(x, y)
	
func addRectangle(x, y):
	var rect = Rectangle.new(x * rectangle_size + rectangle_size / 2, y * rectangle_size + rectangle_size / 2)
	rect.set_name("Rectangle_" + str(x) + "_" + str(y))
	
	RECTANGLES[x].append(rect)
	self.add_child(rect)
	
func getGridNodes(position: Vector2, selection):
	var field = []
	for vector in selection:
		field.append(getRectangle(position.x + vector.x, position.y + vector.y))
	return field
	
func highlight(selection):
	for rectangle in selection:
		rectangle.highlight()

func unhighlight(selection):
	for rectangle in selection:
		rectangle.unhighlight()
		
func getRectangle(x,y):
	# Überprüfe überschreitungen der Feldgröße
	if x < 0 || x >= COLUMNS - 1:
		return
	elif y < 0 || y >= ROWS - 1:
		return
	else:
		return RECTANGLES[x][y]
		
func getCoordinates(gridNode):
	for x in range(self.ROWS):
		for y in range(self.COLUMNS):
			if gridNode == RECTANGLES[x][y]:
				return(Vector2(x,y))