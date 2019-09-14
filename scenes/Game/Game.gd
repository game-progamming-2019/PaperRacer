# Autor: Christoph Brosch
# Erstellt 14.09.2019
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():

	$Racetrack._initialise(10, 10)
	$Camera._initiliase()
	
	$Racetrack.RECTANGLES[4][4].highlight()
	# Set to test Methods in $Spielfeld
	yield(get_tree().create_timer(2), "timeout")
	$Racetrack.RECTANGLES[4][4].unhighlight()
	
	pass # Replace with function body.


