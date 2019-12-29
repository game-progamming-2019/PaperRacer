# Autor: Christoph Brosch
# Erstellt 14.09.2019
extends Node2D

# Skript das sich nur um das rundenbasierte Verhalten kümmert
# Erzeugt einen Thread
const Turn = preload("res://scenes/Game/scripts/TurnQueue.gd")
# Kümmert sich um die Regeln des Spiels
const Rules = preload("res://scenes/Game/scripts/Rules.gd")
# Schreibt eine Abschrift des Spielverlaufs und liefert Informationen zu vorherigen Zügen
const Transcription = preload("res://scenes/Game/scripts/Transcription.gd")

var TURNMANAGER: Turn = null
var RULEMANAGER: Rules = null
var TRANSCRIPTION: Transcription = null

# Notwendig für das richtige Verhalten der Funktion "Driver_Turn()" innerhalb von Turn.gd
signal mouse_click;
signal action_finished;
signal race_finished;

# Speichert alle Teilnehmer des Rennens
var Drivers = []
var orderInWhichDriversFinished = [];
var clicked_node: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# Wird vom Spieler in den Optionen festgelegt.
	Global.setLapcount(1);
	
	$Racetrack.initialise("res://assets/maps/map_1.json")
	$Camera.initialise()
	
	# Call by Reference, Participants vergibt nur eine Referenz auf sich.
	TURNMANAGER = Turn.new(self, Drivers)
	RULEMANAGER = Rules.new()
	
	# addDriver(Driver.new("Christoph", Mercedes.new(), 0, false));
	addDriver(Driver.new("Mike", Golf.new(), 0, false));
	
	initialiseDrivers()
	TRANSCRIPTION = Transcription.new(Drivers)
	TURNMANAGER.initialise()
	TURNMANAGER.start()
	$HUD.init();
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if !event.is_pressed():
				# NULL FEHLER
				if $Ray.castRayAt(get_global_mouse_position()) != null:
					clicked_node = $Ray.castRayAt(get_global_mouse_position()).get_parent()
					print(clicked_node)
					emit_signal("mouse_click")
			
func addDriver(driver):
	# Überprüfe ob es sich um einen validen Driver handelt und ob das Rennen schon gestartet ist.
	if driver is Driver:
		self.Drivers.append(driver)
			
func initialiseDrivers():
	for driver in Drivers:
		# Startposition
		driver.setPosition($Racetrack.getStartPosition(driver.getStartIndex()).x, $Racetrack.getStartPosition(driver.getStartIndex()).y);
		
# Hauptfunktion zuständig für die Aktion die ein Fahrer vornimmt
func action(driver): 
	yield(get_tree(), "idle_frame") # Behebt das erste Parameter ist kein Objekt fehler von yield()
	if Settings.DEBUG:
		print(driver.NAME + "'s Aktion")
	
	# Hier soll entschieden werden können wie das Verhalten auf verschiedenen Untergründen ist
	var current_position = driver.getPosition()
	$Racetrack.getGridNode(current_position.x, current_position.y).hasDriverOnIt = false;
	var target_position: Vector2
	if Settings.DEBUG:
		print("Previous Vector: " + str(TRANSCRIPTION.getPreviousVector(driver)))
	var vector_selection = RULEMANAGER.getPossibieVectors(TRANSCRIPTION.getPreviousVector(driver))
	if Settings.DEBUG:
		print("Possible Vectors: " + str(vector_selection))
	var gridNode_selection = $Racetrack.getChoosableGridNodes(driver.getPosition(), vector_selection)
	if Settings.DEBUG:
		print("Possible GridNodes: " + str(gridNode_selection))

 	# Falls der Fahrer sich gegen eine Wand fährt darf er anhalten in der Runde.
	if len(gridNode_selection) == 0:
		vector_selection = [Vector2(0,0)]
		gridNode_selection = $Racetrack.getChoosableGridNodes(driver.getPosition(), vector_selection)
		
	if driver.KI:
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
		while !(clicked_node in gridNode_selection):
			yield(self, "mouse_click")
		target_position = $Racetrack.getCoordinates(clicked_node)
		$Racetrack.unhighlight(gridNode_selection)
	
	# Überprüfe ob die Ziellinie überfahren wurde.
	var direction = determineDirection(current_position, target_position);
	var gridNodes = $Racetrack.getGridNodesInBetween(current_position, target_position);
	gridNodes.append($Racetrack.getGridNode(target_position.x, target_position.y));
	
	for node in gridNodes:
		if node is StartFinish:
			if node.getDirection() in direction:
				driver.increaseLap();
			else:
				driver.decreaseLap();
			
	# Setze die Position des Spielers auf den neuen Platz
	driver.setPosition(target_position.x, target_position.y)
	$Racetrack.getGridNode(target_position.x, target_position.y).hasDriverOnIt = true;
	# Mathe is hier ggf. noch falsch
	TRANSCRIPTION.recordMovement(driver,-(current_position - target_position))
	
	emit_signal("action_finished");
	# Überprüfe ob der Spieler alle Runden gefahren ist.
	if (driver.getLap() > Global.getLapcount()):
		# Entferne Spieler aus der Fahrerliste
		driver.done();
		self.orderInWhichDriversFinished.append(driver);
		if isEveryDriverDone():
			finished();
			
			
	
func determineDirection(current, target):
	var vector = target - current;
	var direction = [];
	
	if vector.x == 0:
		pass;
	elif vector.x > 0:
		direction.append(Vector2.RIGHT);
	elif vector.x < 0:
		direction.append(Vector2.LEFT);
	
	if vector.y == 0:
		pass;
	elif vector.y > 0:
		direction.append(Vector2.DOWN);
	elif vector.y < 0:
		direction.append(Vector2.UP);

	return direction;

func isEveryDriverDone():
	for driver in self.Drivers:
		if !driver.isDone():
			return false;
	return true;

func finished():
	TURNMANAGER.end();
	emit_signal("race_finished");
	# func _init()
	#	Initialisiert Racetrack
	#   Initialisiert Camera
	#	Initialisiert Driver
	#	Befüllt DriverArray
	#	Setzt Driver an den Start
	#	Start Race ->