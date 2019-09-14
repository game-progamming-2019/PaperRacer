# Autor: Christoph Brosch
# Erstellt 14.09.2019
extends Node2D

var COLUMNS: int
var ROWS: int
# Gibt an wie groß der Sprite ist
var rectangle_size = 51

var RECTANGLES = []

# Baut das Level
# 14.09 - Baut ein Feld der Größe ROWS, COLUMNS
func _initialise(rows, columns):
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