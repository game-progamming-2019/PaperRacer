extends Node2D

class_name Vehicle

# Speichert die jetzige Geschwindigkeit des Fahrzeugs
var vehicle_name: String
var frames = null

# Liefert die Texture des Fahrzeugs
func getFrames():
	if self.frames == null:
		pass
	return self.frames

func getName():
	return vehicle_name