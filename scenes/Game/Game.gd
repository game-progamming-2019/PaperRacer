# Autor: Christoph Brosch
# Erstellt 14.09.2019
extends Node2D

# Skript das sich nur um das rundenbasierte Verhalten kümmert
# Erzeugt einen Thread
const Turn = preload("res://scripts/gamemaster/Turn.gd")
var TURNMANAGER = null

# Notwendig für das richtige Verhalten der Funktion "Driver_Turn()" innerhalb von Turn.gd
signal mouse_click
signal action_finished

# Speichert alle Teilnehmer des Rennens
var Participants = []
var clicked_node: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$Racetrack.initialise(10, 10)
	$Camera.initialise()
	
	# Call by Reference, Participants vergibt nur eine Referenz auf sich.
	TURNMANAGER = Turn.new(self, $Racetrack, Participants)
	
	#	$Racetrack.RECTANGLES[4][4].highlight()
	#	yield(get_tree().create_timer(2), "timeout")
	#	$Racetrack.RECTANGLES[4][4].unhighlight()
	
	addParticipant(Driver.new("Christoph", Mercedes.new(), false))
	addParticipant(Driver.new("Anja", Golf.new(), true))
	initialiseDrivers()
	TURNMANAGER.start()
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if !event.is_pressed():
				clicked_node = $Ray.castRayAt(get_global_mouse_position()).get_parent()
				emit_signal("mouse_click")
			
func addParticipant(driver):
	# Überprüfe ob es sich um einen validen Driver handelt und ob das Rennen schon gestartet ist.
	if driver is Driver:
		self.Participants.append(driver)
			
func initialiseDrivers():
	for driver in Participants:
		driver.appendTo($Drivers)
		
		# Startposition
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		driver.setPosition(rng.randi_range(0, Settings.COLUMNS - 1), rng.randi_range(0, Settings.ROWS - 1))

func action(driver): 
	print(driver.NAME + "'s Aktion")
	var selection = $Racetrack.getPossibilities(driver)
	if driver.KI:
		
		# Provisorisch
		# "KI" wird auf ein zufälliges erlaubtes Feld gesetzt
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var x = rng.randi_range(0, selection.size() - 1) 
		driver.setPosition($Racetrack.getCoordinates(selection[x]).x, $Racetrack.getCoordinates(selection[x]).y)
	else:
		clicked_node = null
		$Racetrack.highlight(selection)
		
		# Highlight und Unhighlight wird nur für den Spieler gemacht.
		yield(self, "mouse_click")
		if !(clicked_node in selection):
			action(driver)
		else:
			var v = $Racetrack.getCoordinates(clicked_node)
			driver.setPosition(v.x, v.y)
			$Racetrack.unhighlight(selection)
			emit_signal("action_finished")
		
	# func _init()
	#	Initialisiert Racetrack
	#   Initialisiert Camera
	#	Initialisiert Driver
	#	Befüllt DriverArray
	#	Setzt Driver an den Start
	#	Start Race ->