# Autor: Christoph Brosch
# Erstellt 14.09.2019
extends Node2D

# Skript das sich nur um das rundenbasierte Verhalten kümmert
# Erzeugt einen Thread
const Turn = preload("res://scenes/Game/scripts/Turn.gd")
# Kümmert sich um die Regeln des Spiels
const Rules = preload("res://scenes/Game/scripts/Rules.gd")
# Schreibt eine Abschrift des Spielverlaufs und liefert Informationen zu vorherigen Zügen
const Transcription = preload("res://scenes/Game/scripts/Transcription.gd")

var TURNMANAGER: Turn = null
var RULEMANAGER: Rules = null
var TRANSCRIPTION: Transcription = null

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
	RULEMANAGER = Rules.new()
	
	addParticipant(Driver.new("Christoph", Mercedes.new(), false))
	# addParticipant(Driver.new("Anja", Golf.new(), true))
	initialiseDrivers()
	TRANSCRIPTION = Transcription.new(Participants)
	TURNMANAGER.start()
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if !event.is_pressed():
				# NULL FEHLER
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
		# driver.setPosition(4, 4)
# Hauptfunktion zuständig für die Aktion die ein Fahrer vornimmt
func action(driver): 
	if Settings.DEBUG:
		print(driver.NAME + "'s Aktion")
		
	var current_position = driver.getPosition()
	var target_position: Vector2
	print("Previous Vector: " + str(TRANSCRIPTION.getPreviousVector(driver)))
	var vector_selection = RULEMANAGER.getPossibilities(TRANSCRIPTION.getPreviousVector(driver))
	print("Possible Vectors: " + str(vector_selection))
	var gridNode_selection = $Racetrack.getGridNodes(driver.getPosition(), vector_selection)
	print("Possible GridNodes: " + str(gridNode_selection))
	
	if driver.KI:
		# Provisorisch
		# "KI" wird auf ein zufälliges erlaubtes Feld gesetzt
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var x = rng.randi_range(0, gridNode_selection.size() - 1) 
		target_position = Vector2($Racetrack.getCoordinates(gridNode_selection[x]).x, $Racetrack.getCoordinates(gridNode_selection[x]).y)
		
	else:
		clicked_node = null
		$Racetrack.highlight(gridNode_selection)
		# Highlight und Unhighlight wird nur für den Spieler gemacht.
		yield(self, "mouse_click")
		print("1")
		if !(clicked_node in gridNode_selection):
			action(driver)
		else:
			target_position = $Racetrack.getCoordinates(clicked_node)
			$Racetrack.unhighlight(gridNode_selection)
	print("2")
	driver.setPosition(target_position.x, target_position.y)
	# Mathe is hier ggf. noch falsch
	TRANSCRIPTION.recordMovement(driver,-(current_position - target_position))
	
	print("3")
	# Es hat zu Problemen geführt wenn das Signal früher gesetzt wird,
	# da Turn und Transcription "zeitgleich" auf Global.Turn zugreifen.
	emit_signal("action_finished")
	print("4")
	
	# func _init()
	#	Initialisiert Racetrack
	#   Initialisiert Camera
	#	Initialisiert Driver
	#	Befüllt DriverArray
	#	Setzt Driver an den Start
	#	Start Race ->