# Autor: Christoph Brosch
# Erstellt 14.09.2019
extends Node2D

signal mouse_click

var Participants = []
var clicked_node: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():

	$Racetrack._initialise(100, 100)
	$Camera._initiliase()
	
	#	$Racetrack.RECTANGLES[4][4].highlight()
	#	yield(get_tree().create_timer(2), "timeout")
	#	$Racetrack.RECTANGLES[4][4].unhighlight()
	
	addParticipant(Driver.new("Christoph", Golf.new()))
	initialiseDrivers()
	player_turn()
	
func player_turn():
	clicked_node = null
	var selection = $Racetrack.get_possibilities_for(Participants[0])
	$Racetrack.highlight(selection)
	
	# Highlight und Unhighlight wird nur für den Spieler gemacht.
	yield(self, "mouse_click")
	print(clicked_node)
	if !(clicked_node in selection):
		print("Nicht in der Selektion")
		player_turn()
	else:
		print("In der Selektion")
		var v = $Racetrack.getCoordinatesOfGridNode(clicked_node)
		Participants[0].setPosition(v.x, v.y)
		$Racetrack.unhighlight(selection)
		player_turn()
	
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
		driver.setPosition(2,2)
		
	# func _init()
	#	Initialisiert Racetrack
	#   Initialisiert Camera
	#	Initialisiert Driver
	#	Befüllt DriverArray
	#	Setzt Driver an den Start
	#	Start Race ->