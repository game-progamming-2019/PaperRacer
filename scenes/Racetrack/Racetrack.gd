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

#!Important
# Errechnet die Felder auf die der Fahrer in seinem Zug fahren darf.
func getPossibilities(driver):
	# Parameter die vom Fahrzeug kommen
	var speed = 3
	# var direction
	var position = driver.getPosition()
	
	# Berechnung der Strecken
	# LANGE LISTE AN PARAMETERN
	var x = calculateSelection(position, speed)
	return x
	
# PROVISORISCH
# Liefert alle Rechtecke im Umkreis von Speed in einem Array zurück
func calculateSelection(position, speed):
	var field = []
	# + 1 weil range() von -speed bis speed - 1 geht
	for x in range(-speed, speed + 1):
		for y in range(-speed, speed +1):
			if x != 0 || y != 0:
				if getRectangle(position.x + x, position.y + y) != null:
					field.append(getRectangle(position.x + x, position.y + y))
	return field

func highlight(selection):
	for rectangle in selection:
		rectangle.highlight()

func unhighlight(selection):
	for rectangle in selection:
		rectangle.unhighlight()
		
func getRectangle(x,y):
	# Überprüfe überschreitungen der Feldgröße
	if x < 0 || x >= COLUMNS:
		return null
	elif y < 0 || y >= ROWS:
		return null
	else:
		return RECTANGLES[x][y]
func getCoordinates(gridNode):
	for x in range(self.ROWS):
		for y in range(self.COLUMNS):
			if gridNode == RECTANGLES[x][y]:
				return(Vector2(x,y))