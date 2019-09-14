# Autor: Christoph Brosch
# Erstellt 14.09.2019
extends Node2D

# var Racetrack = load("<Path>")
# Called when the node enters the scene tree for the first time.
func _ready():
	# self.add_child(Racetrack.instance())
	# $"Racetrack".initialize(Settings)
	$Racetrack.initialise(100, 100)
	pass # Replace with function body.


